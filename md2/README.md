# md2

Convert Markdown to one of several output formats. Single-file Python script,
no external Python dependencies for the dispatch layer; per-format
dependencies are checked at runtime.

## Subcommands

| Subcommand   | Purpose                                                            |
|--------------|--------------------------------------------------------------------|
| `html`       | Themed self-contained HTML (uses `pandoc`).                        |
| `mark`       | Markdown shaped for [kovetskiy/mark][mark] to push to Confluence.  |
| `pdf`        | Themed PDF (uses `pandoc` and `weasyprint`).                       |
| `doctor`     | Report which dependencies are present / missing per subcommand.    |

[mark]: https://github.com/kovetskiy/mark

## Quick start

```bash
md2 html   --theme sakura --width M  doc.md
md2 mark   --space ENG --parent "Team Docs" --title "My Page" --strip-h1  doc.md
md2 pdf    --theme sakura --printable  doc.md
md2 doctor
```

## Themes

Two classless CSS themes:

| Theme    | Notes                                                         |
|----------|---------------------------------------------------------------|
| `sakura` | Light background, larger serif body. Default.                 |
| `holiday`| Light background, denser layout. Code-block red color removed.|

Widths (`--width`) are scaled per theme, so `M` is whatever each theme
considers "normal":

| Width | Scale | Sakura M-base | Holiday M-base |
|-------|-------|---------------|----------------|
| `S`   | 80%   | 75.6rem       | 48rem          |
| `M`   | 100%  | 75.6rem       | 48rem          |
| `L`   | 125%  | 75.6rem       | 48rem          |

## Dependencies

| Subcommand | Needs                                                           |
|------------|-----------------------------------------------------------------|
| `html`     | `pandoc`                                                        |
| `mark`     | (none — pure Python text transform)                             |
| `pdf`      | `pandoc`, Python package `weasyprint`                           |
| `doctor`   | (none — only reports on the above)                              |

Run `md2 doctor` to see what's installed.

## Notes

- `md2 mark` does GitHub-Flavored Markdown admonition translation
  (`> [!NOTE]`, `> [!TIP]`, etc.) into Confluence structured-macros,
  preserves fenced code blocks unchanged, and optionally strips a leading
  `# H1` (use `--strip-h1` when the H1 duplicates the Confluence page
  title).
- `md2 pdf --printable` forces white backgrounds on body, code blocks,
  and blockquotes — saves ink when printing.
