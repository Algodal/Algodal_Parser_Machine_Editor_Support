APML for Visual Studio Code
===========================

Syntax highlighting for `.apm` and `.apml` files, plus `#` comments and bracket
matching.

```
package.json                    what the extension is, and what it contributes
language-configuration.json     comments, brackets, auto-closing pairs
syntaxes/apml.tmLanguage.json   the highlighting patterns
```


Using it locally
----------------

## Option 1

Copy this folder into the extensions directory and
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

## Option 2

1. Open **this `VSCode/` folder** as the workspace root -- File, Open Folder,
   and pick `VSCode`, not the repository above it. The launch configuration
   passes `--extensionDevelopmentPath=${workspaceFolder}`, so a workspace
   rooted one level up points at the wrong directory and nothing loads.
2. Press <kbd>F5</kbd>, or pick **Run APML extension** in the Run and Debug
   panel. A second window opens, titled *[Extension Development Host]*, with
   this extension loaded from source. Your normal editor keeps whatever APML
   extension it already had; the two do not collide.
3. It opens `examples/tour.apm`, a grammar that uses every construct the
   highlighter colours. If something is the wrong colour, it shows there.
4. Change a pattern, then press <kbd>Ctrl</kbd>+<kbd>R</kbd> in the second
   window to reload it. Nothing is compiled or installed at any point.


Packaging it (for Owner :))
-----------------------------

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


