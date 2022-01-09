import XMonad
import Data.Monoid
import Data.Maybe (fromJust)
import XMonad.Util.CustomKeys
import System.Exit
import XMonad.Util.SpawnOnce
import XMonad.Util.Run(runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten,PP(..))
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.EwmhDesktops
import System.IO (hPutStrLn)
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts,ToggleLayout(Toggle))
import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))
import XMonad.Hooks.Minimize

import XMonad.Layout.Accordion
import XMonad.Layout.Renamed
import XMonad.Layout.Magnifier
import XMonad.Layout.MultiToggle
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.SimpleFloat
import XMonad.Layout.LayoutModifier
import XMonad.Layout.ResizableTile
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import XMonad.Layout.NoBorders
import XMonad.Layout.Fullscreen (fullscreenFull)
import XMonad.Layout.Cross(simpleCross)
import XMonad.Layout.Spiral(spiral)
import XMonad.Layout.Tabbed
import XMonad.Layout.Grid
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowNavigation
import XMonad.Layout.Simplest
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.IndependentScreens
import XMonad.Layout.Minimize
import XMonad.Layout.CenteredMaster(centerMaster)

import Graphics.X11.ExtraTypes.XF86
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

myTerminal      = "st"

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myClickJustFocuses :: Bool
myClickJustFocuses = False

myBorderWidth   = 2

myModMask       = mod4Mask

myWorkspaces   = ["1 ","2","3","4","5","6","7","8","9"]
--myWorkspaces = ["\61612","\61899","\61947","\61635","\61502","\61501","\61705","\61564","\62150"]
myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..] 

myNormalBorderColor  = "#ff0000"
myFocusedBorderColor = "#5500ff"

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    [ ((modm,               xK_Return), spawn $ XMonad.terminal conf)
    , ((modm,               xK_q     ), kill)
    , ((modm,               xK_Tab   ), sendMessage NextLayout)
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((modm,               xK_n     ), refresh)
    , ((modm .|. shiftMask, xK_Tab   ), windows W.focusDown)
    , ((modm,               xK_j     ), windows W.focusDown)
    , ((modm,               xK_k     ), windows W.focusUp  )
    , ((modm .|. controlMask, xK_Return), windows W.swapMaster)
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )
    , ((modm,               xK_h     ), sendMessage Shrink)
    , ((modm,               xK_l     ), sendMessage Expand)
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    , ((modm .|. controlMask, xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    , ((modm,               xK_m     ), sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts)
    ]
    ++

    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
    ]



myLayoutHook = spacingRaw True (Border 0 3 3 3) True (Border 3 3 3 3) True $ gaps [(U,3), (D,3), (R,3), (L,3)]
               $ avoidStruts
               $ T.toggleLayouts simpleFloat
               $ mkToggle (NBFULL ?? NOBORDERS ?? EOT)
               $ tiled ||| Grid ||| spiral (6/7) ||| simpleFloat ||| noBorders Full 
  where
     tiled   = Tall nmaster delta ratio
     nmaster = 1
     delta   = 3/100
     ratio   = 1/2

myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    , title     =? "gmrun"          --> doFloat
    , className =? "confirm"         --> doFloat
    , className =? "file_progress"   --> doFloat
    , className =? "dialog"          --> doFloat
    , className =? "download"        --> doFloat
    , className =? "error"           --> doFloat
    , className =? "Gimp"            --> doFloat
    , className =? "notification"    --> doFloat
    , className =? "pinentry-gtk-2"  --> doFloat
    , className =? "splash"          --> doFloat
    , className =? "toolbar"         --> doFloat
    , title =? "Oracle VM VirtualBox Manager"  --> doFloat
  ]

myEventHook = mempty

myLogHook = return ()

myStartupHook = return()

main :: IO()
main = do
     xmproc <- spawnPipe "polybar -c $HOME/.config/polybar/config.xmonad example"
     xmonad $ ewmh $ docks defaults
       { manageHook = manageDocks <+> manageHook defaultConfig
       , layoutHook = avoidStruts  $ myLayoutHook
      -- , logHook = dynamicLogWithPP $
       , handleEventHook = docksEventHook <+>fullscreenEventHook <+> minimizeEventHook
       }

defaults = def{
        terminal           = myTerminal
        ,focusFollowsMouse  = myFocusFollowsMouse
        ,clickJustFocuses   = myClickJustFocuses
        ,borderWidth        = myBorderWidth
        ,modMask            = myModMask
        ,workspaces         = myWorkspaces
        ,normalBorderColor  = myNormalBorderColor
        ,focusedBorderColor = myFocusedBorderColor
        ,keys               = myKeys
        ,mouseBindings      = myMouseBindings
        ,layoutHook         = myLayoutHook
        ,manageHook         = myManageHook
        ,handleEventHook    = myEventHook
        ,logHook            = myLogHook
        ,startupHook        = myStartupHook
    }
