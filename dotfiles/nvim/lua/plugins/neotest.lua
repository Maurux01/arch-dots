return {
  -- Neotest (Testing Framework)
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- Adapters for different languages
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-jest",
      "nvim-neotest/neotest-go",
      "rouge8/neotest-rust",
    },
    keys = {
      { "<leader>nt", function() require("neotest").run.run() end, desc = "Run Test" },
      { "<leader>nT", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
      { "<leader>na", function() require("neotest").run.attach() end, desc = "Attach" },
      { "<leader>nf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
      { "<leader>nd", function() require("neotest").run.run({strategy = "dap"}) end, desc = "Debug Test" },
      { "<leader>nl", function() require("neotest").run.run_last() end, desc = "Run Last" },
      { "<leader>no", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Output" },
      { "<leader>nO", function() require("neotest").output_panel.toggle() end, desc = "Output Panel" },
      { "<leader>nS", function() require("neotest").run.stop() end, desc = "Stop" },
      { "<leader>ns", function() require("neotest").summary.toggle() end, desc = "Summary" },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            dap = { justMyCode = false },
            args = { "--log-level", "DEBUG" },
          }),
          require("neotest-jest")({
            jestCommand = "npm test --",
            jestConfigFile = "custom.jest.config.ts",
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          }),
          require("neotest-go"),
          require("neotest-rust"),
        },
        status = { virtual_text = true },
        output = { open_on_run = true },
        quickfix = {
          open = function()
            if require("lazyvim.util").has("trouble.nvim") then
              require("trouble").open({ mode = "quickfix", focus = false })
            else
              vim.cmd("copen")
            end
          end,
        },
        discovery = {
          enabled = true,
        },
        summary = {
          enabled = true,
          expand_errors = true,
          follow = true,
          mappings = {
            expand = { "<CR>", "<2-LeftMouse>" },
            expand_all = "e",
            output = "o",
            short = "O",
            attach = "a",
            jumpto = "i",
            stop = "u",
            debug = "d",
          },
        },
      })
    end,
  },
} 