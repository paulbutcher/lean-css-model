/-
Copyright (c) 2026 Paul Butcher. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module


@[expose] public section

/-! Keywords and functions, generated from `@webref/css` by `gen`. -/

namespace CssModel

/-- How a function variant's arguments are enclosed: `name( ... )`, `( ... )`, or `[ ... ]`. -/
inductive Bracket where
  | function | parens | brackets
  deriving DecidableEq, Repr

/-- A keyword some grammar admits. Keywords are ASCII case-insensitive; each is spelled as the data first spells it. -/
structure Keyword where
  id : Nat
  valid : id < 1007
  deriving DecidableEq, Repr

namespace Keyword

/-- `-infinity` -/
def «-infinity» : Keyword := ⟨0, by decide⟩
/-- `-webkit-legacy` -/
def webkitLegacy : Keyword := ⟨1, by decide⟩
/-- `A3` -/
def A3 : Keyword := ⟨2, by decide⟩
/-- `A4` -/
def A4 : Keyword := ⟨3, by decide⟩
/-- `A5` -/
def A5 : Keyword := ⟨4, by decide⟩
/-- `a98-rgb` -/
def a98Rgb : Keyword := ⟨5, by decide⟩
/-- `aa` -/
def aa : Keyword := ⟨6, by decide⟩
/-- `aaa` -/
def aaa : Keyword := ⟨7, by decide⟩
/-- `absolute` -/
def absolute : Keyword := ⟨8, by decide⟩
/-- `absolute-colorimetric` -/
def absoluteColorimetric : Keyword := ⟨9, by decide⟩
/-- `AccentColor` -/
def AccentColor : Keyword := ⟨10, by decide⟩
/-- `AccentColorText` -/
def AccentColorText : Keyword := ⟨11, by decide⟩
/-- `accumulate` -/
def accumulate : Keyword := ⟨12, by decide⟩
/-- `active` -/
def active : Keyword := ⟨13, by decide⟩
/-- `ActiveBorder` -/
def ActiveBorder : Keyword := ⟨14, by decide⟩
/-- `ActiveCaption` -/
def ActiveCaption : Keyword := ⟨15, by decide⟩
/-- `ActiveText` -/
def ActiveText : Keyword := ⟨16, by decide⟩
/-- `add` -/
def add : Keyword := ⟨17, by decide⟩
/-- `additive` -/
def additive : Keyword := ⟨18, by decide⟩
/-- `after` -/
def after : Keyword := ⟨19, by decide⟩
/-- `alias` -/
def alias : Keyword := ⟨20, by decide⟩
/-- `aliceblue` -/
def aliceblue : Keyword := ⟨21, by decide⟩
/-- `all` -/
def all : Keyword := ⟨22, by decide⟩
/-- `all-petite-caps` -/
def allPetiteCaps : Keyword := ⟨23, by decide⟩
/-- `all-scroll` -/
def allScroll : Keyword := ⟨24, by decide⟩
/-- `all-small-caps` -/
def allSmallCaps : Keyword := ⟨25, by decide⟩
/-- `allow-discrete` -/
def allowDiscrete : Keyword := ⟨26, by decide⟩
/-- `allow-end` -/
def allowEnd : Keyword := ⟨27, by decide⟩
/-- `allow-keywords` -/
def allowKeywords : Keyword := ⟨28, by decide⟩
/-- `alpha` -/
def alpha : Keyword := ⟨29, by decide⟩
/-- `alphabetic` -/
def alphabetic : Keyword := ⟨30, by decide⟩
/-- `alternate` -/
def alternate : Keyword := ⟨31, by decide⟩
/-- `alternate-reverse` -/
def alternateReverse : Keyword := ⟨32, by decide⟩
/-- `always` -/
def always : Keyword := ⟨33, by decide⟩
/-- `anchor-center` -/
def anchorCenter : Keyword := ⟨34, by decide⟩
/-- `anchor-valid` -/
def anchorValid : Keyword := ⟨35, by decide⟩
/-- `anchor-visible` -/
def anchorVisible : Keyword := ⟨36, by decide⟩
/-- `antiquewhite` -/
def antiquewhite : Keyword := ⟨37, by decide⟩
/-- `any` -/
def any : Keyword := ⟨38, by decide⟩
/-- `anywhere` -/
def anywhere : Keyword := ⟨39, by decide⟩
/-- `application` -/
def application : Keyword := ⟨40, by decide⟩
/-- `AppWorkspace` -/
def AppWorkspace : Keyword := ⟨41, by decide⟩
/-- `aqua` -/
def aqua : Keyword := ⟨42, by decide⟩
/-- `aquamarine` -/
def aquamarine : Keyword := ⟨43, by decide⟩
/-- `arc` -/
def arc : Keyword := ⟨44, by decide⟩
/-- `arcs` -/
def arcs : Keyword := ⟨45, by decide⟩
/-- `around` -/
def around : Keyword := ⟨46, by decide⟩
/-- `at` -/
def «at» : Keyword := ⟨47, by decide⟩
/-- `auto` -/
def auto : Keyword := ⟨48, by decide⟩
/-- `auto-add` -/
def autoAdd : Keyword := ⟨49, by decide⟩
/-- `auto-fill` -/
def autoFill : Keyword := ⟨50, by decide⟩
/-- `auto-fit` -/
def autoFit : Keyword := ⟨51, by decide⟩
/-- `auto-flow` -/
def autoFlow : Keyword := ⟨52, by decide⟩
/-- `auto-phrase` -/
def autoPhrase : Keyword := ⟨53, by decide⟩
/-- `avoid` -/
def avoid : Keyword := ⟨54, by decide⟩
/-- `avoid-column` -/
def avoidColumn : Keyword := ⟨55, by decide⟩
/-- `avoid-flex` -/
def avoidFlex : Keyword := ⟨56, by decide⟩
/-- `avoid-line` -/
def avoidLine : Keyword := ⟨57, by decide⟩
/-- `avoid-page` -/
def avoidPage : Keyword := ⟨58, by decide⟩
/-- `avoid-region` -/
def avoidRegion : Keyword := ⟨59, by decide⟩
/-- `avoid-short-last-line` -/
def avoidShortLastLine : Keyword := ⟨60, by decide⟩
/-- `azure` -/
def azure : Keyword := ⟨61, by decide⟩
/-- `B4` -/
def B4 : Keyword := ⟨62, by decide⟩
/-- `B5` -/
def B5 : Keyword := ⟨63, by decide⟩
/-- `back` -/
def back : Keyword := ⟨64, by decide⟩
/-- `Background` -/
def Background : Keyword := ⟨65, by decide⟩
/-- `backwards` -/
def backwards : Keyword := ⟨66, by decide⟩
/-- `balance` -/
def balance : Keyword := ⟨67, by decide⟩
/-- `balance-all` -/
def balanceAll : Keyword := ⟨68, by decide⟩
/-- `bar` -/
def bar : Keyword := ⟨69, by decide⟩
/-- `base` -/
def base : Keyword := ⟨70, by decide⟩
/-- `base-select` -/
def baseSelect : Keyword := ⟨71, by decide⟩
/-- `baseline` -/
def baseline : Keyword := ⟨72, by decide⟩
/-- `before` -/
def before : Keyword := ⟨73, by decide⟩
/-- `beige` -/
def beige : Keyword := ⟨74, by decide⟩
/-- `between` -/
def between : Keyword := ⟨75, by decide⟩
/-- `bevel` -/
def bevel : Keyword := ⟨76, by decide⟩
/-- `bidi-override` -/
def bidiOverride : Keyword := ⟨77, by decide⟩
/-- `bikeshed-this` -/
def bikeshedThis : Keyword := ⟨78, by decide⟩
/-- `bisque` -/
def bisque : Keyword := ⟨79, by decide⟩
/-- `black` -/
def black : Keyword := ⟨80, by decide⟩
/-- `blanchedalmond` -/
def blanchedalmond : Keyword := ⟨81, by decide⟩
/-- `blink` -/
def blink : Keyword := ⟨82, by decide⟩
/-- `block` -/
def block : Keyword := ⟨83, by decide⟩
/-- `block-end` -/
def blockEnd : Keyword := ⟨84, by decide⟩
/-- `block-start` -/
def blockStart : Keyword := ⟨85, by decide⟩
/-- `blue` -/
def blue : Keyword := ⟨86, by decide⟩
/-- `blueviolet` -/
def blueviolet : Keyword := ⟨87, by decide⟩
/-- `bold` -/
def bold : Keyword := ⟨88, by decide⟩
/-- `bolder` -/
def bolder : Keyword := ⟨89, by decide⟩
/-- `border-area` -/
def borderArea : Keyword := ⟨90, by decide⟩
/-- `border-box` -/
def borderBox : Keyword := ⟨91, by decide⟩
/-- `both` -/
def both : Keyword := ⟨92, by decide⟩
/-- `both-block` -/
def bothBlock : Keyword := ⟨93, by decide⟩
/-- `both-edges` -/
def bothEdges : Keyword := ⟨94, by decide⟩
/-- `both-inline` -/
def bothInline : Keyword := ⟨95, by decide⟩
/-- `bottom` -/
def bottom : Keyword := ⟨96, by decide⟩
/-- `bottom-to-top` -/
def bottomToTop : Keyword := ⟨97, by decide⟩
/-- `bounding-box` -/
def boundingBox : Keyword := ⟨98, by decide⟩
/-- `break` -/
def «break» : Keyword := ⟨99, by decide⟩
/-- `break-all` -/
def breakAll : Keyword := ⟨100, by decide⟩
/-- `break-spaces` -/
def breakSpaces : Keyword := ⟨101, by decide⟩
/-- `break-word` -/
def breakWord : Keyword := ⟨102, by decide⟩
/-- `brown` -/
def brown : Keyword := ⟨103, by decide⟩
/-- `browser` -/
def browser : Keyword := ⟨104, by decide⟩
/-- `bullets` -/
def bullets : Keyword := ⟨105, by decide⟩
/-- `burlywood` -/
def burlywood : Keyword := ⟨106, by decide⟩
/-- `butt` -/
def butt : Keyword := ⟨107, by decide⟩
/-- `button` -/
def button : Keyword := ⟨108, by decide⟩
/-- `ButtonBorder` -/
def ButtonBorder : Keyword := ⟨109, by decide⟩
/-- `ButtonFace` -/
def ButtonFace : Keyword := ⟨110, by decide⟩
/-- `ButtonHighlight` -/
def ButtonHighlight : Keyword := ⟨111, by decide⟩
/-- `ButtonShadow` -/
def ButtonShadow : Keyword := ⟨112, by decide⟩
/-- `ButtonText` -/
def ButtonText : Keyword := ⟨113, by decide⟩
/-- `by` -/
def «by» : Keyword := ⟨114, by decide⟩
/-- `cadetblue` -/
def cadetblue : Keyword := ⟨115, by decide⟩
/-- `Canvas` -/
def Canvas : Keyword := ⟨116, by decide⟩
/-- `CanvasText` -/
def CanvasText : Keyword := ⟨117, by decide⟩
/-- `cap` -/
def cap : Keyword := ⟨118, by decide⟩
/-- `cap-height` -/
def capHeight : Keyword := ⟨119, by decide⟩
/-- `capitalize` -/
def capitalize : Keyword := ⟨120, by decide⟩
/-- `caption` -/
def caption : Keyword := ⟨121, by decide⟩
/-- `CaptionText` -/
def CaptionText : Keyword := ⟨122, by decide⟩
/-- `ccw` -/
def ccw : Keyword := ⟨123, by decide⟩
/-- `cell` -/
def cell : Keyword := ⟨124, by decide⟩
/-- `center` -/
def center : Keyword := ⟨125, by decide⟩
/-- `central` -/
def central : Keyword := ⟨126, by decide⟩
/-- `ch-width` -/
def chWidth : Keyword := ⟨127, by decide⟩
/-- `chain` -/
def chain : Keyword := ⟨128, by decide⟩
/-- `chartreuse` -/
def chartreuse : Keyword := ⟨129, by decide⟩
/-- `checkbox` -/
def checkbox : Keyword := ⟨130, by decide⟩
/-- `child` -/
def child : Keyword := ⟨131, by decide⟩
/-- `chocolate` -/
def chocolate : Keyword := ⟨132, by decide⟩
/-- `circle` -/
def circle : Keyword := ⟨133, by decide⟩
/-- `clamp` -/
def clamp : Keyword := ⟨134, by decide⟩
/-- `clear` -/
def clear : Keyword := ⟨135, by decide⟩
/-- `clip` -/
def clip : Keyword := ⟨136, by decide⟩
/-- `clone` -/
def clone : Keyword := ⟨137, by decide⟩
/-- `close` -/
def close : Keyword := ⟨138, by decide⟩
/-- `close-quote` -/
def closeQuote : Keyword := ⟨139, by decide⟩
/-- `closed` -/
def closed : Keyword := ⟨140, by decide⟩
/-- `closest-corner` -/
def closestCorner : Keyword := ⟨141, by decide⟩
/-- `closest-side` -/
def closestSide : Keyword := ⟨142, by decide⟩
/-- `coarse` -/
def coarse : Keyword := ⟨143, by decide⟩
/-- `col-resize` -/
def colResize : Keyword := ⟨144, by decide⟩
/-- `collapse` -/
def collapse : Keyword := ⟨145, by decide⟩
/-- `collection` -/
def collection : Keyword := ⟨146, by decide⟩
/-- `color` -/
def color : Keyword := ⟨147, by decide⟩
/-- `color-burn` -/
def colorBurn : Keyword := ⟨148, by decide⟩
/-- `color-CBDT` -/
def colorCBDT : Keyword := ⟨149, by decide⟩
/-- `color-COLRv0` -/
def colorCOLRv0 : Keyword := ⟨150, by decide⟩
/-- `color-COLRv1` -/
def colorCOLRv1 : Keyword := ⟨151, by decide⟩
/-- `color-dodge` -/
def colorDodge : Keyword := ⟨152, by decide⟩
/-- `color-sbix` -/
def colorSbix : Keyword := ⟨153, by decide⟩
/-- `color-SVG` -/
def colorSVG : Keyword := ⟨154, by decide⟩
/-- `column` -/
def column : Keyword := ⟨155, by decide⟩
/-- `column-over-row` -/
def columnOverRow : Keyword := ⟨156, by decide⟩
/-- `column-reverse` -/
def columnReverse : Keyword := ⟨157, by decide⟩
/-- `common-ligatures` -/
def commonLigatures : Keyword := ⟨158, by decide⟩
/-- `compact` -/
def compact : Keyword := ⟨159, by decide⟩
/-- `compress` -/
def compress : Keyword := ⟨160, by decide⟩
/-- `condensed` -/
def condensed : Keyword := ⟨161, by decide⟩
/-- `consistent` -/
def consistent : Keyword := ⟨162, by decide⟩
/-- `constrained` -/
def constrained : Keyword := ⟨163, by decide⟩
/-- `contain` -/
def contain : Keyword := ⟨164, by decide⟩
/-- `content` -/
def content : Keyword := ⟨165, by decide⟩
/-- `content-block-size` -/
def contentBlockSize : Keyword := ⟨166, by decide⟩
/-- `content-box` -/
def contentBox : Keyword := ⟨167, by decide⟩
/-- `content-height` -/
def contentHeight : Keyword := ⟨168, by decide⟩
/-- `content-inline-size` -/
def contentInlineSize : Keyword := ⟨169, by decide⟩
/-- `content-width` -/
def contentWidth : Keyword := ⟨170, by decide⟩
/-- `contents` -/
def contents : Keyword := ⟨171, by decide⟩
/-- `context-menu` -/
def contextMenu : Keyword := ⟨172, by decide⟩
/-- `contextual` -/
def contextual : Keyword := ⟨173, by decide⟩
/-- `copy` -/
def copy : Keyword := ⟨174, by decide⟩
/-- `coral` -/
def coral : Keyword := ⟨175, by decide⟩
/-- `corners` -/
def corners : Keyword := ⟨176, by decide⟩
/-- `cornflowerblue` -/
def cornflowerblue : Keyword := ⟨177, by decide⟩
/-- `cornsilk` -/
def cornsilk : Keyword := ⟨178, by decide⟩
/-- `cover` -/
def cover : Keyword := ⟨179, by decide⟩
/-- `create` -/
def create : Keyword := ⟨180, by decide⟩
/-- `crimson` -/
def crimson : Keyword := ⟨181, by decide⟩
/-- `crisp-edges` -/
def «crisp-edges» : Keyword := ⟨182, by decide⟩
/-- `crispEdges` -/
def crispEdges : Keyword := ⟨183, by decide⟩
/-- `crop` -/
def crop : Keyword := ⟨184, by decide⟩
/-- `cross` -/
def cross : Keyword := ⟨185, by decide⟩
/-- `crosshair` -/
def crosshair : Keyword := ⟨186, by decide⟩
/-- `current` -/
def current : Keyword := ⟨187, by decide⟩
/-- `currentColor` -/
def currentColor : Keyword := ⟨188, by decide⟩
/-- `cursive` -/
def cursive : Keyword := ⟨189, by decide⟩
/-- `curve` -/
def curve : Keyword := ⟨190, by decide⟩
/-- `custom` -/
def custom : Keyword := ⟨191, by decide⟩
/-- `cw` -/
def cw : Keyword := ⟨192, by decide⟩
/-- `cyan` -/
def cyan : Keyword := ⟨193, by decide⟩
/-- `cyclic` -/
def cyclic : Keyword := ⟨194, by decide⟩
/-- `dark` -/
def dark : Keyword := ⟨195, by decide⟩
/-- `darkblue` -/
def darkblue : Keyword := ⟨196, by decide⟩
/-- `darkcyan` -/
def darkcyan : Keyword := ⟨197, by decide⟩
/-- `darken` -/
def darken : Keyword := ⟨198, by decide⟩
/-- `darkgoldenrod` -/
def darkgoldenrod : Keyword := ⟨199, by decide⟩
/-- `darkgray` -/
def darkgray : Keyword := ⟨200, by decide⟩
/-- `darkgreen` -/
def darkgreen : Keyword := ⟨201, by decide⟩
/-- `darkgrey` -/
def darkgrey : Keyword := ⟨202, by decide⟩
/-- `darkkhaki` -/
def darkkhaki : Keyword := ⟨203, by decide⟩
/-- `darkmagenta` -/
def darkmagenta : Keyword := ⟨204, by decide⟩
/-- `darkolivegreen` -/
def darkolivegreen : Keyword := ⟨205, by decide⟩
/-- `darkorange` -/
def darkorange : Keyword := ⟨206, by decide⟩
/-- `darkorchid` -/
def darkorchid : Keyword := ⟨207, by decide⟩
/-- `darkred` -/
def darkred : Keyword := ⟨208, by decide⟩
/-- `darksalmon` -/
def darksalmon : Keyword := ⟨209, by decide⟩
/-- `darkseagreen` -/
def darkseagreen : Keyword := ⟨210, by decide⟩
/-- `darkslateblue` -/
def darkslateblue : Keyword := ⟨211, by decide⟩
/-- `darkslategray` -/
def darkslategray : Keyword := ⟨212, by decide⟩
/-- `darkslategrey` -/
def darkslategrey : Keyword := ⟨213, by decide⟩
/-- `darkturquoise` -/
def darkturquoise : Keyword := ⟨214, by decide⟩
/-- `darkviolet` -/
def darkviolet : Keyword := ⟨215, by decide⟩
/-- `dashed` -/
def dashed : Keyword := ⟨216, by decide⟩
/-- `dashes` -/
def dashes : Keyword := ⟨217, by decide⟩
/-- `decreasing` -/
def decreasing : Keyword := ⟨218, by decide⟩
/-- `deeppink` -/
def deeppink : Keyword := ⟨219, by decide⟩
/-- `deepskyblue` -/
def deepskyblue : Keyword := ⟨220, by decide⟩
/-- `default` -/
def default : Keyword := ⟨221, by decide⟩
/-- `dense` -/
def dense : Keyword := ⟨222, by decide⟩
/-- `diagonal-fractions` -/
def diagonalFractions : Keyword := ⟨223, by decide⟩
/-- `difference` -/
def difference : Keyword := ⟨224, by decide⟩
/-- `digits` -/
def digits : Keyword := ⟨225, by decide⟩
/-- `dimgray` -/
def dimgray : Keyword := ⟨226, by decide⟩
/-- `dimgrey` -/
def dimgrey : Keyword := ⟨227, by decide⟩
/-- `disc` -/
def disc : Keyword := ⟨228, by decide⟩
/-- `discard` -/
def discard : Keyword := ⟨229, by decide⟩
/-- `discard-after` -/
def discardAfter : Keyword := ⟨230, by decide⟩
/-- `discard-before` -/
def discardBefore : Keyword := ⟨231, by decide⟩
/-- `discard-inner` -/
def discardInner : Keyword := ⟨232, by decide⟩
/-- `disclosure-closed` -/
def disclosureClosed : Keyword := ⟨233, by decide⟩
/-- `disclosure-open` -/
def disclosureOpen : Keyword := ⟨234, by decide⟩
/-- `discretionary-ligatures` -/
def discretionaryLigatures : Keyword := ⟨235, by decide⟩
/-- `display` -/
def display : Keyword := ⟨236, by decide⟩
/-- `display-p3` -/
def displayP3 : Keyword := ⟨237, by decide⟩
/-- `display-p3-linear` -/
def displayP3Linear : Keyword := ⟨238, by decide⟩
/-- `dodgerblue` -/
def dodgerblue : Keyword := ⟨239, by decide⟩
/-- `dot` -/
def dot : Keyword := ⟨240, by decide⟩
/-- `dotted` -/
def dotted : Keyword := ⟨241, by decide⟩
/-- `double` -/
def double : Keyword := ⟨242, by decide⟩
/-- `double-circle` -/
def doubleCircle : Keyword := ⟨243, by decide⟩
/-- `down` -/
def down : Keyword := ⟨244, by decide⟩
/-- `drop` -/
def drop : Keyword := ⟨245, by decide⟩
/-- `e-resize` -/
def eResize : Keyword := ⟨246, by decide⟩
/-- `each-line` -/
def eachLine : Keyword := ⟨247, by decide⟩
/-- `ease` -/
def ease : Keyword := ⟨248, by decide⟩
/-- `ease-in` -/
def easeIn : Keyword := ⟨249, by decide⟩
/-- `ease-in-out` -/
def easeInOut : Keyword := ⟨250, by decide⟩
/-- `ease-out` -/
def easeOut : Keyword := ⟨251, by decide⟩
/-- `economy` -/
def economy : Keyword := ⟨252, by decide⟩
/-- `element` -/
def element : Keyword := ⟨253, by decide⟩
/-- `ellipse` -/
def ellipse : Keyword := ⟨254, by decide⟩
/-- `ellipsis` -/
def ellipsis : Keyword := ⟨255, by decide⟩
/-- `embed` -/
def embed : Keyword := ⟨256, by decide⟩
/-- `embedded-opentype` -/
def embeddedOpentype : Keyword := ⟨257, by decide⟩
/-- `emoji` -/
def emoji : Keyword := ⟨258, by decide⟩
/-- `enabled` -/
def enabled : Keyword := ⟨259, by decide⟩
/-- `end` -/
def «end» : Keyword := ⟨260, by decide⟩
/-- `entry` -/
def entry : Keyword := ⟨261, by decide⟩
/-- `entry-crossing` -/
def entryCrossing : Keyword := ⟨262, by decide⟩
/-- `evenodd` -/
def evenodd : Keyword := ⟨263, by decide⟩
/-- `ew-resize` -/
def ewResize : Keyword := ⟨264, by decide⟩
/-- `ex` -/
def ex : Keyword := ⟨265, by decide⟩
/-- `ex-height` -/
def exHeight : Keyword := ⟨266, by decide⟩
/-- `exact` -/
def exact : Keyword := ⟨267, by decide⟩
/-- `exclude` -/
def exclude : Keyword := ⟨268, by decide⟩
/-- `exclusion` -/
def exclusion : Keyword := ⟨269, by decide⟩
/-- `exit` -/
def exit : Keyword := ⟨270, by decide⟩
/-- `exit-crossing` -/
def exitCrossing : Keyword := ⟨271, by decide⟩
/-- `expanded` -/
def expanded : Keyword := ⟨272, by decide⟩
/-- `extends` -/
def «extends» : Keyword := ⟨273, by decide⟩
/-- `extra-condensed` -/
def extraCondensed : Keyword := ⟨274, by decide⟩
/-- `extra-expanded` -/
def extraExpanded : Keyword := ⟨275, by decide⟩
/-- `fade` -/
def fade : Keyword := ⟨276, by decide⟩
/-- `fallback` -/
def fallback : Keyword := ⟨277, by decide⟩
/-- `false` -/
def false : Keyword := ⟨278, by decide⟩
/-- `fangsong` -/
def fangsong : Keyword := ⟨279, by decide⟩
/-- `fantasy` -/
def fantasy : Keyword := ⟨280, by decide⟩
/-- `farthest-corner` -/
def farthestCorner : Keyword := ⟨281, by decide⟩
/-- `farthest-side` -/
def farthestSide : Keyword := ⟨282, by decide⟩
/-- `fast` -/
def fast : Keyword := ⟨283, by decide⟩
/-- `features-aat` -/
def featuresAat : Keyword := ⟨284, by decide⟩
/-- `features-graphite` -/
def featuresGraphite : Keyword := ⟨285, by decide⟩
/-- `features-opentype` -/
def featuresOpentype : Keyword := ⟨286, by decide⟩
/-- `female` -/
def female : Keyword := ⟨287, by decide⟩
/-- `Field` -/
def Field : Keyword := ⟨288, by decide⟩
/-- `FieldText` -/
def FieldText : Keyword := ⟨289, by decide⟩
/-- `fill` -/
def fill : Keyword := ⟨290, by decide⟩
/-- `fill-box` -/
def fillBox : Keyword := ⟨291, by decide⟩
/-- `filled` -/
def filled : Keyword := ⟨292, by decide⟩
/-- `fine` -/
def fine : Keyword := ⟨293, by decide⟩
/-- `firebrick` -/
def firebrick : Keyword := ⟨294, by decide⟩
/-- `first` -/
def first : Keyword := ⟨295, by decide⟩
/-- `first-except` -/
def firstExcept : Keyword := ⟨296, by decide⟩
/-- `first-letter` -/
def firstLetter : Keyword := ⟨297, by decide⟩
/-- `fit-content` -/
def fitContent : Keyword := ⟨298, by decide⟩
/-- `fixed` -/
def fixed : Keyword := ⟨299, by decide⟩
/-- `fixed-position` -/
def fixedPosition : Keyword := ⟨300, by decide⟩
/-- `flat` -/
def flat : Keyword := ⟨301, by decide⟩
/-- `flex` -/
def flex : Keyword := ⟨302, by decide⟩
/-- `flex-end` -/
def flexEnd : Keyword := ⟨303, by decide⟩
/-- `flex-flow` -/
def flexFlow : Keyword := ⟨304, by decide⟩
/-- `flex-start` -/
def flexStart : Keyword := ⟨305, by decide⟩
/-- `flex-visual` -/
def flexVisual : Keyword := ⟨306, by decide⟩
/-- `flip` -/
def flip : Keyword := ⟨307, by decide⟩
/-- `flip-block` -/
def flipBlock : Keyword := ⟨308, by decide⟩
/-- `flip-inline` -/
def flipInline : Keyword := ⟨309, by decide⟩
/-- `flip-start` -/
def flipStart : Keyword := ⟨310, by decide⟩
/-- `flip-x` -/
def flipX : Keyword := ⟨311, by decide⟩
/-- `flip-y` -/
def flipY : Keyword := ⟨312, by decide⟩
/-- `floralwhite` -/
def floralwhite : Keyword := ⟨313, by decide⟩
/-- `flow` -/
def flow : Keyword := ⟨314, by decide⟩
/-- `flow-end` -/
def flowEnd : Keyword := ⟨315, by decide⟩
/-- `flow-root` -/
def flowRoot : Keyword := ⟨316, by decide⟩
/-- `flow-start` -/
def flowStart : Keyword := ⟨317, by decide⟩
/-- `focus` -/
def focus : Keyword := ⟨318, by decide⟩
/-- `footnote` -/
def footnote : Keyword := ⟨319, by decide⟩
/-- `force-end` -/
def forceEnd : Keyword := ⟨320, by decide⟩
/-- `force-hidden` -/
def forceHidden : Keyword := ⟨321, by decide⟩
/-- `forestgreen` -/
def forestgreen : Keyword := ⟨322, by decide⟩
/-- `forwards` -/
def forwards : Keyword := ⟨323, by decide⟩
/-- `fragments` -/
def fragments : Keyword := ⟨324, by decide⟩
/-- `from` -/
def «from» : Keyword := ⟨325, by decide⟩
/-- `from-font` -/
def fromFont : Keyword := ⟨326, by decide⟩
/-- `from-image` -/
def fromImage : Keyword := ⟨327, by decide⟩
/-- `fuchsia` -/
def fuchsia : Keyword := ⟨328, by decide⟩
/-- `full-size-kana` -/
def fullSizeKana : Keyword := ⟨329, by decide⟩
/-- `full-width` -/
def fullWidth : Keyword := ⟨330, by decide⟩
/-- `fullscreen` -/
def fullscreen : Keyword := ⟨331, by decide⟩
/-- `gainsboro` -/
def gainsboro : Keyword := ⟨332, by decide⟩
/-- `gaps` -/
def gaps : Keyword := ⟨333, by decide⟩
/-- `geometricPrecision` -/
def geometricPrecision : Keyword := ⟨334, by decide⟩
/-- `ghostwhite` -/
def ghostwhite : Keyword := ⟨335, by decide⟩
/-- `gold` -/
def gold : Keyword := ⟨336, by decide⟩
/-- `goldenrod` -/
def goldenrod : Keyword := ⟨337, by decide⟩
/-- `grab` -/
def grab : Keyword := ⟨338, by decide⟩
/-- `grabbing` -/
def grabbing : Keyword := ⟨339, by decide⟩
/-- `grammar-error` -/
def grammarError : Keyword := ⟨340, by decide⟩
/-- `gray` -/
def gray : Keyword := ⟨341, by decide⟩
/-- `GrayText` -/
def GrayText : Keyword := ⟨342, by decide⟩
/-- `green` -/
def green : Keyword := ⟨343, by decide⟩
/-- `greenyellow` -/
def greenyellow : Keyword := ⟨344, by decide⟩
/-- `grey` -/
def grey : Keyword := ⟨345, by decide⟩
/-- `grid` -/
def grid : Keyword := ⟨346, by decide⟩
/-- `grid-columns` -/
def gridColumns : Keyword := ⟨347, by decide⟩
/-- `grid-lanes` -/
def gridLanes : Keyword := ⟨348, by decide⟩
/-- `grid-order` -/
def gridOrder : Keyword := ⟨349, by decide⟩
/-- `grid-rows` -/
def gridRows : Keyword := ⟨350, by decide⟩
/-- `groove` -/
def groove : Keyword := ⟨351, by decide⟩
/-- `grow` -/
def grow : Keyword := ⟨352, by decide⟩
/-- `hairline` -/
def hairline : Keyword := ⟨353, by decide⟩
/-- `half-border-box` -/
def halfBorderBox : Keyword := ⟨354, by decide⟩
/-- `hanging` -/
def hanging : Keyword := ⟨355, by decide⟩
/-- `hard-light` -/
def hardLight : Keyword := ⟨356, by decide⟩
/-- `height` -/
def height : Keyword := ⟨357, by decide⟩
/-- `help` -/
def help : Keyword := ⟨358, by decide⟩
/-- `hidden` -/
def hidden : Keyword := ⟨359, by decide⟩
/-- `hide` -/
def hide : Keyword := ⟨360, by decide⟩
/-- `high` -/
def high : Keyword := ⟨361, by decide⟩
/-- `high-quality` -/
def highQuality : Keyword := ⟨362, by decide⟩
/-- `Highlight` -/
def Highlight : Keyword := ⟨363, by decide⟩
/-- `HighlightText` -/
def HighlightText : Keyword := ⟨364, by decide⟩
/-- `historical-forms` -/
def historicalForms : Keyword := ⟨365, by decide⟩
/-- `historical-ligatures` -/
def historicalLigatures : Keyword := ⟨366, by decide⟩
/-- `hline` -/
def hline : Keyword := ⟨367, by decide⟩
/-- `honeydew` -/
def honeydew : Keyword := ⟨368, by decide⟩
/-- `horizontal` -/
def horizontal : Keyword := ⟨369, by decide⟩
/-- `horizontal-tb` -/
def horizontalTb : Keyword := ⟨370, by decide⟩
/-- `hotpink` -/
def hotpink : Keyword := ⟨371, by decide⟩
/-- `hover` -/
def hover : Keyword := ⟨372, by decide⟩
/-- `hsl` -/
def hsl : Keyword := ⟨373, by decide⟩
/-- `hue` -/
def hue : Keyword := ⟨374, by decide⟩
/-- `hwb` -/
def hwb : Keyword := ⟨375, by decide⟩
/-- `ic-height` -/
def icHeight : Keyword := ⟨376, by decide⟩
/-- `ic-width` -/
def icWidth : Keyword := ⟨377, by decide⟩
/-- `icon` -/
def icon : Keyword := ⟨378, by decide⟩
/-- `ideograph-alpha` -/
def ideographAlpha : Keyword := ⟨379, by decide⟩
/-- `ideograph-numeric` -/
def ideographNumeric : Keyword := ⟨380, by decide⟩
/-- `ideographic` -/
def ideographic : Keyword := ⟨381, by decide⟩
/-- `ideographic-ink` -/
def ideographicInk : Keyword := ⟨382, by decide⟩
/-- `ideographic-space` -/
def ideographicSpace : Keyword := ⟨383, by decide⟩
/-- `in` -/
def «in» : Keyword := ⟨384, by decide⟩
/-- `InactiveBorder` -/
def InactiveBorder : Keyword := ⟨385, by decide⟩
/-- `InactiveCaption` -/
def InactiveCaption : Keyword := ⟨386, by decide⟩
/-- `InactiveCaptionText` -/
def InactiveCaptionText : Keyword := ⟨387, by decide⟩
/-- `increasing` -/
def increasing : Keyword := ⟨388, by decide⟩
/-- `incremental` -/
def incremental : Keyword := ⟨389, by decide⟩
/-- `indianred` -/
def indianred : Keyword := ⟨390, by decide⟩
/-- `indigo` -/
def indigo : Keyword := ⟨391, by decide⟩
/-- `inert` -/
def inert : Keyword := ⟨392, by decide⟩
/-- `infinite` -/
def infinite : Keyword := ⟨393, by decide⟩
/-- `infinity` -/
def infinity : Keyword := ⟨394, by decide⟩
/-- `InfoBackground` -/
def InfoBackground : Keyword := ⟨395, by decide⟩
/-- `InfoText` -/
def InfoText : Keyword := ⟨396, by decide⟩
/-- `inherit` -/
def inherit : Keyword := ⟨397, by decide⟩
/-- `initial` -/
def initial : Keyword := ⟨398, by decide⟩
/-- `initial-only` -/
def initialOnly : Keyword := ⟨399, by decide⟩
/-- `inline` -/
def inline : Keyword := ⟨400, by decide⟩
/-- `inline-block` -/
def inlineBlock : Keyword := ⟨401, by decide⟩
/-- `inline-end` -/
def inlineEnd : Keyword := ⟨402, by decide⟩
/-- `inline-flex` -/
def inlineFlex : Keyword := ⟨403, by decide⟩
/-- `inline-grid` -/
def inlineGrid : Keyword := ⟨404, by decide⟩
/-- `inline-grid-lanes` -/
def inlineGridLanes : Keyword := ⟨405, by decide⟩
/-- `inline-size` -/
def inlineSize : Keyword := ⟨406, by decide⟩
/-- `inline-start` -/
def inlineStart : Keyword := ⟨407, by decide⟩
/-- `inline-table` -/
def inlineTable : Keyword := ⟨408, by decide⟩
/-- `inner` -/
def inner : Keyword := ⟨409, by decide⟩
/-- `insert` -/
def insert : Keyword := ⟨410, by decide⟩
/-- `inset` -/
def inset : Keyword := ⟨411, by decide⟩
/-- `inside` -/
def inside : Keyword := ⟨412, by decide⟩
/-- `inter-character` -/
def interCharacter : Keyword := ⟨413, by decide⟩
/-- `inter-word` -/
def interWord : Keyword := ⟨414, by decide⟩
/-- `interlace` -/
def interlace : Keyword := ⟨415, by decide⟩
/-- `intersect` -/
def intersect : Keyword := ⟨416, by decide⟩
/-- `intersection` -/
def intersection : Keyword := ⟨417, by decide⟩
/-- `inverted` -/
def inverted : Keyword := ⟨418, by decide⟩
/-- `isolate` -/
def isolate : Keyword := ⟨419, by decide⟩
/-- `isolate-override` -/
def isolateOverride : Keyword := ⟨420, by decide⟩
/-- `italic` -/
def italic : Keyword := ⟨421, by decide⟩
/-- `ivory` -/
def ivory : Keyword := ⟨422, by decide⟩
/-- `JIS-B4` -/
def JISB4 : Keyword := ⟨423, by decide⟩
/-- `JIS-B5` -/
def JISB5 : Keyword := ⟨424, by decide⟩
/-- `jis04` -/
def jis04 : Keyword := ⟨425, by decide⟩
/-- `jis78` -/
def jis78 : Keyword := ⟨426, by decide⟩
/-- `jis83` -/
def jis83 : Keyword := ⟨427, by decide⟩
/-- `jis90` -/
def jis90 : Keyword := ⟨428, by decide⟩
/-- `jump-both` -/
def jumpBoth : Keyword := ⟨429, by decide⟩
/-- `jump-end` -/
def jumpEnd : Keyword := ⟨430, by decide⟩
/-- `jump-none` -/
def jumpNone : Keyword := ⟨431, by decide⟩
/-- `jump-start` -/
def jumpStart : Keyword := ⟨432, by decide⟩
/-- `justify` -/
def justify : Keyword := ⟨433, by decide⟩
/-- `justify-all` -/
def justifyAll : Keyword := ⟨434, by decide⟩
/-- `kai` -/
def kai : Keyword := ⟨435, by decide⟩
/-- `keep` -/
def keep : Keyword := ⟨436, by decide⟩
/-- `keep-all` -/
def keepAll : Keyword := ⟨437, by decide⟩
/-- `khaki` -/
def khaki : Keyword := ⟨438, by decide⟩
/-- `khmer-mul` -/
def khmerMul : Keyword := ⟨439, by decide⟩
/-- `lab` -/
def lab : Keyword := ⟨440, by decide⟩
/-- `landscape` -/
def landscape : Keyword := ⟨441, by decide⟩
/-- `large` -/
def large : Keyword := ⟨442, by decide⟩
/-- `larger` -/
def larger : Keyword := ⟨443, by decide⟩
/-- `last` -/
def last : Keyword := ⟨444, by decide⟩
/-- `last-baseline` -/
def lastBaseline : Keyword := ⟨445, by decide⟩
/-- `lavender` -/
def lavender : Keyword := ⟨446, by decide⟩
/-- `lavenderblush` -/
def lavenderblush : Keyword := ⟨447, by decide⟩
/-- `lawngreen` -/
def lawngreen : Keyword := ⟨448, by decide⟩
/-- `layout` -/
def layout : Keyword := ⟨449, by decide⟩
/-- `lch` -/
def lch : Keyword := ⟨450, by decide⟩
/-- `leading` -/
def leading : Keyword := ⟨451, by decide⟩
/-- `ledger` -/
def ledger : Keyword := ⟨452, by decide⟩
/-- `left` -/
def left : Keyword := ⟨453, by decide⟩
/-- `left-to-right` -/
def leftToRight : Keyword := ⟨454, by decide⟩
/-- `leftwards` -/
def leftwards : Keyword := ⟨455, by decide⟩
/-- `legacy` -/
def legacy : Keyword := ⟨456, by decide⟩
/-- `legal` -/
def legal : Keyword := ⟨457, by decide⟩
/-- `lemonchiffon` -/
def lemonchiffon : Keyword := ⟨458, by decide⟩
/-- `less` -/
def less : Keyword := ⟨459, by decide⟩
/-- `letter` -/
def letter : Keyword := ⟨460, by decide⟩
/-- `light` -/
def light : Keyword := ⟨461, by decide⟩
/-- `lightblue` -/
def lightblue : Keyword := ⟨462, by decide⟩
/-- `lightcoral` -/
def lightcoral : Keyword := ⟨463, by decide⟩
/-- `lightcyan` -/
def lightcyan : Keyword := ⟨464, by decide⟩
/-- `lighten` -/
def lighten : Keyword := ⟨465, by decide⟩
/-- `lighter` -/
def lighter : Keyword := ⟨466, by decide⟩
/-- `lightgoldenrodyellow` -/
def lightgoldenrodyellow : Keyword := ⟨467, by decide⟩
/-- `lightgray` -/
def lightgray : Keyword := ⟨468, by decide⟩
/-- `lightgreen` -/
def lightgreen : Keyword := ⟨469, by decide⟩
/-- `lightgrey` -/
def lightgrey : Keyword := ⟨470, by decide⟩
/-- `lightpink` -/
def lightpink : Keyword := ⟨471, by decide⟩
/-- `lightsalmon` -/
def lightsalmon : Keyword := ⟨472, by decide⟩
/-- `lightseagreen` -/
def lightseagreen : Keyword := ⟨473, by decide⟩
/-- `lightskyblue` -/
def lightskyblue : Keyword := ⟨474, by decide⟩
/-- `lightslategray` -/
def lightslategray : Keyword := ⟨475, by decide⟩
/-- `lightslategrey` -/
def lightslategrey : Keyword := ⟨476, by decide⟩
/-- `lightsteelblue` -/
def lightsteelblue : Keyword := ⟨477, by decide⟩
/-- `lightyellow` -/
def lightyellow : Keyword := ⟨478, by decide⟩
/-- `lime` -/
def lime : Keyword := ⟨479, by decide⟩
/-- `limegreen` -/
def limegreen : Keyword := ⟨480, by decide⟩
/-- `line` -/
def line : Keyword := ⟨481, by decide⟩
/-- `line-through` -/
def lineThrough : Keyword := ⟨482, by decide⟩
/-- `linear` -/
def linear : Keyword := ⟨483, by decide⟩
/-- `linearRGB` -/
def linearRGB : Keyword := ⟨484, by decide⟩
/-- `linen` -/
def linen : Keyword := ⟨485, by decide⟩
/-- `lining-nums` -/
def liningNums : Keyword := ⟨486, by decide⟩
/-- `links` -/
def links : Keyword := ⟨487, by decide⟩
/-- `LinkText` -/
def LinkText : Keyword := ⟨488, by decide⟩
/-- `list-item` -/
def listItem : Keyword := ⟨489, by decide⟩
/-- `listbox` -/
def listbox : Keyword := ⟨490, by decide⟩
/-- `literal-punctuation` -/
def literalPunctuation : Keyword := ⟨491, by decide⟩
/-- `local` -/
def «local» : Keyword := ⟨492, by decide⟩
/-- `longer` -/
def longer : Keyword := ⟨493, by decide⟩
/-- `loose` -/
def loose : Keyword := ⟨494, by decide⟩
/-- `loud` -/
def loud : Keyword := ⟨495, by decide⟩
/-- `low` -/
def low : Keyword := ⟨496, by decide⟩
/-- `lowercase` -/
def lowercase : Keyword := ⟨497, by decide⟩
/-- `ltr` -/
def ltr : Keyword := ⟨498, by decide⟩
/-- `luminance` -/
def luminance : Keyword := ⟨499, by decide⟩
/-- `luminosity` -/
def luminosity : Keyword := ⟨500, by decide⟩
/-- `magenta` -/
def magenta : Keyword := ⟨501, by decide⟩
/-- `male` -/
def male : Keyword := ⟨502, by decide⟩
/-- `mandatory` -/
def mandatory : Keyword := ⟨503, by decide⟩
/-- `manipulation` -/
def manipulation : Keyword := ⟨504, by decide⟩
/-- `manual` -/
def manual : Keyword := ⟨505, by decide⟩
/-- `margin-box` -/
def marginBox : Keyword := ⟨506, by decide⟩
/-- `Mark` -/
def Mark : Keyword := ⟨507, by decide⟩
/-- `marker` -/
def marker : Keyword := ⟨508, by decide⟩
/-- `markers` -/
def markers : Keyword := ⟨509, by decide⟩
/-- `MarkText` -/
def MarkText : Keyword := ⟨510, by decide⟩
/-- `maroon` -/
def maroon : Keyword := ⟨511, by decide⟩
/-- `match-parent` -/
def matchParent : Keyword := ⟨512, by decide⟩
/-- `match-self` -/
def matchSelf : Keyword := ⟨513, by decide⟩
/-- `match-source` -/
def matchSource : Keyword := ⟨514, by decide⟩
/-- `math` -/
def math : Keyword := ⟨515, by decide⟩
/-- `math-auto` -/
def mathAuto : Keyword := ⟨516, by decide⟩
/-- `mathematical` -/
def mathematical : Keyword := ⟨517, by decide⟩
/-- `max-content` -/
def maxContent : Keyword := ⟨518, by decide⟩
/-- `maximized` -/
def maximized : Keyword := ⟨519, by decide⟩
/-- `maximum` -/
def maximum : Keyword := ⟨520, by decide⟩
/-- `medium` -/
def medium : Keyword := ⟨521, by decide⟩
/-- `mediumaquamarine` -/
def mediumaquamarine : Keyword := ⟨522, by decide⟩
/-- `mediumblue` -/
def mediumblue : Keyword := ⟨523, by decide⟩
/-- `mediumorchid` -/
def mediumorchid : Keyword := ⟨524, by decide⟩
/-- `mediumpurple` -/
def mediumpurple : Keyword := ⟨525, by decide⟩
/-- `mediumseagreen` -/
def mediumseagreen : Keyword := ⟨526, by decide⟩
/-- `mediumslateblue` -/
def mediumslateblue : Keyword := ⟨527, by decide⟩
/-- `mediumspringgreen` -/
def mediumspringgreen : Keyword := ⟨528, by decide⟩
/-- `mediumturquoise` -/
def mediumturquoise : Keyword := ⟨529, by decide⟩
/-- `mediumvioletred` -/
def mediumvioletred : Keyword := ⟨530, by decide⟩
/-- `menu` -/
def menu : Keyword := ⟨531, by decide⟩
/-- `menulist` -/
def menulist : Keyword := ⟨532, by decide⟩
/-- `menulist-button` -/
def menulistButton : Keyword := ⟨533, by decide⟩
/-- `MenuText` -/
def MenuText : Keyword := ⟨534, by decide⟩
/-- `merge` -/
def merge : Keyword := ⟨535, by decide⟩
/-- `message-box` -/
def messageBox : Keyword := ⟨536, by decide⟩
/-- `meter` -/
def meter : Keyword := ⟨537, by decide⟩
/-- `middle` -/
def middle : Keyword := ⟨538, by decide⟩
/-- `midnightblue` -/
def midnightblue : Keyword := ⟨539, by decide⟩
/-- `min-content` -/
def minContent : Keyword := ⟨540, by decide⟩
/-- `minimal-ui` -/
def minimalUi : Keyword := ⟨541, by decide⟩
/-- `minimized` -/
def minimized : Keyword := ⟨542, by decide⟩
/-- `minimum` -/
def minimum : Keyword := ⟨543, by decide⟩
/-- `mintcream` -/
def mintcream : Keyword := ⟨544, by decide⟩
/-- `mistyrose` -/
def mistyrose : Keyword := ⟨545, by decide⟩
/-- `miter` -/
def miter : Keyword := ⟨546, by decide⟩
/-- `mixed` -/
def mixed : Keyword := ⟨547, by decide⟩
/-- `moccasin` -/
def moccasin : Keyword := ⟨548, by decide⟩
/-- `moderate` -/
def moderate : Keyword := ⟨549, by decide⟩
/-- `monospace` -/
def monospace : Keyword := ⟨550, by decide⟩
/-- `more` -/
def more : Keyword := ⟨551, by decide⟩
/-- `most-block-size` -/
def mostBlockSize : Keyword := ⟨552, by decide⟩
/-- `most-height` -/
def mostHeight : Keyword := ⟨553, by decide⟩
/-- `most-inline-size` -/
def mostInlineSize : Keyword := ⟨554, by decide⟩
/-- `most-width` -/
def mostWidth : Keyword := ⟨555, by decide⟩
/-- `move` -/
def move : Keyword := ⟨556, by decide⟩
/-- `multiply` -/
def multiply : Keyword := ⟨557, by decide⟩
/-- `n-resize` -/
def nResize : Keyword := ⟨558, by decide⟩
/-- `narrow` -/
def narrow : Keyword := ⟨559, by decide⟩
/-- `nastaliq` -/
def nastaliq : Keyword := ⟨560, by decide⟩
/-- `navajowhite` -/
def navajowhite : Keyword := ⟨561, by decide⟩
/-- `navy` -/
def navy : Keyword := ⟨562, by decide⟩
/-- `ne-resize` -/
def neResize : Keyword := ⟨563, by decide⟩
/-- `near` -/
def near : Keyword := ⟨564, by decide⟩
/-- `nearest` -/
def nearest : Keyword := ⟨565, by decide⟩
/-- `nesw-resize` -/
def neswResize : Keyword := ⟨566, by decide⟩
/-- `neutral` -/
def neutral : Keyword := ⟨567, by decide⟩
/-- `never` -/
def never : Keyword := ⟨568, by decide⟩
/-- `no-autospace` -/
def noAutospace : Keyword := ⟨569, by decide⟩
/-- `no-clip` -/
def noClip : Keyword := ⟨570, by decide⟩
/-- `no-close-quote` -/
def noCloseQuote : Keyword := ⟨571, by decide⟩
/-- `no-common-ligatures` -/
def noCommonLigatures : Keyword := ⟨572, by decide⟩
/-- `no-compress` -/
def noCompress : Keyword := ⟨573, by decide⟩
/-- `no-contextual` -/
def noContextual : Keyword := ⟨574, by decide⟩
/-- `no-discretionary-ligatures` -/
def noDiscretionaryLigatures : Keyword := ⟨575, by decide⟩
/-- `no-drop` -/
def noDrop : Keyword := ⟨576, by decide⟩
/-- `no-ellipsis` -/
def noEllipsis : Keyword := ⟨577, by decide⟩
/-- `no-historical-ligatures` -/
def noHistoricalLigatures : Keyword := ⟨578, by decide⟩
/-- `no-limit` -/
def noLimit : Keyword := ⟨579, by decide⟩
/-- `no-open-quote` -/
def noOpenQuote : Keyword := ⟨580, by decide⟩
/-- `no-overflow` -/
def noOverflow : Keyword := ⟨581, by decide⟩
/-- `no-preference` -/
def noPreference : Keyword := ⟨582, by decide⟩
/-- `no-punctuation` -/
def noPunctuation : Keyword := ⟨583, by decide⟩
/-- `no-repeat` -/
def noRepeat : Keyword := ⟨584, by decide⟩
/-- `no-skip` -/
def noSkip : Keyword := ⟨585, by decide⟩
/-- `non-rotation` -/
def nonRotation : Keyword := ⟨586, by decide⟩
/-- `non-scaling-size` -/
def nonScalingSize : Keyword := ⟨587, by decide⟩
/-- `non-scaling-stroke` -/
def nonScalingStroke : Keyword := ⟨588, by decide⟩
/-- `none` -/
def none : Keyword := ⟨589, by decide⟩
/-- `nonzero` -/
def nonzero : Keyword := ⟨590, by decide⟩
/-- `normal` -/
def normal : Keyword := ⟨591, by decide⟩
/-- `not-allowed` -/
def notAllowed : Keyword := ⟨592, by decide⟩
/-- `notch` -/
def notch : Keyword := ⟨593, by decide⟩
/-- `nowrap` -/
def nowrap : Keyword := ⟨594, by decide⟩
/-- `ns-resize` -/
def nsResize : Keyword := ⟨595, by decide⟩
/-- `numbers` -/
def numbers : Keyword := ⟨596, by decide⟩
/-- `numeric` -/
def numeric : Keyword := ⟨597, by decide⟩
/-- `numeric-only` -/
def numericOnly : Keyword := ⟨598, by decide⟩
/-- `nw-resize` -/
def nwResize : Keyword := ⟨599, by decide⟩
/-- `nwse-resize` -/
def nwseResize : Keyword := ⟨600, by decide⟩
/-- `oblique` -/
def oblique : Keyword := ⟨601, by decide⟩
/-- `oblique-only` -/
def obliqueOnly : Keyword := ⟨602, by decide⟩
/-- `of` -/
def of : Keyword := ⟨603, by decide⟩
/-- `off` -/
def off : Keyword := ⟨604, by decide⟩
/-- `oklab` -/
def oklab : Keyword := ⟨605, by decide⟩
/-- `oklch` -/
def oklch : Keyword := ⟨606, by decide⟩
/-- `old` -/
def old : Keyword := ⟨607, by decide⟩
/-- `oldlace` -/
def oldlace : Keyword := ⟨608, by decide⟩
/-- `oldstyle-nums` -/
def oldstyleNums : Keyword := ⟨609, by decide⟩
/-- `olive` -/
def olive : Keyword := ⟨610, by decide⟩
/-- `olivedrab` -/
def olivedrab : Keyword := ⟨611, by decide⟩
/-- `on` -/
def on : Keyword := ⟨612, by decide⟩
/-- `only` -/
def «only» : Keyword := ⟨613, by decide⟩
/-- `opaque` -/
def «opaque» : Keyword := ⟨614, by decide⟩
/-- `open` -/
def «open» : Keyword := ⟨615, by decide⟩
/-- `open-quote` -/
def openQuote : Keyword := ⟨616, by decide⟩
/-- `opentype` -/
def opentype : Keyword := ⟨617, by decide⟩
/-- `optimizeLegibility` -/
def optimizeLegibility : Keyword := ⟨618, by decide⟩
/-- `optimizeSpeed` -/
def optimizeSpeed : Keyword := ⟨619, by decide⟩
/-- `optional` -/
def optional : Keyword := ⟨620, by decide⟩
/-- `orange` -/
def orange : Keyword := ⟨621, by decide⟩
/-- `orangered` -/
def orangered : Keyword := ⟨622, by decide⟩
/-- `orchid` -/
def orchid : Keyword := ⟨623, by decide⟩
/-- `ordinal` -/
def ordinal : Keyword := ⟨624, by decide⟩
/-- `origin` -/
def origin : Keyword := ⟨625, by decide⟩
/-- `outer` -/
def outer : Keyword := ⟨626, by decide⟩
/-- `outset` -/
def outset : Keyword := ⟨627, by decide⟩
/-- `outside` -/
def outside : Keyword := ⟨628, by decide⟩
/-- `outside-shape` -/
def outsideShape : Keyword := ⟨629, by decide⟩
/-- `over` -/
def over : Keyword := ⟨630, by decide⟩
/-- `overflow` -/
def overflow : Keyword := ⟨631, by decide⟩
/-- `overlap-join` -/
def overlapJoin : Keyword := ⟨632, by decide⟩
/-- `overlay` -/
def overlay : Keyword := ⟨633, by decide⟩
/-- `overline` -/
def overline : Keyword := ⟨634, by decide⟩
/-- `p3` -/
def p3 : Keyword := ⟨635, by decide⟩
/-- `padding-box` -/
def paddingBox : Keyword := ⟨636, by decide⟩
/-- `page` -/
def page : Keyword := ⟨637, by decide⟩
/-- `paged` -/
def paged : Keyword := ⟨638, by decide⟩
/-- `paginate` -/
def paginate : Keyword := ⟨639, by decide⟩
/-- `paint` -/
def paint : Keyword := ⟨640, by decide⟩
/-- `painted` -/
def painted : Keyword := ⟨641, by decide⟩
/-- `pair` -/
def pair : Keyword := ⟨642, by decide⟩
/-- `palegoldenrod` -/
def palegoldenrod : Keyword := ⟨643, by decide⟩
/-- `palegreen` -/
def palegreen : Keyword := ⟨644, by decide⟩
/-- `palettes` -/
def palettes : Keyword := ⟨645, by decide⟩
/-- `paleturquoise` -/
def paleturquoise : Keyword := ⟨646, by decide⟩
/-- `palevioletred` -/
def palevioletred : Keyword := ⟨647, by decide⟩
/-- `pan-down` -/
def panDown : Keyword := ⟨648, by decide⟩
/-- `pan-left` -/
def panLeft : Keyword := ⟨649, by decide⟩
/-- `pan-right` -/
def panRight : Keyword := ⟨650, by decide⟩
/-- `pan-up` -/
def panUp : Keyword := ⟨651, by decide⟩
/-- `pan-x` -/
def panX : Keyword := ⟨652, by decide⟩
/-- `pan-y` -/
def panY : Keyword := ⟨653, by decide⟩
/-- `papayawhip` -/
def papayawhip : Keyword := ⟨654, by decide⟩
/-- `parent` -/
def parent : Keyword := ⟨655, by decide⟩
/-- `paused` -/
def paused : Keyword := ⟨656, by decide⟩
/-- `peachpuff` -/
def peachpuff : Keyword := ⟨657, by decide⟩
/-- `per-line` -/
def perLine : Keyword := ⟨658, by decide⟩
/-- `per-line-all` -/
def perLineAll : Keyword := ⟨659, by decide⟩
/-- `perceptual` -/
def perceptual : Keyword := ⟨660, by decide⟩
/-- `peru` -/
def peru : Keyword := ⟨661, by decide⟩
/-- `petite-caps` -/
def petiteCaps : Keyword := ⟨662, by decide⟩
/-- `picture-in-picture` -/
def pictureInPicture : Keyword := ⟨663, by decide⟩
/-- `pinch-zoom` -/
def pinchZoom : Keyword := ⟨664, by decide⟩
/-- `pink` -/
def pink : Keyword := ⟨665, by decide⟩
/-- `pixelated` -/
def pixelated : Keyword := ⟨666, by decide⟩
/-- `plaintext` -/
def plaintext : Keyword := ⟨667, by decide⟩
/-- `plum` -/
def plum : Keyword := ⟨668, by decide⟩
/-- `plus-lighter` -/
def plusLighter : Keyword := ⟨669, by decide⟩
/-- `pointer` -/
def pointer : Keyword := ⟨670, by decide⟩
/-- `portrait` -/
def portrait : Keyword := ⟨671, by decide⟩
/-- `position` -/
def position : Keyword := ⟨672, by decide⟩
/-- `powderblue` -/
def powderblue : Keyword := ⟨673, by decide⟩
/-- `pre` -/
def pre : Keyword := ⟨674, by decide⟩
/-- `pre-line` -/
def preLine : Keyword := ⟨675, by decide⟩
/-- `pre-wrap` -/
def preWrap : Keyword := ⟨676, by decide⟩
/-- `preserve` -/
def preserve : Keyword := ⟨677, by decide⟩
/-- `preserve-3d` -/
def preserve3d : Keyword := ⟨678, by decide⟩
/-- `preserve-breaks` -/
def preserveBreaks : Keyword := ⟨679, by decide⟩
/-- `preserve-parent-color` -/
def preserveParentColor : Keyword := ⟨680, by decide⟩
/-- `preserve-spaces` -/
def preserveSpaces : Keyword := ⟨681, by decide⟩
/-- `pretty` -/
def pretty : Keyword := ⟨682, by decide⟩
/-- `progress` -/
def progress : Keyword := ⟨683, by decide⟩
/-- `progress-bar` -/
def progressBar : Keyword := ⟨684, by decide⟩
/-- `progressive` -/
def progressive : Keyword := ⟨685, by decide⟩
/-- `prophoto-rgb` -/
def prophotoRgb : Keyword := ⟨686, by decide⟩
/-- `proportional-nums` -/
def proportionalNums : Keyword := ⟨687, by decide⟩
/-- `proportional-width` -/
def proportionalWidth : Keyword := ⟨688, by decide⟩
/-- `proximity` -/
def proximity : Keyword := ⟨689, by decide⟩
/-- `punctuation` -/
def punctuation : Keyword := ⟨690, by decide⟩
/-- `purple` -/
def purple : Keyword := ⟨691, by decide⟩
/-- `radio` -/
def radio : Keyword := ⟨692, by decide⟩
/-- `raise` -/
def raise : Keyword := ⟨693, by decide⟩
/-- `rebeccapurple` -/
def rebeccapurple : Keyword := ⟨694, by decide⟩
/-- `rec2020` -/
def rec2020 : Keyword := ⟨695, by decide⟩
/-- `rec2100-hlg` -/
def rec2100Hlg : Keyword := ⟨696, by decide⟩
/-- `rec2100-linear` -/
def rec2100Linear : Keyword := ⟨697, by decide⟩
/-- `rec2100-pq` -/
def rec2100Pq : Keyword := ⟨698, by decide⟩
/-- `rect` -/
def rect : Keyword := ⟨699, by decide⟩
/-- `recto` -/
def recto : Keyword := ⟨700, by decide⟩
/-- `red` -/
def red : Keyword := ⟨701, by decide⟩
/-- `reduce` -/
def reduce : Keyword := ⟨702, by decide⟩
/-- `reduced` -/
def reduced : Keyword := ⟨703, by decide⟩
/-- `region` -/
def region : Keyword := ⟨704, by decide⟩
/-- `relative` -/
def relative : Keyword := ⟨705, by decide⟩
/-- `relative-colorimetric` -/
def relativeColorimetric : Keyword := ⟨706, by decide⟩
/-- `repeat` -/
def «repeat» : Keyword := ⟨707, by decide⟩
/-- `repeat-block` -/
def repeatBlock : Keyword := ⟨708, by decide⟩
/-- `repeat-inline` -/
def repeatInline : Keyword := ⟨709, by decide⟩
/-- `repeat-x` -/
def repeatX : Keyword := ⟨710, by decide⟩
/-- `repeat-y` -/
def repeatY : Keyword := ⟨711, by decide⟩
/-- `replace` -/
def replace : Keyword := ⟨712, by decide⟩
/-- `reverse` -/
def reverse : Keyword := ⟨713, by decide⟩
/-- `revert` -/
def revert : Keyword := ⟨714, by decide⟩
/-- `revert-layer` -/
def revertLayer : Keyword := ⟨715, by decide⟩
/-- `revert-rule` -/
def revertRule : Keyword := ⟨716, by decide⟩
/-- `ridge` -/
def ridge : Keyword := ⟨717, by decide⟩
/-- `right` -/
def right : Keyword := ⟨718, by decide⟩
/-- `right-to-left` -/
def rightToLeft : Keyword := ⟨719, by decide⟩
/-- `rightwards` -/
def rightwards : Keyword := ⟨720, by decide⟩
/-- `root` -/
def root : Keyword := ⟨721, by decide⟩
/-- `rosybrown` -/
def rosybrown : Keyword := ⟨722, by decide⟩
/-- `rotate` -/
def rotate : Keyword := ⟨723, by decide⟩
/-- `rotate-left` -/
def rotateLeft : Keyword := ⟨724, by decide⟩
/-- `rotate-right` -/
def rotateRight : Keyword := ⟨725, by decide⟩
/-- `round` -/
def round : Keyword := ⟨726, by decide⟩
/-- `row` -/
def row : Keyword := ⟨727, by decide⟩
/-- `row-over-column` -/
def rowOverColumn : Keyword := ⟨728, by decide⟩
/-- `row-resize` -/
def rowResize : Keyword := ⟨729, by decide⟩
/-- `row-reverse` -/
def rowReverse : Keyword := ⟨730, by decide⟩
/-- `royalblue` -/
def royalblue : Keyword := ⟨731, by decide⟩
/-- `rtl` -/
def rtl : Keyword := ⟨732, by decide⟩
/-- `ruby` -/
def ruby : Keyword := ⟨733, by decide⟩
/-- `ruby-base` -/
def rubyBase : Keyword := ⟨734, by decide⟩
/-- `ruby-base-container` -/
def rubyBaseContainer : Keyword := ⟨735, by decide⟩
/-- `ruby-text` -/
def rubyText : Keyword := ⟨736, by decide⟩
/-- `ruby-text-container` -/
def rubyTextContainer : Keyword := ⟨737, by decide⟩
/-- `run-in` -/
def runIn : Keyword := ⟨738, by decide⟩
/-- `running` -/
def running : Keyword := ⟨739, by decide⟩
/-- `s-resize` -/
def sResize : Keyword := ⟨740, by decide⟩
/-- `saddlebrown` -/
def saddlebrown : Keyword := ⟨741, by decide⟩
/-- `safe` -/
def safe : Keyword := ⟨742, by decide⟩
/-- `salmon` -/
def salmon : Keyword := ⟨743, by decide⟩
/-- `sandybrown` -/
def sandybrown : Keyword := ⟨744, by decide⟩
/-- `sans-serif` -/
def sansSerif : Keyword := ⟨745, by decide⟩
/-- `saturation` -/
def saturation : Keyword := ⟨746, by decide⟩
/-- `scale-down` -/
def scaleDown : Keyword := ⟨747, by decide⟩
/-- `scoop` -/
def scoop : Keyword := ⟨748, by decide⟩
/-- `screen` -/
def screen : Keyword := ⟨749, by decide⟩
/-- `scroll` -/
def scroll : Keyword := ⟨750, by decide⟩
/-- `scroll-position` -/
def scrollPosition : Keyword := ⟨751, by decide⟩
/-- `scroll-state` -/
def scrollState : Keyword := ⟨752, by decide⟩
/-- `Scrollbar` -/
def Scrollbar : Keyword := ⟨753, by decide⟩
/-- `se-resize` -/
def seResize : Keyword := ⟨754, by decide⟩
/-- `seagreen` -/
def seagreen : Keyword := ⟨755, by decide⟩
/-- `searchfield` -/
def searchfield : Keyword := ⟨756, by decide⟩
/-- `seashell` -/
def seashell : Keyword := ⟨757, by decide⟩
/-- `SelectedItem` -/
def SelectedItem : Keyword := ⟨758, by decide⟩
/-- `SelectedItemText` -/
def SelectedItemText : Keyword := ⟨759, by decide⟩
/-- `self` -/
def self : Keyword := ⟨760, by decide⟩
/-- `self-block` -/
def selfBlock : Keyword := ⟨761, by decide⟩
/-- `self-block-end` -/
def selfBlockEnd : Keyword := ⟨762, by decide⟩
/-- `self-block-start` -/
def selfBlockStart : Keyword := ⟨763, by decide⟩
/-- `self-end` -/
def selfEnd : Keyword := ⟨764, by decide⟩
/-- `self-inline` -/
def selfInline : Keyword := ⟨765, by decide⟩
/-- `self-inline-end` -/
def selfInlineEnd : Keyword := ⟨766, by decide⟩
/-- `self-inline-start` -/
def selfInlineStart : Keyword := ⟨767, by decide⟩
/-- `self-start` -/
def selfStart : Keyword := ⟨768, by decide⟩
/-- `self-x-end` -/
def selfXEnd : Keyword := ⟨769, by decide⟩
/-- `self-x-start` -/
def selfXStart : Keyword := ⟨770, by decide⟩
/-- `self-y-end` -/
def selfYEnd : Keyword := ⟨771, by decide⟩
/-- `self-y-start` -/
def selfYStart : Keyword := ⟨772, by decide⟩
/-- `semi-condensed` -/
def semiCondensed : Keyword := ⟨773, by decide⟩
/-- `semi-expanded` -/
def semiExpanded : Keyword := ⟨774, by decide⟩
/-- `separate` -/
def separate : Keyword := ⟨775, by decide⟩
/-- `serif` -/
def serif : Keyword := ⟨776, by decide⟩
/-- `sesame` -/
def sesame : Keyword := ⟨777, by decide⟩
/-- `shape-box` -/
def shapeBox : Keyword := ⟨778, by decide⟩
/-- `shorter` -/
def shorter : Keyword := ⟨779, by decide⟩
/-- `show` -/
def «show» : Keyword := ⟨780, by decide⟩
/-- `shrink` -/
def shrink : Keyword := ⟨781, by decide⟩
/-- `sides` -/
def sides : Keyword := ⟨782, by decide⟩
/-- `sideways` -/
def sideways : Keyword := ⟨783, by decide⟩
/-- `sideways-lr` -/
def sidewaysLr : Keyword := ⟨784, by decide⟩
/-- `sideways-rl` -/
def sidewaysRl : Keyword := ⟨785, by decide⟩
/-- `sienna` -/
def sienna : Keyword := ⟨786, by decide⟩
/-- `silent` -/
def silent : Keyword := ⟨787, by decide⟩
/-- `silver` -/
def silver : Keyword := ⟨788, by decide⟩
/-- `simplified` -/
def simplified : Keyword := ⟨789, by decide⟩
/-- `size` -/
def size : Keyword := ⟨790, by decide⟩
/-- `skip-all` -/
def skipAll : Keyword := ⟨791, by decide⟩
/-- `skip-line-through` -/
def skipLineThrough : Keyword := ⟨792, by decide⟩
/-- `skip-overline` -/
def skipOverline : Keyword := ⟨793, by decide⟩
/-- `skip-underline` -/
def skipUnderline : Keyword := ⟨794, by decide⟩
/-- `skyblue` -/
def skyblue : Keyword := ⟨795, by decide⟩
/-- `slashed-zero` -/
def slashedZero : Keyword := ⟨796, by decide⟩
/-- `slateblue` -/
def slateblue : Keyword := ⟨797, by decide⟩
/-- `slategray` -/
def slategray : Keyword := ⟨798, by decide⟩
/-- `slategrey` -/
def slategrey : Keyword := ⟨799, by decide⟩
/-- `slice` -/
def slice : Keyword := ⟨800, by decide⟩
/-- `slow` -/
def slow : Keyword := ⟨801, by decide⟩
/-- `small` -/
def small : Keyword := ⟨802, by decide⟩
/-- `small-caps` -/
def smallCaps : Keyword := ⟨803, by decide⟩
/-- `small-caption` -/
def smallCaption : Keyword := ⟨804, by decide⟩
/-- `smaller` -/
def smaller : Keyword := ⟨805, by decide⟩
/-- `smooth` -/
def smooth : Keyword := ⟨806, by decide⟩
/-- `snap` -/
def snap : Keyword := ⟨807, by decide⟩
/-- `snap-block` -/
def snapBlock : Keyword := ⟨808, by decide⟩
/-- `snap-inline` -/
def snapInline : Keyword := ⟨809, by decide⟩
/-- `snow` -/
def snow : Keyword := ⟨810, by decide⟩
/-- `soft` -/
def soft : Keyword := ⟨811, by decide⟩
/-- `soft-light` -/
def softLight : Keyword := ⟨812, by decide⟩
/-- `solid` -/
def solid : Keyword := ⟨813, by decide⟩
/-- `source-order` -/
def sourceOrder : Keyword := ⟨814, by decide⟩
/-- `space` -/
def space : Keyword := ⟨815, by decide⟩
/-- `space-all` -/
def spaceAll : Keyword := ⟨816, by decide⟩
/-- `space-around` -/
def spaceAround : Keyword := ⟨817, by decide⟩
/-- `space-between` -/
def spaceBetween : Keyword := ⟨818, by decide⟩
/-- `space-evenly` -/
def spaceEvenly : Keyword := ⟨819, by decide⟩
/-- `space-first` -/
def spaceFirst : Keyword := ⟨820, by decide⟩
/-- `spaces` -/
def spaces : Keyword := ⟨821, by decide⟩
/-- `span` -/
def span : Keyword := ⟨822, by decide⟩
/-- `span-all` -/
def spanAll : Keyword := ⟨823, by decide⟩
/-- `span-block-end` -/
def spanBlockEnd : Keyword := ⟨824, by decide⟩
/-- `span-block-start` -/
def spanBlockStart : Keyword := ⟨825, by decide⟩
/-- `span-bottom` -/
def spanBottom : Keyword := ⟨826, by decide⟩
/-- `span-end` -/
def spanEnd : Keyword := ⟨827, by decide⟩
/-- `span-inline-end` -/
def spanInlineEnd : Keyword := ⟨828, by decide⟩
/-- `span-inline-start` -/
def spanInlineStart : Keyword := ⟨829, by decide⟩
/-- `span-left` -/
def spanLeft : Keyword := ⟨830, by decide⟩
/-- `span-right` -/
def spanRight : Keyword := ⟨831, by decide⟩
/-- `span-self-block-end` -/
def spanSelfBlockEnd : Keyword := ⟨832, by decide⟩
/-- `span-self-block-start` -/
def spanSelfBlockStart : Keyword := ⟨833, by decide⟩
/-- `span-self-end` -/
def spanSelfEnd : Keyword := ⟨834, by decide⟩
/-- `span-self-inline-end` -/
def spanSelfInlineEnd : Keyword := ⟨835, by decide⟩
/-- `span-self-inline-start` -/
def spanSelfInlineStart : Keyword := ⟨836, by decide⟩
/-- `span-self-start` -/
def spanSelfStart : Keyword := ⟨837, by decide⟩
/-- `span-self-x-end` -/
def spanSelfXEnd : Keyword := ⟨838, by decide⟩
/-- `span-self-x-start` -/
def spanSelfXStart : Keyword := ⟨839, by decide⟩
/-- `span-self-y-end` -/
def spanSelfYEnd : Keyword := ⟨840, by decide⟩
/-- `span-self-y-start` -/
def spanSelfYStart : Keyword := ⟨841, by decide⟩
/-- `span-start` -/
def spanStart : Keyword := ⟨842, by decide⟩
/-- `span-top` -/
def spanTop : Keyword := ⟨843, by decide⟩
/-- `span-x-end` -/
def spanXEnd : Keyword := ⟨844, by decide⟩
/-- `span-x-start` -/
def spanXStart : Keyword := ⟨845, by decide⟩
/-- `span-y-end` -/
def spanYEnd : Keyword := ⟨846, by decide⟩
/-- `span-y-start` -/
def spanYStart : Keyword := ⟨847, by decide⟩
/-- `spell-out` -/
def spellOut : Keyword := ⟨848, by decide⟩
/-- `spelling-error` -/
def spellingError : Keyword := ⟨849, by decide⟩
/-- `spread` -/
def spread : Keyword := ⟨850, by decide⟩
/-- `springgreen` -/
def springgreen : Keyword := ⟨851, by decide⟩
/-- `square` -/
def square : Keyword := ⟨852, by decide⟩
/-- `squircle` -/
def squircle : Keyword := ⟨853, by decide⟩
/-- `srgb` -/
def srgb : Keyword := ⟨854, by decide⟩
/-- `srgb-linear` -/
def srgbLinear : Keyword := ⟨855, by decide⟩
/-- `stable` -/
def stable : Keyword := ⟨856, by decide⟩
/-- `stacked-fractions` -/
def stackedFractions : Keyword := ⟨857, by decide⟩
/-- `standalone` -/
def standalone : Keyword := ⟨858, by decide⟩
/-- `standard` -/
def standard : Keyword := ⟨859, by decide⟩
/-- `start` -/
def start : Keyword := ⟨860, by decide⟩
/-- `static` -/
def static : Keyword := ⟨861, by decide⟩
/-- `status-bar` -/
def statusBar : Keyword := ⟨862, by decide⟩
/-- `steelblue` -/
def steelblue : Keyword := ⟨863, by decide⟩
/-- `step-end` -/
def stepEnd : Keyword := ⟨864, by decide⟩
/-- `step-start` -/
def stepStart : Keyword := ⟨865, by decide⟩
/-- `sticky` -/
def sticky : Keyword := ⟨866, by decide⟩
/-- `stopped` -/
def stopped : Keyword := ⟨867, by decide⟩
/-- `stretch` -/
def stretch : Keyword := ⟨868, by decide⟩
/-- `strict` -/
def strict : Keyword := ⟨869, by decide⟩
/-- `stroke` -/
def stroke : Keyword := ⟨870, by decide⟩
/-- `stroke-box` -/
def strokeBox : Keyword := ⟨871, by decide⟩
/-- `strong` -/
def strong : Keyword := ⟨872, by decide⟩
/-- `style` -/
def style : Keyword := ⟨873, by decide⟩
/-- `sub` -/
def sub : Keyword := ⟨874, by decide⟩
/-- `subgrid` -/
def subgrid : Keyword := ⟨875, by decide⟩
/-- `subtract` -/
def subtract : Keyword := ⟨876, by decide⟩
/-- `subtractive` -/
def subtractive : Keyword := ⟨877, by decide⟩
/-- `super` -/
def super : Keyword := ⟨878, by decide⟩
/-- `svg` -/
def svg : Keyword := ⟨879, by decide⟩
/-- `sw-resize` -/
def swResize : Keyword := ⟨880, by decide⟩
/-- `swap` -/
def swap : Keyword := ⟨881, by decide⟩
/-- `symbolic` -/
def symbolic : Keyword := ⟨882, by decide⟩
/-- `symbols` -/
def symbols : Keyword := ⟨883, by decide⟩
/-- `system-ui` -/
def systemUi : Keyword := ⟨884, by decide⟩
/-- `table` -/
def table : Keyword := ⟨885, by decide⟩
/-- `table-caption` -/
def tableCaption : Keyword := ⟨886, by decide⟩
/-- `table-cell` -/
def tableCell : Keyword := ⟨887, by decide⟩
/-- `table-column` -/
def tableColumn : Keyword := ⟨888, by decide⟩
/-- `table-column-group` -/
def tableColumnGroup : Keyword := ⟨889, by decide⟩
/-- `table-footer-group` -/
def tableFooterGroup : Keyword := ⟨890, by decide⟩
/-- `table-header-group` -/
def tableHeaderGroup : Keyword := ⟨891, by decide⟩
/-- `table-row` -/
def tableRow : Keyword := ⟨892, by decide⟩
/-- `table-row-group` -/
def tableRowGroup : Keyword := ⟨893, by decide⟩
/-- `tabs` -/
def tabs : Keyword := ⟨894, by decide⟩
/-- `tabular-nums` -/
def tabularNums : Keyword := ⟨895, by decide⟩
/-- `tan` -/
def tan : Keyword := ⟨896, by decide⟩
/-- `tbd-bg` -/
def tbdBg : Keyword := ⟨897, by decide⟩
/-- `tbd-fg` -/
def tbdFg : Keyword := ⟨898, by decide⟩
/-- `teal` -/
def teal : Keyword := ⟨899, by decide⟩
/-- `text` -/
def text : Keyword := ⟨900, by decide⟩
/-- `text-bottom` -/
def textBottom : Keyword := ⟨901, by decide⟩
/-- `text-top` -/
def textTop : Keyword := ⟨902, by decide⟩
/-- `textarea` -/
def textarea : Keyword := ⟨903, by decide⟩
/-- `textfield` -/
def textfield : Keyword := ⟨904, by decide⟩
/-- `thick` -/
def thick : Keyword := ⟨905, by decide⟩
/-- `thin` -/
def thin : Keyword := ⟨906, by decide⟩
/-- `thistle` -/
def thistle : Keyword := ⟨907, by decide⟩
/-- `ThreeDDarkShadow` -/
def ThreeDDarkShadow : Keyword := ⟨908, by decide⟩
/-- `ThreeDFace` -/
def ThreeDFace : Keyword := ⟨909, by decide⟩
/-- `ThreeDHighlight` -/
def ThreeDHighlight : Keyword := ⟨910, by decide⟩
/-- `ThreeDLightShadow` -/
def ThreeDLightShadow : Keyword := ⟨911, by decide⟩
/-- `ThreeDShadow` -/
def ThreeDShadow : Keyword := ⟨912, by decide⟩
/-- `titling-caps` -/
def titlingCaps : Keyword := ⟨913, by decide⟩
/-- `to` -/
def «to» : Keyword := ⟨914, by decide⟩
/-- `tomato` -/
def tomato : Keyword := ⟨915, by decide⟩
/-- `top` -/
def top : Keyword := ⟨916, by decide⟩
/-- `top-to-bottom` -/
def topToBottom : Keyword := ⟨917, by decide⟩
/-- `traditional` -/
def traditional : Keyword := ⟨918, by decide⟩
/-- `transparent` -/
def transparent : Keyword := ⟨919, by decide⟩
/-- `triangle` -/
def triangle : Keyword := ⟨920, by decide⟩
/-- `trim-all` -/
def trimAll : Keyword := ⟨921, by decide⟩
/-- `trim-both` -/
def trimBoth : Keyword := ⟨922, by decide⟩
/-- `trim-end` -/
def trimEnd : Keyword := ⟨923, by decide⟩
/-- `trim-start` -/
def trimStart : Keyword := ⟨924, by decide⟩
/-- `true` -/
def true : Keyword := ⟨925, by decide⟩
/-- `truetype` -/
def truetype : Keyword := ⟨926, by decide⟩
/-- `turquoise` -/
def turquoise : Keyword := ⟨927, by decide⟩
/-- `ui-monospace` -/
def uiMonospace : Keyword := ⟨928, by decide⟩
/-- `ui-rounded` -/
def uiRounded : Keyword := ⟨929, by decide⟩
/-- `ui-sans-serif` -/
def uiSansSerif : Keyword := ⟨930, by decide⟩
/-- `ui-serif` -/
def uiSerif : Keyword := ⟨931, by decide⟩
/-- `ultra-condensed` -/
def ultraCondensed : Keyword := ⟨932, by decide⟩
/-- `ultra-expanded` -/
def ultraExpanded : Keyword := ⟨933, by decide⟩
/-- `under` -/
def under : Keyword := ⟨934, by decide⟩
/-- `underline` -/
def underline : Keyword := ⟨935, by decide⟩
/-- `underscore` -/
def underscore : Keyword := ⟨936, by decide⟩
/-- `unicase` -/
def unicase : Keyword := ⟨937, by decide⟩
/-- `unicode` -/
def unicode : Keyword := ⟨938, by decide⟩
/-- `unsafe` -/
def «unsafe» : Keyword := ⟨939, by decide⟩
/-- `unset` -/
def unset : Keyword := ⟨940, by decide⟩
/-- `up` -/
def up : Keyword := ⟨941, by decide⟩
/-- `uppercase` -/
def uppercase : Keyword := ⟨942, by decide⟩
/-- `upright` -/
def upright : Keyword := ⟨943, by decide⟩
/-- `variations` -/
def variations : Keyword := ⟨944, by decide⟩
/-- `verso` -/
def verso : Keyword := ⟨945, by decide⟩
/-- `vertical` -/
def vertical : Keyword := ⟨946, by decide⟩
/-- `vertical-lr` -/
def verticalLr : Keyword := ⟨947, by decide⟩
/-- `vertical-rl` -/
def verticalRl : Keyword := ⟨948, by decide⟩
/-- `vertical-text` -/
def verticalText : Keyword := ⟨949, by decide⟩
/-- `view-box` -/
def viewBox : Keyword := ⟨950, by decide⟩
/-- `violet` -/
def violet : Keyword := ⟨951, by decide⟩
/-- `visible` -/
def visible : Keyword := ⟨952, by decide⟩
/-- `visibleFill` -/
def visibleFill : Keyword := ⟨953, by decide⟩
/-- `visiblePainted` -/
def visiblePainted : Keyword := ⟨954, by decide⟩
/-- `visibleStroke` -/
def visibleStroke : Keyword := ⟨955, by decide⟩
/-- `VisitedText` -/
def VisitedText : Keyword := ⟨956, by decide⟩
/-- `vline` -/
def vline : Keyword := ⟨957, by decide⟩
/-- `w-resize` -/
def wResize : Keyword := ⟨958, by decide⟩
/-- `wait` -/
def wait : Keyword := ⟨959, by decide⟩
/-- `wavy` -/
def wavy : Keyword := ⟨960, by decide⟩
/-- `wcag2` -/
def wcag2 : Keyword := ⟨961, by decide⟩
/-- `weak` -/
def weak : Keyword := ⟨962, by decide⟩
/-- `weight` -/
def weight : Keyword := ⟨963, by decide⟩
/-- `wheat` -/
def wheat : Keyword := ⟨964, by decide⟩
/-- `white` -/
def white : Keyword := ⟨965, by decide⟩
/-- `whitesmoke` -/
def whitesmoke : Keyword := ⟨966, by decide⟩
/-- `width` -/
def width : Keyword := ⟨967, by decide⟩
/-- `Window` -/
def Window : Keyword := ⟨968, by decide⟩
/-- `WindowFrame` -/
def WindowFrame : Keyword := ⟨969, by decide⟩
/-- `WindowText` -/
def WindowText : Keyword := ⟨970, by decide⟩
/-- `with` -/
def «with» : Keyword := ⟨971, by decide⟩
/-- `woff` -/
def woff : Keyword := ⟨972, by decide⟩
/-- `woff2` -/
def woff2 : Keyword := ⟨973, by decide⟩
/-- `words` -/
def words : Keyword := ⟨974, by decide⟩
/-- `wrap` -/
def wrap : Keyword := ⟨975, by decide⟩
/-- `wrap-reverse` -/
def wrapReverse : Keyword := ⟨976, by decide⟩
/-- `x` -/
def x : Keyword := ⟨977, by decide⟩
/-- `x-end` -/
def xEnd : Keyword := ⟨978, by decide⟩
/-- `x-fast` -/
def xFast : Keyword := ⟨979, by decide⟩
/-- `x-high` -/
def xHigh : Keyword := ⟨980, by decide⟩
/-- `x-large` -/
def xLarge : Keyword := ⟨981, by decide⟩
/-- `x-loud` -/
def xLoud : Keyword := ⟨982, by decide⟩
/-- `x-low` -/
def xLow : Keyword := ⟨983, by decide⟩
/-- `x-slow` -/
def xSlow : Keyword := ⟨984, by decide⟩
/-- `x-small` -/
def xSmall : Keyword := ⟨985, by decide⟩
/-- `x-soft` -/
def xSoft : Keyword := ⟨986, by decide⟩
/-- `x-start` -/
def xStart : Keyword := ⟨987, by decide⟩
/-- `x-strong` -/
def xStrong : Keyword := ⟨988, by decide⟩
/-- `x-weak` -/
def xWeak : Keyword := ⟨989, by decide⟩
/-- `xx-large` -/
def xxLarge : Keyword := ⟨990, by decide⟩
/-- `xx-small` -/
def xxSmall : Keyword := ⟨991, by decide⟩
/-- `xxx-large` -/
def xxxLarge : Keyword := ⟨992, by decide⟩
/-- `xyz` -/
def xyz : Keyword := ⟨993, by decide⟩
/-- `xyz-d50` -/
def xyzD50 : Keyword := ⟨994, by decide⟩
/-- `xyz-d65` -/
def xyzD65 : Keyword := ⟨995, by decide⟩
/-- `y` -/
def y : Keyword := ⟨996, by decide⟩
/-- `y-end` -/
def yEnd : Keyword := ⟨997, by decide⟩
/-- `y-start` -/
def yStart : Keyword := ⟨998, by decide⟩
/-- `yellow` -/
def yellow : Keyword := ⟨999, by decide⟩
/-- `yellowgreen` -/
def yellowgreen : Keyword := ⟨1000, by decide⟩
/-- `young` -/
def young : Keyword := ⟨1001, by decide⟩
/-- `z` -/
def z : Keyword := ⟨1002, by decide⟩
/-- `zero-if-extrinsic` -/
def zeroIfExtrinsic : Keyword := ⟨1003, by decide⟩
/-- `zero-if-scroll` -/
def zeroIfScroll : Keyword := ⟨1004, by decide⟩
/-- `zoom-in` -/
def zoomIn : Keyword := ⟨1005, by decide⟩
/-- `zoom-out` -/
def zoomOut : Keyword := ⟨1006, by decide⟩

