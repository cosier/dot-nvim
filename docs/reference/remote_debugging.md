# Remote Debugging Rails with Neovim (2025)

Complete guide for debugging Rails applications in Neovim using nvim-dap and LazyVim extras.

---

## Overview

LazyVim provides built-in DAP (Debug Adapter Protocol) support through extras. For Ruby/Rails debugging, we use:

- **LazyVim DAP Core** - Base debugging framework
- **LazyVim Ruby Language Extra** - Includes nvim-dap-ruby adapter
- **Custom Rails Configuration** - Attach to systemd services

---

## Setup (Completed)

### 1. Enabled LazyVim Extras

Added to `lua/config/lazy.lua`:

```lua
require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- DAP debugging support
    { import = "lazyvim.plugins.extras.dap.core" },
    -- Ruby language support (includes nvim-dap-ruby)
    { import = "lazyvim.plugins.extras.lang.ruby" },
    { import = "plugins" },
  },
})
```

### 2. Added Custom Rails Configuration

Created `lua/plugins/ruby-dap.lua`:

```lua
return {
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      local dap = require("dap")

      if not dap.configurations.ruby then
        dap.configurations.ruby = {}
      end

      -- Attach to Sendtrick on custom port (port 50000 → Rails 5000)
      table.insert(dap.configurations.ruby, {
        type = "ruby",
        request = "attach",
        name = "Attach to Sendtrick (port 50000 → Rails 5000)",
        port = 50000,
        host = "127.0.0.1",
        localfs = true,
      })

      -- Attach to other Rails apps on default port
      table.insert(dap.configurations.ruby, {
        type = "ruby",
        request = "attach",
        name = "Attach to Rails (default port 38698)",
        port = 38698,
        host = "127.0.0.1",
        localfs = true,
      })

      -- Debug current file
      table.insert(dap.configurations.ruby, {
        type = "ruby",
        request = "launch",
        name = "Debug current file",
        command = "ruby",
        script = "${file}",
      })
    end,
  },
}
```

### 3. Installed Plugins

Ran `:Lazy sync` to install:
- nvim-dap (core DAP client)
- nvim-dap-ui (visual debugging interface)
- nvim-dap-virtual-text (inline variable values)
- nvim-dap-ruby (Ruby adapter from suketa)

---

## Usage

### Quick Start

1. **Ensure Rails service is running with debug enabled:**
   ```bash
   sudo systemctl status sendtrick-web
   # Should show: DEBUGGER: Debugger can attach via TCP/IP (127.0.0.1:50000)
   ```

2. **Open Ruby file:**
   ```bash
   nvim /work/sendtrick/web/app/controllers/countdowns_controller.rb
   ```

3. **Set breakpoint:**
   - Position cursor on line
   - Press `<leader>db` (Space + d + b)
   - See ● indicator in sign column

4. **Attach debugger:**
   - Press `<leader>dc` (Space + d + c)
   - Select: "Attach to Sendtrick (port 50000 → Rails 5000)" or "Attach to Rails (default port 38698)"
   - DAP UI opens automatically

5. **Trigger breakpoint:**
   - Visit URL: `https://local.sendtrick.com/countdowns/1`
   - Neovim pauses at breakpoint
   - Inspect variables, step through code

### LazyVim DAP Keybindings

All keybindings start with `<leader>d` (Space + d):

**Breakpoints:**
- `<leader>db` - Toggle breakpoint
- `<leader>dB` - Conditional breakpoint

**Execution:**
- `<leader>dc` - Continue/Start debugging
- `<leader>dC` - Run to cursor
- `<leader>da` - Run with args

**Stepping:**
- `<leader>di` - Step into
- `<leader>do` - Step over
- `<leader>dO` - Step out

**Inspection:**
- `<leader>de` - Eval expression (visual mode: eval selection)
- `<leader>dw` - Show widgets

**UI:**
- `<leader>du` - Toggle DAP UI
- `<leader>dr` - Toggle REPL

