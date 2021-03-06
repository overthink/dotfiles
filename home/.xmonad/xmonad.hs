import System.IO
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Run(spawnPipe)
import XMonad.Hooks.ICCCMFocus
import XMonad.Hooks.EwmhDesktops

myWorkspaces = ["1","2","3","4","5","6","7","8","9"]

myManageHook = composeAll
    [ className =? "Gimp"      --> doFloat
    , className =? "Vncviewer" --> doFloat
    ]

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/mark/.xmobarrc"
    xmonad $ ewmh defaultConfig { terminal = "urxvt" }
        { manageHook = manageDocks <+> manageHook defaultConfig
        , startupHook = setWMName "LG3D" -- fix for Java apps
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , logHook = do
            takeTopFocus
            dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        , workspaces = myWorkspaces
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_l), spawn "gnome-screensaver-command --lock")
        --, ((mod4Mask, xK_P), spawn "dmenu_run")
        ]

