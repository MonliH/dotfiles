-- Use the Nord theme: https://www.nordtheme.com/docs/colors-and-palettes
Config { 

   -- appearance
     font =         "xft:FiraCode Nerd Font Mono:pixelsize=16:antialias=true:hinting=true"
   , bgColor =      "#000000"
   , fgColor =      "#D8DEE9"
   , position =     Top

   -- layout
   , sepChar =  "%"   -- delineator between plugin names and straight text
   , alignSep = "}{"  -- separator between left-right alignment
   , template = " %UnsafeStdinReader% }{%date% | %multicpu%  %memory% | %alsa:default:Master%  %bright% | %battery% %padding%"
   -- general behavior
   , lowerOnStart =     True    -- send to bottom of window stack on start
   , hideOnStart =      False   -- start with window unmapped (hidden)
   , allDesktops =      True    -- show on all desktops
   , overrideRedirect = True    -- set the Override Redirect flag (Xlib)
   , pickBroadest =     False   -- choose widest display (multi-monitor)
   , persistent =       True    -- enable/disable hiding (True = disabled)

   -- plugins
   --   Numbers can be automatically colored according to their value. xmobar
   --   decides color based on a three-tier/two-cutoff system, controlled by
   --   command options:
   --     --Low sets the low cutoff
   --     --High sets the high cutoff
   --
   --     --low sets the color below --Low cutoff
   --     --normal sets the color between --Low and --High cutoffs
   --     --High sets the color above --High cutoff
   --
   --   The --template option controls how the plugin is displayed. Text
   --   color can be set by enclosing in <fc></fc> tags. For more details
   --   see http://projects.haskell.org/xmobar/#system-monitor-plugins.
   , commands = 
        [
        Run Com "/home/jonathan/.config/xmobar/trayer-padding-xmobar.sh" [] "padding" 20
        , Run MultiCpu       [ "--template" , " <total>%"
                             , "-p" , "2"
                             , "-c" , "0"
                             , "--Low"      , "50"         -- units: %
                             , "--High"     , "85"         -- units: %
                             , "--low"      , "#A3BE8C"
                             , "--normal"   , "#EBCB8B"
                             , "--high"     , "#BF616A"
                             ] 10
        , Run Memory         [ "--template" ," <usedratio>%"
                             , "-p" , "2"
                             , "-c" , "0"
                             , "--Low"      , "20"        -- units: %
                             , "--High"     , "90"        -- units: %
                             , "--low"      , "#A3BE8C"
                             , "--normal"   , "#EBCB8B"
                             , "--high"     , "#BF616A"
                             ] 10

        , Run Battery
                       [ "--template" , "<acstatus>"
                             , "--Low"      , "10"        -- units: %
                             , "--High"     , "80"        -- units: %
                             , "--low"      , "#BF616A"
                             , "--normal"   , "#EBCB8B"
                             , "--high"     , "#A3BE8C"
                             , "--" -- battery specififihsc options
                                       -- discharging status - use icons
                                       , "-l"   ,  "#BF616A"
                                       , "-m"   ,  "#EBCB8B"
                                       , "-h"   ,  "#A3BE8C"
                                       , "-o"   , ""
                                       , "--lows"     , " <left>% (<timeleft>)"
                                       , "--mediums"  , " <left>% (<timeleft>)"
                                       , "--highs"    , " <left>% (<timeleft>)"
                                       -- AC "on" status
                                       , "-O"  , " <left>% (<timeleft>)"
                                       -- charged status
                                       , "-i"  , ""
                                       , "-A", "20"
                             ] 50
        , Run Date           "%A, %B %e | <fc=#EBCB8B>%I:%M</fc>" "date" 10
        , Run Brightness 
           [ "-t", "<fc=#FFFB9E>盛 <percent>%</fc>",
              "--",
              "-D", "intel_backlight"
           ] 1
        , Run UnsafeStdinReader
        , Run Alsa "default" "Master" [
          "--template" , "<status>"
          , "--"
          , "-C" , "#A3BE8C"
          , "-c" , "#BF616A"
          , "-O", "<volume>%"
          , "-o", "ﱝ"
          , "--highs", " "
          , "--mediums", "墳 "
          , "--lows", "奔 "
        ]
        ]
   }
