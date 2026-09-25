Publishing it
-------------

The VS Code marketplace authenticates through **Azure DevOps**, which is why an
Azure account is involved at all. Nothing is deployed to Azure; it is used only
to prove who you are.

**1. Make an Azure DevOps organisation.** Sign in at
<https://dev.azure.com> with a Microsoft account and create one. The name does
not matter and it is free.

**2. Make a Personal Access Token.** From your profile menu, *Personal access
tokens*, then *New Token*:

| field | value |
|---|---|
| Organization | **All accessible organizations** |
| Scopes | *Custom defined*, then **Marketplace → Manage** |
| Expiration | whatever you are willing to rotate |

Copy the token when it is shown. It is not shown again.

**3. Make a publisher.** At
<https://marketplace.visualstudio.com/manage> create one. Its ID is what goes in
`package.json` as `"publisher"`. The `algodal` in this file is a placeholder;
change it to yours or the upload is rejected.

**4. Log in and publish.**

```sh
vsce login <your-publisher-id>     # paste the token when asked
vsce publish
```

`vsce publish patch` or `minor` bumps the version in `package.json` for you.

