Algodal Parser Machine — Editor Support
=======================================

Editor support for the **Algodal Parser Machine Language (APML)**, the language
you write parsers in. Anything that helps an editor read a `.apm` file belongs
here.

APM itself lives in a separate repository, and so does its manual. This one
holds nothing that the toolchain needs to build or run.

| | |
|---|---|
| [`VSCode/`](VSCode/) | a Visual Studio Code extension: syntax highlighting, brackets, comments |
| [`Vim/`](Vim/) | a Vim syntax file and filetype detection |

Each folder has its own README with how to build it, how to use it locally, and
where it is published.


What gets highlighted
---------------------

The same groups the manual's Keywords chapter prints, so the two stay
recognisably the same language:

- **Declarations** — `program`, `link`, `parser`, `config`, `feat`, `bindpow`,
  `foreign`, `node_id`, `alias`
- **Variables and sets** — `texvar`, `numvar`, `semvar`, `scope`
- **Built-in functions** — `spc`, `nl`, `eol`, `eof`, `char`, `error`
- **Units and control** — `perm`, `give`, `if`, `node`
- **Called after `::`** — `order`, `oneof`, `icase`, `is`, `not`, `subkind`,
  `part`, `char_count`, `to_num`, `iter_steps`, `first`, `begin`, `end`,
  `clear`
- **Logic** — `AND`, `OR`, `NOT`, and the values `TRUE` and `FALSE`

Plus the things that are not words: string and character literals, character
blocks in `<>`, AST-map labels in `'quotes'`, comments from `#` to end of line,
and the operators `:=`, `=`, `->`, `=>`, `::`.

**Adding a keyword to APML means adding it in three places**: the language's own
grammar, the manual's Keywords chapter, and here. A word missing from here is
not an error anywhere; it just stops being coloured.


A note on `.` and `_`
---------------------

Two characters carry weight in APML that an editor would otherwise ignore.

`.` between units is the **inbetween skip**, not punctuation. `_` as a whole
body means the action is written in C. Both are highlighted as operators rather
than left plain, because a reader scanning a grammar needs to see them.
