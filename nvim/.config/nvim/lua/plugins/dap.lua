return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      ensure_installed = { "stylua", "jq", "ocaml" },
      handlers = {
        function(config)
          -- all sources with no handler get passed here

          -- Keep original functionality
          require("mason-nvim-dap").default_setup(config)
        end,
        ocamlearlybird = function(config)
          config.adapters = {
            type = "executable",
            command = "/usr/bin/ocamlearlybird",
            args = {},
          }
          require("mason-nvim-dap").default_setup(config) -- don't forget this!
        end,
        python = function(config)
          config.adapters = {
            type = "executable",
            command = "/usr/bin/python3",
            args = {
              "-m",
              "debugpy.adapter",
            },
          }
          require("mason-nvim-dap").default_setup(config) -- don't forget this!
        end,
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "jbyuki/one-small-step-for-vimkind",
      -- stylua: ignore
      config = function()
        local dap = require("dap")
        dap.adapters.ocamlearlybird = {
        type = 'executable',
        command = 'ocamlearlybird',
        args = { 'debug' }
        }
        -- dap.adapters.nlua = function(callback, conf)
        --   local adapter = {
        --     type = "server",
        --     host = conf.host or "127.0.0.1",
        --     port = conf.port or 4711,
        --   }
        --   if conf.start_neovim then
        --     local dap_run = dap.run
        --     dap.run = function(c)
        --       adapter.port = c.port
        --       adapter.host = c.host
        --     end
        --     require("osv").run_this()
        --     dap.run = dap_run
        --   end
        --   callback(adapter)
        -- end
        dap.configurations.ocaml = {
        {
            name = 'OCaml Debug test.bc',
            type = 'ocamlearlybird',
            request = 'launch',
            program = '${workspaceFolder}/_build/default/test/test.bc',
        },
        {
            name = 'OCaml Debug main.bc',
            type = 'ocamlearlybird',
            request = 'launch',
            program = '${workspaceFolder}/_build/default/bin/main.bc',
        },
        }
      end,
      },
    },
  },
}
