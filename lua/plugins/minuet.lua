---@type LazySpec
return {
  {
    "milanglacier/minuet-ai.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "InsertEnter",
    config = function()
      require("minuet").setup {
        provider = "openai_fim_compatible",
        request_timeout = 3,
        throttle = 1000,
        debounce = 400,
        provider_options = {
          openai_fim_compatible = {
            api_key = "DEEPSEEK_API_KEY",
            name = "deepseek",
            model = "deepseek-v4-flash",
            optional = {
              max_tokens = 256,
              top_p = 0.9,
            },
          },
        },
        -- Copilot-style inline ghost text (not popup)
        virtualtext = {
          auto_trigger_ft = { "*" },
          keymap = {
            accept     = "<Tab>",
            accept_line = "<A-a>",
            next       = "<A-]>",
            prev       = "<A-[>",
            dismiss    = "<A-e>",
          },
        },
      }
    end,
  },

  -- Remove minuet from blink.cmp sources (virtualtext handles it now)
  -- Keep blink.cmp Tab binding for snippet nav only
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.completion = opts.completion or {}
      opts.completion.trigger = vim.tbl_extend("force", opts.completion.trigger or {}, {
        prefetch_on_insert = false,
      })

      opts.keymap = opts.keymap or {}
      opts.keymap["<Tab>"] = { "snippet_forward", "fallback" }
      opts.keymap["<S-Tab>"] = { "snippet_backward", "fallback" }

      opts.sources = opts.sources or {}
      opts.sources.default = { "lsp", "path", "snippets", "buffer" }
      opts.sources.providers = opts.sources.providers or {}
      opts.sources.providers.lsp = vim.tbl_deep_extend("force", opts.sources.providers.lsp or {}, {
        min_keyword_length = 0,
        score_offset = 10,
      })
      opts.sources.providers.snippets = vim.tbl_deep_extend("force", opts.sources.providers.snippets or {}, {
        min_keyword_length = 0,
      })

      return opts
    end,
  },
}
