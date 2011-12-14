-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- Widget Library
require("vicious")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.add_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- Enable or disable widgets:
useMpd = true
----------------------------

--Widget Settings
widthMpd = 420 --Width of MPD widget
----------------------------

-- Widget update itervals (seconds)
updateMpd = 7
----------------------------


-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init("/home/vbim0nk/.config/awesome/themes/m0nastery/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {
   names = { "MAIN", "CHAT", "DEV", "CONFIG", "EXTRA" },
   layout = {
      layouts[1], layouts[1], layouts[1], layouts[1], layouts[1]
   }
}
for s = 1, screen.count() do
    tags[s] = awful.tag(tags.names, s, tags.layout)
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " /home/vbim0nk/.config/awesome/rc.lua.new" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

myappmenu = {
   { "Web Browser", "firefox"},
   { "Mail", "claws-mail"},
   { "Editor", "urxv -e vim"},
   { "Music Player", "banshee"},
   { "Video Player", "smplayer"},
   { "Audacity", "audacity"},
   { "GIMP", "gimp"},
   { "Inkscape", "inkscape"}
}

mysettingsmenu = {
   { "Sound", "pavucontrol"},
   { "Appearance", "lxappearance"},
   { "NVIDIA", "nvidia-settings"}
}

mymainmenu = awful.menu({ items = { { "programs", myappmenu },
				    { "settings", mysettingsmenu },
                                    { "awesome", myawesomemenu },
                                    { "open terminal", terminal },
				    { "lock screen", "xscreensaver-command -lock" }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.arch_icon),
                                     menu = mymainmenu })
-- }}}

-- Seperators
spacer = widget({ type = "textbox" })
seperator = widget({ type = "textbox" })
lbrac = widget({ type = "textbox" })
rbrac = widget({ type = "textbox" })
spacer.text = " "
seperator.text = "<span color='#8baeef'>] [</span>"
lbrac.text = "<span color='#8baeef'>[</span>"
rbrac.text = "<span color='#8baeef'>]</span>"


-- MPD Widget
-- MPD Widget
if useMpd == true then
  -- PLAY, STOP, PREV/NEXT Buttons
  -- requires modification of /usr/share/awesome/lib/awful/widget/launcher.lua
  --  b = util.table.join(w:buttons(), button({}, 1, nil, function () util.spawn(args.command) end))
  --  to:
  --  b = util.table.join(w:buttons(), button({}, 1, nil, function () util.spawn_with_shell(args.command) end))
  music_play = awful.widget.launcher({
    image = beautiful.widget_play,
    command = "mpc toggle && echo -e 'vicious.force({ mpdwidget, })' | awesome-client"
  })

  music_pause = awful.widget.launcher({
    image = beautiful.widget_pause,
    command = "mpc toggle && echo -e 'vicious.force({ mpdwidget, })' | awesome-client"
  })
  music_pause.visible = false

  music_stop = awful.widget.launcher({
    image = beautiful.widget_stop,
    command = "mpc stop && echo -e 'vicious.force({ mpdwidget, })' | awesome-client"
  })

  music_prev = awful.widget.launcher({
    image = beautiful.widget_prev,
    command = "mpc prev && echo -e 'vicious.force({ mpdwidget, })' | awesome-client"
  })

  music_next = awful.widget.launcher({
    image = beautiful.widget_next,
    command = "mpc next && echo -e 'vicious.force({ mpdwidget, })' | awesome-client"
  })


  mpdicon = widget({ type = "imagebox" })
  mpdicon.image = image(beautiful.widget_mpd)
  -- Initialize widget
  mpdwidget = widget({ type = "textbox" })
  --mpdwidget.wrap = "none"
  mpdwidget.width = widthMpd
  --mpdwidget.wrap = "word_char"
  -- Register Widget
  --vicious.register(mpdwidget, vicious.widgets.mpd, "(${state}) : ${Artist} - ${Title} ]", 13)
  -- Set the maximum width of the MPD widget inside the string.format function as "%.<length>s"
  vicious.register(mpdwidget, vicious.widgets.mpd,
    function(widget, args)
    --local maxlength = 85
      local font = beautiful.font
      local string = args["{Artist}"] .. " - " .. args["{Title}"]
      --local string = "[" .. args["{state}"] .. "]" .. " : " .. args["{Artist}"] .. " - " .. args["{Title}"]

      --[[                if maxlength < string.len(string) then
        return "<span font_desc='" .. font .. "'>" .. string.sub(string, 0, maxlength-6)  .. "</span> ..."
      else
        return "<span font_desc='" .. font .. "'>" .. string .. "</span>"
      end]]

      if args["{state}"] == "Play" then
        music_play.visible = false
        music_pause.visible = true
      else
        music_play.visible = true
        music_pause.visible = false
      end
      return string
    end, updateMpd)
end

-- CPU usage (text box)
cpuwidget = widget({ type = "textbox" })
vicious.register(cpuwidget, vicious.widgets.cpu, "CPU: <span color='#8baeef'>$1%</span>")

-- RAM widget (text box)
memwidget = widget({ type = "textbox" })
vicious.cache(vicious.widgets.mem)
vicious.register(memwidget, vicious.widgets.mem, "RAM: <span color='#8baeef'>$1%</span>", 13)

-- Volume widget
volumewidget = widget({ type = "textbox" })
--vicious.register(volumewidget, vicious.widgets.volume, "$1 $2", 2, "Master" )
channel = "Master"

--    local ifile = io.popen("amixer get " .. channel)
--    local fread = ifile:read("*all")
--    ifile:close()

--    local mute = string.match(fread, "off")
--    if mute ~= nil then
--        volumewidget.text = "--"
--    else
--        vicious.register(volumewidget, vicious.widgets.volume, "$1%", 2, channel)
--    end

-- TODO: Make a volume widget that displays an image based on mute/volume level

-- Uptime widget (text box)
--uptimewidget = widget({ type = "textbox" })
--vicious.register(uptimewidget, vicious.widgets.uptime, "uptime $2hrs", 3600)

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" })

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mybottomwibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            --mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        mytextclock,
        s == 1 and mysystray or nil,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }

    mybottomwibox[s] = awful.wibox({ position = "bottom", screen = s, border_width = 0, height = 18 })

    mybottomwibox[s].widgets = {
       {
         space, music_prev, music_play, music_pause, music_next, space, mpdwidget,
	 layout = awful.widget.layout.horizontal.leftright
       },
       spacer,
       rbrac,
       spacer,
       memwidget,
       spacer,
       seperator,
       spacer,
       cpuwidget,
       spacer,
       lbrac,
       spacer,
       --volumewidget,
       --uptimewidget,
       layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

    --Volume Manipulation
    awful.key({}, "XF86AudioRaiseVolume", function () awful.util.spawn("amixer set Master 5%+") end),
    awful.key({}, "XF86AudioLowerVolume", function () awful.util.spawn("amixer set Master 5%-") end),
    awful.key({}, "XF86AudioMute", function () awful.util.spawn("amixer set Master toggle") end),

    -- Media Keys
    awful.key({}, "XF86AudioPlay", function () awful.util.spawn("mpc toggle && echo -c 'vicious.force({ mpdwidget, })' | awesome-client") end),
    awful.key({}, "XF86AudioNext", function () awful.util.spawn("mpc next && echo -c 'vicious.force({ mpdwidget, })' | awesome-client") end),
    awful.key({}, "XF86AudioPrev", function () awful.util.spawn("mpc prev && echo -c 'vicious.force({ mpdwidget, })' | awesome-client") end),


    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
