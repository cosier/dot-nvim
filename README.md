# 💤 LazyVim Configuration

Bailey's LazyVim setup for Rails development with DAP debugging.

> 📘 For AI-assisted development, see **[CLAUDE.md](./CLAUDE.md)** for comprehensive documentation.
>
> 🐛 For Ruby/Rails debugging, see **[docs/reference/remote_debugging.md](./docs/reference/remote_debugging.md)**

---

## Quick Links

- **[Full Documentation](./docs/INDEX.md)** - Complete docs index
- **[Debugging Guide](./docs/reference/remote_debugging.md)** - DAP Ruby/Rails setup
- **[LazyVim Docs](https://lazyvim.github.io/)** - Official documentation

---

## Features

- 🐛 **DAP Debugging** - Full Ruby/Rails debugging with nvim-dap
- 💎 **Ruby LSP** - Ruby language server with RuboCop formatting
- 🧪 **Testing** - RSpec integration with neotest
- 🎨 **UI** - Auto-opening debug panels, virtual text, breakpoint indicators

---

## Ruby Debugging Quick Start

1. **Set breakpoint:**
   ```
   <leader>db (Space + d + b)
   ```

2. **Attach to Rails:**
   ```
   <leader>dc (Space + d + c)
   Select: "Attach to Rails (systemd port 38698)"
   ```

3. **Debug interactively:**
   - REPL panel opens at bottom
   - Use `<leader>de` to eval expressions
   - Step with `<leader>do` / `<leader>di`

---

## Installation

Refer to the [LazyVim installation guide](https://lazyvim.github.io/installation) to get started.
