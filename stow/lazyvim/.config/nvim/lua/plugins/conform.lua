return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      python = { "autopep8" },
      html = { "html_beautify" },
      cs = { "csharpier" },
    },
    formatters = {
      csharpier = {
        ignore_errors = true,
      },
      autopep8 = {
        exe = "autopep8",
        args = { "--indent-size", "2", "--aggressive", "--max-line-length", "100", "-" },
        stdin = true,
      },
      ["php-cs-fixer"] = {
        -- This env var tells php-cs-fixer to stop complaining about missing composer.json
        env = {
          PHP_CS_FIXER_IGNORE_ENV = "1",
        },
      },
      html_beautify = {
        exe = "html-beautify",
        args = { "--indent-size", "2", "--wrap-line-length", "120" },
        stdin = true,
      },
    },
    keys = {
      {
        -- Map this to whatever you prefer, like <leader>cf
        "<leader>cf",
        function()
          -- This forces conform to format the visual range directly
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = { "n", "v" }, -- Ensures it operates in both Normal and Visual mode
        desc = "Format buffer or selection",
      },
    },
  },
}
