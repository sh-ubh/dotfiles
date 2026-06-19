---@module 'hl'

--#################
--## MONITORS   ###
--#################

-- Placed at origin so it is the "left/main" display
hl.monitor({
    output   = "DP-1",
    mode     = "3840x2160@60",
    position = "0x0",
    scale    = 1.5,
    vrr      = 1, -- enable VRR/FreeSync
})

-- Laptop display — positioned at DP-1's logical width (3840/1.5 = 2560)
hl.monitor({
    output   = "eDP-1",
    mode     = "2560x1600@240",
    position = "2560x0",
    scale    = 1.33,
})

-- Catch-all: standalone mode
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1.5,
})

--####################
--## WORKSPACES    ###
--####################

-- Workspaces 1-4 pinned to external monitor, workspace 5 to laptop
-- Pinning prevents workspaces from floating to wrong monitor on focus
hl.workspace_rule({ workspace = "1", monitor = "DP-1", default = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-1" })
hl.workspace_rule({ workspace = "3", monitor = "DP-1" })
hl.workspace_rule({ workspace = "4", monitor = "DP-1" })
hl.workspace_rule({ workspace = "5", monitor = "eDP-1", default = true })

--####################
--## MY PROGRAMS   ###
--####################

local terminal    = "kitty"
local fileManager = "thunar"
local menu        = "wofi --show drun"
local browser     = "helium-browser"

--####################
--## AUTOSTART     ###
--####################

hl.on("hyprland.start", function()
    hl.exec_cmd("~/.config/hypr/scripts/wallpaper.sh")
    hl.exec_cmd("thunar --daemon")
    -- hl.exec_cmd("waybar")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("~/.config/hypr/scripts/power-watch.sh")
    hl.exec_cmd("kdeconnectd")
    hl.exec_cmd("sleep 2 && kdeconnect-indicator")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
end)

hl.config({
    xwayland = {
        use_nearest_neighbor = false, -- smooth bilinear scaling for XWayland apps
        force_zero_scaling   = true,  -- report physical resolution (3840x2160) to games
    },
})

-- hl.env("XCURSOR_SIZE", "24")
-- hl.env("XCURSOR_THEME", "Adwaita")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_STYLE_OVERRIDE", "Breeze")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- To run a specific app on NVIDIA (PRIME offload):
--   __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia <app>

--####################
--## LOOK AND FEEL ###
--####################

hl.config({
    general = {
        gaps_in          = 5,
        gaps_out         = 10,
        border_size      = 2,
        col              = {
            active_border   = "rgba(75736ffa)",
            inactive_border = "rgba(45475aaa)",
        },
        resize_on_border = true,
        allow_tearing    = true,
        layout           = "dwindle",
    },
})

hl.config({
    decoration = {
        rounding         = 12,
        active_opacity   = 1.0,
        inactive_opacity = 0.95,
        shadow           = {
            enabled        = true,
            range          = 8,
            render_power   = 2,
            color          = "rgba(1a1a2ecc)",
            color_inactive = "rgba(1a1a2e66)",
        },
        blur             = {
            enabled           = true,
            size              = 6,
            passes            = 2,
            new_optimizations = true,
            vibrancy          = 0.17,
        },
    },
})

hl.config({
    animations = { enabled = true },
    dwindle    = { preserve_split = true },
    master     = { new_status = "master" },
    misc       = {
        force_default_wallpaper  = 0,
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
        focus_on_activate        = true,
    },
})

--####################
--## ANIMATIONS    ###
--####################

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.22, 1 }, { 0.36, 1 } } })
hl.curve("easeInOutSine", { type = "bezier", points = { { 0.37, 0 }, { 0.63, 1 } } })
hl.curve("overshot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 4, bezier = "overshot", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 25, bezier = "linear", style = "loop" })
hl.animation({ leaf = "fade", enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3, bezier = "easeOutQuint", style = "slidevert" })

--#############
--## INPUT  ###
--#############

hl.config({
    input = {
        kb_layout      = "us",
        follow_mouse   = 1,
        sensitivity    = 0,
        accel_profile  = "flat",
        natural_scroll = true,
        touchpad       = {
            natural_scroll       = true,
            disable_while_typing = true,
            clickfinger_behavior = true,
            scroll_factor        = 0.8,
        },
    },
})

--##############
--## GESTURES ##
--##############

-- 3-finger horizontal swipe → switch workspaces
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- 3-finger swipe down + SUPER → toggle scratchpad
hl.gesture({ fingers = 3, direction = "down", mods = "SUPER", action = "special", workspace_name = "magic" })

-- 3-finger swipe up + SUPER → fullscreen toggle
hl.gesture({ fingers = 3, direction = "up", mods = "SUPER", action = "fullscreen" })

-- Note: "left" direction is covered by "horizontal", so float toggle is on 4-finger swipe left
hl.gesture({ fingers = 4, direction = "left", action = "float" })

--###################
--## KEYBINDINGS  ###
--###################

local mainMod = "SUPER"

-- ── Apps ─────────────────────────────────────────────────────────────────────
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd(terminal, { float = true, size = { 1000, 800 } }))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))

-- ── Window management ────────────────────────────────────────────────────────
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = 0 }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = 1 })) -- maximize (no gaps)
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + T", hl.dsp.layout("togglesplit"))

