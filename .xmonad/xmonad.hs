import Control.Monad
import XMonad
import XMonad.Config.Gnome
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import XMonad.Layout.ShowWName
import qualified XMonad.StackSet as W

myWorkspaces = ["1","2","3","4","5","6","7","8","9"]

myManageHook = composeAll
    -- [ className =? "Gimp" --> doFloat
    [ className =? "Empathy" --> doFloat
    , className =? "Gcalctool" --> doFloat
    ]

myLayout = layoutHook gnomeConfig

main = xmonad gnomeConfig
        { modMask = mod4Mask -- use super/windows key instead of alt
        , workspaces = myWorkspaces
        , manageHook = myManageHook <+> manageHook gnomeConfig
        , startupHook = ewmhDesktopsStartup >> setWMName "LG3D" -- fix for Java apps
        -- , layoutHook = showWName myLayout
        , logHook = takeTopFocus
        }



-- Machinery to fix Java focus issue: http://permalink.gmane.org/gmane.comp.lang.haskell.xmonad/10693
-- This is supposed to be in xmonadcontirb, but not in Ubuntu 10.04...

atom_WM_TAKE_FOCUS ::
  X Atom
atom_WM_TAKE_FOCUS =
  getAtom "WM_TAKE_FOCUS"

takeFocusX ::
  Window
  -> X ()
takeFocusX w =
  withWindowSet . const $ do
    dpy       <- asks display
    wmtakef   <- atom_WM_TAKE_FOCUS
    wmprot    <- atom_WM_PROTOCOLS
    protocols <- io $ getWMProtocols dpy w
    when (wmtakef `elem` protocols) $
      io . allocaXEvent $ \ev -> do
          setEventType ev clientMessage
          setClientMessageEvent ev w wmprot 32 wmtakef currentTime
          sendEvent dpy w False noEventMask ev

-- | The value to add to your log hook configuration.
takeTopFocus ::
  X ()
takeTopFocus =
  (withWindowSet $ maybe (setFocusX =<< asks theRoot) takeFocusX . W.peek) >> setWMName "LG3D"  

