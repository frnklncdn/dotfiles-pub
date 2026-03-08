-- __  ____  __  ___  _   _    _    ____
-- \ \/ /  \/  |/ _ \| \ | |  / \  |  _ \
--  \  /| |\/| | | | |  \| | / _ \ | | | |
--  /  \| |  | | |_| | |\  |/ ___ \| |_| |
-- /_/\_\_|  |_|\___/|_| \_/_/   \_\____/

-- Fecha: 2025-11-29
-- Autor: Prof. Franklin Cedeño Cocho
-- Descripción: Configuración de xmonad

-- Base
import XMonad

-- Utilidades
import XMonad.Util.EZConfig (additionalKeysP) -- Sintaxis de atajos teclas legible

-- Hooks
import XMonad.Hooks.EwmhDesktops -- Compatibilidad con EWMH
import XMonad.Hooks.DynamicLog 
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.InsertPosition

-- Acciones
import XMonad.Actions.CycleWS (nextWS, prevWS, shiftToNext, shiftToPrev) -- Teclas de movimiento o navegación de ventanas

-- Layout
import XMonad.Layout.Spacing -- Espaciado entre ventanas
import XMonad.Layout.ThreeColumns -- Diseño de 03 columnas
import XMonad.Layout.Magnifier -- Amplía una ventana una cantidad determinada
import XMonad.Layout.NoBorders

colorBg = "#1a1b26" -- background
colorFg = "#a9b1d6" -- foreground
colorBlk = "#32344a" -- black
colorRed = "#f7768e" -- red
colorGrn = "#9ece6a" -- green
colorYlw = "#e0af68" -- yellow
colorBlu = "#7aa2f7" -- blue
colorMag = "#ad8ee6" -- magenta
colorCyn = "#0db9d7" -- cyan
colorBrBlk = "#444b6a" -- bright black
colorGra = "#44464d" -- gray
colorWhi = "#c2c2c2" -- white

myTerminal = "st"
myModMask = mod4Mask
myBorderWidth = 3
myNormalBorderColor = colorBrBlk
myFocusedBorderColor = colorBlu
mySpacing = spacingWithEdge 3
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

myLayout = avoidStruts $ mySpacing $ smartBorders tiled ||| Mirror tiled ||| noBorders Full ||| threeCol
    where
    threeCol = magnifiercz' 1.3 $ ThreeColMid nmaster delta ratio
    tiled    = Tall nmaster delta ratio
    nmaster  = 1      -- Numéro de ventanas en el panel master
    ratio    = 1/2    -- Proporción de pantalla ocupada por el panel master
    delta    = 3/100  -- Porcentaje de incremento en la ventana cuando cambia de tamaño

myLayoutHook = myLayout

myXmobarPP :: PP
myXmobarPP = def
    { ppSep             = xmobarColor colorGra "" "  |  "
    , ppCurrent         = xmobarColor colorBlu "" . wrap "  " "" . xmobarBorder "VBoth" colorBlu 3
    , ppHidden          = xmobarColor colorBlu "" . wrap  "  " "" 
    , ppHiddenNoWindows = xmobarColor colorWhi "" . wrap  "  " "" 
    }

myStatusBar = (statusBarProp "xmobar $HOME/.config/xmobar/xmobar.config" (pure myXmobarPP))

-- xprop | grep WM_CLASS
myManageHook :: ManageHook
myManageHook = composeAll
  [ className =? "St" --> doShift "1"
  , className =? "firefox-esr" --> doShift "2"
  , className =? "Emacs" --> doShift "3"
  , className =? "TelegramDesktop" --> doShift "5"
  , className =? "VeraCrypt" --> doShift "8"
  , className =? "Thunar" --> doShift "9"
  ]

myKeys = 
  -- Lanzar aplicaciones
  [ ("M-<Return>", spawn myTerminal)
  , -- Ventanas
    ("M-q", kill)
  , -- Compilar y Reiniciar
    ("M-S-r", spawn "xmonad --recompile" >> spawn "xmonad --restart")
  , -- Cambiar layout
    ("M-t", sendMessage $ JumpToLayout "Tall")
  , ("M-e", sendMessage $ JumpToLayout "Mirror Tall")
  , ("M-f", sendMessage $ JumpToLayout "Full")
  , ("M-n", sendMessage $ JumpToLayout "Magnifier NoMaster ThreeCol")
  , -- Navegar entre workspaces
    ("M-<Left>", prevWS)
  , ("M-<Right>", nextWS)
  , -- Mover ventanas entre workspaces
    ("M-S-<Left>",  shiftToPrev)
  , ("M-S-<Right>", shiftToNext)
  ]

myConfig = def
  { modMask = myModMask
  , terminal = myTerminal
  , workspaces = myWorkspaces
  , borderWidth = myBorderWidth
  , normalBorderColor = myNormalBorderColor
  , focusedBorderColor = myFocusedBorderColor
  , layoutHook = myLayoutHook
  , manageHook = myManageHook <+> manageDocks
  }
  `additionalKeysP` myKeys

main :: IO ()
main = xmonad . ewmhFullscreen . ewmh . withEasySB myStatusBar defToggleStrutsKey $ myConfig
