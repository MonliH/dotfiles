-- IMPORTS
--
import           XMonad
import           Data.Monoid
import           Data.Word                      ( Word64 )
import           System.Exit
import           Control.Monad.State
import           GHC.IO.Handle                  ( Handle )

import           XMonad.Core                    ( X )
import           XMonad.Util.EZConfig
import           XMonad.Hooks.ManageDocks
import           XMonad.Util.SpawnOnce
import           XMonad.Util.Run
import           XMonad.Actions.Submap
import           XMonad.Hooks.DynamicLog
import           XMonad.Layout.Spacing
import           XMonad.Hooks.FadeInactive
import qualified XMonad.StackSet               as W
import qualified Data.Map                      as M

-- Set kitty to default terminal
myTerminal = "kitty"

-- Focus should follow mouse cursor
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
myBorderWidth = 0

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask = mod4Mask

myTextEditor :: String
myTextEditor = "nvim"

myFont :: String
myFont =
  "xft:FiraCode Nerd Font Mono:regular:size=11:antialias=true:hinting=true"

myBrowser :: String
myBrowser = "firefox-developer-edition"

myEditor :: String
myEditor = myTerminal ++ " -e nvim"

xmobarEscape = concatMap doubleLts
 where
  doubleLts '<' = "<<"
  doubleLts x   = [x]

-- Make workspaces clickable
myWorkspaces :: [String]
myWorkspaces = clickable . (map xmobarEscape) $ map show [1 .. 9]
 where
  clickable l =
    [ "<action=xdotool key super+" ++ show (n) ++ ">" ++ ws ++ "</action>"
    | (i, ws) <- zip [1 .. 5] l
    , let n = i
    ]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor = "#dddddd"
