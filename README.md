# carpetbag

A modest container of small command-line tools. Like Mary Poppins's bag —
nothing fancy on the outside, but you can reach in and pull out whatever
you need.

## What's inside

| Tool   | Description                                                           |
|--------|-----------------------------------------------------------------------|
| `md2`  | Convert Markdown to HTML / Confluence (kovetskiy/mark) / PDF.         |

See each tool's own `README.md` inside its directory for details.

## Install

The installer drops scripts into `$PREFIX/bin`. Default `PREFIX` is
`$HOME/.local`, so by default tools end up in `$HOME/.local/bin`.

```bash
# install everything
curl -fsSL https://raw.githubusercontent.com/mborsalino/carpetbag/main/install.sh | bash

# install specific tools only
curl -fsSL https://raw.githubusercontent.com/mborsalino/carpetbag/main/install.sh | bash -s -- md2

# install to a custom prefix
curl -fsSL https://raw.githubusercontent.com/mborsalino/carpetbag/main/install.sh | bash -s -- --prefix /opt/carpetbag

# combine
curl -fsSL https://raw.githubusercontent.com/mborsalino/carpetbag/main/install.sh | bash -s -- --prefix /opt/carpetbag md2
```

Equivalent env vars (CLI flag wins if both are set):

| Env var             | CLI equivalent  | Default        |
|---------------------|-----------------|----------------|
| `CARPETBAG_PREFIX`  | `--prefix DIR`  | `$HOME/.local` |

Make sure `$PREFIX/bin` is on your `PATH`.

## License

MIT. See [LICENSE](LICENSE).
