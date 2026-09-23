APML for Vim
============

Syntax highlighting for `.apm` and `.apml` files.

There is no build step. A Vim syntax file is a script Vim runs when it opens a
buffer of that filetype, so editing it and reloading is the whole loop.

```
ftdetect/apml.vim    says any .apm or .apml file is APML
syntax/apml.vim      the highlighting itself
```


Using it locally
----------------

**With a plugin manager**, point it at this repository and tell it to load the
`Vim/` folder as the plugin root.

```vim
" vim-plug
Plug 'algodal/Algodal_Parser_Machine_Editor_Support', { 'rtp': 'Vim' }

" lazy.nvim
{ "algodal/Algodal_Parser_Machine_Editor_Support", config = function() end }
```

**Without one**, copy the two files into your runtime directory. Vim finds them
there with no configuration:

```sh
# Vim
mkdir -p ~/.vim/syntax ~/.vim/ftdetect
cp Vim/syntax/apml.vim    ~/.vim/syntax/
cp Vim/ftdetect/apml.vim  ~/.vim/ftdetect/

# Neovim
mkdir -p ~/.config/nvim/syntax ~/.config/nvim/ftdetect
cp Vim/syntax/apml.vim    ~/.config/nvim/syntax/
cp Vim/ftdetect/apml.vim  ~/.config/nvim/ftdetect/
```

On Windows the directories are `%USERPROFILE%\vimfiles\` and
`%LOCALAPPDATA%\nvim\`.

Open a `.apm` file. Check it took with:

```vim
:set filetype?
```

It should answer `filetype=apml`. If it answers something else, the `ftdetect`
file is not on the runtime path.


While editing the syntax file
-----------------------------

Reload without restarting:

```vim
:syntax off | syntax on
```

To see which rule coloured something, put the cursor on it and run:

```vim
:echo synIDattr(synID(line("."), col("."), 1), "name")
```

That prints the syntax group, which is the fastest way to find a pattern that is
matching more than it should. Vim's own `:syntax` lists every group currently
defined.


How the colours are chosen
--------------------------

The file links each group to a **standard highlight group** rather than naming
colours, so it follows whatever scheme you already use:

| APML | standard group |
|---|---|
| `program`, `parser`, `if`, `perm` | `Statement` |
| `texvar`, `numvar`, `semvar`, `scope` | `Type` |
| `spc`, `nl`, `char`, `error` | `Function` |
| a character block `<a:z>` | `Constant` |
| a map label `'l'` | `Identifier` |
| `_`, a body written in C | `Special` |
| `:=`, `->`, `=>`, `::`, `.`, `^` | `Operator` |

`.` is highlighted as an operator on purpose. Between units it is the inbetween
skip, not punctuation, and a reader scanning a grammar needs to see it.


Keeping it honest
-----------------

The word lists are APML's reserved words. When the language gains one, it has to
be added in three places: the language's own grammar, the manual's Keywords
chapter, and this file. A word missing here is not an error anywhere, it simply
stops being coloured.