-- ── Move focus (HJKL + arrows) ───────────────────────────────────────────────
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- ── Move windows ─────────────────────────────────────────────────────────────
-- FIX: was missing hl.dsp.window.move() wrapper
hl.bind(mainMod .. " + Tab", hl.dsp.window.cycle_next())
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "d" }))
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "d" }))

-- ── Resize windows ───────────────────────────────────────────────────────────
hl.bind(mainMod .. " + CTRL + h", hl.dsp.window.resize({ x = -30, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + l", hl.dsp.window.resize({ x = 30, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + k", hl.dsp.window.resize({ x = 0, y = -30, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + j", hl.dsp.window.resize({ x = 0, y = 30, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + left", hl.dsp.window.resize({ x = -30, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ x = 30, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + up", hl.dsp.window.resize({ x = 0, y = -30, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + down", hl.dsp.window.resize({ x = 0, y = 30, relative = true }), { repeating = true })

-- FIX: workspace numbers must be strings in bind key; move needs { workspace = N }
for i = 1, 5 do
    hl.bind(mainMod .. " + " .. tostring(i), hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. tostring(i), hl.dsp.window.move({ workspace = i }))
end
-- Workspace 10 on key 0
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Cycle workspaces
hl.bind(mainMod .. " + bracketright", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + bracketleft", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- ── Mouse window control ─────────────────────────────────────────────────────
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- ── Brightness (brightnessctl) ───────────────────────────────────────────────
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { repeating = true })

-- External monitor (DP-1) via DDC/CI
hl.bind(mainMod .. " + XF86MonBrightnessUp", hl.dsp.exec_cmd("ddcutil setvcp 10 + 5"), { repeating = true })
hl.bind(mainMod .. " + XF86MonBrightnessDown", hl.dsp.exec_cmd("ddcutil setvcp 10 - 5"), { repeating = true })

-- ── Volume (wpctl) ────────────────────────────────────────────────────────────
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))

-- ── Media keys ───────────────────────────────────────────────────────────────
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

-- ── Screenshots (grim + slurp) ──────────────────────────────────────────────────────────────────
hl.bind(mainMod .. " + CTRL + S",
    hl.dsp.exec_cmd("grim -g \"$(slurp -d)\" - | wl-copy && notify-send 'Screenshot' 'Region copied to clipboard'"))
hl.bind(mainMod .. " + CTRL + SHIFT + S",
    hl.dsp.exec_cmd(
        "grim ~/Pictures/Screenshots/$(date +'%Y%m%d_%H%M%S.png') && notify-send 'Screenshot' 'Fullscreen saved'"))
hl.bind(mainMod .. " + CTRL + R",
    hl.dsp.exec_cmd(
        "grim -g \"$(slurp)\" ~/Pictures/Screenshots/$(date +'%Y%m%d_%H%M%S.png') && notify-send 'Screenshot' 'Region saved'"))

-- ── System ─────────────────────────────────────────────────────────────────────
hl.bind("CTRL + ALT + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("~/.config/hypr/scripts/powermenu.sh"))

--###################
--## WINDOW RULES ###
--###################

-- ── Steam games ──────────────────────────────────────────────────────────────
hl.window_rule({ name = "steam-fullscreen", match = { class = "^steam_app_\\d+$" }, fullscreen = true })
hl.window_rule({ name = "steam-monitor", match = { class = "^steam_app_\\d+$" }, monitor = "DP-1" })
hl.window_rule({ name = "steam-workspace", match = { class = "^steam_app_\\d+$" }, workspace = "10 silent" })
hl.window_rule({ name = "steam-tearing", match = { class = "^steam_app_\\d+$" }, immediate = true })
hl.window_rule({ name = "steam-noblur", match = { class = "^steam_app_\\d+$" }, no_blur = true })

-- gamescope window rules temporarily disabled for debugging
hl.window_rule({ name = "gamescope-fullscreen", match = { class = "gamescope" }, fullscreen = true })
hl.window_rule({ name = "gamescope-monitor",    match = { class = "gamescope" }, monitor = "DP-1" })
hl.window_rule({ name = "gamescope-workspace",  match = { class = "gamescope" }, workspace = "10 silent" })
hl.window_rule({ name = "gamescope-tearing",    match = { class = "gamescope" }, immediate = true })
hl.window_rule({ name = "gamescope-noblur",     match = { class = "gamescope" }, no_blur = true })

-- Workspace 10: dedicated gaming workspace, no decorations
hl.workspace_rule({ workspace = "10", monitor = "DP-1", border_size = 0 })

hl.window_rule({
    name           = "suppress-maximize",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name     = "fix-xwayland-drags",
    match    = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
    no_focus = true,
})

hl.window_rule({ name = "float-pavucontrol", match = { class = "^(pavucontrol)$" }, float = true })
hl.window_rule({ name = "float-nm-editor", match = { class = "^(nm-connection-editor)$" }, float = true })
hl.window_rule({ name = "float-blueman", match = { class = "^(blueman-manager)$" }, float = true })
hl.window_rule({ name = "float-file-progress", match = { title = "^(File Operation Progress)$" }, float = true })
hl.window_rule({ name = "float-portal", match = { class = "^(xdg-desktop-portal-gtk)$" }, float = true })

-- Fix screen sharing (xwaylandvideobridge)
-- hl.window_rule({
--     name             = "xwaylandvideobridge",
--     match            = { class = "^(xwaylandvideobridge)$" },
--     opacity          = 0,
--     no_anim          = true,
--     no_initial_focus = true,
--     max_size         = { 1, 1 },
-- })
