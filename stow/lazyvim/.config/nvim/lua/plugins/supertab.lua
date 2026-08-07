-- only trigger completion when the cursor follows a non-whitespace character,
-- so <Tab> at the start of a line or after a space still inserts a real tab
local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  if col == 0 then
    return false
  end
  return vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
  "saghen/blink.cmp",
  opts = {
    completion = {
      list = {
        selection = {
          -- nothing is selected when the menu opens...
          preselect = false,
          -- ...but cycling with <Tab> inserts the item as you go
          -- (equivalent to cmp.SelectBehavior.Insert)
          auto_insert = true,
        },
      },
    },

    keymap = {
      preset = "default",

      -- <CR> is just a normal Enter, never a confirm
      ["<CR>"] = { "fallback" },

      -- <Tab> is blink's alone; Copilot accepts on \<Tab>.
      -- `show` unconditionally reports the key as handled, so it has to be
      -- guarded or <Tab> could never fall through to inserting a tab.
      ["<Tab>"] = {
        "select_next",
        "snippet_forward",
        function(cmp)
          if has_words_before() then
            return cmp.show()
          end
        end,
        "fallback",
      },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    },
  },
}
