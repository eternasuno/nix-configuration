---
name: obscura
description: Install and operate the Obscura CLI for page loading, extraction, screenshots, stealth browsing, CDP automation, and MCP browser interaction. Use when an Obscura task requires locating the command, downloading a matching release binary, or selecting CLI commands.
---

# Obscura

## Prepare the command

Test the current environment before doing anything else:

```bash
command -v obscura && obscura --help
```

On Windows, use `Get-Command obscura` followed by `obscura --help`.

If the command works, use the installed executable. Otherwise:

1. Detect the operating system and architecture (`uname -s` and `uname -m`, or the Windows equivalents).
2. Open the latest release at <https://github.com/h4ckf0r0day/obscura/releases> and select the archive matching that platform. Prefer the normal rendering archive; select the `-stealth` archive when stealth is requested, and select `-no-render` only when rendering and screenshots are unnecessary.
3. Download and extract the archive, then persist the executable in the user-level binary directory: `~/.local/bin/obscura` on Linux or macOS, or `%LOCALAPPDATA%\Programs\Obscura\obscura.exe` on Windows. Create the directory when absent and make the Unix executable runnable.
4. Test whether that directory is already in `PATH`. On Unix, use `case ":$PATH:" in *":$HOME/.local/bin:"*) echo yes;; *) echo no;; esac`. On Windows PowerShell, use `$env:Path -split ';' -contains "$env:LOCALAPPDATA\Programs\Obscura"`.
5. If absent, add the directory to the user's persistent `PATH`, update the current process's `PATH`, and then verify resolution with `command -v obscura` on Unix or `Get-Command obscura` on Windows.
6. Run `obscura --help` to verify the installation.

Use release binaries only; no source-build instructions are needed.

## Command-line usage

Inspect the installed version's authoritative options first:

```bash
obscura --help
obscura <subcommand> --help
```

Common operations:

```bash
obscura fetch https://example.com --dump text
obscura fetch https://example.com --eval "document.title"
obscura fetch https://example.com --screenshot page.png
obscura --stealth fetch https://example.com --screenshot page.png
obscura scrape urls.txt
obscura serve --port 9222
obscura mcp
obscura mcp --http --port 3000
```

- `fetch` loads one URL and can dump content, evaluate JavaScript, or capture a screenshot.
- `scrape` processes multiple URLs.
- `serve` exposes a Chrome DevTools Protocol endpoint for clients such as Puppeteer or Playwright.
- `mcp` starts the MCP browser server over stdio; `--http` exposes it over HTTP.
- `--stealth` requires a stealth release archive.
- Use `--wait N` for a fixed delay in seconds and `--timeout N` to bound navigation.

For any option not shown here, rely on the downloaded version's `--help` output rather than assuming flags.
