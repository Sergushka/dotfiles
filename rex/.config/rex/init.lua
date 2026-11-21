-- Rex configuration (~/.config/rex/init.lua)
-- Managed via GNU Stow in ~/dotfiles/rex
--
-- Philosophy: Mac-native Cmd shortcuts + Vim motions (no tmux/herdr prefix).
-- Rex layers these bindings over its built-in macOS defaults, so standard Mac
-- shortcuts stay intact:
--   cmd+t            New Tab (default)
--   cmd+w            Close Pane / Tab / Window (default)
--   shift+cmd+w      Close Window (default)
--   cmd+k            Switch Session (default)
--   shift+cmd+p      Command Palette (default)
--   shift+cmd+enter  Zoom / Unzoom Pane (default)
--   cmd+1..9         Go to Tab 1..9 (default)
--   shift+cmd+[/]    Previous / Next Tab (default)
--   cmd+,            Settings (default)

-- ============================================================================
-- Sessions & Windows (swapped so Session is primary, like Herdr workspaces)
-- ============================================================================
rex.bind("cmd+n", "session.new")
rex.bind("shift+cmd+n", "client.window.new")

-- Switch between sessions (sidebar is vertical, so j/k and up/down match layout)
rex.bind("opt+cmd+k", "session.previous")
rex.bind("opt+cmd+j", "session.next")
rex.bind("opt+cmd+up", "session.previous")
rex.bind("opt+cmd+down", "session.next")

-- ============================================================================
-- Tabs (cmd+t stays New Tab; ctrl+n stays untouched for Vim / shell)
-- ============================================================================
-- Direct tab switching matching Herdr & tmux
rex.bind("shift+left", "client.tab.previous")
rex.bind("shift+right", "client.tab.next")

-- ============================================================================
-- Helpers & Custom Actions (local & remote session aware)
-- ============================================================================
local TERMINAL = "com.superlogical.terminal"

local function is_vim(block_id)
  if not block_id then
    return false
  end
  local proc = rex.block.call(TERMINAL, "process", { block_id = block_id })
  local fg = proc and proc.foreground and proc.foreground.name
  if not fg then
    return false
  end
  fg = fg:lower()
  return fg == "nvim" or fg == "vim" or fg == "vi"
end

local function get_block_cwd(block_id)
  if not block_id then
    return nil
  end
  local pwd = rex.block.call(TERMINAL, "pwd", { block_id = block_id })
  if pwd and pwd.pwd and pwd.pwd ~= "" then
    return pwd.pwd
  end
  local proc = rex.block.call(TERMINAL, "process", { block_id = block_id })
  if proc and proc.foreground and proc.foreground.cwd and proc.foreground.cwd ~= "" then
    return proc.foreground.cwd
  end
  if proc and proc.home and proc.home ~= "" then
    return proc.home
  end
  return nil
end

rex.action({
  name = "floating_lazygit",
  title = "Floating Lazygit",
  description = "Open lazygit in a floating layer at the focused pane's working directory",
  run = function(ctx)
    local cwd = get_block_cwd(ctx.block_id)
    local shell = os.getenv("SHELL") or "/bin/sh"
    local opts = {
      command = { shell, "-lc", "exec lazygit" },
    }
    if cwd then
      opts.cwd = cwd
    end
    rex.session.new_layer({
      session_id = ctx.session_id,
      bounds = { 0.08, 0.08, 0.84, 0.84 },
      focus = true,
      layout = rex.layout.block({
        flavor = "com.superlogical.terminal.shell",
        label = "lazygit",
        options = opts,
      }),
    })
  end,
})

-- ============================================================================
-- Panes (Vim motions for focus & movement, Mac-native Cmd for splits)
-- ============================================================================
-- Focus panes directly (return false when nvim/vim is in foreground so Rex
-- passes the native keystroke—including Kitty keyboard protocol—through to it)
for key, dir in pairs({
  ["ctrl+h"] = "left",
  ["ctrl+j"] = "down",
  ["ctrl+k"] = "up",
  ["ctrl+l"] = "right",
}) do
  rex.bind(key, function(ctx)
    if is_vim(ctx.block_id) then
      return false
    end
    rex.session.focus_direction({ direction = dir })
    return true
  end)
end

-- Move / rearrange panes with Vim directions
rex.bind("ctrl+shift+h", "pane.move.left")
rex.bind("ctrl+shift+j", "pane.move.down")
rex.bind("ctrl+shift+k", "pane.move.up")
rex.bind("ctrl+shift+l", "pane.move.right")

-- Mac-native splits (iTerm2 / Ghostty convention)
rex.bind("cmd+d", "pane.split.right")
rex.bind("shift+cmd+d", "pane.split.down")

-- Balance splits
rex.bind("opt+cmd+=", "pane.balance")

-- ============================================================================
-- Vim-style Resize Mode (cmd+r to enter, h/j/k/l or arrows to resize, Esc/q to exit)
-- ============================================================================
rex.mode("resize", { exclusive = true })
rex.bind("cmd+r", "client.mode.enter", { name = "resize" })

-- Fine resize
rex.bind("resize/h", "pane.resize", { direction = "left", amount = 5 })
rex.bind("resize/j", "pane.resize", { direction = "down", amount = 5 })
rex.bind("resize/k", "pane.resize", { direction = "up", amount = 5 })
rex.bind("resize/l", "pane.resize", { direction = "right", amount = 5 })
rex.bind("resize/left", "pane.resize", { direction = "left", amount = 5 })
rex.bind("resize/down", "pane.resize", { direction = "down", amount = 5 })
rex.bind("resize/up", "pane.resize", { direction = "up", amount = 5 })
rex.bind("resize/right", "pane.resize", { direction = "right", amount = 5 })

-- Coarse resize
rex.bind("resize/shift+h", "pane.resize", { direction = "left", amount = 15 })
rex.bind("resize/shift+j", "pane.resize", { direction = "down", amount = 15 })
rex.bind("resize/shift+k", "pane.resize", { direction = "up", amount = 15 })
rex.bind("resize/shift+l", "pane.resize", { direction = "right", amount = 15 })

-- Balance and exit
rex.bind("resize/=", "pane.balance")
rex.bind("resize/esc", "client.mode.exit")
rex.bind("resize/q", "client.mode.exit")
rex.bind("resize/enter", "client.mode.exit")

-- ============================================================================
-- Vim Copy Mode (shift+cmd+v instead of default shift+cmd+c to avoid clipboard manager conflict)
-- ============================================================================
rex.unbind("shift+cmd+c", "pane.copy_mode.enter")
rex.bind("shift+cmd+v", "pane.copy_mode.enter")
-- Neovim-style Y (yank to end of line) alongside Rex's default D.
-- pane.copy_mode.* actions are only active inside Copy Mode, so Shift+Y still
-- types a normal "Y" everywhere else.
rex.bind("shift+y", "pane.copy_mode.copy_to_line_end")

-- ============================================================================
-- UI, Popups & Config (Herdr equivalents translated to Mac-native Cmd)
-- ============================================================================
rex.bind("cmd+g", "floating_lazygit")
rex.bind("cmd+b", "client.sidebar.toggle")
rex.bind("shift+cmd+r", "client.config.reload")
