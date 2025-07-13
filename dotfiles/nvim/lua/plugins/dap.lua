return {
  -- DAP (Debug Adapter Protocol) - Configuración general
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-telescope/telescope-dap.nvim",
    },
    keys = {
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no stop)" },
      { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>ds", function() require("dap").session() end, desc = "Session" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      
      -- Configuración de DAP UI
      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.33 },
              { id = "breakpoints", size = 0.17 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            size = 0.33,
            position = "right",
          },
          {
            elements = {
              { id = "repl", size = 0.45 },
              { id = "console", size = 0.55 },
            },
            size = 0.27,
            position = "bottom",
          },
        },
      })
      
      -- Configuración de DAP Virtual Text
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
        virt_text_pos = 'eol',
        all_frames = true,
        virt_lines = false,
        virt_text_win_col = nil
      })
      
      -- Configuraciones para otros lenguajes (Python, Rust, Go, etc.)
      dap.configurations.python = {
        {
          name = "Launch Python",
          type = "python",
          request = "launch",
          program = "${file}",
          console = "integratedTerminal",
        },
        {
          name = "Attach to Python",
          type = "python",
          request = "attach",
          connect = {
            host = "localhost",
            port = 5678,
          },
        },
      }
      
      dap.configurations.rust = {
        {
          name = "Launch Rust",
          type = "lldb",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
      }
      
      dap.configurations.go = {
        {
          name = "Launch Go",
          type = "delve",
          request = "launch",
          program = "${file}",
        },
        {
          name = "Attach to Go",
          type = "delve",
          request = "attach",
          mode = "local",
          program = "${file}",
        },
      }
      
      -- Eventos de DAP
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  
  -- Telescope DAP
  {
    "nvim-telescope/telescope-dap.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap",
    },
    keys = {
      { "<leader>dC", function() require("telescope").extensions.dap.commands() end, desc = "DAP Commands" },
      { "<leader>dH", function() require("telescope").extensions.dap.configurations() end, desc = "DAP Configurations" },
      { "<leader>dL", function() require("telescope").extensions.dap.list_breakpoints() end, desc = "DAP Breakpoints" },
      { "<leader>dv", function() require("telescope").extensions.dap.variables() end, desc = "DAP Variables" },
      { "<leader>df", function() require("telescope").extensions.dap.frames() end, desc = "DAP Frames" },
    },
    config = function()
      require("telescope").load_extension("dap")
    end,
  },
} 