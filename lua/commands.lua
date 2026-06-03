vim.api.nvim_create_user_command("DiffClipboard", function()
  local filetype = vim.bo.filetype
  vim.cmd("rightbelow vnew")
  local scratch_buf = vim.api.nvim_get_current_buf()

  vim.bo[scratch_buf].buftype = "nofile"
  vim.bo[scratch_buf].bufhidden = "wipe"
  vim.bo[scratch_buf].swapfile = false
  vim.bo[scratch_buf].filetype = filetype

  local clipboard_content = vim.fn.getreg("+")
  if clipboard_content == "" then
    clipboard_content = vim.fn.getreg("*")
  end

  local lines = vim.split(clipboard_content, "\n")
  vim.api.nvim_buf_set_lines(scratch_buf, 0, -1, false, lines)
  vim.bo[scratch_buf].modifiable = false

  vim.cmd("diffthis")

  vim.cmd("wincmd p")
  vim.cmd("diffthis")
end, {})
