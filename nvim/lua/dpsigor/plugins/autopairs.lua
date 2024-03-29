local setup, autopairs = pcall(require, "nvim-autopairs")
if not setup then
  return
end

local rule_setup, Rule = pcall(require, "nvim-autopairs.rule")
if not rule_setup then
  return
end

autopairs.setup({
  check_ts = true, -- enable treesitter
  ts_config = {
    javascript = { "template_string" },
    java = false, -- don't check treesitter on java
  }
})

-- Add spaces between parentheses
local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
autopairs.add_rules {
  Rule(' ', ' ')
    :with_pair(function (opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({
        brackets[1][1]..brackets[1][2],
        brackets[2][1]..brackets[2][2],
        brackets[3][1]..brackets[3][2],
      }, pair)
    end)
}
for _,bracket in pairs(brackets) do
  autopairs.add_rules {
    Rule(bracket[1]..' ', ' '..bracket[2])
      :with_pair(function() return false end)
      :with_move(function(opts)
        return opts.prev_char:match('.%'..bracket[2]) ~= nil
      end)
      :use_key(bracket[2])
  }
end

-- make autopairs and completion work together
local cmp_autopairs_setup, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if not cmp_autopairs_setup then
  return
end

local cmp_setup, cmp = pcall(require, "cmp")
if not cmp_setup then
  return
end

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
