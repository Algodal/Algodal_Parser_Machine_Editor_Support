APML for Visual Studio Code
===========================

Syntax highlighting for `.apm` and `.apml` files, plus `#` comments and bracket
matching.

There is no build step and no compiler. A Visual Studio Code grammar is data:
`syntaxes/apml.tmLanguage.json` is a list of patterns, `package.json` says which
file extensions it applies to, and `language-configuration.json` says what a
comment and a bracket are. Editing any of them and reloading is the whole loop.

```
package.json                    what the extension is, and what it contributes
language-configuration.json     comments, brackets, auto-closing pairs
syntaxes/apml.tmLanguage.json   the highlighting patterns
```


Using it locally
----------------

**The quickest way** is to copy this folder into the extensions directory and
restart VS Code:

```sh
# Windows
xcopy /E /I VSCode "%USERPROFILE%\.vscode\extensions\algodal.apml-0.1.0"

# macOS and Linux
cp -r VSCode ~/.vscode/extensions/algodal.apml-0.1.0
```

Open any `.apm` file. If nothing is coloured, check the language shown in the
bottom-right of the window says **APML**; if it says Plain Text, the extension
did not load.

**While editing the grammar**, use the extension host instead, so a reload takes
a keystroke rather than a restart:

1. Open this `VSCode/` folder in VS Code.
2. Press <kbd>F5</kbd>. A second window opens with the extension loaded.
3. Open a `.apm` file in it.
4. After changing a pattern, press <kbd>Ctrl</kbd>+<kbd>R</kbd> in that second
   window to reload.

To see which rule coloured something, run **Developer: Inspect Editor Tokens and
Scopes** from the command palette and put the cursor on it. That shows the
scope name, which is the fastest way to find a pattern that is matching too much.


Packaging it
------------

A `.vsix` is a zip with a manifest. `vsce` builds one:

```sh
npm install -g @vscode/vsce
cd VSCode
vsce package
```

That writes `apml-0.1.0.vsix`. Install it without a marketplace:

```sh
code --install-extension apml-0.1.0.vsix
```

That is enough to hand the extension to somebody. Publishing is only needed for
it to be findable from inside VS Code.


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

**What to expect.** The first publish takes a few minutes to appear and the
extension is verified in the background. A failure almost always means the
publisher ID in `package.json` does not match the one you logged in as, or the
token was scoped to one organisation rather than all of them.


Keeping it honest
-----------------

The word lists here are APML's reserved words. When the language gains one, it
has to be added in three places: the language's own grammar, the manual's
Keywords chapter, and this file. A word missing from here is not an error
anywhere, it simply stops being coloured, which is exactly the kind of thing
nobody notices for a year.