**Navigation:**
- `<leader>dj` - Down in stack
- `<leader>dk` - Up in stack
- `<leader>dg` - Go to line (no execute)

**Session:**
- `<leader>dt` - Terminate
- `<leader>dl` - Run last

### Visual Features

**Breakpoint Indicators:**
- ● Red dot - Active breakpoint
- ◆ Blue diamond - Conditional breakpoint
- ► Yellow arrow - Current execution line

**Virtual Text:**
Variable values appear inline:
```ruby
@countdown = Countdown.find(params[:id])  # @countdown = #<Countdown id: 1, ...>
days_left = 42                            # days_left = 42
```

**DAP UI Panels:**
- Left sidebar: Scopes, Breakpoints, Stacks, Watches
- Bottom panel: REPL, Console

---

## Rails Debugging Workflow

### Debugging Systemd Service

```ruby
# 1. Add breakpoint in controller
class CountdownsController < ApplicationController
  def show
    @countdown = Countdown.find(params[:id])
    # Cursor here, press <leader>db
    render :show
  end
end
```

```vim
" 2. Attach debugger
<leader>dc
" Select: Attach to Sendtrick (port 50000 → Rails 5000)

" 3. Trigger via browser
" Visit: https://local.sendtrick.com/countdowns/1

" 4. Debug!
" - Press <leader>do to step over
" - Press <leader>de to eval @countdown
" - Press <leader>dc to continue
```

### Debugging Current File

```vim
" Open standalone Ruby file
nvim script.rb

" Set breakpoint
<leader>db

" Start debugging current file
<leader>dc
" Select: Debug current file
```

---

## Configuration Files

**Location:** `/home/bailey/conf/dot-nvim/`

```
dot-nvim/
├── lua/
│   ├── config/
│   │   └── lazy.lua              # LazyVim extras import
│   └── plugins/
│       └── ruby-dap.lua          # Rails attach config
└── docs/
    └── reference/
        └── remote_debugging.md   # This file
```

---

## Rails Service Configuration

**Systemd Service:** `sendtrick-web.service`

Must have debug environment variables:
```ini
Environment="RUBY_DEBUG_OPEN=true"
Environment="RUBY_DEBUG_HOST=127.0.0.1"
Environment="RUBY_DEBUG_PORT=50000"
```

**Note:** Sendtrick uses custom port 50000 (matches Rails port 5000 for easy memory). Other Rails apps typically use default port 38698.

Or in `config/application.rb`:
```ruby
if defined?(Rails::Server) && Rails.env.development?
  require "debug/open_nonstop"
end
```

---

## Troubleshooting

### Debugger Won't Attach

**Check Rails service:**
```bash
sudo journalctl -u sendtrick-web | grep "DEBUGGER.*50000"
```

**Check port is open:**
```bash
lsof -i :50000
```

**Restart service:**
```bash
sudo systemctl restart sendtrick-web
```

### Breakpoint Not Hitting

**Enable debug logging:**
```vim
:DapSetLogLevel TRACE
:messages
```

**Check configurations:**
```vim
:lua print(vim.inspect(require('dap').configurations.ruby))
```

### UI Not Showing

```vim
" Manually open UI
:lua require("dapui").open()

" Check plugin loaded
:Lazy
```

---

## Resources

- **LazyVim DAP Core:** https://www.lazyvim.org/extras/dap/core
- **LazyVim Ruby Extra:** https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/lang/ruby.lua
- **nvim-dap:** https://github.com/mfussenegger/nvim-dap
- **nvim-dap-ruby:** https://github.com/suketa/nvim-dap-ruby
- **Ruby debug gem:** https://github.com/ruby/debug

---

**Last Updated:** 2025-10-26
**Status:** Working ✅
**Rails Project:** Sendtrick (`/work/sendtrick/web`)
**Debug Port:** 50000 (custom - matches Rails port 5000)
