# Neovim Configuration Documentation

**Location:** `/home/bailey/conf/dot-nvim`
**Symlink:** `~/.config/nvim → /home/bailey/conf/dot-nvim`

---

## 📚 Documentation Structure

```
docs/
├── INDEX.md                    # This file
├── reference/                  # Implementation guides
│   └── remote_debugging.md     # DAP Ruby/Rails debugging
├── planning/                   # Future features & specs
├── todo/                       # Current tasks
└── completed/                  # Completed work logs
    └── 2025-10-26-dap-setup.md # DAP setup completion
```

---

## 🔧 Configuration Overview

### Base System
- **Framework:** LazyVim
- **Plugin Manager:** lazy.nvim
- **Colorscheme:** tokyonight

### Enabled LazyVim Extras
- **`dap.core`** - Debug Adapter Protocol support
- **`lang.ruby`** - Ruby/Rails language support

### Custom Plugins
Located in `lua/plugins/`:
- **`ruby-dap.lua`** - Rails debugging configuration (port 38698)

---

## 📖 Reference Documentation

| Document | Purpose |
|----------|---------|
| **[remote_debugging.md](./reference/remote_debugging.md)** | Complete DAP debugging guide for Rails |

---

## ✅ Completed Work

| Date | Task | Document |
|------|------|----------|
| 2025-10-26 | DAP Ruby debugging setup | [2025-10-26-dap-setup.md](./completed/2025-10-26-dap-setup.md) |

---

## 🎯 Todo

*(Empty - add tasks as needed)*

---

## 📋 Planning

*(Empty - add specs as needed)*

---

## 🔗 Related Projects

**Sendtrick** - Rails 8 + Rust API platform
- Location: `/work/sendtrick/`
- Debug Port: 38698
- Systemd Service: `sendtrick-web`

---

**Last Updated:** 2025-10-26