def names : Array String := #[
  "-infinity",
  "-webkit-legacy",
  "A3",
  "A4",
  "A5",
  "a98-rgb",
  "aa",
  "aaa",
  "absolute",
  "absolute-colorimetric",
  "AccentColor",
  "AccentColorText",
  "accumulate",
  "active",
  "ActiveBorder",
  "ActiveCaption",
  "ActiveText",
  "add",
  "additive",
  "after",
  "alias",
  "aliceblue",
  "all",
  "all-petite-caps",
  "all-scroll",
  "all-small-caps",
  "allow-discrete",
  "allow-end",
  "allow-keywords",
  "alpha",
  "alphabetic",
  "alternate",
  "alternate-reverse",
  "always",
  "anchor-center",
  "anchor-valid",
  "anchor-visible",
  "antiquewhite",
  "any",
  "anywhere",
  "application",
  "AppWorkspace",
  "aqua",
  "aquamarine",
  "arc",
  "arcs",
  "around",
  "at",
  "auto",
  "auto-add",
  "auto-fill",
  "auto-fit",
  "auto-flow",
  "auto-phrase",
  "avoid",
  "avoid-column",
  "avoid-flex",
  "avoid-line",
  "avoid-page",
  "avoid-region",
  "avoid-short-last-line",
  "azure",
  "B4",
  "B5",
  "back",
  "Background",
  "backwards",
  "balance",
  "balance-all",
  "bar",
  "base",
  "base-select",
  "baseline",
  "before",
  "beige",
  "between",
  "bevel",
  "bidi-override",
  "bikeshed-this",
  "bisque",
  "black",
  "blanchedalmond",
  "blink",
  "block",
  "block-end",
  "block-start",
  "blue",
  "blueviolet",
  "bold",
  "bolder",
  "border-area",
  "border-box",
  "both",
  "both-block",
  "both-edges",
  "both-inline",
  "bottom",
  "bottom-to-top",
  "bounding-box",
  "break",
  "break-all",
  "break-spaces",
  "break-word",
  "brown",
  "browser",
  "bullets",
  "burlywood",
  "butt",
  "button",
  "ButtonBorder",
  "ButtonFace",
  "ButtonHighlight",
  "ButtonShadow",
  "ButtonText",
  "by",
  "cadetblue",
  "Canvas",
  "CanvasText",
  "cap",
  "cap-height",
  "capitalize",
  "caption",
  "CaptionText",
  "ccw",
  "cell",
  "center",
  "central",
  "ch-width",
  "chain",
  "chartreuse",
  "checkbox",
  "child",
  "chocolate",
  "circle",
  "clamp",
  "clear",
  "clip",
  "clone",
  "close",
  "close-quote",
  "closed",
  "closest-corner",
  "closest-side",
  "coarse",
  "col-resize",
  "collapse",
  "collection",
  "color",
  "color-burn",
  "color-CBDT",
  "color-COLRv0",
  "color-COLRv1",
  "color-dodge",
  "color-sbix",
  "color-SVG",
  "column",
  "column-over-row",
  "column-reverse",
  "common-ligatures",
  "compact",
  "compress",
  "condensed",
  "consistent",
  "constrained",
  "contain",
  "content",
  "content-block-size",
  "content-box",
  "content-height",
  "content-inline-size",
  "content-width",
  "contents",
  "context-menu",
  "contextual",
  "copy",
  "coral",
  "corners",
  "cornflowerblue",
  "cornsilk",
  "cover",
  "create",
  "crimson",
  "crisp-edges",
  "crispEdges",
  "crop",
  "cross",
  "crosshair",
  "current",
  "currentColor",
  "cursive",
  "curve",
  "custom",
  "cw",
  "cyan",
  "cyclic",
  "dark",
  "darkblue",
  "darkcyan",
  "darken",
  "darkgoldenrod",
  "darkgray",
  "darkgreen",
  "darkgrey",
  "darkkhaki",
  "darkmagenta",
  "darkolivegreen",
  "darkorange",
  "darkorchid",
  "darkred",
  "darksalmon",
  "darkseagreen",
  "darkslateblue",
  "darkslategray",
  "darkslategrey",
  "darkturquoise",
  "darkviolet",
  "dashed",
  "dashes",
  "decreasing",
  "deeppink",
  "deepskyblue",
  "default",
  "dense",
  "diagonal-fractions",
  "difference",
  "digits",
  "dimgray",
  "dimgrey",
  "disc",
  "discard",
  "discard-after",
  "discard-before",
  "discard-inner",
  "disclosure-closed",
  "disclosure-open",
  "discretionary-ligatures",
  "display",
  "display-p3",
  "display-p3-linear",
  "dodgerblue",
  "dot",
  "dotted",
  "double",
  "double-circle",
  "down",
  "drop",
  "e-resize",
  "each-line",
  "ease",
  "ease-in",
  "ease-in-out",
  "ease-out",
  "economy",
  "element",
  "ellipse",
  "ellipsis",
  "embed",
  "embedded-opentype",
  "emoji",
  "enabled",
  "end",
  "entry",
  "entry-crossing",
  "evenodd",
  "ew-resize",
  "ex",
  "ex-height",
  "exact",
  "exclude",
  "exclusion",
  "exit",
  "exit-crossing",
  "expanded",
  "extends",
  "extra-condensed",
  "extra-expanded",
  "fade",
  "fallback",
  "false",
  "fangsong",
  "fantasy",
  "farthest-corner",
  "farthest-side",
  "fast",
  "features-aat",
  "features-graphite",
  "features-opentype",
  "female",
  "Field",
  "FieldText",
  "fill",
  "fill-box",
  "filled",
  "fine",
  "firebrick",
  "first",
  "first-except",
  "first-letter",
  "fit-content",
  "fixed",
  "fixed-position",
  "flat",
  "flex",
  "flex-end",
  "flex-flow",
  "flex-start",
  "flex-visual",
  "flip",
  "flip-block",
  "flip-inline",
  "flip-start",
  "flip-x",
  "flip-y",
  "floralwhite",
  "flow",
  "flow-end",
  "flow-root",
  "flow-start",
  "focus",
  "footnote",
  "force-end",
  "force-hidden",
  "forestgreen",
  "forwards",
  "fragments",
  "from",
  "from-font",
  "from-image",
  "fuchsia",
  "full-size-kana",
  "full-width",
  "fullscreen",
  "gainsboro",
  "gaps",
  "geometricPrecision",
  "ghostwhite",
  "gold",
  "goldenrod",
  "grab",
  "grabbing",
  "grammar-error",
  "gray",
  "GrayText",
  "green",
  "greenyellow",
  "grey",
  "grid",
  "grid-columns",
  "grid-lanes",
  "grid-order",
  "grid-rows",
  "groove",
  "grow",
  "hairline",
  "half-border-box",
  "hanging",
  "hard-light",
  "height",
  "help",
  "hidden",
  "hide",
  "high",
  "high-quality",
  "Highlight",
  "HighlightText",
  "historical-forms",
  "historical-ligatures",
  "hline",
  "honeydew",
  "horizontal",
  "horizontal-tb",
  "hotpink",
  "hover",
  "hsl",
  "hue",
  "hwb",
  "ic-height",
  "ic-width",
  "icon",
  "ideograph-alpha",
  "ideograph-numeric",
  "ideographic",
  "ideographic-ink",
  "ideographic-space",
  "in",
  "InactiveBorder",
  "InactiveCaption",
  "InactiveCaptionText",
  "increasing",
  "incremental",
  "indianred",
  "indigo",
  "inert",
  "infinite",
  "infinity",
  "InfoBackground",
  "InfoText",
  "inherit",
  "initial",
  "initial-only",
  "inline",
  "inline-block",
  "inline-end",
  "inline-flex",
  "inline-grid",
  "inline-grid-lanes",
  "inline-size",
  "inline-start",
  "inline-table",
  "inner",
  "insert",
  "inset",
  "inside",
  "inter-character",
  "inter-word",
  "interlace",
  "intersect",
  "intersection",
  "inverted",
  "isolate",
  "isolate-override",
  "italic",
  "ivory",
  "JIS-B4",
  "JIS-B5",
  "jis04",
  "jis78",
  "jis83",
  "jis90",
  "jump-both",
  "jump-end",
  "jump-none",
  "jump-start",
  "justify",
  "justify-all",
  "kai",
  "keep",
  "keep-all",
  "khaki",
  "khmer-mul",
  "lab",
  "landscape",
  "large",
  "larger",
  "last",
  "last-baseline",
  "lavender",
  "lavenderblush",
  "lawngreen",
  "layout",
  "lch",
  "leading",
  "ledger",
  "left",
  "left-to-right",
  "leftwards",
  "legacy",
  "legal",
  "lemonchiffon",
  "less",
  "letter",
  "light",
  "lightblue",
  "lightcoral",
  "lightcyan",
  "lighten",
  "lighter",
  "lightgoldenrodyellow",
  "lightgray",
  "lightgreen",
  "lightgrey",
  "lightpink",
  "lightsalmon",
  "lightseagreen",
  "lightskyblue",
  "lightslategray",
  "lightslategrey",
  "lightsteelblue",
  "lightyellow",
  "lime",
  "limegreen",
  "line",
  "line-through",
  "linear",
  "linearRGB",
  "linen",
  "lining-nums",
  "links",
  "LinkText",
  "list-item",
  "listbox",
  "literal-punctuation",
  "local",
  "longer",
  "loose",
  "loud",
  "low",
  "lowercase",
  "ltr",
  "luminance",
  "luminosity",
  "magenta",
  "male",
  "mandatory",
  "manipulation",
  "manual",
  "margin-box",
  "Mark",
  "marker",
  "markers",
  "MarkText",
  "maroon",
  "match-parent",
  "match-self",
  "match-source",
  "math",
  "math-auto",
  "mathematical",
  "max-content",
  "maximized",
  "maximum",
  "medium",
  "mediumaquamarine",
  "mediumblue",
  "mediumorchid",
  "mediumpurple",
  "mediumseagreen",
  "mediumslateblue",
  "mediumspringgreen",
  "mediumturquoise",
  "mediumvioletred",
  "menu",
  "menulist",
  "menulist-button",
  "MenuText",
  "merge",
  "message-box",
  "meter",
  "middle",
  "midnightblue",
  "min-content",
  "minimal-ui",
  "minimized",
  "minimum",
  "mintcream",
  "mistyrose",
  "miter",
  "mixed",
  "moccasin",
  "moderate",
  "monospace",
  "more",
  "most-block-size",
  "most-height",
  "most-inline-size",
  "most-width",
  "move",
  "multiply",
  "n-resize",
  "narrow",
  "nastaliq",
  "navajowhite",
  "navy",
  "ne-resize",
  "near",
  "nearest",
  "nesw-resize",
  "neutral",
  "never",
  "no-autospace",
  "no-clip",
  "no-close-quote",
  "no-common-ligatures",
  "no-compress",
  "no-contextual",
  "no-discretionary-ligatures",
  "no-drop",
  "no-ellipsis",
  "no-historical-ligatures",
  "no-limit",
  "no-open-quote",
  "no-overflow",
  "no-preference",
  "no-punctuation",
  "no-repeat",
  "no-skip",
  "non-rotation",
  "non-scaling-size",
  "non-scaling-stroke",
  "none",
  "nonzero",
  "normal",
  "not-allowed",
  "notch",
  "nowrap",
  "ns-resize",
  "numbers",
  "numeric",
  "numeric-only",
  "nw-resize",
  "nwse-resize",
  "oblique",
  "oblique-only",
  "of",
  "off",
  "oklab",
  "oklch",
  "old",
  "oldlace",
  "oldstyle-nums",
  "olive",
  "olivedrab",
  "on",
  "only",
  "opaque",
  "open",
  "open-quote",
  "opentype",
  "optimizeLegibility",
  "optimizeSpeed",
  "optional",
  "orange",
  "orangered",
  "orchid",
  "ordinal",
  "origin",
  "outer",
  "outset",
  "outside",
  "outside-shape",
  "over",
  "overflow",
  "overlap-join",
  "overlay",
  "overline",
  "p3",
  "padding-box",
  "page",
  "paged",
  "paginate",
  "paint",
  "painted",
  "pair",
  "palegoldenrod",
  "palegreen",
  "palettes",
  "paleturquoise",
  "palevioletred",
  "pan-down",
  "pan-left",
  "pan-right",
  "pan-up",
  "pan-x",
  "pan-y",
  "papayawhip",
  "parent",
  "paused",
  "peachpuff",
  "per-line",
  "per-line-all",
  "perceptual",
  "peru",
  "petite-caps",
  "picture-in-picture",
  "pinch-zoom",
  "pink",
  "pixelated",
  "plaintext",
  "plum",
  "plus-lighter",
  "pointer",
  "portrait",
  "position",
  "powderblue",
  "pre",
  "pre-line",
  "pre-wrap",
  "preserve",
  "preserve-3d",
  "preserve-breaks",
  "preserve-parent-color",
  "preserve-spaces",
  "pretty",
  "progress",
  "progress-bar",
  "progressive",
  "prophoto-rgb",
  "proportional-nums",
  "proportional-width",
  "proximity",
  "punctuation",
  "purple",
  "radio",
  "raise",
  "rebeccapurple",
  "rec2020",
  "rec2100-hlg",
  "rec2100-linear",
  "rec2100-pq",
  "rect",
  "recto",
  "red",
  "reduce",
  "reduced",
  "region",
  "relative",
  "relative-colorimetric",
  "repeat",
  "repeat-block",
  "repeat-inline",
  "repeat-x",
  "repeat-y",
  "replace",
  "reverse",
  "revert",
  "revert-layer",
  "revert-rule",
  "ridge",
  "right",
  "right-to-left",
  "rightwards",
  "root",
  "rosybrown",
  "rotate",
  "rotate-left",
  "rotate-right",
  "round",
  "row",
  "row-over-column",
  "row-resize",
  "row-reverse",
  "royalblue",
  "rtl",
  "ruby",
  "ruby-base",
  "ruby-base-container",
  "ruby-text",
  "ruby-text-container",
  "run-in",
  "running",
  "s-resize",
  "saddlebrown",
  "safe",
  "salmon",
  "sandybrown",
  "sans-serif",
  "saturation",
  "scale-down",
  "scoop",
  "screen",
  "scroll",
  "scroll-position",
  "scroll-state",
  "Scrollbar",
  "se-resize",
  "seagreen",
  "searchfield",
  "seashell",
  "SelectedItem",
  "SelectedItemText",
  "self",
  "self-block",
  "self-block-end",
  "self-block-start",
  "self-end",
  "self-inline",
  "self-inline-end",
  "self-inline-start",
  "self-start",
  "self-x-end",
  "self-x-start",
  "self-y-end",
  "self-y-start",
  "semi-condensed",
  "semi-expanded",
  "separate",
  "serif",
  "sesame",
  "shape-box",
  "shorter",
  "show",
  "shrink",
  "sides",
  "sideways",
  "sideways-lr",
  "sideways-rl",
  "sienna",
  "silent",
  "silver",
  "simplified",
  "size",
  "skip-all",
  "skip-line-through",
  "skip-overline",
  "skip-underline",
  "skyblue",
  "slashed-zero",
  "slateblue",
  "slategray",
  "slategrey",
  "slice",
  "slow",
  "small",
  "small-caps",
  "small-caption",
  "smaller",
  "smooth",
  "snap",
  "snap-block",
  "snap-inline",
  "snow",
  "soft",
  "soft-light",
  "solid",
  "source-order",
  "space",
  "space-all",
  "space-around",
  "space-between",
  "space-evenly",
  "space-first",
  "spaces",
  "span",
  "span-all",
  "span-block-end",
  "span-block-start",
  "span-bottom",
  "span-end",
  "span-inline-end",
  "span-inline-start",
  "span-left",
  "span-right",
  "span-self-block-end",
  "span-self-block-start",
  "span-self-end",
  "span-self-inline-end",
  "span-self-inline-start",
  "span-self-start",
  "span-self-x-end",
  "span-self-x-start",
  "span-self-y-end",
  "span-self-y-start",
  "span-start",
  "span-top",
  "span-x-end",
  "span-x-start",
  "span-y-end",
  "span-y-start",
  "spell-out",
  "spelling-error",
  "spread",
  "springgreen",
  "square",
  "squircle",
  "srgb",
  "srgb-linear",
  "stable",
  "stacked-fractions",
  "standalone",
  "standard",
  "start",
  "static",
  "status-bar",
  "steelblue",
  "step-end",
  "step-start",
  "sticky",
  "stopped",
  "stretch",
  "strict",
  "stroke",
  "stroke-box",
  "strong",
  "style",
  "sub",
  "subgrid",
  "subtract",
  "subtractive",
  "super",
  "svg",
  "sw-resize",
  "swap",
  "symbolic",
  "symbols",
  "system-ui",
  "table",
  "table-caption",
  "table-cell",
  "table-column",
  "table-column-group",
  "table-footer-group",
  "table-header-group",
  "table-row",
  "table-row-group",
  "tabs",
  "tabular-nums",
  "tan",
  "tbd-bg",
  "tbd-fg",
  "teal",
  "text",
  "text-bottom",
  "text-top",
  "textarea",
  "textfield",
  "thick",
  "thin",
  "thistle",
  "ThreeDDarkShadow",
  "ThreeDFace",
  "ThreeDHighlight",
  "ThreeDLightShadow",
  "ThreeDShadow",
  "titling-caps",
  "to",
  "tomato",
  "top",
  "top-to-bottom",
  "traditional",
  "transparent",
  "triangle",
  "trim-all",
  "trim-both",
  "trim-end",
  "trim-start",
  "true",
  "truetype",
  "turquoise",
  "ui-monospace",
  "ui-rounded",
  "ui-sans-serif",
  "ui-serif",
  "ultra-condensed",
  "ultra-expanded",
  "under",
  "underline",
  "underscore",
  "unicase",
  "unicode",
  "unsafe",
  "unset",
  "up",
  "uppercase",
  "upright",
  "variations",
  "verso",
  "vertical",
  "vertical-lr",
  "vertical-rl",
  "vertical-text",
  "view-box",
  "violet",
  "visible",
  "visibleFill",
  "visiblePainted",
  "visibleStroke",
  "VisitedText",
  "vline",
  "w-resize",
  "wait",
  "wavy",
  "wcag2",
  "weak",
  "weight",
  "wheat",
  "white",
  "whitesmoke",
  "width",
  "Window",
  "WindowFrame",
  "WindowText",
  "with",
  "woff",
  "woff2",
  "words",
  "wrap",
  "wrap-reverse",
  "x",
  "x-end",
  "x-fast",
  "x-high",
  "x-large",
  "x-loud",
  "x-low",
  "x-slow",
  "x-small",
  "x-soft",
  "x-start",
  "x-strong",
  "x-weak",
  "xx-large",
  "xx-small",
  "xxx-large",
  "xyz",
  "xyz-d50",
  "xyz-d65",
  "y",
  "y-end",
  "y-start",
  "yellow",
  "yellowgreen",
  "young",
  "z",
  "zero-if-extrinsic",
  "zero-if-scroll",
  "zoom-in",
  "zoom-out"]

