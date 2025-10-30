-- Ruby DAP configuration for Rails debugging
-- Extends the LazyVim ruby extra with custom configurations

return {
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      local dap = require("dap")

      -- Configure Ruby adapter for attaching to running Rails server
      if not dap.configurations.ruby then
        dap.configurations.ruby = {}
      end

      -- Add attach configurations for different Rails apps
      table.insert(dap.configurations.ruby, {
        type = "ruby",
        request = "attach",
        name = "Attach to Sendtrick (port 50000 → Rails 5000)",
        port = 50000,
        host = "127.0.0.1",
        localfs = true,
      })

      table.insert(dap.configurations.ruby, {
        type = "ruby",
        request = "attach",
        name = "Attach to Rails (default port 38698)",
        port = 38698,
        host = "127.0.0.1",
        localfs = true,
      })

      -- Add configuration to debug current file
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
