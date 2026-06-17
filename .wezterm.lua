local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

--------------------------------------------------------------------------------
-- WSL Domains
--------------------------------------------------------------------------------
local wsl_domains = wezterm.default_wsl_domains()
for _, dom in ipairs(wsl_domains) do
	if dom.name == "WSL:FedoraLinux-44" then
		dom.username = "ngash"
		dom.default_cwd = "~"
	end
end
config.wsl_domains = wsl_domains
config.default_domain = "WSL:FedoraLinux-44"

--------------------------------------------------------------------------------
-- Appearance
--------------------------------------------------------------------------------
config.font_dirs = { "C:\\Windows\\Fonts" }
config.font = wezterm.font("MonoLisa Nerd Font")
config.font_size = 11
config.line_height = 1.2
config.warn_about_missing_glyphs = false

config.window_decorations = "RESIZE"
config.enable_tab_bar = false
config.window_background_opacity = 0.96

config.background = {
	{
		source = { File = { path = "C:\\Users\\Chomz\\wezterm-bg.png" } },
		opacity = 0.06,
		hsb = { brightness = 0.3 },
	},
}

--------------------------------------------------------------------------------
-- Colors
--------------------------------------------------------------------------------
config.colors = {
	foreground         = "#cdd6f4",
	background         = "#0f0f1a",
	cursor_bg          = "#007F47",
	cursor_border      = "#007F47",
	selection_bg       = "#45475a",
	ansi = {
		"#45475a", "#f38ba8", "#a6e3a1", "#f9e2af",
		"#89b4fa", "#f5c2e7", "#94e2d5", "#bac2de",
	},
	brights = {
		"#585b70", "#f38ba8", "#a6e3a1", "#f9e2af",
		"#89b4fa", "#f5c2e7", "#94e2d5", "#a6adc8",
	},
}

--------------------------------------------------------------------------------
-- Status Bar
--------------------------------------------------------------------------------
wezterm.on("update-status", function(window, pane)
	local cwd = pane:get_current_working_dir()
	local cwd_text = cwd and cwd or "~"
	local basename = cwd_text:match("([^/]+)$") or cwd_text
	local time = os.date("%H:%M")
	window:set_right_status(wezterm.format({
		{ Attribute = { Intensity = "Bold" } },
		{ Foreground = { AnsiColor = "Green" } },
		{ Text = "  " .. basename .. "  " },
		{ Foreground = { AnsiColor = "Silver" } },
		{ Text = time .. "  " },
	}))
end)

--------------------------------------------------------------------------------
-- Key Bindings
--------------------------------------------------------------------------------
config.keys = {
	{ key = "w", mods = "CTRL|SHIFT", action = act.CloseCurrentPane({ confirm = false }) },
	{ key = "}", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Next") },
	{ key = "{", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Prev") },

	{
		key = "Enter",
		mods = "CTRL|SHIFT",
		action = act.SplitPane({ direction = "Right", size = { Percent = 50 }, command = { cwd = "~" } }),
	},
	{ key = "t", mods = "CTRL|SHIFT", action = act.SpawnCommandInNewTab({ cwd = "~" }) },

	{
		key = "c",
		mods = "CTRL",
		action = wezterm.action_callback(function(window, pane)
			if window:get_selection_text_for_pane(pane) ~= "" then
				window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
			else
				window:perform_action(act.SendString("\x03"), pane)
			end
		end),
	},
	{ key = "v", mods = "CTRL", action = act.PasteFrom("Clipboard") },

	{ key = "Enter", mods = "SHIFT", action = act.SendString("\n") },

	{ key = "LeftArrow", mods = "CTRL", action = act.SendString("\x1bb") },
	{ key = "RightArrow", mods = "CTRL", action = act.SendString("\x1bf") },
	{ key = "Backspace", mods = "CTRL", action = act.SendString("\x08") },

	-- Unbind alt+enter (fullscreen) so broot can use it
	{ key = "Enter", mods = "ALT", action = act.DisableDefaultAssignment },
	-- Rebind fullscreen to F11 instead
	{ key = "F11", action = "ToggleFullScreen" },
}

--------------------------------------------------------------------------------
-- Mouse Bindings
--------------------------------------------------------------------------------
config.mouse_bindings = {
	{ event = { Up = { streak = 1, button = "Right" } }, mods = "CTRL", action = act.OpenLinkAtMouseCursor },
}

--------------------------------------------------------------------------------
-- Shell Integration
--------------------------------------------------------------------------------
config.scrollback_lines = 10000
config.hyperlink_rules = wezterm.default_hyperlink_rules()

--------------------------------------------------------------------------------
-- Advanced
--------------------------------------------------------------------------------
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 800

config.audible_bell = "Disabled"
config.visual_bell = {
	fade_in_function = "EaseIn",
	fade_in_duration_ms = 150,
	fade_out_function = "EaseOut",
	fade_out_duration_ms = 150,
}

config.animation_fps = 60
config.max_fps = 144

wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
	local gui_window = window:gui_window()
	if gui_window then
		local screens = wezterm.gui.screens()
		local screen = screens.active or screens.main
		if screen then
			local target_width = 1800
			local target_height = 970

			local inner_width = target_width
			local inner_height = target_height - 30

			local pos_x = screen.x + ((screen.width - target_width) / 2)
			local pos_y = screen.y + ((screen.height - target_height) / 2)

			gui_window:set_inner_size(inner_width, inner_height)
			gui_window:set_position(pos_x, pos_y)
		end
	end
end)

return config
