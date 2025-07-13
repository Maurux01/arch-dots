-- Code Capture Utilities
local M = {}

-- Function to capture current buffer as image
function M.capture_buffer_as_image()
  local filename = vim.fn.expand('%:t')
  local timestamp = os.date("%Y%m%d_%H%M%S")
  local output_file = string.format("~/Pictures/nvim_capture_%s_%s.png", filename:gsub("%.", "_"), timestamp)
  
  -- Use wl-screenshot on Wayland or import on X11
  local cmd
  if vim.fn.system("echo $XDG_SESSION_TYPE") == "wayland\n" then
    cmd = string.format("wl-screenshot -f %s", output_file)
  else
    cmd = string.format("import -window root %s", output_file)
  end
  
  vim.fn.jobstart(cmd, {
    on_exit = function(_, code)
      if code == 0 then
        vim.notify("Screenshot saved to: " .. output_file, vim.log.levels.INFO, {
          title = "Code Capture",
          timeout = 3000,
        })
      else
        vim.notify("Failed to capture screenshot", vim.log.levels.ERROR, {
          title = "Code Capture",
          timeout = 3000,
        })
      end
    end
  })
end

-- Function to capture selection as image
function M.capture_selection_as_image()
  local timestamp = os.date("%Y%m%d_%H%M%S")
  local output_file = string.format("~/Pictures/nvim_selection_%s.png", timestamp)
  
  -- Use wl-screenshot on Wayland or import on X11
  local cmd
  if vim.fn.system("echo $XDG_SESSION_TYPE") == "wayland\n" then
    cmd = string.format("wl-screenshot -f %s", output_file)
  else
    cmd = string.format("import -window root %s", output_file)
  end
  
  vim.fn.jobstart(cmd, {
    on_exit = function(_, code)
      if code == 0 then
        vim.notify("Selection captured to: " .. output_file, vim.log.levels.INFO, {
          title = "Code Capture",
          timeout = 3000,
        })
      else
        vim.notify("Failed to capture selection", vim.log.levels.ERROR, {
          title = "Code Capture",
          timeout = 3000,
        })
      end
    end
  })
end

-- Function to start screen recording
function M.start_screen_recording()
  local timestamp = os.date("%Y%m%d_%H%M%S")
  local output_file = string.format("~/Videos/nvim_recording_%s.mp4", timestamp)
  
  -- Create videos directory if it doesn't exist
  vim.fn.system("mkdir -p ~/Videos")
  
  local cmd
  if vim.fn.system("echo $XDG_SESSION_TYPE") == "wayland\n" then
    cmd = string.format("wf-recorder -f %s", output_file)
  else
    cmd = string.format("ffmpeg -f x11grab -r 30 -s 1920x1080 -i :0.0 -c:v libx264 -preset ultrafast -crf 22 %s", output_file)
  end
  
  -- Store the recording process ID
  M.recording_pid = vim.fn.jobstart(cmd, {
    on_exit = function(_, code)
      if code == 0 then
        vim.notify("Recording saved to: " .. output_file, vim.log.levels.INFO, {
          title = "Screen Recording",
          timeout = 3000,
        })
      else
        vim.notify("Recording stopped", vim.log.levels.INFO, {
          title = "Screen Recording",
          timeout = 3000,
        })
      end
      M.recording_pid = nil
    end
  })
  
  vim.notify("Screen recording started. Press <leader>cr to stop.", vim.log.levels.INFO, {
    title = "Screen Recording",
    timeout = 3000,
  })
end

-- Function to stop screen recording
function M.stop_screen_recording()
  if M.recording_pid then
    vim.fn.jobstop(M.recording_pid)
    M.recording_pid = nil
    vim.notify("Screen recording stopped", vim.log.levels.INFO, {
      title = "Screen Recording",
      timeout = 2000,
    })
  else
    vim.notify("No active recording found", vim.log.levels.WARN, {
      title = "Screen Recording",
      timeout = 2000,
    })
  end
end

-- Function to capture code block with syntax highlighting
function M.capture_code_block()
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  local filetype = vim.bo.filetype
  
  local timestamp = os.date("%Y%m%d_%H%M%S")
  local output_file = string.format("~/Pictures/code_block_%s_%s.png", filetype, timestamp)
  
  -- Create a temporary file with the code
  local temp_file = "/tmp/code_capture_" .. timestamp .. "." .. filetype
  local f = io.open(temp_file, "w")
  if f then
    f:write(table.concat(lines, "\n"))
    f:close()
    
    -- Use bat or highlight to create syntax-highlighted output
    local highlight_cmd
    if vim.fn.executable("bat") == 1 then
      highlight_cmd = string.format("bat --style=full --color=always %s", temp_file)
    elseif vim.fn.executable("highlight") == 1 then
      highlight_cmd = string.format("highlight -O png %s", temp_file)
    else
      highlight_cmd = string.format("cat %s", temp_file)
    end
    
    -- Capture the highlighted output
    local cmd
    if vim.fn.system("echo $XDG_SESSION_TYPE") == "wayland\n" then
      cmd = string.format("%s | wl-screenshot -f %s", highlight_cmd, output_file)
    else
      cmd = string.format("%s | import -window root %s", highlight_cmd, output_file)
    end
    
    vim.fn.jobstart(cmd, {
      on_exit = function(_, code)
        if code == 0 then
          vim.notify("Code block captured to: " .. output_file, vim.log.levels.INFO, {
            title = "Code Capture",
            timeout = 3000,
          })
        else
          vim.notify("Failed to capture code block", vim.log.levels.ERROR, {
            title = "Code Capture",
            timeout = 3000,
          })
        end
        -- Clean up temp file
        os.remove(temp_file)
      end
    })
  end
end

-- Function to create ASCII art box around selection
function M.create_ascii_box()
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  
  -- Find the longest line for box width
  local max_width = 0
  for _, line in ipairs(lines) do
    max_width = math.max(max_width, #line)
  end
  
  -- Create box
  local box_top = "┌" .. string.rep("─", max_width + 2) .. "┐"
  local box_bottom = "└" .. string.rep("─", max_width + 2) .. "┘"
  
  -- Insert box around selection
  vim.api.nvim_buf_set_lines(0, start_line - 1, start_line - 1, false, {box_top})
  for i, line in ipairs(lines) do
    local padded_line = "│ " .. line .. string.rep(" ", max_width - #line) .. " │"
    vim.api.nvim_buf_set_lines(0, start_line + i - 1, start_line + i - 1, false, {padded_line})
  end
  vim.api.nvim_buf_set_lines(0, end_line + 1, end_line + 1, false, {box_bottom})
end

-- Function to toggle recording mode
function M.toggle_recording_mode()
  if M.recording_pid then
    M.stop_screen_recording()
  else
    M.start_screen_recording()
  end
end

-- Export functions globally
_G.code_capture = M

return M 