def name (x : Keyword) : String := names[x.id]?.getD ""

def ofName? (s : String) : Option Keyword :=
  match names.findIdx? (· == s) with
  | .some i => if h : i < 1007 then .some ⟨i, h⟩ else .none
  | .none => .none

/-- Every keyword, as `Sym.keywords` holds them. -/
def allBits : Nat := 2 ^ 1007 - 1

end Keyword

/-- A function or block, by its argument grammar. Where a function has one grammar it bears the function's name; where it has several, each is named after the definition it appears in, such as `trackSizeMinmax` for the `minmax()` of `<track-size>`. -/
structure Func where
  id : Nat
  valid : id < 149
  deriving DecidableEq, Repr

namespace Func

/-- `linear` -/
def linear : Func := ⟨0, by decide⟩
/-- `cubic-bezier` -/
def cubicBezier : Func := ⟨1, by decide⟩
/-- `steps` -/
def steps : Func := ⟨2, by decide⟩
/-- `scroll` -/
def scroll : Func := ⟨3, by decide⟩
/-- `view` -/
def view : Func := ⟨4, by decide⟩
/-- `rgb` -/
def rgb : Func := ⟨5, by decide⟩
/-- `rgba` -/
def rgba : Func := ⟨6, by decide⟩
/-- `hsl` -/
def hsl : Func := ⟨7, by decide⟩
/-- `hsla` -/
def hsla : Func := ⟨8, by decide⟩
/-- `hwb` -/
def hwb : Func := ⟨9, by decide⟩
/-- `lab` -/
def lab : Func := ⟨10, by decide⟩
/-- `lch` -/
def lch : Func := ⟨11, by decide⟩
/-- `oklab` -/
def oklab : Func := ⟨12, by decide⟩
/-- `oklch` -/
def oklch : Func := ⟨13, by decide⟩
/-- `ictcp` -/
def ictcp : Func := ⟨14, by decide⟩
/-- `jzazbz` -/
def jzazbz : Func := ⟨15, by decide⟩
/-- `jzczhz` -/
def jzczhz : Func := ⟨16, by decide⟩
/-- `alpha` -/
def alpha : Func := ⟨17, by decide⟩
/-- `color` -/
def color : Func := ⟨18, by decide⟩
/-- `color-hdr` -/
def colorHdr : Func := ⟨19, by decide⟩
/-- `color-mix` -/
def colorMix : Func := ⟨20, by decide⟩
/-- `contrast-color` -/
def contrastColor : Func := ⟨21, by decide⟩
/-- `device-cmyk` -/
def deviceCmyk : Func := ⟨22, by decide⟩
/-- `light-dark` -/
def lightDark : Func := ⟨23, by decide⟩
/-- `blur` -/
def blur : Func := ⟨24, by decide⟩
/-- `brightness` -/
def brightness : Func := ⟨25, by decide⟩
/-- `contrast` -/
def contrast : Func := ⟨26, by decide⟩
/-- `drop-shadow` -/
def dropShadow : Func := ⟨27, by decide⟩
/-- `grayscale` -/
def grayscale : Func := ⟨28, by decide⟩
/-- `hue-rotate` -/
def hueRotate : Func := ⟨29, by decide⟩
/-- `invert` -/
def invert : Func := ⟨30, by decide⟩
/-- `opacity` -/
def opacity : Func := ⟨31, by decide⟩
/-- `sepia` -/
def sepia : Func := ⟨32, by decide⟩
/-- `saturate` -/
def saturate : Func := ⟨33, by decide⟩
/-- `stretch` -/
def stretch : Func := ⟨34, by decide⟩
/-- `fit-content` -/
def boxSizeFitContent : Func := ⟨35, by decide⟩
/-- `calc-size` -/
def calcSize : Func := ⟨36, by decide⟩
/-- `anchor-size` -/
def anchorSize : Func := ⟨37, by decide⟩
/-- `image` -/
def image : Func := ⟨38, by decide⟩
/-- `image-set` -/
def imageSet : Func := ⟨39, by decide⟩
/-- `cross-fade` -/
def crossFade : Func := ⟨40, by decide⟩
/-- `element` -/
def element : Func := ⟨41, by decide⟩
/-- `linear-gradient` -/
def linearGradient : Func := ⟨42, by decide⟩
/-- `repeating-linear-gradient` -/
def repeatingLinearGradient : Func := ⟨43, by decide⟩
/-- `radial-gradient` -/
def radialGradient : Func := ⟨44, by decide⟩
/-- `repeating-radial-gradient` -/
def repeatingRadialGradient : Func := ⟨45, by decide⟩
/-- `conic-gradient` -/
def conicGradient : Func := ⟨46, by decide⟩
/-- `repeating-conic-gradient` -/
def repeatingConicGradient : Func := ⟨47, by decide⟩
/-- `scale3d` -/
def scale3d : Func := ⟨48, by decide⟩
/-- `scale` -/
def scale : Func := ⟨49, by decide⟩
/-- `scaleX` -/
def scaleX : Func := ⟨50, by decide⟩
/-- `scaleY` -/
def scaleY : Func := ⟨51, by decide⟩
/-- `scaleZ` -/
def scaleZ : Func := ⟨52, by decide⟩
/-- `translate3d` -/
def translate3d : Func := ⟨53, by decide⟩
/-- `translate` -/
def translate : Func := ⟨54, by decide⟩
/-- `translateX` -/
def translateX : Func := ⟨55, by decide⟩
/-- `translateY` -/
def translateY : Func := ⟨56, by decide⟩
/-- `translateZ` -/
def translateZ : Func := ⟨57, by decide⟩
/-- `rotate3d` -/
def rotate3d : Func := ⟨58, by decide⟩
/-- `rotate` -/
def rotate : Func := ⟨59, by decide⟩
/-- `rotateX` -/
def rotateX : Func := ⟨60, by decide⟩
/-- `rotateY` -/
def rotateY : Func := ⟨61, by decide⟩
/-- `rotateZ` -/
def rotateZ : Func := ⟨62, by decide⟩
/-- `skew` -/
def skew : Func := ⟨63, by decide⟩
/-- `skewX` -/
def skewX : Func := ⟨64, by decide⟩
/-- `skewY` -/
def skewY : Func := ⟨65, by decide⟩
/-- `matrix3d` -/
def matrix3d : Func := ⟨66, by decide⟩
/-- `matrix` -/
def matrix : Func := ⟨67, by decide⟩
/-- `perspective` -/
def perspective : Func := ⟨68, by decide⟩
/-- `leader` -/
def leader : Func := ⟨69, by decide⟩
/-- `target-counter` -/
def targetCounter : Func := ⟨70, by decide⟩
/-- `target-counters` -/
def targetCounters : Func := ⟨71, by decide⟩
/-- `target-text` -/
def targetText : Func := ⟨72, by decide⟩
/-- `string` -/
def string : Func := ⟨73, by decide⟩
/-- `content` -/
def content : Func := ⟨74, by decide⟩
/-- `counter` -/
def counter : Func := ⟨75, by decide⟩
/-- `counters` -/
def counters : Func := ⟨76, by decide⟩
/-- `stripes` -/
def stripes : Func := ⟨77, by decide⟩
/-- `inset` -/
def inset : Func := ⟨78, by decide⟩
/-- `rect` -/
def basicShapeRect : Func := ⟨79, by decide⟩
/-- `xywh` -/
def xywh : Func := ⟨80, by decide⟩
/-- `circle` -/
def circle : Func := ⟨81, by decide⟩
/-- `ellipse` -/
def ellipse : Func := ⟨82, by decide⟩
/-- `polygon` -/
def polygon : Func := ⟨83, by decide⟩
/-- `path` -/
def path : Func := ⟨84, by decide⟩
/-- `shape` -/
def shape : Func := ⟨85, by decide⟩
/-- `anchor` -/
def anchor : Func := ⟨86, by decide⟩
/-- `rect` -/
def clipRect : Func := ⟨87, by decide⟩
/-- `repeat` -/
def gapRepeatRule : Func := ⟨88, by decide⟩
/-- `repeat` -/
def gapAutoRepeatRule : Func := ⟨89, by decide⟩
/-- `repeat` -/
def repeatLineColor : Func := ⟨90, by decide⟩
/-- `repeat` -/
def autoRepeatLineColor : Func := ⟨91, by decide⟩
/-- `repeat` -/
def repeatLineStyle : Func := ⟨92, by decide⟩
/-- `repeat` -/
def autoRepeatLineStyle : Func := ⟨93, by decide⟩
/-- `repeat` -/
def repeatLineWidth : Func := ⟨94, by decide⟩
/-- `repeat` -/
def autoRepeatLineWidth : Func := ⟨95, by decide⟩
/-- `superellipse` -/
def superellipse : Func := ⟨96, by decide⟩
/-- `reversed` -/
def reversed : Func := ⟨97, by decide⟩
/-- `dynamic-range-limit-mix` -/
def dynamicRangeLimitMix : Func := ⟨98, by decide⟩
/-- `click` -/
def click : Func := ⟨99, by decide⟩
/-- `dblclick` -/
def dblclick : Func := ⟨100, by decide⟩
/-- `pointerenter` -/
def pointerenter : Func := ⟨101, by decide⟩
/-- `pointerleave` -/
def pointerleave : Func := ⟨102, by decide⟩
/-- `pointerup` -/
def pointerup : Func := ⟨103, by decide⟩
/-- `pointerdown` -/
def pointerdown : Func := ⟨104, by decide⟩
/-- `keypress` -/
def keypress : Func := ⟨105, by decide⟩
/-- `focusin` -/
def focusin : Func := ⟨106, by decide⟩
/-- `focusout` -/
def focusout : Func := ⟨107, by decide⟩
/-- `input` -/
def input : Func := ⟨108, by decide⟩
/-- `change` -/
def change : Func := ⟨109, by decide⟩
/-- `child` -/
def child : Func := ⟨110, by decide⟩
/-- `snap-block` -/
def snapBlock : Func := ⟨111, by decide⟩
/-- `snap-inline` -/
def snapInline : Func := ⟨112, by decide⟩
/-- `generic` -/
def generic : Func := ⟨113, by decide⟩
/-- `palette-mix` -/
def paletteMix : Func := ⟨114, by decide⟩
/-- `stylistic` -/
def fontVariantStylistic : Func := ⟨115, by decide⟩
/-- `styleset` -/
def fontVariantStyleset : Func := ⟨116, by decide⟩
/-- `character-variant` -/
def fontVariantCharacterVariant : Func := ⟨117, by decide⟩
/-- `swash` -/
def fontVariantSwash : Func := ⟨118, by decide⟩
/-- `ornaments` -/
def fontVariantOrnaments : Func := ⟨119, by decide⟩
/-- `annotation` -/
def fontVariantAnnotation : Func := ⟨120, by decide⟩
/-- `stylistic` -/
def fontVariantAlternatesStylistic : Func := ⟨121, by decide⟩
/-- `styleset` -/
def fontVariantAlternatesStyleset : Func := ⟨122, by decide⟩
/-- `character-variant` -/
def fontVariantAlternatesCharacterVariant : Func := ⟨123, by decide⟩
/-- `swash` -/
def fontVariantAlternatesSwash : Func := ⟨124, by decide⟩
/-- `ornaments` -/
def fontVariantAlternatesOrnaments : Func := ⟨125, by decide⟩
/-- `annotation` -/
def fontVariantAlternatesAnnotation : Func := ⟨126, by decide⟩
/-- `` -/
def lineNames : Func := ⟨127, by decide⟩
/-- `minmax` -/
def trackSizeMinmax : Func := ⟨128, by decide⟩
/-- `fit-content` -/
def trackSizeFitContent : Func := ⟨129, by decide⟩
/-- `repeat` -/
def trackRepeat : Func := ⟨130, by decide⟩
/-- `minmax` -/
def fixedSizeMinmax : Func := ⟨131, by decide⟩
/-- `repeat` -/
def fixedRepeat : Func := ⟨132, by decide⟩
/-- `repeat` -/
def autoRepeat : Func := ⟨133, by decide⟩
/-- `repeat` -/
def nameRepeat : Func := ⟨134, by decide⟩
/-- `param` -/
def param : Func := ⟨135, by decide⟩
/-- `symbols` -/
def symbols : Func := ⟨136, by decide⟩
/-- `add` -/
def add : Func := ⟨137, by decide⟩
/-- `ray` -/
def ray : Func := ⟨138, by decide⟩
/-- `running` -/
def running : Func := ⟨139, by decide⟩
/-- `fade` -/
def fade : Func := ⟨140, by decide⟩
/-- `scale` -/
def transformScale : Func := ⟨141, by decide⟩
/-- `scaleX` -/
def transformScaleX : Func := ⟨142, by decide⟩
/-- `scaleY` -/
def transformScaleY : Func := ⟨143, by decide⟩
/-- `format` -/
def format : Func := ⟨144, by decide⟩
/-- `tech` -/
def tech : Func := ⟨145, by decide⟩
/-- `local` -/
def «local» : Func := ⟨146, by decide⟩
/-- `wcag2` -/
def wcag2 : Func := ⟨147, by decide⟩
/-- `type` -/
def type : Func := ⟨148, by decide⟩