myFocusedBorderColor = "#63A0FF"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig { XMonad.modMask = modm }) =
  M.fromList
    $

    -- launch a terminal
       [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
       , ( (modm, xK_d)
         , spawn
           "rofi -modi drun -show drun -display-drun \"|>\" -font \"FiraCode Nerd Font 10\""
         )

    -- close focused window
       , ((modm .|. shiftMask, xK_q)    , kill)

     -- Rotate through the available layout algorithms
       , ((modm, xK_space)              , sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
       , ((modm .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
       , ((modm, xK_n)                  , refresh)

    -- Move focus to the next window
       , ((modm, xK_Tab)                , windows W.focusDown)

    -- Move focus to the next window
       , ((modm, xK_j)                  , windows W.focusDown)

    -- Move focus to the previous window
       , ((modm, xK_k)                  , windows W.focusUp)

    -- Move focus to the master window
       , ((modm, xK_m)                  , windows W.focusMaster)

    -- Swap the focused window and the master window
       , ((modm, xK_Return)             , windows W.swapMaster)

    -- Swap the focused window with the next window
       , ((modm .|. shiftMask, xK_j)    , windows W.swapDown)

    -- Swap the focused window with the previous window
       , ((modm .|. shiftMask, xK_k)    , windows W.swapUp)

    -- Shrink the master area
       , ((modm, xK_h)                  , sendMessage Shrink)

    -- Expand the master area
       , ((modm, xK_l)                  , sendMessage Expand)

    -- Push window back into tiling
       , ((modm, xK_t)                  , withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
       , ((modm, xK_comma)              , sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
       , ((modm, xK_period)             , sendMessage (IncMasterN (-1)))

    -- Power option
       , ( (modm, xK_p)
         , submap
         . M.fromList
         $ [ ((0, xK_l), io (exitWith ExitSuccess))
           , ((0, xK_s), spawn "systemctl poweroff")
           , ((0, xK_r), spawn "systemctl reboot")
           ]
         )

    -- Restart xmonad
       , ( (modm .|. shiftMask, xK_r)
         , spawn "xmonad --recompile; xmonad --restart"
         )
       ]

    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
       [ ((m .|. modm, k), windows $ f i)
       | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
       , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
       ]

myAdditionalKeys =
  [ ("<XF86MonBrightnessUp>"  , spawn "xbacklight +5")
  , ("<XF86MonBrightnessDown>", spawn "xbacklight -5")
  , ( "<XF86AudioRaiseVolume>"
    , spawn "pactl set-sink-volume @DEFAULT_SINK@ +10%"
    )
  , ( "<XF86AudioLowerVolume>"
    , spawn "pactl set-sink-volume @DEFAULT_SINK@ -10%"
    )
  , ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
  , ("<XF86MicMute>"  , spawn "pactl set-source-mute @DEFAULT_SOURCE@ toggle")
  ]

myMouseBindings (XConfig { XMonad.modMask = modm }) =
  M.fromList
    $

    -- mod-button1, Set the window to floating mode and move by dragging
      [ ( (modm, button1)
        , (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster)
        )

    -- mod-button2, Raise the window to the top of the stack
      , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
      , ( (modm, button3)
        , (\w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster)
        )

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
      ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.

borderAmount :: Integer
borderAmount = 0
mySpacing = spacingRaw
  True
  (Border borderAmount borderAmount borderAmount borderAmount)
  True
  (Border borderAmount borderAmount borderAmount borderAmount)
  True

myLayout = avoidStruts $ mySpacing (tiled ||| Mirror tiled ||| Full)
 where
     -- default tiling algorithm partitions the screen into two panes
  tiled   = Tall nmaster delta ratio

  -- The default number of windows in the master pane
  nmaster = 1

  -- Default proportion of screen occupied by master pane
  ratio   = 1 / 2

  -- Percent of screen to increment by when resizing panes
  delta   = 3 / 100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
  [ className =? "MPlayer" --> doFloat
  , className =? "Gimp" --> doFloat
  , resource =? "desktop_window" --> doIgnore
  , resource =? "kdesktop" --> doIgnore
  ]

getWindowState :: X (WindowSet)
getWindowState = do
  XState { windowset = old } <- get
  return $ old

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook :: Event -> X All
myEventHook ConfigureEvent { ev_event_type = createNotify, ev_window = id } =
  do
    ws <- W.integrate' . W.stack . W.workspace . W.current . windowset <$> get
    if length ws <= 1
      then do
        disableRoundedCorners id
        return (All True)
      else do
        enableRoundedCorners id
        return (All True)
 where
  disableRoundedCorners :: Word64 -> X ()
  disableRoundedCorners id =
    spawn
      $  "xprop -id "
      ++ show id
      ++ " -f _PICOM_ROUNDED 32c -set _PICOM_ROUNDED 1 "

  enableRoundedCorners :: Word64 -> X ()
  enableRoundedCorners id =
    spawn $ "xprop -id " ++ show id ++ " -remove _PICOM_ROUNDED"
myEventHook _ = return (All True)

myLogHook :: Handle -> X ()
myLogHook xmproc = do
  fadeInactiveLogHook fadeAmount
  dynamicLogWithPP xmobarPP { ppOutput  = hPutStrLn xmproc
                            , ppCurrent = xmobarColor "#5799FF" ""
                            , ppTitle   = const ""
                            , ppVisible = wrap "(" ")"
                            , ppUrgent  = xmobarColor "#FF5555" ""
                            , ppSep     = " | "
                            }
  where fadeAmount = 0.7

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
  spawnOnce "nitrogen --restore &"
  spawnOnce "picom &"
  spawnOnce "xrandr --output eDP1 --set \"Broadcast RGB\" \"Full\" &"
  spawnOnce "nm-applet &"
  spawnOnce "xbindkeys &"
  spawnOnce
    "setxkbmap -option 'caps:ctrl_modifier' && xcape -e 'Caps_Lock=Escape' &"
  spawnOnce "gtk-launch redshift-gtk.desktop &"
  spawnOnce
    "trayer --edge top --align right --widthtype request --padding 6 --SetDockType true --SetPartialStrut true --expand true --monitor 0 --transparent true --alpha 0 --tint 0x000000  --height 22 &"

main = do
  xmproc <- spawnPipe "/home/jonathan/.config/xmobar/launch.sh"
  xmonad $ docks $ defaults xmproc

defaults xmproc =
  def {
      -- simple stuff
        terminal           = myTerminal
      , focusFollowsMouse  = myFocusFollowsMouse
      , clickJustFocuses   = myClickJustFocuses
      , borderWidth        = myBorderWidth
      , modMask            = myModMask
      , workspaces         = myWorkspaces
      , normalBorderColor  = myNormalBorderColor
      , focusedBorderColor = myFocusedBorderColor

      -- key bindings
      , keys               = myKeys
      , mouseBindings      = myMouseBindings

      -- hooks, layouts
      , layoutHook         = myLayout
      , manageHook         = myManageHook
      , handleEventHook    = myEventHook
      , logHook            = myLogHook xmproc
      , startupHook        = myStartupHook
      }
    `additionalKeysP` myAdditionalKeys
