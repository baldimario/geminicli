local M = {}

local term_buf = nil
local term_win = nil
local term_job_id = nil

function M.toggle_terminal()
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    vim.api.nvim_win_close(term_win, true)
    term_win = nil
    return
  end

  if not term_buf or not vim.api.nvim_buf_is_valid(term_buf) then
    term_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_name(term_buf, "GeminiTerminal")
    vim.bo[term_buf].bufhidden = "hide"
  end

  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  term_win = vim.api.nvim_open_win(term_buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })

  vim.api.nvim_set_current_buf(term_buf)

  if not term_job_id or vim.fn.jobwait({ term_job_id }, 0)[1] ~= -1 then
    term_job_id = vim.fn.termopen("gemini", {
      cwd = vim.fn.getcwd(),
      pty = true,
    })
  end

  -- Clear window variable if user manually closes floating window (:q, etc)
  vim.api.nvim_create_autocmd("WinClosed", {
    pattern = tostring(term_win),
    callback = function()
      term_win = nil
    end,
    once = true,
  })

  vim.cmd("startinsert")
end

function M.setup(opts)
  opts = opts or {}

  vim.api.nvim_create_user_command("GeminiRun", M.toggle_terminal, {})

  local keymap = opts.keymap or "<M-g>"

  -- Normal mode mapping
  vim.keymap.set("n", keymap, M.toggle_terminal, {
    desc = "Toggle Gemini CLI terminal",
    silent = true,
  })

  -- Terminal mode mapping: switch to normal mode first then toggle
  vim.keymap.set("t", keymap, function()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), 'n', false)
    M.toggle_terminal()
  end, {
    desc = "Toggle Gemini CLI terminal from terminal mode",
    silent = true,
  })
end

return M