def names : Array String := #[
  "linear",
  "cubic-bezier",
  "steps",
  "scroll",
  "view",
  "rgb",
  "rgba",
  "hsl",
  "hsla",
  "hwb",
  "lab",
  "lch",
  "oklab",
  "oklch",
  "ictcp",
  "jzazbz",
  "jzczhz",
  "alpha",
  "color",
  "color-hdr",
  "color-mix",
  "contrast-color",
  "device-cmyk",
  "light-dark",
  "blur",
  "brightness",
  "contrast",
  "drop-shadow",
  "grayscale",
  "hue-rotate",
  "invert",
  "opacity",
  "sepia",
  "saturate",
  "stretch",
  "fit-content",
  "calc-size",
  "anchor-size",
  "image",
  "image-set",
  "cross-fade",
  "element",
  "linear-gradient",
  "repeating-linear-gradient",
  "radial-gradient",
  "repeating-radial-gradient",
  "conic-gradient",
  "repeating-conic-gradient",
  "scale3d",
  "scale",
  "scaleX",
  "scaleY",
  "scaleZ",
  "translate3d",
  "translate",
  "translateX",
  "translateY",
  "translateZ",
  "rotate3d",
  "rotate",
  "rotateX",
  "rotateY",
  "rotateZ",
  "skew",
  "skewX",
  "skewY",
  "matrix3d",
  "matrix",
  "perspective",
  "leader",
  "target-counter",
  "target-counters",
  "target-text",
  "string",
  "content",
  "counter",
  "counters",
  "stripes",
  "inset",
  "rect",
  "xywh",
  "circle",
  "ellipse",
  "polygon",
  "path",
  "shape",
  "anchor",
  "rect",
  "repeat",
  "repeat",
  "repeat",
  "repeat",
  "repeat",
  "repeat",
  "repeat",
  "repeat",
  "superellipse",
  "reversed",
  "dynamic-range-limit-mix",
  "click",
  "dblclick",
  "pointerenter",
  "pointerleave",
  "pointerup",
  "pointerdown",
  "keypress",
  "focusin",
  "focusout",
  "input",
  "change",
  "child",
  "snap-block",
  "snap-inline",
  "generic",
  "palette-mix",
  "stylistic",
  "styleset",
  "character-variant",
  "swash",
  "ornaments",
  "annotation",
  "stylistic",
  "styleset",
  "character-variant",
  "swash",
  "ornaments",
  "annotation",
  "",
  "minmax",
  "fit-content",
  "repeat",
  "minmax",
  "repeat",
  "repeat",
  "repeat",
  "param",
  "symbols",
  "add",
  "ray",
  "running",
  "fade",
  "scale",
  "scaleX",
  "scaleY",
  "format",
  "tech",
  "local",
  "wcag2",
  "type"]

def name (x : Func) : String := names[x.id]?.getD ""

def ofName? (s : String) : Option Func :=
  match names.findIdx? (· == s) with
  | .some i => if h : i < 149 then .some ⟨i, h⟩ else .none
  | .none => .none

/-- How the variant's arguments are enclosed. -/
def brackets : Array Bracket := #[
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .brackets,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function,
  .function]

def bracket (f : Func) : Bracket := brackets[f.id]?.getD .function

end Func

end CssModel
