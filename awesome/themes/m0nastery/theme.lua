---------------------------
-- Default awesome theme --
---------------------------

theme = {}

home                = os.getenv("HOME")
themename           = "m0nastery"
themedir            = home .. "/.config/awesome/themes/" .. themename
themeicons = themedir .. "/icons"

theme.font          = "terminus 8"

--theme.bg_normal     = "#222222"
theme.bg_normal     = "#00000000"
theme.bg_focus      = "#00000000"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#4444440a"

theme.fg_normal     = "#18618e"
theme.fg_focus      = "#8baeef"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.border_width  = "1"
theme.border_normal = "#000000"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel   = themeicons .. "/taglist/squarefw.png"
theme.taglist_squares_unsel = themeicons .. "/taglist/squarew.png"

theme.tasklist_floating_icon = themeicons .. "/tasklist/floatingw.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themeicons .. "/submenu.png"
theme.menu_height = "15"
theme.menu_width  = "150"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = themeicons .. "/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = themeicons .. "/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = themeicons .. "/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themeicons .. "/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themeicons .. "/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themeicons .. "/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themeicons .. "/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themeicons .. "/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themeicons .. "/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themeicons .. "/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themeicons .. "/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themeicons .. "/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themeicons .. "/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themeicons .. "/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themeicons .. "/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themeicons .. "/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themeicons .. "/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themeicons .. "/titlebar/maximized_focus_active.png"

-- You can use your own command to set your wallpaper
theme.wallpaper_cmd = { "awsetbg /home/vbim0nk/.wallpaper.jpg" }

-- You can use your own layout icons like this:
theme.layout_fairh = themeicons .. "/layouts/fairhw.png"
theme.layout_fairv = themeicons .. "/layouts/fairvw.png"
theme.layout_floating  = themeicons .. "/layouts/floatingw.png"
theme.layout_magnifier = themeicons .. "/layouts/magnifierw.png"
theme.layout_max = themeicons .. "/layouts/maxw.png"
theme.layout_fullscreen = themeicons .. "/layouts/fullscreenw.png"
theme.layout_tilebottom = themeicons .. "/layouts/tilebottomw.png"
theme.layout_tileleft   = themeicons .. "/layouts/tileleftw.png"
theme.layout_tile = themeicons .. "/layouts/tilew.png"
theme.layout_tiletop = themeicons .. "/layouts/tiletopw.png"
theme.layout_spiral  = themeicons .. "/layouts/spiralw.png"
theme.layout_dwindle = themeicons .. "/layouts/dwindlew.png"

-- Icons

-- Menu
theme.arch_icon = themeicons .. "/arch_16x16.png"
theme.awesome_icon = themeicons .. "/awesome16.png"
theme.programs_icon = themeicons .. "/programs16.png"
theme.settings_icon = themeicons .. "/settings16.png"

-- Widgets
theme.widget_play = themeicons .. "/play.png"
theme.widget_pause = themeicons .. "/pause.png"
theme.widget_stop = themeicons .. "/stop.png"
theme.widget_prev = themeicons .. "/prev.png"
theme.widget_next = themeicons .. "/next.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
