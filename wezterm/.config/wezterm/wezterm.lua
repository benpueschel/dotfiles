local wezterm = require('wezterm');
local config = wezterm.config_builder();

config = {
	automatically_reload_config = true,
	enable_tab_bar = false,
	window_close_confirmation = "NeverPrompt",
	-- window_background_opacity = 0.7,
	font_size = 11.0,
	font = wezterm.font("JetBrains Mono"),
}

-- Check if the current OS is MacOS and set the font size to 14.0
if wezterm.target_triple == "x86_64-apple-darwin" or wezterm.target_triple == "aarch64-apple-darwin" then
	config.font_size = 14.0
end

return config
