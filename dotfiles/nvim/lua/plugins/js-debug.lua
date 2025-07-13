-- lua/plugins/js-debug.lua
-- Configuración de debugging de JavaScript integrada como plugin

return {
  -- DAP (Debug Adapter Protocol) para JavaScript
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
      
      -- Configuración para JavaScript/Node.js debugging
      dap.adapters.node2 = {
        type = 'executable',
        command = 'node',
        args = { os.getenv('HOME') .. '/.local/share/nvim/dapinstall/jsnode_modules/js-debug/src/dapDebugServer.js', '8143' },
        sourceMaps = true,
        protocol = 'inspector',
        cwd = vim.fn.getcwd(),
        console = 'integratedTerminal',
      }
      
      -- Configuración para Chrome debugging
      dap.adapters.chrome = {
        type = "executable",
        command = "node",
        args = { os.getenv('HOME') .. '/.local/share/nvim/dapinstall/jsnode_modules/js-debug/src/dapDebugServer.js', '9222' },
        sourceMaps = true,
        protocol = "inspector",
        webRoot = "${workspaceFolder}",
      }
      
      -- Configuración para Firefox debugging
      dap.adapters.firefox = {
        type = "executable",
        command = "node",
        args = { os.getenv('HOME') .. '/.local/share/nvim/dapinstall/jsnode_modules/js-debug/src/dapDebugServer.js', '9222' },
        sourceMaps = true,
        protocol = "inspector",
        webRoot = "${workspaceFolder}",
      }
      
      -- Configuraciones para JavaScript
      dap.configurations.javascript = {
        {
          name = "Launch Node.js",
          type = "node2",
          request = "launch",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          console = "integratedTerminal",
        },
        {
          name = "Attach to Node.js",
          type = "node2",
          request = "attach",
          port = 9229,
          sourceMaps = true,
          localRoot = "${workspaceFolder}",
          remoteRoot = "/",
        },
        {
          name = "Launch Chrome",
          type = "chrome",
          request = "launch",
          url = "http://localhost:3000",
          webRoot = "${workspaceFolder}",
          sourceMaps = true,
        },
        {
          name = "Attach to Chrome",
          type = "chrome",
          request = "attach",
          port = 9222,
          webRoot = "${workspaceFolder}",
          sourceMaps = true,
        },
      }
      
      -- Configuraciones para TypeScript
      dap.configurations.typescript = {
        {
          name = "Launch TypeScript",
          type = "node2",
          request = "launch",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          console = "integratedTerminal",
          skipFiles = { "<node_internals>/**" },
        },
        {
          name = "Attach to TypeScript",
          type = "node2",
          request = "attach",
          port = 9229,
          sourceMaps = true,
          localRoot = "${workspaceFolder}",
          remoteRoot = "/",
        },
      }
      
      -- Configuraciones para React/Next.js
      dap.configurations.javascriptreact = {
        {
          name = "Launch Chrome (React)",
          type = "chrome",
          request = "launch",
          url = "http://localhost:3000",
          webRoot = "${workspaceFolder}",
          sourceMaps = true,
          userDataDir = "${workspaceFolder}/.vscode/chrome-debug-profile",
        },
        {
          name = "Attach to Chrome (React)",
          type = "chrome",
          request = "attach",
          port = 9222,
          webRoot = "${workspaceFolder}",
          sourceMaps = true,
        },
      }
      
      dap.configurations.typescriptreact = {
        {
          name = "Launch Chrome (TypeScript React)",
          type = "chrome",
          request = "launch",
          url = "http://localhost:3000",
          webRoot = "${workspaceFolder}",
          sourceMaps = true,
          userDataDir = "${workspaceFolder}/.vscode/chrome-debug-profile",
        },
        {
          name = "Attach to Chrome (TypeScript React)",
          type = "chrome",
          request = "attach",
          port = 9222,
          webRoot = "${workspaceFolder}",
          sourceMaps = true,
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

  -- Auto-install js-debug when needed
  {
    "nvim-lua/plenary.nvim",
    config = function()
      -- Función para instalar js-debug automáticamente
      local function install_js_debug()
        local js_debug_path = vim.fn.stdpath("data") .. "/dapinstall/jsnode_modules/js-debug"
        
        if vim.fn.isdirectory(js_debug_path) == 0 then
          vim.notify("Installing js-debug...", vim.log.levels.INFO)
          
          -- Crear directorio
          vim.fn.mkdir(vim.fn.stdpath("data") .. "/dapinstall/jsnode_modules", "p")
          
          -- Clonar repositorio
          local job = vim.fn.jobstart({
            "git", "clone", "--depth", "1",
            "https://github.com/microsoft/vscode-js-debug.git",
            js_debug_path
          }, {
            on_exit = function(_, code)
              if code == 0 then
                -- Instalar dependencias
                local install_job = vim.fn.jobstart({
                  "npm", "install"
                }, {
                  cwd = js_debug_path,
                  on_exit = function(_, install_code)
                    if install_code == 0 then
                      -- Compilar
                      local compile_job = vim.fn.jobstart({
                        "npm", "run", "compile"
                      }, {
                        cwd = js_debug_path,
                        on_exit = function(_, compile_code)
                          if compile_code == 0 then
                            vim.notify("js-debug installed successfully!", vim.log.levels.INFO)
                          else
                            vim.notify("Failed to compile js-debug", vim.log.levels.ERROR)
                          end
                        end
                      })
                    else
                      vim.notify("Failed to install js-debug dependencies", vim.log.levels.ERROR)
                    end
                  end
                })
              else
                vim.notify("Failed to clone js-debug repository", vim.log.levels.ERROR)
              end
            end
          })
        end
      end
      
      -- Instalar js-debug al cargar el plugin
      vim.defer_fn(install_js_debug, 1000)
    end,
  },
} 