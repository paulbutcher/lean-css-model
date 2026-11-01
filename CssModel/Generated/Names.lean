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
  valid : id < 1013
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
/-- `and` -/
def and : Keyword := ⟨37, by decide⟩
/-- `antiquewhite` -/
def antiquewhite : Keyword := ⟨38, by decide⟩
/-- `any` -/
def any : Keyword := ⟨39, by decide⟩
/-- `anywhere` -/
def anywhere : Keyword := ⟨40, by decide⟩
/-- `application` -/
def application : Keyword := ⟨41, by decide⟩
/-- `AppWorkspace` -/
def AppWorkspace : Keyword := ⟨42, by decide⟩
/-- `aqua` -/
def aqua : Keyword := ⟨43, by decide⟩
/-- `aquamarine` -/
def aquamarine : Keyword := ⟨44, by decide⟩
/-- `arc` -/
def arc : Keyword := ⟨45, by decide⟩
/-- `arcs` -/
def arcs : Keyword := ⟨46, by decide⟩
/-- `around` -/
def around : Keyword := ⟨47, by decide⟩
/-- `at` -/
def «at» : Keyword := ⟨48, by decide⟩
/-- `auto` -/
def auto : Keyword := ⟨49, by decide⟩
/-- `auto-add` -/
def autoAdd : Keyword := ⟨50, by decide⟩
/-- `auto-fill` -/
def autoFill : Keyword := ⟨51, by decide⟩
/-- `auto-fit` -/
def autoFit : Keyword := ⟨52, by decide⟩
/-- `auto-flow` -/
def autoFlow : Keyword := ⟨53, by decide⟩
/-- `auto-phrase` -/
def autoPhrase : Keyword := ⟨54, by decide⟩
/-- `avoid` -/
def avoid : Keyword := ⟨55, by decide⟩
/-- `avoid-column` -/
def avoidColumn : Keyword := ⟨56, by decide⟩
/-- `avoid-flex` -/
def avoidFlex : Keyword := ⟨57, by decide⟩
/-- `avoid-line` -/
def avoidLine : Keyword := ⟨58, by decide⟩
/-- `avoid-page` -/
def avoidPage : Keyword := ⟨59, by decide⟩
/-- `avoid-region` -/
def avoidRegion : Keyword := ⟨60, by decide⟩
/-- `avoid-short-last-line` -/
def avoidShortLastLine : Keyword := ⟨61, by decide⟩
/-- `azure` -/
def azure : Keyword := ⟨62, by decide⟩
/-- `B4` -/
def B4 : Keyword := ⟨63, by decide⟩
/-- `B5` -/
def B5 : Keyword := ⟨64, by decide⟩
/-- `back` -/
def back : Keyword := ⟨65, by decide⟩
/-- `Background` -/
def Background : Keyword := ⟨66, by decide⟩
/-- `backwards` -/
def backwards : Keyword := ⟨67, by decide⟩
/-- `balance` -/
def balance : Keyword := ⟨68, by decide⟩
/-- `balance-all` -/
def balanceAll : Keyword := ⟨69, by decide⟩
/-- `bar` -/
def bar : Keyword := ⟨70, by decide⟩
/-- `base` -/
def base : Keyword := ⟨71, by decide⟩
/-- `base-select` -/
def baseSelect : Keyword := ⟨72, by decide⟩
/-- `baseline` -/
def baseline : Keyword := ⟨73, by decide⟩
/-- `before` -/
def before : Keyword := ⟨74, by decide⟩
/-- `beige` -/
def beige : Keyword := ⟨75, by decide⟩
/-- `between` -/
def between : Keyword := ⟨76, by decide⟩
/-- `bevel` -/
def bevel : Keyword := ⟨77, by decide⟩
/-- `bidi-override` -/
def bidiOverride : Keyword := ⟨78, by decide⟩
/-- `bikeshed-this` -/
def bikeshedThis : Keyword := ⟨79, by decide⟩
/-- `bisque` -/
def bisque : Keyword := ⟨80, by decide⟩
/-- `black` -/
def black : Keyword := ⟨81, by decide⟩
/-- `blanchedalmond` -/
def blanchedalmond : Keyword := ⟨82, by decide⟩
/-- `blink` -/
def blink : Keyword := ⟨83, by decide⟩
/-- `block` -/
def block : Keyword := ⟨84, by decide⟩
/-- `block-end` -/
def blockEnd : Keyword := ⟨85, by decide⟩
/-- `block-start` -/
def blockStart : Keyword := ⟨86, by decide⟩
/-- `blue` -/
def blue : Keyword := ⟨87, by decide⟩
/-- `blueviolet` -/
def blueviolet : Keyword := ⟨88, by decide⟩
/-- `bold` -/
def bold : Keyword := ⟨89, by decide⟩
/-- `bolder` -/
def bolder : Keyword := ⟨90, by decide⟩
/-- `border-area` -/
def borderArea : Keyword := ⟨91, by decide⟩
/-- `border-box` -/
def borderBox : Keyword := ⟨92, by decide⟩
/-- `both` -/
def both : Keyword := ⟨93, by decide⟩
/-- `both-block` -/
def bothBlock : Keyword := ⟨94, by decide⟩
/-- `both-edges` -/
def bothEdges : Keyword := ⟨95, by decide⟩
/-- `both-inline` -/
def bothInline : Keyword := ⟨96, by decide⟩
/-- `bottom` -/
def bottom : Keyword := ⟨97, by decide⟩
/-- `bottom-to-top` -/
def bottomToTop : Keyword := ⟨98, by decide⟩
/-- `bounding-box` -/
def boundingBox : Keyword := ⟨99, by decide⟩
/-- `break` -/
def «break» : Keyword := ⟨100, by decide⟩
/-- `break-all` -/
def breakAll : Keyword := ⟨101, by decide⟩
/-- `break-spaces` -/
def breakSpaces : Keyword := ⟨102, by decide⟩
/-- `break-word` -/
def breakWord : Keyword := ⟨103, by decide⟩
/-- `brown` -/
def brown : Keyword := ⟨104, by decide⟩
/-- `browser` -/
def browser : Keyword := ⟨105, by decide⟩
/-- `bullets` -/
def bullets : Keyword := ⟨106, by decide⟩
/-- `burlywood` -/
def burlywood : Keyword := ⟨107, by decide⟩
/-- `butt` -/
def butt : Keyword := ⟨108, by decide⟩
/-- `button` -/
def button : Keyword := ⟨109, by decide⟩
/-- `ButtonBorder` -/
def ButtonBorder : Keyword := ⟨110, by decide⟩
/-- `ButtonFace` -/
def ButtonFace : Keyword := ⟨111, by decide⟩
/-- `ButtonHighlight` -/
def ButtonHighlight : Keyword := ⟨112, by decide⟩
/-- `ButtonShadow` -/
def ButtonShadow : Keyword := ⟨113, by decide⟩
/-- `ButtonText` -/
def ButtonText : Keyword := ⟨114, by decide⟩
/-- `by` -/
def «by» : Keyword := ⟨115, by decide⟩
/-- `cadetblue` -/
def cadetblue : Keyword := ⟨116, by decide⟩
/-- `Canvas` -/
def Canvas : Keyword := ⟨117, by decide⟩
/-- `CanvasText` -/
def CanvasText : Keyword := ⟨118, by decide⟩
/-- `cap` -/
def cap : Keyword := ⟨119, by decide⟩
/-- `cap-height` -/
def capHeight : Keyword := ⟨120, by decide⟩
/-- `capitalize` -/
def capitalize : Keyword := ⟨121, by decide⟩
/-- `caption` -/
def caption : Keyword := ⟨122, by decide⟩
/-- `CaptionText` -/
def CaptionText : Keyword := ⟨123, by decide⟩
/-- `ccw` -/
def ccw : Keyword := ⟨124, by decide⟩
/-- `cell` -/
def cell : Keyword := ⟨125, by decide⟩
/-- `center` -/
def center : Keyword := ⟨126, by decide⟩
/-- `central` -/
def central : Keyword := ⟨127, by decide⟩
/-- `ch-width` -/
def chWidth : Keyword := ⟨128, by decide⟩
/-- `chain` -/
def chain : Keyword := ⟨129, by decide⟩
/-- `chartreuse` -/
def chartreuse : Keyword := ⟨130, by decide⟩
/-- `checkbox` -/
def checkbox : Keyword := ⟨131, by decide⟩
/-- `child` -/
def child : Keyword := ⟨132, by decide⟩
/-- `chocolate` -/
def chocolate : Keyword := ⟨133, by decide⟩
/-- `circle` -/
def circle : Keyword := ⟨134, by decide⟩
/-- `clamp` -/
def clamp : Keyword := ⟨135, by decide⟩
/-- `clear` -/
def clear : Keyword := ⟨136, by decide⟩
/-- `clip` -/
def clip : Keyword := ⟨137, by decide⟩
/-- `clone` -/
def clone : Keyword := ⟨138, by decide⟩
/-- `close` -/
def close : Keyword := ⟨139, by decide⟩
/-- `close-quote` -/
def closeQuote : Keyword := ⟨140, by decide⟩
/-- `closed` -/
def closed : Keyword := ⟨141, by decide⟩
/-- `closest-corner` -/
def closestCorner : Keyword := ⟨142, by decide⟩
/-- `closest-side` -/
def closestSide : Keyword := ⟨143, by decide⟩
/-- `coarse` -/
def coarse : Keyword := ⟨144, by decide⟩
/-- `col-resize` -/
def colResize : Keyword := ⟨145, by decide⟩
/-- `collapse` -/
def collapse : Keyword := ⟨146, by decide⟩
/-- `collection` -/
def collection : Keyword := ⟨147, by decide⟩
/-- `color` -/
def color : Keyword := ⟨148, by decide⟩
/-- `color-burn` -/
def colorBurn : Keyword := ⟨149, by decide⟩
/-- `color-CBDT` -/
def colorCBDT : Keyword := ⟨150, by decide⟩
/-- `color-COLRv0` -/
def colorCOLRv0 : Keyword := ⟨151, by decide⟩
/-- `color-COLRv1` -/
def colorCOLRv1 : Keyword := ⟨152, by decide⟩
/-- `color-dodge` -/
def colorDodge : Keyword := ⟨153, by decide⟩
/-- `color-sbix` -/
def colorSbix : Keyword := ⟨154, by decide⟩
/-- `color-SVG` -/
def colorSVG : Keyword := ⟨155, by decide⟩
/-- `column` -/
def column : Keyword := ⟨156, by decide⟩
/-- `column-over-row` -/
def columnOverRow : Keyword := ⟨157, by decide⟩
/-- `column-reverse` -/
def columnReverse : Keyword := ⟨158, by decide⟩
/-- `common-ligatures` -/
def commonLigatures : Keyword := ⟨159, by decide⟩
/-- `compact` -/
def compact : Keyword := ⟨160, by decide⟩
/-- `compress` -/
def compress : Keyword := ⟨161, by decide⟩
/-- `condensed` -/
def condensed : Keyword := ⟨162, by decide⟩
/-- `consistent` -/
def consistent : Keyword := ⟨163, by decide⟩
/-- `constrained` -/
def constrained : Keyword := ⟨164, by decide⟩
/-- `contain` -/
def contain : Keyword := ⟨165, by decide⟩
/-- `content` -/
def content : Keyword := ⟨166, by decide⟩
/-- `content-block-size` -/
def contentBlockSize : Keyword := ⟨167, by decide⟩
/-- `content-box` -/
def contentBox : Keyword := ⟨168, by decide⟩
/-- `content-height` -/
def contentHeight : Keyword := ⟨169, by decide⟩
/-- `content-inline-size` -/
def contentInlineSize : Keyword := ⟨170, by decide⟩
/-- `content-width` -/
def contentWidth : Keyword := ⟨171, by decide⟩
/-- `contents` -/
def contents : Keyword := ⟨172, by decide⟩
/-- `context-menu` -/
def contextMenu : Keyword := ⟨173, by decide⟩
/-- `contextual` -/
def contextual : Keyword := ⟨174, by decide⟩
/-- `copy` -/
def copy : Keyword := ⟨175, by decide⟩
/-- `coral` -/
def coral : Keyword := ⟨176, by decide⟩
/-- `corners` -/
def corners : Keyword := ⟨177, by decide⟩
/-- `cornflowerblue` -/
def cornflowerblue : Keyword := ⟨178, by decide⟩
/-- `cornsilk` -/
def cornsilk : Keyword := ⟨179, by decide⟩
/-- `cover` -/
def cover : Keyword := ⟨180, by decide⟩
/-- `create` -/
def create : Keyword := ⟨181, by decide⟩
/-- `crimson` -/
def crimson : Keyword := ⟨182, by decide⟩
/-- `crisp-edges` -/
def «crisp-edges» : Keyword := ⟨183, by decide⟩
/-- `crispEdges` -/
def crispEdges : Keyword := ⟨184, by decide⟩
/-- `crop` -/
def crop : Keyword := ⟨185, by decide⟩
/-- `cross` -/
def cross : Keyword := ⟨186, by decide⟩
/-- `crosshair` -/
def crosshair : Keyword := ⟨187, by decide⟩
/-- `current` -/
def current : Keyword := ⟨188, by decide⟩
/-- `currentColor` -/
def currentColor : Keyword := ⟨189, by decide⟩
/-- `cursive` -/
def cursive : Keyword := ⟨190, by decide⟩
/-- `curve` -/
def curve : Keyword := ⟨191, by decide⟩
/-- `custom` -/
def custom : Keyword := ⟨192, by decide⟩
/-- `cw` -/
def cw : Keyword := ⟨193, by decide⟩
/-- `cyan` -/
def cyan : Keyword := ⟨194, by decide⟩
/-- `cyclic` -/
def cyclic : Keyword := ⟨195, by decide⟩
/-- `dark` -/
def dark : Keyword := ⟨196, by decide⟩
/-- `darkblue` -/
def darkblue : Keyword := ⟨197, by decide⟩
/-- `darkcyan` -/
def darkcyan : Keyword := ⟨198, by decide⟩
/-- `darken` -/
def darken : Keyword := ⟨199, by decide⟩
/-- `darkgoldenrod` -/
def darkgoldenrod : Keyword := ⟨200, by decide⟩
/-- `darkgray` -/
def darkgray : Keyword := ⟨201, by decide⟩
/-- `darkgreen` -/
def darkgreen : Keyword := ⟨202, by decide⟩
/-- `darkgrey` -/
def darkgrey : Keyword := ⟨203, by decide⟩
/-- `darkkhaki` -/
def darkkhaki : Keyword := ⟨204, by decide⟩
/-- `darkmagenta` -/
def darkmagenta : Keyword := ⟨205, by decide⟩
/-- `darkolivegreen` -/
def darkolivegreen : Keyword := ⟨206, by decide⟩
/-- `darkorange` -/
def darkorange : Keyword := ⟨207, by decide⟩
/-- `darkorchid` -/
def darkorchid : Keyword := ⟨208, by decide⟩
/-- `darkred` -/
def darkred : Keyword := ⟨209, by decide⟩
/-- `darksalmon` -/
def darksalmon : Keyword := ⟨210, by decide⟩
/-- `darkseagreen` -/
def darkseagreen : Keyword := ⟨211, by decide⟩
/-- `darkslateblue` -/
def darkslateblue : Keyword := ⟨212, by decide⟩
/-- `darkslategray` -/
def darkslategray : Keyword := ⟨213, by decide⟩
/-- `darkslategrey` -/
def darkslategrey : Keyword := ⟨214, by decide⟩
/-- `darkturquoise` -/
def darkturquoise : Keyword := ⟨215, by decide⟩
/-- `darkviolet` -/
def darkviolet : Keyword := ⟨216, by decide⟩
/-- `dashed` -/
def dashed : Keyword := ⟨217, by decide⟩
/-- `dashes` -/
def dashes : Keyword := ⟨218, by decide⟩
/-- `decimal` -/
def decimal : Keyword := ⟨219, by decide⟩
/-- `decreasing` -/
def decreasing : Keyword := ⟨220, by decide⟩
/-- `deeppink` -/
def deeppink : Keyword := ⟨221, by decide⟩
/-- `deepskyblue` -/
def deepskyblue : Keyword := ⟨222, by decide⟩
/-- `default` -/
def default : Keyword := ⟨223, by decide⟩
/-- `dense` -/
def dense : Keyword := ⟨224, by decide⟩
/-- `diagonal-fractions` -/
def diagonalFractions : Keyword := ⟨225, by decide⟩
/-- `difference` -/
def difference : Keyword := ⟨226, by decide⟩
/-- `digits` -/
def digits : Keyword := ⟨227, by decide⟩
/-- `dimgray` -/
def dimgray : Keyword := ⟨228, by decide⟩
/-- `dimgrey` -/
def dimgrey : Keyword := ⟨229, by decide⟩
/-- `disc` -/
def disc : Keyword := ⟨230, by decide⟩
/-- `discard` -/
def discard : Keyword := ⟨231, by decide⟩
/-- `discard-after` -/
def discardAfter : Keyword := ⟨232, by decide⟩
/-- `discard-before` -/
def discardBefore : Keyword := ⟨233, by decide⟩
/-- `discard-inner` -/
def discardInner : Keyword := ⟨234, by decide⟩
/-- `disclosure-closed` -/
def disclosureClosed : Keyword := ⟨235, by decide⟩
/-- `disclosure-open` -/
def disclosureOpen : Keyword := ⟨236, by decide⟩
/-- `discretionary-ligatures` -/
def discretionaryLigatures : Keyword := ⟨237, by decide⟩
/-- `display` -/
def display : Keyword := ⟨238, by decide⟩
/-- `display-p3` -/
def displayP3 : Keyword := ⟨239, by decide⟩
/-- `display-p3-linear` -/
def displayP3Linear : Keyword := ⟨240, by decide⟩
/-- `dodgerblue` -/
def dodgerblue : Keyword := ⟨241, by decide⟩
/-- `dot` -/
def dot : Keyword := ⟨242, by decide⟩
/-- `dotted` -/
def dotted : Keyword := ⟨243, by decide⟩
/-- `double` -/
def double : Keyword := ⟨244, by decide⟩
/-- `double-circle` -/
def doubleCircle : Keyword := ⟨245, by decide⟩
/-- `down` -/
def down : Keyword := ⟨246, by decide⟩
/-- `drop` -/
def drop : Keyword := ⟨247, by decide⟩
/-- `e-resize` -/
def eResize : Keyword := ⟨248, by decide⟩
/-- `each-line` -/
def eachLine : Keyword := ⟨249, by decide⟩
/-- `ease` -/
def ease : Keyword := ⟨250, by decide⟩
/-- `ease-in` -/
def easeIn : Keyword := ⟨251, by decide⟩
/-- `ease-in-out` -/
def easeInOut : Keyword := ⟨252, by decide⟩
/-- `ease-out` -/
def easeOut : Keyword := ⟨253, by decide⟩
/-- `economy` -/
def economy : Keyword := ⟨254, by decide⟩
/-- `element` -/
def element : Keyword := ⟨255, by decide⟩
/-- `ellipse` -/
def ellipse : Keyword := ⟨256, by decide⟩
/-- `ellipsis` -/
def ellipsis : Keyword := ⟨257, by decide⟩
/-- `embed` -/
def embed : Keyword := ⟨258, by decide⟩
/-- `embedded-opentype` -/
def embeddedOpentype : Keyword := ⟨259, by decide⟩
/-- `emoji` -/
def emoji : Keyword := ⟨260, by decide⟩
/-- `enabled` -/
def enabled : Keyword := ⟨261, by decide⟩
/-- `end` -/
def «end» : Keyword := ⟨262, by decide⟩
/-- `entry` -/
def entry : Keyword := ⟨263, by decide⟩
/-- `entry-crossing` -/
def entryCrossing : Keyword := ⟨264, by decide⟩
/-- `evenodd` -/
def evenodd : Keyword := ⟨265, by decide⟩
/-- `ew-resize` -/
def ewResize : Keyword := ⟨266, by decide⟩
/-- `ex` -/
def ex : Keyword := ⟨267, by decide⟩
/-- `ex-height` -/
def exHeight : Keyword := ⟨268, by decide⟩
/-- `exact` -/
def exact : Keyword := ⟨269, by decide⟩
/-- `exclude` -/
def exclude : Keyword := ⟨270, by decide⟩
/-- `exclusion` -/
def exclusion : Keyword := ⟨271, by decide⟩
/-- `exit` -/
def exit : Keyword := ⟨272, by decide⟩
/-- `exit-crossing` -/
def exitCrossing : Keyword := ⟨273, by decide⟩
/-- `expanded` -/
def expanded : Keyword := ⟨274, by decide⟩
/-- `extends` -/
def «extends» : Keyword := ⟨275, by decide⟩
/-- `extra-condensed` -/
def extraCondensed : Keyword := ⟨276, by decide⟩
/-- `extra-expanded` -/
def extraExpanded : Keyword := ⟨277, by decide⟩
/-- `fade` -/
def fade : Keyword := ⟨278, by decide⟩
/-- `fallback` -/
def fallback : Keyword := ⟨279, by decide⟩
/-- `false` -/
def false : Keyword := ⟨280, by decide⟩
/-- `fangsong` -/
def fangsong : Keyword := ⟨281, by decide⟩
/-- `fantasy` -/
def fantasy : Keyword := ⟨282, by decide⟩
/-- `farthest-corner` -/
def farthestCorner : Keyword := ⟨283, by decide⟩
/-- `farthest-side` -/
def farthestSide : Keyword := ⟨284, by decide⟩
/-- `fast` -/
def fast : Keyword := ⟨285, by decide⟩
/-- `features-aat` -/
def featuresAat : Keyword := ⟨286, by decide⟩
/-- `features-graphite` -/
def featuresGraphite : Keyword := ⟨287, by decide⟩
/-- `features-opentype` -/
def featuresOpentype : Keyword := ⟨288, by decide⟩
/-- `female` -/
def female : Keyword := ⟨289, by decide⟩
/-- `Field` -/
def Field : Keyword := ⟨290, by decide⟩
/-- `FieldText` -/
def FieldText : Keyword := ⟨291, by decide⟩
/-- `fill` -/
def fill : Keyword := ⟨292, by decide⟩
/-- `fill-box` -/
def fillBox : Keyword := ⟨293, by decide⟩
/-- `filled` -/
def filled : Keyword := ⟨294, by decide⟩
/-- `fine` -/
def fine : Keyword := ⟨295, by decide⟩
/-- `firebrick` -/
def firebrick : Keyword := ⟨296, by decide⟩
/-- `first` -/
def first : Keyword := ⟨297, by decide⟩
/-- `first-except` -/
def firstExcept : Keyword := ⟨298, by decide⟩
/-- `first-letter` -/
def firstLetter : Keyword := ⟨299, by decide⟩
/-- `fit-content` -/
def fitContent : Keyword := ⟨300, by decide⟩
/-- `fixed` -/
def fixed : Keyword := ⟨301, by decide⟩
/-- `fixed-position` -/
def fixedPosition : Keyword := ⟨302, by decide⟩
/-- `flat` -/
def flat : Keyword := ⟨303, by decide⟩
/-- `flex` -/
def flex : Keyword := ⟨304, by decide⟩
/-- `flex-end` -/
def flexEnd : Keyword := ⟨305, by decide⟩
/-- `flex-flow` -/
def flexFlow : Keyword := ⟨306, by decide⟩
/-- `flex-start` -/
def flexStart : Keyword := ⟨307, by decide⟩
/-- `flex-visual` -/
def flexVisual : Keyword := ⟨308, by decide⟩
/-- `flip` -/
def flip : Keyword := ⟨309, by decide⟩
/-- `flip-block` -/
def flipBlock : Keyword := ⟨310, by decide⟩
/-- `flip-inline` -/
def flipInline : Keyword := ⟨311, by decide⟩
/-- `flip-start` -/
def flipStart : Keyword := ⟨312, by decide⟩
/-- `flip-x` -/
def flipX : Keyword := ⟨313, by decide⟩
/-- `flip-y` -/
def flipY : Keyword := ⟨314, by decide⟩
/-- `floralwhite` -/
def floralwhite : Keyword := ⟨315, by decide⟩
/-- `flow` -/
def flow : Keyword := ⟨316, by decide⟩
/-- `flow-end` -/
def flowEnd : Keyword := ⟨317, by decide⟩
/-- `flow-root` -/
def flowRoot : Keyword := ⟨318, by decide⟩
/-- `flow-start` -/
def flowStart : Keyword := ⟨319, by decide⟩
/-- `focus` -/
def focus : Keyword := ⟨320, by decide⟩
/-- `footnote` -/
def footnote : Keyword := ⟨321, by decide⟩
/-- `force-end` -/
def forceEnd : Keyword := ⟨322, by decide⟩
/-- `force-hidden` -/
def forceHidden : Keyword := ⟨323, by decide⟩
/-- `forestgreen` -/
def forestgreen : Keyword := ⟨324, by decide⟩
/-- `forwards` -/
def forwards : Keyword := ⟨325, by decide⟩
/-- `fragments` -/
def fragments : Keyword := ⟨326, by decide⟩
/-- `from` -/
def «from» : Keyword := ⟨327, by decide⟩
/-- `from-font` -/
def fromFont : Keyword := ⟨328, by decide⟩
/-- `from-image` -/
def fromImage : Keyword := ⟨329, by decide⟩
/-- `fuchsia` -/
def fuchsia : Keyword := ⟨330, by decide⟩
/-- `full-size-kana` -/
def fullSizeKana : Keyword := ⟨331, by decide⟩
/-- `full-width` -/
def fullWidth : Keyword := ⟨332, by decide⟩
/-- `fullscreen` -/
def fullscreen : Keyword := ⟨333, by decide⟩
/-- `gainsboro` -/
def gainsboro : Keyword := ⟨334, by decide⟩
/-- `gaps` -/
def gaps : Keyword := ⟨335, by decide⟩
/-- `geometricPrecision` -/
def geometricPrecision : Keyword := ⟨336, by decide⟩
/-- `ghostwhite` -/
def ghostwhite : Keyword := ⟨337, by decide⟩
/-- `gold` -/
def gold : Keyword := ⟨338, by decide⟩
/-- `goldenrod` -/
def goldenrod : Keyword := ⟨339, by decide⟩
/-- `grab` -/
def grab : Keyword := ⟨340, by decide⟩
/-- `grabbing` -/
def grabbing : Keyword := ⟨341, by decide⟩
/-- `grammar-error` -/
def grammarError : Keyword := ⟨342, by decide⟩
/-- `gray` -/
def gray : Keyword := ⟨343, by decide⟩
/-- `GrayText` -/
def GrayText : Keyword := ⟨344, by decide⟩
/-- `green` -/
def green : Keyword := ⟨345, by decide⟩
/-- `greenyellow` -/
def greenyellow : Keyword := ⟨346, by decide⟩
/-- `grey` -/
def grey : Keyword := ⟨347, by decide⟩
/-- `grid` -/
def grid : Keyword := ⟨348, by decide⟩
/-- `grid-columns` -/
def gridColumns : Keyword := ⟨349, by decide⟩
/-- `grid-lanes` -/
def gridLanes : Keyword := ⟨350, by decide⟩
/-- `grid-order` -/
def gridOrder : Keyword := ⟨351, by decide⟩
/-- `grid-rows` -/
def gridRows : Keyword := ⟨352, by decide⟩
/-- `groove` -/
def groove : Keyword := ⟨353, by decide⟩
/-- `grow` -/
def grow : Keyword := ⟨354, by decide⟩
/-- `hairline` -/
def hairline : Keyword := ⟨355, by decide⟩
/-- `half-border-box` -/
def halfBorderBox : Keyword := ⟨356, by decide⟩
/-- `hanging` -/
def hanging : Keyword := ⟨357, by decide⟩
/-- `hard-light` -/
def hardLight : Keyword := ⟨358, by decide⟩
/-- `height` -/
def height : Keyword := ⟨359, by decide⟩
/-- `help` -/
def help : Keyword := ⟨360, by decide⟩
/-- `hidden` -/
def hidden : Keyword := ⟨361, by decide⟩
/-- `hide` -/
def hide : Keyword := ⟨362, by decide⟩
/-- `high` -/
def high : Keyword := ⟨363, by decide⟩
/-- `high-quality` -/
def highQuality : Keyword := ⟨364, by decide⟩
/-- `Highlight` -/
def Highlight : Keyword := ⟨365, by decide⟩
/-- `HighlightText` -/
def HighlightText : Keyword := ⟨366, by decide⟩
/-- `historical-forms` -/
def historicalForms : Keyword := ⟨367, by decide⟩
/-- `historical-ligatures` -/
def historicalLigatures : Keyword := ⟨368, by decide⟩
/-- `hline` -/
def hline : Keyword := ⟨369, by decide⟩
/-- `honeydew` -/
def honeydew : Keyword := ⟨370, by decide⟩
/-- `horizontal` -/
def horizontal : Keyword := ⟨371, by decide⟩
/-- `horizontal-tb` -/
def horizontalTb : Keyword := ⟨372, by decide⟩
/-- `hotpink` -/
def hotpink : Keyword := ⟨373, by decide⟩
/-- `hover` -/
def hover : Keyword := ⟨374, by decide⟩
/-- `hsl` -/
def hsl : Keyword := ⟨375, by decide⟩
/-- `hue` -/
def hue : Keyword := ⟨376, by decide⟩
/-- `hwb` -/
def hwb : Keyword := ⟨377, by decide⟩
/-- `ic-height` -/
def icHeight : Keyword := ⟨378, by decide⟩
/-- `ic-width` -/
def icWidth : Keyword := ⟨379, by decide⟩
/-- `icon` -/
def icon : Keyword := ⟨380, by decide⟩
/-- `ideograph-alpha` -/
def ideographAlpha : Keyword := ⟨381, by decide⟩
/-- `ideograph-numeric` -/
def ideographNumeric : Keyword := ⟨382, by decide⟩
/-- `ideographic` -/
def ideographic : Keyword := ⟨383, by decide⟩
/-- `ideographic-ink` -/
def ideographicInk : Keyword := ⟨384, by decide⟩
/-- `ideographic-space` -/
def ideographicSpace : Keyword := ⟨385, by decide⟩
/-- `in` -/
def «in» : Keyword := ⟨386, by decide⟩
/-- `InactiveBorder` -/
def InactiveBorder : Keyword := ⟨387, by decide⟩
/-- `InactiveCaption` -/
def InactiveCaption : Keyword := ⟨388, by decide⟩
/-- `InactiveCaptionText` -/
def InactiveCaptionText : Keyword := ⟨389, by decide⟩
/-- `increasing` -/
def increasing : Keyword := ⟨390, by decide⟩
/-- `incremental` -/
def incremental : Keyword := ⟨391, by decide⟩
/-- `indianred` -/
def indianred : Keyword := ⟨392, by decide⟩
/-- `indigo` -/
def indigo : Keyword := ⟨393, by decide⟩
/-- `inert` -/
def inert : Keyword := ⟨394, by decide⟩
/-- `infinite` -/
def infinite : Keyword := ⟨395, by decide⟩
/-- `infinity` -/
def infinity : Keyword := ⟨396, by decide⟩
/-- `InfoBackground` -/
def InfoBackground : Keyword := ⟨397, by decide⟩
/-- `InfoText` -/
def InfoText : Keyword := ⟨398, by decide⟩
/-- `inherit` -/
def inherit : Keyword := ⟨399, by decide⟩
/-- `initial` -/
def initial : Keyword := ⟨400, by decide⟩
/-- `initial-only` -/
def initialOnly : Keyword := ⟨401, by decide⟩
/-- `inline` -/
def inline : Keyword := ⟨402, by decide⟩
/-- `inline-block` -/
def inlineBlock : Keyword := ⟨403, by decide⟩
/-- `inline-end` -/
def inlineEnd : Keyword := ⟨404, by decide⟩
/-- `inline-flex` -/
def inlineFlex : Keyword := ⟨405, by decide⟩
/-- `inline-grid` -/
def inlineGrid : Keyword := ⟨406, by decide⟩
/-- `inline-grid-lanes` -/
def inlineGridLanes : Keyword := ⟨407, by decide⟩
/-- `inline-size` -/
def inlineSize : Keyword := ⟨408, by decide⟩
/-- `inline-start` -/
def inlineStart : Keyword := ⟨409, by decide⟩
/-- `inline-table` -/
def inlineTable : Keyword := ⟨410, by decide⟩
/-- `inner` -/
def inner : Keyword := ⟨411, by decide⟩
/-- `insert` -/
def insert : Keyword := ⟨412, by decide⟩
/-- `inset` -/
def inset : Keyword := ⟨413, by decide⟩
/-- `inside` -/
def inside : Keyword := ⟨414, by decide⟩
/-- `inter-character` -/
def interCharacter : Keyword := ⟨415, by decide⟩
/-- `inter-word` -/
def interWord : Keyword := ⟨416, by decide⟩
/-- `interlace` -/
def interlace : Keyword := ⟨417, by decide⟩
/-- `intersect` -/
def intersect : Keyword := ⟨418, by decide⟩
/-- `intersection` -/
def intersection : Keyword := ⟨419, by decide⟩
/-- `inverted` -/
def inverted : Keyword := ⟨420, by decide⟩
/-- `isolate` -/
def isolate : Keyword := ⟨421, by decide⟩
/-- `isolate-override` -/
def isolateOverride : Keyword := ⟨422, by decide⟩
/-- `italic` -/
def italic : Keyword := ⟨423, by decide⟩
/-- `ivory` -/
def ivory : Keyword := ⟨424, by decide⟩
/-- `JIS-B4` -/
def JISB4 : Keyword := ⟨425, by decide⟩
/-- `JIS-B5` -/
def JISB5 : Keyword := ⟨426, by decide⟩
/-- `jis04` -/
def jis04 : Keyword := ⟨427, by decide⟩
/-- `jis78` -/
def jis78 : Keyword := ⟨428, by decide⟩
/-- `jis83` -/
def jis83 : Keyword := ⟨429, by decide⟩
/-- `jis90` -/
def jis90 : Keyword := ⟨430, by decide⟩
/-- `jump-both` -/
def jumpBoth : Keyword := ⟨431, by decide⟩
/-- `jump-end` -/
def jumpEnd : Keyword := ⟨432, by decide⟩
/-- `jump-none` -/
def jumpNone : Keyword := ⟨433, by decide⟩
/-- `jump-start` -/
def jumpStart : Keyword := ⟨434, by decide⟩
/-- `justify` -/
def justify : Keyword := ⟨435, by decide⟩
/-- `justify-all` -/
def justifyAll : Keyword := ⟨436, by decide⟩
/-- `kai` -/
def kai : Keyword := ⟨437, by decide⟩
/-- `keep` -/
def keep : Keyword := ⟨438, by decide⟩
/-- `keep-all` -/
def keepAll : Keyword := ⟨439, by decide⟩
/-- `khaki` -/
def khaki : Keyword := ⟨440, by decide⟩
/-- `khmer-mul` -/
def khmerMul : Keyword := ⟨441, by decide⟩
/-- `lab` -/
def lab : Keyword := ⟨442, by decide⟩
/-- `landscape` -/
def landscape : Keyword := ⟨443, by decide⟩
/-- `large` -/
def large : Keyword := ⟨444, by decide⟩
/-- `larger` -/
def larger : Keyword := ⟨445, by decide⟩
/-- `last` -/
def last : Keyword := ⟨446, by decide⟩
/-- `last-baseline` -/
def lastBaseline : Keyword := ⟨447, by decide⟩
/-- `lavender` -/
def lavender : Keyword := ⟨448, by decide⟩
/-- `lavenderblush` -/
def lavenderblush : Keyword := ⟨449, by decide⟩
/-- `lawngreen` -/
def lawngreen : Keyword := ⟨450, by decide⟩
/-- `layout` -/
def layout : Keyword := ⟨451, by decide⟩
/-- `lch` -/
def lch : Keyword := ⟨452, by decide⟩
/-- `leading` -/
def leading : Keyword := ⟨453, by decide⟩
/-- `ledger` -/
def ledger : Keyword := ⟨454, by decide⟩
/-- `left` -/
def left : Keyword := ⟨455, by decide⟩
/-- `left-to-right` -/
def leftToRight : Keyword := ⟨456, by decide⟩
/-- `leftwards` -/
def leftwards : Keyword := ⟨457, by decide⟩
/-- `legacy` -/
def legacy : Keyword := ⟨458, by decide⟩
/-- `legal` -/
def legal : Keyword := ⟨459, by decide⟩
/-- `lemonchiffon` -/
def lemonchiffon : Keyword := ⟨460, by decide⟩
/-- `less` -/
def less : Keyword := ⟨461, by decide⟩
/-- `letter` -/
def letter : Keyword := ⟨462, by decide⟩
/-- `light` -/
def light : Keyword := ⟨463, by decide⟩
/-- `lightblue` -/
def lightblue : Keyword := ⟨464, by decide⟩
/-- `lightcoral` -/
def lightcoral : Keyword := ⟨465, by decide⟩
/-- `lightcyan` -/
def lightcyan : Keyword := ⟨466, by decide⟩
/-- `lighten` -/
def lighten : Keyword := ⟨467, by decide⟩
/-- `lighter` -/
def lighter : Keyword := ⟨468, by decide⟩
/-- `lightgoldenrodyellow` -/
def lightgoldenrodyellow : Keyword := ⟨469, by decide⟩
/-- `lightgray` -/
def lightgray : Keyword := ⟨470, by decide⟩
/-- `lightgreen` -/
def lightgreen : Keyword := ⟨471, by decide⟩
/-- `lightgrey` -/
def lightgrey : Keyword := ⟨472, by decide⟩
/-- `lightpink` -/
def lightpink : Keyword := ⟨473, by decide⟩
/-- `lightsalmon` -/
def lightsalmon : Keyword := ⟨474, by decide⟩
/-- `lightseagreen` -/
def lightseagreen : Keyword := ⟨475, by decide⟩
/-- `lightskyblue` -/
def lightskyblue : Keyword := ⟨476, by decide⟩
/-- `lightslategray` -/
def lightslategray : Keyword := ⟨477, by decide⟩
/-- `lightslategrey` -/
def lightslategrey : Keyword := ⟨478, by decide⟩
/-- `lightsteelblue` -/
def lightsteelblue : Keyword := ⟨479, by decide⟩
/-- `lightyellow` -/
def lightyellow : Keyword := ⟨480, by decide⟩
/-- `lime` -/
def lime : Keyword := ⟨481, by decide⟩
/-- `limegreen` -/
def limegreen : Keyword := ⟨482, by decide⟩
/-- `line` -/
def line : Keyword := ⟨483, by decide⟩
/-- `line-through` -/
def lineThrough : Keyword := ⟨484, by decide⟩
/-- `linear` -/
def linear : Keyword := ⟨485, by decide⟩
/-- `linearRGB` -/
def linearRGB : Keyword := ⟨486, by decide⟩
/-- `linen` -/
def linen : Keyword := ⟨487, by decide⟩
/-- `lining-nums` -/
def liningNums : Keyword := ⟨488, by decide⟩
/-- `links` -/
def links : Keyword := ⟨489, by decide⟩
/-- `LinkText` -/
def LinkText : Keyword := ⟨490, by decide⟩
/-- `list-item` -/
def listItem : Keyword := ⟨491, by decide⟩
/-- `listbox` -/
def listbox : Keyword := ⟨492, by decide⟩
/-- `literal-punctuation` -/
def literalPunctuation : Keyword := ⟨493, by decide⟩
/-- `local` -/
def «local» : Keyword := ⟨494, by decide⟩
/-- `longer` -/
def longer : Keyword := ⟨495, by decide⟩
/-- `loose` -/
def loose : Keyword := ⟨496, by decide⟩
/-- `loud` -/
def loud : Keyword := ⟨497, by decide⟩
/-- `low` -/
def low : Keyword := ⟨498, by decide⟩
/-- `lowercase` -/
def lowercase : Keyword := ⟨499, by decide⟩
/-- `ltr` -/
def ltr : Keyword := ⟨500, by decide⟩
/-- `luminance` -/
def luminance : Keyword := ⟨501, by decide⟩
/-- `luminosity` -/
def luminosity : Keyword := ⟨502, by decide⟩
/-- `magenta` -/
def magenta : Keyword := ⟨503, by decide⟩
/-- `male` -/
def male : Keyword := ⟨504, by decide⟩
/-- `mandatory` -/
def mandatory : Keyword := ⟨505, by decide⟩
/-- `manipulation` -/
def manipulation : Keyword := ⟨506, by decide⟩
/-- `manual` -/
def manual : Keyword := ⟨507, by decide⟩
/-- `margin-box` -/
def marginBox : Keyword := ⟨508, by decide⟩
/-- `Mark` -/
def Mark : Keyword := ⟨509, by decide⟩
/-- `marker` -/
def marker : Keyword := ⟨510, by decide⟩
/-- `markers` -/
def markers : Keyword := ⟨511, by decide⟩
/-- `MarkText` -/
def MarkText : Keyword := ⟨512, by decide⟩
/-- `maroon` -/
def maroon : Keyword := ⟨513, by decide⟩
/-- `match-element` -/
def matchElement : Keyword := ⟨514, by decide⟩
/-- `match-parent` -/
def matchParent : Keyword := ⟨515, by decide⟩
/-- `match-self` -/
def matchSelf : Keyword := ⟨516, by decide⟩
/-- `match-source` -/
def matchSource : Keyword := ⟨517, by decide⟩
/-- `math` -/
def math : Keyword := ⟨518, by decide⟩
/-- `math-auto` -/
def mathAuto : Keyword := ⟨519, by decide⟩
/-- `mathematical` -/
def mathematical : Keyword := ⟨520, by decide⟩
/-- `max-content` -/
def maxContent : Keyword := ⟨521, by decide⟩
/-- `maximized` -/
def maximized : Keyword := ⟨522, by decide⟩
/-- `maximum` -/
def maximum : Keyword := ⟨523, by decide⟩
/-- `medium` -/
def medium : Keyword := ⟨524, by decide⟩
/-- `mediumaquamarine` -/
def mediumaquamarine : Keyword := ⟨525, by decide⟩
/-- `mediumblue` -/
def mediumblue : Keyword := ⟨526, by decide⟩
/-- `mediumorchid` -/
def mediumorchid : Keyword := ⟨527, by decide⟩
/-- `mediumpurple` -/
def mediumpurple : Keyword := ⟨528, by decide⟩
/-- `mediumseagreen` -/
def mediumseagreen : Keyword := ⟨529, by decide⟩
/-- `mediumslateblue` -/
def mediumslateblue : Keyword := ⟨530, by decide⟩
/-- `mediumspringgreen` -/
def mediumspringgreen : Keyword := ⟨531, by decide⟩
/-- `mediumturquoise` -/
def mediumturquoise : Keyword := ⟨532, by decide⟩
/-- `mediumvioletred` -/
def mediumvioletred : Keyword := ⟨533, by decide⟩
/-- `menu` -/
def menu : Keyword := ⟨534, by decide⟩
/-- `menulist` -/
def menulist : Keyword := ⟨535, by decide⟩
/-- `menulist-button` -/
def menulistButton : Keyword := ⟨536, by decide⟩
/-- `MenuText` -/
def MenuText : Keyword := ⟨537, by decide⟩
/-- `merge` -/
def merge : Keyword := ⟨538, by decide⟩
/-- `message-box` -/
def messageBox : Keyword := ⟨539, by decide⟩
/-- `meter` -/
def meter : Keyword := ⟨540, by decide⟩
/-- `middle` -/
def middle : Keyword := ⟨541, by decide⟩
/-- `midnightblue` -/
def midnightblue : Keyword := ⟨542, by decide⟩
/-- `min-content` -/
def minContent : Keyword := ⟨543, by decide⟩
/-- `minimal-ui` -/
def minimalUi : Keyword := ⟨544, by decide⟩
/-- `minimized` -/
def minimized : Keyword := ⟨545, by decide⟩
/-- `minimum` -/
def minimum : Keyword := ⟨546, by decide⟩
/-- `mintcream` -/
def mintcream : Keyword := ⟨547, by decide⟩
/-- `mistyrose` -/
def mistyrose : Keyword := ⟨548, by decide⟩
/-- `miter` -/
def miter : Keyword := ⟨549, by decide⟩
/-- `mixed` -/
def mixed : Keyword := ⟨550, by decide⟩
/-- `moccasin` -/
def moccasin : Keyword := ⟨551, by decide⟩
/-- `moderate` -/
def moderate : Keyword := ⟨552, by decide⟩
/-- `monospace` -/
def monospace : Keyword := ⟨553, by decide⟩
/-- `more` -/
def more : Keyword := ⟨554, by decide⟩
/-- `most-block-size` -/
def mostBlockSize : Keyword := ⟨555, by decide⟩
/-- `most-height` -/
def mostHeight : Keyword := ⟨556, by decide⟩
/-- `most-inline-size` -/
def mostInlineSize : Keyword := ⟨557, by decide⟩
/-- `most-width` -/
def mostWidth : Keyword := ⟨558, by decide⟩
/-- `move` -/
def move : Keyword := ⟨559, by decide⟩
/-- `multiply` -/
def multiply : Keyword := ⟨560, by decide⟩
/-- `n-resize` -/
def nResize : Keyword := ⟨561, by decide⟩
/-- `narrow` -/
def narrow : Keyword := ⟨562, by decide⟩
/-- `nastaliq` -/
def nastaliq : Keyword := ⟨563, by decide⟩
/-- `navajowhite` -/
def navajowhite : Keyword := ⟨564, by decide⟩
/-- `navy` -/
def navy : Keyword := ⟨565, by decide⟩
/-- `ne-resize` -/
def neResize : Keyword := ⟨566, by decide⟩
/-- `near` -/
def near : Keyword := ⟨567, by decide⟩
/-- `nearest` -/
def nearest : Keyword := ⟨568, by decide⟩
/-- `nesw-resize` -/
def neswResize : Keyword := ⟨569, by decide⟩
/-- `neutral` -/
def neutral : Keyword := ⟨570, by decide⟩
/-- `never` -/
def never : Keyword := ⟨571, by decide⟩
/-- `no-autospace` -/
def noAutospace : Keyword := ⟨572, by decide⟩
/-- `no-clip` -/
def noClip : Keyword := ⟨573, by decide⟩
/-- `no-close-quote` -/
def noCloseQuote : Keyword := ⟨574, by decide⟩
/-- `no-common-ligatures` -/
def noCommonLigatures : Keyword := ⟨575, by decide⟩
/-- `no-compress` -/
def noCompress : Keyword := ⟨576, by decide⟩
/-- `no-contextual` -/
def noContextual : Keyword := ⟨577, by decide⟩
/-- `no-discretionary-ligatures` -/
def noDiscretionaryLigatures : Keyword := ⟨578, by decide⟩
/-- `no-drop` -/
def noDrop : Keyword := ⟨579, by decide⟩
/-- `no-ellipsis` -/
def noEllipsis : Keyword := ⟨580, by decide⟩
/-- `no-historical-ligatures` -/
def noHistoricalLigatures : Keyword := ⟨581, by decide⟩
/-- `no-limit` -/
def noLimit : Keyword := ⟨582, by decide⟩
/-- `no-open-quote` -/
def noOpenQuote : Keyword := ⟨583, by decide⟩
/-- `no-overflow` -/
def noOverflow : Keyword := ⟨584, by decide⟩
/-- `no-preference` -/
def noPreference : Keyword := ⟨585, by decide⟩
/-- `no-punctuation` -/
def noPunctuation : Keyword := ⟨586, by decide⟩
/-- `no-repeat` -/
def noRepeat : Keyword := ⟨587, by decide⟩
/-- `no-skip` -/
def noSkip : Keyword := ⟨588, by decide⟩
/-- `non-rotation` -/
def nonRotation : Keyword := ⟨589, by decide⟩
/-- `non-scaling-size` -/
def nonScalingSize : Keyword := ⟨590, by decide⟩
/-- `non-scaling-stroke` -/
def nonScalingStroke : Keyword := ⟨591, by decide⟩
/-- `none` -/
def none : Keyword := ⟨592, by decide⟩
/-- `nonzero` -/
def nonzero : Keyword := ⟨593, by decide⟩
/-- `normal` -/
def normal : Keyword := ⟨594, by decide⟩
/-- `not` -/
def not : Keyword := ⟨595, by decide⟩
/-- `not-allowed` -/
def notAllowed : Keyword := ⟨596, by decide⟩
/-- `notch` -/
def notch : Keyword := ⟨597, by decide⟩
/-- `nowrap` -/
def nowrap : Keyword := ⟨598, by decide⟩
/-- `ns-resize` -/
def nsResize : Keyword := ⟨599, by decide⟩
/-- `numbers` -/
def numbers : Keyword := ⟨600, by decide⟩
/-- `numeric` -/
def numeric : Keyword := ⟨601, by decide⟩
/-- `numeric-only` -/
def numericOnly : Keyword := ⟨602, by decide⟩
/-- `nw-resize` -/
def nwResize : Keyword := ⟨603, by decide⟩
/-- `nwse-resize` -/
def nwseResize : Keyword := ⟨604, by decide⟩
/-- `oblique` -/
def oblique : Keyword := ⟨605, by decide⟩
/-- `oblique-only` -/
def obliqueOnly : Keyword := ⟨606, by decide⟩
/-- `of` -/
def of : Keyword := ⟨607, by decide⟩
/-- `off` -/
def off : Keyword := ⟨608, by decide⟩
/-- `oklab` -/
def oklab : Keyword := ⟨609, by decide⟩
/-- `oklch` -/
def oklch : Keyword := ⟨610, by decide⟩
/-- `old` -/
def old : Keyword := ⟨611, by decide⟩
/-- `oldlace` -/
def oldlace : Keyword := ⟨612, by decide⟩
/-- `oldstyle-nums` -/
def oldstyleNums : Keyword := ⟨613, by decide⟩
/-- `olive` -/
def olive : Keyword := ⟨614, by decide⟩
/-- `olivedrab` -/
def olivedrab : Keyword := ⟨615, by decide⟩
/-- `on` -/
def on : Keyword := ⟨616, by decide⟩
/-- `only` -/
def «only» : Keyword := ⟨617, by decide⟩
/-- `opaque` -/
def «opaque» : Keyword := ⟨618, by decide⟩
/-- `open` -/
def «open» : Keyword := ⟨619, by decide⟩
/-- `open-quote` -/
def openQuote : Keyword := ⟨620, by decide⟩
/-- `opentype` -/
def opentype : Keyword := ⟨621, by decide⟩
/-- `optimizeLegibility` -/
def optimizeLegibility : Keyword := ⟨622, by decide⟩
/-- `optimizeSpeed` -/
def optimizeSpeed : Keyword := ⟨623, by decide⟩
/-- `optional` -/
def optional : Keyword := ⟨624, by decide⟩
/-- `or` -/
def or : Keyword := ⟨625, by decide⟩
/-- `orange` -/
def orange : Keyword := ⟨626, by decide⟩
/-- `orangered` -/
def orangered : Keyword := ⟨627, by decide⟩
/-- `orchid` -/
def orchid : Keyword := ⟨628, by decide⟩
/-- `ordinal` -/
def ordinal : Keyword := ⟨629, by decide⟩
/-- `origin` -/
def origin : Keyword := ⟨630, by decide⟩
/-- `outer` -/
def outer : Keyword := ⟨631, by decide⟩
/-- `outset` -/
def outset : Keyword := ⟨632, by decide⟩
/-- `outside` -/
def outside : Keyword := ⟨633, by decide⟩
/-- `outside-shape` -/
def outsideShape : Keyword := ⟨634, by decide⟩
/-- `over` -/
def over : Keyword := ⟨635, by decide⟩
/-- `overflow` -/
def overflow : Keyword := ⟨636, by decide⟩
/-- `overlap-join` -/
def overlapJoin : Keyword := ⟨637, by decide⟩
/-- `overlay` -/
def overlay : Keyword := ⟨638, by decide⟩
/-- `overline` -/
def overline : Keyword := ⟨639, by decide⟩
/-- `p3` -/
def p3 : Keyword := ⟨640, by decide⟩
/-- `padding-box` -/
def paddingBox : Keyword := ⟨641, by decide⟩
/-- `page` -/
def page : Keyword := ⟨642, by decide⟩
/-- `paged` -/
def paged : Keyword := ⟨643, by decide⟩
/-- `paginate` -/
def paginate : Keyword := ⟨644, by decide⟩
/-- `paint` -/
def paint : Keyword := ⟨645, by decide⟩
/-- `painted` -/
def painted : Keyword := ⟨646, by decide⟩
/-- `pair` -/
def pair : Keyword := ⟨647, by decide⟩
/-- `palegoldenrod` -/
def palegoldenrod : Keyword := ⟨648, by decide⟩
/-- `palegreen` -/
def palegreen : Keyword := ⟨649, by decide⟩
/-- `palettes` -/
def palettes : Keyword := ⟨650, by decide⟩
/-- `paleturquoise` -/
def paleturquoise : Keyword := ⟨651, by decide⟩
/-- `palevioletred` -/
def palevioletred : Keyword := ⟨652, by decide⟩
/-- `pan-down` -/
def panDown : Keyword := ⟨653, by decide⟩
/-- `pan-left` -/
def panLeft : Keyword := ⟨654, by decide⟩
/-- `pan-right` -/
def panRight : Keyword := ⟨655, by decide⟩
/-- `pan-up` -/
def panUp : Keyword := ⟨656, by decide⟩
/-- `pan-x` -/
def panX : Keyword := ⟨657, by decide⟩
/-- `pan-y` -/
def panY : Keyword := ⟨658, by decide⟩
/-- `papayawhip` -/
def papayawhip : Keyword := ⟨659, by decide⟩
/-- `parent` -/
def parent : Keyword := ⟨660, by decide⟩
/-- `paused` -/
def paused : Keyword := ⟨661, by decide⟩
/-- `peachpuff` -/
def peachpuff : Keyword := ⟨662, by decide⟩
/-- `per-line` -/
def perLine : Keyword := ⟨663, by decide⟩
/-- `per-line-all` -/
def perLineAll : Keyword := ⟨664, by decide⟩
/-- `perceptual` -/
def perceptual : Keyword := ⟨665, by decide⟩
/-- `peru` -/
def peru : Keyword := ⟨666, by decide⟩
/-- `petite-caps` -/
def petiteCaps : Keyword := ⟨667, by decide⟩
/-- `picture-in-picture` -/
def pictureInPicture : Keyword := ⟨668, by decide⟩
/-- `pinch-zoom` -/
def pinchZoom : Keyword := ⟨669, by decide⟩
/-- `pink` -/
def pink : Keyword := ⟨670, by decide⟩
/-- `pixelated` -/
def pixelated : Keyword := ⟨671, by decide⟩
/-- `plaintext` -/
def plaintext : Keyword := ⟨672, by decide⟩
/-- `plum` -/
def plum : Keyword := ⟨673, by decide⟩
/-- `plus-lighter` -/
def plusLighter : Keyword := ⟨674, by decide⟩
/-- `pointer` -/
def pointer : Keyword := ⟨675, by decide⟩
/-- `portrait` -/
def portrait : Keyword := ⟨676, by decide⟩
/-- `position` -/
def position : Keyword := ⟨677, by decide⟩
/-- `powderblue` -/
def powderblue : Keyword := ⟨678, by decide⟩
/-- `pre` -/
def pre : Keyword := ⟨679, by decide⟩
/-- `pre-line` -/
def preLine : Keyword := ⟨680, by decide⟩
/-- `pre-wrap` -/
def preWrap : Keyword := ⟨681, by decide⟩
/-- `preserve` -/
def preserve : Keyword := ⟨682, by decide⟩
/-- `preserve-3d` -/
def preserve3d : Keyword := ⟨683, by decide⟩
/-- `preserve-breaks` -/
def preserveBreaks : Keyword := ⟨684, by decide⟩
/-- `preserve-parent-color` -/
def preserveParentColor : Keyword := ⟨685, by decide⟩
/-- `preserve-spaces` -/
def preserveSpaces : Keyword := ⟨686, by decide⟩
/-- `pretty` -/
def pretty : Keyword := ⟨687, by decide⟩
/-- `progress` -/
def progress : Keyword := ⟨688, by decide⟩
/-- `progress-bar` -/
def progressBar : Keyword := ⟨689, by decide⟩
/-- `progressive` -/
def progressive : Keyword := ⟨690, by decide⟩
/-- `prophoto-rgb` -/
def prophotoRgb : Keyword := ⟨691, by decide⟩
/-- `proportional-nums` -/
def proportionalNums : Keyword := ⟨692, by decide⟩
/-- `proportional-width` -/
def proportionalWidth : Keyword := ⟨693, by decide⟩
/-- `proximity` -/
def proximity : Keyword := ⟨694, by decide⟩
/-- `punctuation` -/
def punctuation : Keyword := ⟨695, by decide⟩
/-- `purple` -/
def purple : Keyword := ⟨696, by decide⟩
/-- `radio` -/
def radio : Keyword := ⟨697, by decide⟩
/-- `raise` -/
def raise : Keyword := ⟨698, by decide⟩
/-- `rebeccapurple` -/
def rebeccapurple : Keyword := ⟨699, by decide⟩
/-- `rec2020` -/
def rec2020 : Keyword := ⟨700, by decide⟩
/-- `rec2100-hlg` -/
def rec2100Hlg : Keyword := ⟨701, by decide⟩
/-- `rec2100-linear` -/
def rec2100Linear : Keyword := ⟨702, by decide⟩
/-- `rec2100-pq` -/
def rec2100Pq : Keyword := ⟨703, by decide⟩
/-- `rect` -/
def rect : Keyword := ⟨704, by decide⟩
/-- `recto` -/
def recto : Keyword := ⟨705, by decide⟩
/-- `red` -/
def red : Keyword := ⟨706, by decide⟩
/-- `reduce` -/
def reduce : Keyword := ⟨707, by decide⟩
/-- `reduced` -/
def reduced : Keyword := ⟨708, by decide⟩
/-- `region` -/
def region : Keyword := ⟨709, by decide⟩
/-- `relative` -/
def relative : Keyword := ⟨710, by decide⟩
/-- `relative-colorimetric` -/
def relativeColorimetric : Keyword := ⟨711, by decide⟩
/-- `repeat` -/
def «repeat» : Keyword := ⟨712, by decide⟩
/-- `repeat-block` -/
def repeatBlock : Keyword := ⟨713, by decide⟩
/-- `repeat-inline` -/
def repeatInline : Keyword := ⟨714, by decide⟩
/-- `repeat-x` -/
def repeatX : Keyword := ⟨715, by decide⟩
/-- `repeat-y` -/
def repeatY : Keyword := ⟨716, by decide⟩
/-- `replace` -/
def replace : Keyword := ⟨717, by decide⟩
/-- `reverse` -/
def reverse : Keyword := ⟨718, by decide⟩
/-- `revert` -/
def revert : Keyword := ⟨719, by decide⟩
/-- `revert-layer` -/
def revertLayer : Keyword := ⟨720, by decide⟩
/-- `revert-rule` -/
def revertRule : Keyword := ⟨721, by decide⟩
/-- `ridge` -/
def ridge : Keyword := ⟨722, by decide⟩
/-- `right` -/
def right : Keyword := ⟨723, by decide⟩
/-- `right-to-left` -/
def rightToLeft : Keyword := ⟨724, by decide⟩
/-- `rightwards` -/
def rightwards : Keyword := ⟨725, by decide⟩
/-- `root` -/
def root : Keyword := ⟨726, by decide⟩
/-- `rosybrown` -/
def rosybrown : Keyword := ⟨727, by decide⟩
/-- `rotate` -/
def rotate : Keyword := ⟨728, by decide⟩
/-- `rotate-left` -/
def rotateLeft : Keyword := ⟨729, by decide⟩
/-- `rotate-right` -/
def rotateRight : Keyword := ⟨730, by decide⟩
/-- `round` -/
def round : Keyword := ⟨731, by decide⟩
/-- `row` -/
def row : Keyword := ⟨732, by decide⟩
/-- `row-over-column` -/
def rowOverColumn : Keyword := ⟨733, by decide⟩
/-- `row-resize` -/
def rowResize : Keyword := ⟨734, by decide⟩
/-- `row-reverse` -/
def rowReverse : Keyword := ⟨735, by decide⟩
/-- `royalblue` -/
def royalblue : Keyword := ⟨736, by decide⟩
/-- `rtl` -/
def rtl : Keyword := ⟨737, by decide⟩
/-- `ruby` -/
def ruby : Keyword := ⟨738, by decide⟩
/-- `ruby-base` -/
def rubyBase : Keyword := ⟨739, by decide⟩
/-- `ruby-base-container` -/
def rubyBaseContainer : Keyword := ⟨740, by decide⟩
/-- `ruby-text` -/
def rubyText : Keyword := ⟨741, by decide⟩
/-- `ruby-text-container` -/
def rubyTextContainer : Keyword := ⟨742, by decide⟩
/-- `run-in` -/
def runIn : Keyword := ⟨743, by decide⟩
/-- `running` -/
def running : Keyword := ⟨744, by decide⟩
/-- `s-resize` -/
def sResize : Keyword := ⟨745, by decide⟩
/-- `saddlebrown` -/
def saddlebrown : Keyword := ⟨746, by decide⟩
/-- `safe` -/
def safe : Keyword := ⟨747, by decide⟩
/-- `salmon` -/
def salmon : Keyword := ⟨748, by decide⟩
/-- `sandybrown` -/
def sandybrown : Keyword := ⟨749, by decide⟩
/-- `sans-serif` -/
def sansSerif : Keyword := ⟨750, by decide⟩
/-- `saturation` -/
def saturation : Keyword := ⟨751, by decide⟩
/-- `scale-down` -/
def scaleDown : Keyword := ⟨752, by decide⟩
/-- `scoop` -/
def scoop : Keyword := ⟨753, by decide⟩
/-- `screen` -/
def screen : Keyword := ⟨754, by decide⟩
/-- `scroll` -/
def scroll : Keyword := ⟨755, by decide⟩
/-- `scroll-position` -/
def scrollPosition : Keyword := ⟨756, by decide⟩
/-- `scroll-state` -/
def scrollState : Keyword := ⟨757, by decide⟩
/-- `Scrollbar` -/
def Scrollbar : Keyword := ⟨758, by decide⟩
/-- `se-resize` -/
def seResize : Keyword := ⟨759, by decide⟩
/-- `seagreen` -/
def seagreen : Keyword := ⟨760, by decide⟩
/-- `searchfield` -/
def searchfield : Keyword := ⟨761, by decide⟩
/-- `seashell` -/
def seashell : Keyword := ⟨762, by decide⟩
/-- `SelectedItem` -/
def SelectedItem : Keyword := ⟨763, by decide⟩
/-- `SelectedItemText` -/
def SelectedItemText : Keyword := ⟨764, by decide⟩
/-- `self` -/
def self : Keyword := ⟨765, by decide⟩
/-- `self-block` -/
def selfBlock : Keyword := ⟨766, by decide⟩
/-- `self-block-end` -/
def selfBlockEnd : Keyword := ⟨767, by decide⟩
/-- `self-block-start` -/
def selfBlockStart : Keyword := ⟨768, by decide⟩
/-- `self-end` -/
def selfEnd : Keyword := ⟨769, by decide⟩
/-- `self-inline` -/
def selfInline : Keyword := ⟨770, by decide⟩
/-- `self-inline-end` -/
def selfInlineEnd : Keyword := ⟨771, by decide⟩
/-- `self-inline-start` -/
def selfInlineStart : Keyword := ⟨772, by decide⟩
/-- `self-start` -/
def selfStart : Keyword := ⟨773, by decide⟩
/-- `self-x-end` -/
def selfXEnd : Keyword := ⟨774, by decide⟩
/-- `self-x-start` -/
def selfXStart : Keyword := ⟨775, by decide⟩
/-- `self-y-end` -/
def selfYEnd : Keyword := ⟨776, by decide⟩
/-- `self-y-start` -/
def selfYStart : Keyword := ⟨777, by decide⟩
/-- `semi-condensed` -/
def semiCondensed : Keyword := ⟨778, by decide⟩
/-- `semi-expanded` -/
def semiExpanded : Keyword := ⟨779, by decide⟩
/-- `separate` -/
def separate : Keyword := ⟨780, by decide⟩
/-- `serif` -/
def serif : Keyword := ⟨781, by decide⟩
/-- `sesame` -/
def sesame : Keyword := ⟨782, by decide⟩
/-- `shape-box` -/
def shapeBox : Keyword := ⟨783, by decide⟩
/-- `shorter` -/
def shorter : Keyword := ⟨784, by decide⟩
/-- `show` -/
def «show» : Keyword := ⟨785, by decide⟩
/-- `shrink` -/
def shrink : Keyword := ⟨786, by decide⟩
/-- `sides` -/
def sides : Keyword := ⟨787, by decide⟩
/-- `sideways` -/
def sideways : Keyword := ⟨788, by decide⟩
/-- `sideways-lr` -/
def sidewaysLr : Keyword := ⟨789, by decide⟩
/-- `sideways-rl` -/
def sidewaysRl : Keyword := ⟨790, by decide⟩
/-- `sienna` -/
def sienna : Keyword := ⟨791, by decide⟩
/-- `silent` -/
def silent : Keyword := ⟨792, by decide⟩
/-- `silver` -/
def silver : Keyword := ⟨793, by decide⟩
/-- `simplified` -/
def simplified : Keyword := ⟨794, by decide⟩
/-- `size` -/
def size : Keyword := ⟨795, by decide⟩
/-- `skip-all` -/
def skipAll : Keyword := ⟨796, by decide⟩
/-- `skip-line-through` -/
def skipLineThrough : Keyword := ⟨797, by decide⟩
/-- `skip-overline` -/
def skipOverline : Keyword := ⟨798, by decide⟩
/-- `skip-underline` -/
def skipUnderline : Keyword := ⟨799, by decide⟩
/-- `skyblue` -/
def skyblue : Keyword := ⟨800, by decide⟩
/-- `slashed-zero` -/
def slashedZero : Keyword := ⟨801, by decide⟩
/-- `slateblue` -/
def slateblue : Keyword := ⟨802, by decide⟩
/-- `slategray` -/
def slategray : Keyword := ⟨803, by decide⟩
/-- `slategrey` -/
def slategrey : Keyword := ⟨804, by decide⟩
/-- `slice` -/
def slice : Keyword := ⟨805, by decide⟩
/-- `slow` -/
def slow : Keyword := ⟨806, by decide⟩
/-- `small` -/
def small : Keyword := ⟨807, by decide⟩
/-- `small-caps` -/
def smallCaps : Keyword := ⟨808, by decide⟩
/-- `small-caption` -/
def smallCaption : Keyword := ⟨809, by decide⟩
/-- `smaller` -/
def smaller : Keyword := ⟨810, by decide⟩
/-- `smooth` -/
def smooth : Keyword := ⟨811, by decide⟩
/-- `snap` -/
def snap : Keyword := ⟨812, by decide⟩
/-- `snap-block` -/
def snapBlock : Keyword := ⟨813, by decide⟩
/-- `snap-inline` -/
def snapInline : Keyword := ⟨814, by decide⟩
/-- `snow` -/
def snow : Keyword := ⟨815, by decide⟩
/-- `soft` -/
def soft : Keyword := ⟨816, by decide⟩
/-- `soft-light` -/
def softLight : Keyword := ⟨817, by decide⟩
/-- `solid` -/
def solid : Keyword := ⟨818, by decide⟩
/-- `source-order` -/
def sourceOrder : Keyword := ⟨819, by decide⟩
/-- `space` -/
def space : Keyword := ⟨820, by decide⟩
/-- `space-all` -/
def spaceAll : Keyword := ⟨821, by decide⟩
/-- `space-around` -/
def spaceAround : Keyword := ⟨822, by decide⟩
/-- `space-between` -/
def spaceBetween : Keyword := ⟨823, by decide⟩
/-- `space-evenly` -/
def spaceEvenly : Keyword := ⟨824, by decide⟩
/-- `space-first` -/
def spaceFirst : Keyword := ⟨825, by decide⟩
/-- `spaces` -/
def spaces : Keyword := ⟨826, by decide⟩
/-- `span` -/
def span : Keyword := ⟨827, by decide⟩
/-- `span-all` -/
def spanAll : Keyword := ⟨828, by decide⟩
/-- `span-block-end` -/
def spanBlockEnd : Keyword := ⟨829, by decide⟩
/-- `span-block-start` -/
def spanBlockStart : Keyword := ⟨830, by decide⟩
/-- `span-bottom` -/
def spanBottom : Keyword := ⟨831, by decide⟩
/-- `span-end` -/
def spanEnd : Keyword := ⟨832, by decide⟩
/-- `span-inline-end` -/
def spanInlineEnd : Keyword := ⟨833, by decide⟩
/-- `span-inline-start` -/
def spanInlineStart : Keyword := ⟨834, by decide⟩
/-- `span-left` -/
def spanLeft : Keyword := ⟨835, by decide⟩
/-- `span-right` -/
def spanRight : Keyword := ⟨836, by decide⟩
/-- `span-self-block-end` -/
def spanSelfBlockEnd : Keyword := ⟨837, by decide⟩
/-- `span-self-block-start` -/
def spanSelfBlockStart : Keyword := ⟨838, by decide⟩
/-- `span-self-end` -/
def spanSelfEnd : Keyword := ⟨839, by decide⟩
/-- `span-self-inline-end` -/
def spanSelfInlineEnd : Keyword := ⟨840, by decide⟩
/-- `span-self-inline-start` -/
def spanSelfInlineStart : Keyword := ⟨841, by decide⟩
/-- `span-self-start` -/
def spanSelfStart : Keyword := ⟨842, by decide⟩
/-- `span-self-x-end` -/
def spanSelfXEnd : Keyword := ⟨843, by decide⟩
/-- `span-self-x-start` -/
def spanSelfXStart : Keyword := ⟨844, by decide⟩
/-- `span-self-y-end` -/
def spanSelfYEnd : Keyword := ⟨845, by decide⟩
/-- `span-self-y-start` -/
def spanSelfYStart : Keyword := ⟨846, by decide⟩
/-- `span-start` -/
def spanStart : Keyword := ⟨847, by decide⟩
/-- `span-top` -/
def spanTop : Keyword := ⟨848, by decide⟩
/-- `span-x-end` -/
def spanXEnd : Keyword := ⟨849, by decide⟩
/-- `span-x-start` -/
def spanXStart : Keyword := ⟨850, by decide⟩
/-- `span-y-end` -/
def spanYEnd : Keyword := ⟨851, by decide⟩
/-- `span-y-start` -/
def spanYStart : Keyword := ⟨852, by decide⟩
/-- `spell-out` -/
def spellOut : Keyword := ⟨853, by decide⟩
/-- `spelling-error` -/
def spellingError : Keyword := ⟨854, by decide⟩
/-- `spread` -/
def spread : Keyword := ⟨855, by decide⟩
/-- `springgreen` -/
def springgreen : Keyword := ⟨856, by decide⟩
/-- `square` -/
def square : Keyword := ⟨857, by decide⟩
/-- `squircle` -/
def squircle : Keyword := ⟨858, by decide⟩
/-- `srgb` -/
def srgb : Keyword := ⟨859, by decide⟩
/-- `srgb-linear` -/
def srgbLinear : Keyword := ⟨860, by decide⟩
/-- `stable` -/
def stable : Keyword := ⟨861, by decide⟩
/-- `stacked-fractions` -/
def stackedFractions : Keyword := ⟨862, by decide⟩
/-- `standalone` -/
def standalone : Keyword := ⟨863, by decide⟩
/-- `standard` -/
def standard : Keyword := ⟨864, by decide⟩
/-- `start` -/
def start : Keyword := ⟨865, by decide⟩
/-- `static` -/
def static : Keyword := ⟨866, by decide⟩
/-- `status-bar` -/
def statusBar : Keyword := ⟨867, by decide⟩
/-- `steelblue` -/
def steelblue : Keyword := ⟨868, by decide⟩
/-- `step-end` -/
def stepEnd : Keyword := ⟨869, by decide⟩
/-- `step-start` -/
def stepStart : Keyword := ⟨870, by decide⟩
/-- `sticky` -/
def sticky : Keyword := ⟨871, by decide⟩
/-- `stopped` -/
def stopped : Keyword := ⟨872, by decide⟩
/-- `stretch` -/
def stretch : Keyword := ⟨873, by decide⟩
/-- `strict` -/
def strict : Keyword := ⟨874, by decide⟩
/-- `stroke` -/
def stroke : Keyword := ⟨875, by decide⟩
/-- `stroke-box` -/
def strokeBox : Keyword := ⟨876, by decide⟩
/-- `strong` -/
def strong : Keyword := ⟨877, by decide⟩
/-- `style` -/
def style : Keyword := ⟨878, by decide⟩
/-- `sub` -/
def sub : Keyword := ⟨879, by decide⟩
/-- `subgrid` -/
def subgrid : Keyword := ⟨880, by decide⟩
/-- `subtract` -/
def subtract : Keyword := ⟨881, by decide⟩
/-- `subtractive` -/
def subtractive : Keyword := ⟨882, by decide⟩
/-- `super` -/
def super : Keyword := ⟨883, by decide⟩
/-- `svg` -/
def svg : Keyword := ⟨884, by decide⟩
/-- `sw-resize` -/
def swResize : Keyword := ⟨885, by decide⟩
/-- `swap` -/
def swap : Keyword := ⟨886, by decide⟩
/-- `symbolic` -/
def symbolic : Keyword := ⟨887, by decide⟩
/-- `symbols` -/
def symbols : Keyword := ⟨888, by decide⟩
/-- `system-ui` -/
def systemUi : Keyword := ⟨889, by decide⟩
/-- `table` -/
def table : Keyword := ⟨890, by decide⟩
/-- `table-caption` -/
def tableCaption : Keyword := ⟨891, by decide⟩
/-- `table-cell` -/
def tableCell : Keyword := ⟨892, by decide⟩
/-- `table-column` -/
def tableColumn : Keyword := ⟨893, by decide⟩
/-- `table-column-group` -/
def tableColumnGroup : Keyword := ⟨894, by decide⟩
/-- `table-footer-group` -/
def tableFooterGroup : Keyword := ⟨895, by decide⟩
/-- `table-header-group` -/
def tableHeaderGroup : Keyword := ⟨896, by decide⟩
/-- `table-row` -/
def tableRow : Keyword := ⟨897, by decide⟩
/-- `table-row-group` -/
def tableRowGroup : Keyword := ⟨898, by decide⟩
/-- `tabs` -/
def tabs : Keyword := ⟨899, by decide⟩
/-- `tabular-nums` -/
def tabularNums : Keyword := ⟨900, by decide⟩
/-- `tan` -/
def tan : Keyword := ⟨901, by decide⟩
/-- `tbd-bg` -/
def tbdBg : Keyword := ⟨902, by decide⟩
/-- `tbd-fg` -/
def tbdFg : Keyword := ⟨903, by decide⟩
/-- `teal` -/
def teal : Keyword := ⟨904, by decide⟩
/-- `text` -/
def text : Keyword := ⟨905, by decide⟩
/-- `text-bottom` -/
def textBottom : Keyword := ⟨906, by decide⟩
/-- `text-top` -/
def textTop : Keyword := ⟨907, by decide⟩
/-- `textarea` -/
def textarea : Keyword := ⟨908, by decide⟩
/-- `textfield` -/
def textfield : Keyword := ⟨909, by decide⟩
/-- `thick` -/
def thick : Keyword := ⟨910, by decide⟩
/-- `thin` -/
def thin : Keyword := ⟨911, by decide⟩
/-- `thistle` -/
def thistle : Keyword := ⟨912, by decide⟩
/-- `ThreeDDarkShadow` -/
def ThreeDDarkShadow : Keyword := ⟨913, by decide⟩
/-- `ThreeDFace` -/
def ThreeDFace : Keyword := ⟨914, by decide⟩
/-- `ThreeDHighlight` -/
def ThreeDHighlight : Keyword := ⟨915, by decide⟩
/-- `ThreeDLightShadow` -/
def ThreeDLightShadow : Keyword := ⟨916, by decide⟩
/-- `ThreeDShadow` -/
def ThreeDShadow : Keyword := ⟨917, by decide⟩
/-- `titling-caps` -/
def titlingCaps : Keyword := ⟨918, by decide⟩
/-- `to` -/
def «to» : Keyword := ⟨919, by decide⟩
/-- `tomato` -/
def tomato : Keyword := ⟨920, by decide⟩
/-- `top` -/
def top : Keyword := ⟨921, by decide⟩
/-- `top-to-bottom` -/
def topToBottom : Keyword := ⟨922, by decide⟩
/-- `traditional` -/
def traditional : Keyword := ⟨923, by decide⟩
/-- `transparent` -/
def transparent : Keyword := ⟨924, by decide⟩
/-- `triangle` -/
def triangle : Keyword := ⟨925, by decide⟩
/-- `trim-all` -/
def trimAll : Keyword := ⟨926, by decide⟩
/-- `trim-both` -/
def trimBoth : Keyword := ⟨927, by decide⟩
/-- `trim-end` -/
def trimEnd : Keyword := ⟨928, by decide⟩
/-- `trim-start` -/
def trimStart : Keyword := ⟨929, by decide⟩
/-- `true` -/
def true : Keyword := ⟨930, by decide⟩
/-- `truetype` -/
def truetype : Keyword := ⟨931, by decide⟩
/-- `turquoise` -/
def turquoise : Keyword := ⟨932, by decide⟩
/-- `ui-monospace` -/
def uiMonospace : Keyword := ⟨933, by decide⟩
/-- `ui-rounded` -/
def uiRounded : Keyword := ⟨934, by decide⟩
/-- `ui-sans-serif` -/
def uiSansSerif : Keyword := ⟨935, by decide⟩
/-- `ui-serif` -/
def uiSerif : Keyword := ⟨936, by decide⟩
/-- `ultra-condensed` -/
def ultraCondensed : Keyword := ⟨937, by decide⟩
/-- `ultra-expanded` -/
def ultraExpanded : Keyword := ⟨938, by decide⟩
/-- `under` -/
def under : Keyword := ⟨939, by decide⟩
/-- `underline` -/
def underline : Keyword := ⟨940, by decide⟩
/-- `underscore` -/
def underscore : Keyword := ⟨941, by decide⟩
/-- `unicase` -/
def unicase : Keyword := ⟨942, by decide⟩
/-- `unicode` -/
def unicode : Keyword := ⟨943, by decide⟩
/-- `unsafe` -/
def «unsafe» : Keyword := ⟨944, by decide⟩
/-- `unset` -/
def unset : Keyword := ⟨945, by decide⟩
/-- `up` -/
def up : Keyword := ⟨946, by decide⟩
/-- `uppercase` -/
def uppercase : Keyword := ⟨947, by decide⟩
/-- `upright` -/
def upright : Keyword := ⟨948, by decide⟩
/-- `variations` -/
def variations : Keyword := ⟨949, by decide⟩
/-- `verso` -/
def verso : Keyword := ⟨950, by decide⟩
/-- `vertical` -/
def vertical : Keyword := ⟨951, by decide⟩
/-- `vertical-lr` -/
def verticalLr : Keyword := ⟨952, by decide⟩
/-- `vertical-rl` -/
def verticalRl : Keyword := ⟨953, by decide⟩
/-- `vertical-text` -/
def verticalText : Keyword := ⟨954, by decide⟩
/-- `view-box` -/
def viewBox : Keyword := ⟨955, by decide⟩
/-- `violet` -/
def violet : Keyword := ⟨956, by decide⟩
/-- `visible` -/
def visible : Keyword := ⟨957, by decide⟩
/-- `visibleFill` -/
def visibleFill : Keyword := ⟨958, by decide⟩
/-- `visiblePainted` -/
def visiblePainted : Keyword := ⟨959, by decide⟩
/-- `visibleStroke` -/
def visibleStroke : Keyword := ⟨960, by decide⟩
/-- `VisitedText` -/
def VisitedText : Keyword := ⟨961, by decide⟩
/-- `vline` -/
def vline : Keyword := ⟨962, by decide⟩
/-- `w-resize` -/
def wResize : Keyword := ⟨963, by decide⟩
/-- `wait` -/
def wait : Keyword := ⟨964, by decide⟩
/-- `wavy` -/
def wavy : Keyword := ⟨965, by decide⟩
/-- `wcag2` -/
def wcag2 : Keyword := ⟨966, by decide⟩
/-- `weak` -/
def weak : Keyword := ⟨967, by decide⟩
/-- `weight` -/
def weight : Keyword := ⟨968, by decide⟩
/-- `wheat` -/
def wheat : Keyword := ⟨969, by decide⟩
/-- `white` -/
def white : Keyword := ⟨970, by decide⟩
/-- `whitesmoke` -/
def whitesmoke : Keyword := ⟨971, by decide⟩
/-- `width` -/
def width : Keyword := ⟨972, by decide⟩
/-- `will-change` -/
def willChange : Keyword := ⟨973, by decide⟩
/-- `Window` -/
def Window : Keyword := ⟨974, by decide⟩
/-- `WindowFrame` -/
def WindowFrame : Keyword := ⟨975, by decide⟩
/-- `WindowText` -/
def WindowText : Keyword := ⟨976, by decide⟩
/-- `with` -/
def «with» : Keyword := ⟨977, by decide⟩
/-- `woff` -/
def woff : Keyword := ⟨978, by decide⟩
/-- `woff2` -/
def woff2 : Keyword := ⟨979, by decide⟩
/-- `words` -/
def words : Keyword := ⟨980, by decide⟩
/-- `wrap` -/
def wrap : Keyword := ⟨981, by decide⟩
/-- `wrap-reverse` -/
def wrapReverse : Keyword := ⟨982, by decide⟩
/-- `x` -/
def x : Keyword := ⟨983, by decide⟩
/-- `x-end` -/
def xEnd : Keyword := ⟨984, by decide⟩
/-- `x-fast` -/
def xFast : Keyword := ⟨985, by decide⟩
/-- `x-high` -/
def xHigh : Keyword := ⟨986, by decide⟩
/-- `x-large` -/
def xLarge : Keyword := ⟨987, by decide⟩
/-- `x-loud` -/
def xLoud : Keyword := ⟨988, by decide⟩
/-- `x-low` -/
def xLow : Keyword := ⟨989, by decide⟩
/-- `x-slow` -/
def xSlow : Keyword := ⟨990, by decide⟩
/-- `x-small` -/
def xSmall : Keyword := ⟨991, by decide⟩
/-- `x-soft` -/
def xSoft : Keyword := ⟨992, by decide⟩
/-- `x-start` -/
def xStart : Keyword := ⟨993, by decide⟩
/-- `x-strong` -/
def xStrong : Keyword := ⟨994, by decide⟩
/-- `x-weak` -/
def xWeak : Keyword := ⟨995, by decide⟩
/-- `xx-large` -/
def xxLarge : Keyword := ⟨996, by decide⟩
/-- `xx-small` -/
def xxSmall : Keyword := ⟨997, by decide⟩
/-- `xxx-large` -/
def xxxLarge : Keyword := ⟨998, by decide⟩
/-- `xyz` -/
def xyz : Keyword := ⟨999, by decide⟩
/-- `xyz-d50` -/
def xyzD50 : Keyword := ⟨1000, by decide⟩
/-- `xyz-d65` -/
def xyzD65 : Keyword := ⟨1001, by decide⟩
/-- `y` -/
def y : Keyword := ⟨1002, by decide⟩
/-- `y-end` -/
def yEnd : Keyword := ⟨1003, by decide⟩
/-- `y-start` -/
def yStart : Keyword := ⟨1004, by decide⟩
/-- `yellow` -/
def yellow : Keyword := ⟨1005, by decide⟩
/-- `yellowgreen` -/
def yellowgreen : Keyword := ⟨1006, by decide⟩
/-- `young` -/
def young : Keyword := ⟨1007, by decide⟩
/-- `z` -/
def z : Keyword := ⟨1008, by decide⟩
/-- `zero-if-extrinsic` -/
def zeroIfExtrinsic : Keyword := ⟨1009, by decide⟩
/-- `zero-if-scroll` -/
def zeroIfScroll : Keyword := ⟨1010, by decide⟩
/-- `zoom-in` -/
def zoomIn : Keyword := ⟨1011, by decide⟩
/-- `zoom-out` -/
def zoomOut : Keyword := ⟨1012, by decide⟩

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
  "and",
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
  "decimal",
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
  "match-element",
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
  "not",
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
  "or",
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
  "will-change",
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
  | .some i => if h : i < 1013 then .some ⟨i, h⟩ else .none
  | .none => .none

/-- Every keyword, as `Sym.keywords` holds them. -/
def allBits : Nat := (1 <<< 1013) - 1

/-- The keyword whose `keywordCode` is `c`. -/
def ofCode? (c : Nat) : Option Keyword :=
  if c < 66317934437135202 then
    if c < 3467894421614 then
      if c < 245133679 then
        if c < 211613809 then
          if c < 1735277 then
            if c < 14447 then
              if c < 12661 then
                if c < 12596 then
                  if c < 122 then
                    if c = 121 then .some .x else .none
                  else
                    if c < 123 then
                      if c = 122 then .some .y else .none
                    else
                      if c = 123 then .some .z else .none
                else
                  if c < 12598 then
                    if c < 12597 then
                      if c = 12596 then .some .A3 else .none
                    else
                      if c = 12597 then .some .A4 else .none
                  else
                    if c < 12642 then
                      if c = 12598 then .some .A5 else .none
                    else
                      if c = 12642 then .some .aa else .none
              else
                if c < 12920 then
                  if c < 12726 then
                    if c < 12725 then
                      if c = 12661 then .some .«at» else .none
                    else
                      if c = 12725 then .some .B4 else .none
                  else
                    if c < 12794 then
                      if c = 12726 then .some .B5 else .none
                    else
                      if c = 12794 then .some .«by» else .none
                else
                  if c < 13679 then
                    if c < 13177 then
                      if c = 12920 then .some .cw else .none
                    else
                      if c = 13177 then .some .ex else .none
                  else
                    if c < 14439 then
                      if c = 13679 then .some .«in» else .none
                    else
                      if c = 14439 then .some .of else .none
            else
              if c < 1619941 then
                if c < 15217 then
                  if c < 14516 then
                    if c < 14451 then
                      if c = 14447 then .some .on else .none
                    else
                      if c = 14451 then .some .or else .none
                  else
                    if c < 15088 then
                      if c = 14516 then .some .p3 else .none
                    else
                      if c = 15088 then .some .«to» else .none
                else
                  if c < 1618661 then
                    if c < 1618274 then
                      if c = 15217 then .some .up else .none
                    else
                      if c = 1618274 then .some .aaa else .none
                  else
                    if c < 1619693 then
                      if c = 1618661 then .some .add else .none
                    else
                      if c = 1619693 then .some .all else .none
              else
                if c < 1651057 then
                  if c < 1620452 then
                    if c < 1619962 then
                      if c = 1619941 then .some .and else .none
                    else
                      if c = 1619962 then .some .any else .none
                  else
                    if c < 1634675 then
                      if c = 1620452 then .some .arc else .none
                    else
                      if c = 1634675 then .some .bar else .none
                else
                  if c < 1669237 then
                    if c < 1651320 then
                      if c = 1651057 then .some .cap else .none
                    else
                      if c = 1651320 then .some .ccw else .none
                  else
                    if c < 1685477 then
                      if c = 1669237 then .some .dot else .none
                    else
                      if c = 1685477 then .some .«end» else .none
          else
            if c < 1915880 then
              if c < 1833077 then
                if c < 1798499 then
                  if c < 1735779 then
                    if c < 1735526 then
                      if c = 1735277 then .some .hsl else .none
                    else
                      if c = 1735526 then .some .hue else .none
                  else
                    if c < 1782122 then
                      if c = 1735779 then .some .hwb else .none
                    else
                      if c = 1782122 then .some .kai else .none
                else
                  if c < 1800312 then
                    if c < 1798761 then
                      if c = 1798499 then .some .lab else .none
                    else
                      if c = 1798761 then .some .lch else .none
                  else
                    if c < 1800947 then
                      if c = 1800312 then .some .low else .none
                    else
                      if c = 1800947 then .some .ltr else .none
              else
                if c < 1897317 then
                  if c < 1849061 then
                    if c < 1848295 then
                      if c = 1833077 then .some .not else .none
                    else
                      if c = 1848295 then .some .off else .none
                  else
                    if c < 1866214 then
                      if c = 1849061 then .some .old else .none
                    else
                      if c = 1866214 then .some .pre else .none
                else
                  if c < 1899245 then
                    if c < 1898616 then
                      if c = 1897317 then .some .red else .none
                    else
                      if c = 1898616 then .some .row else .none
                  else
                    if c < 1915747 then
                      if c = 1899245 then .some .rtl else .none
                    else
                      if c = 1915747 then .some .sub else .none
            else
              if c < 209238630 then
                if c < 207403874 then
                  if c < 1931377 then
                    if c < 1929583 then
                      if c = 1915880 then .some .svg else .none
                    else
                      if c = 1929583 then .some .tan else .none
                  else
                    if c < 1998203 then
                      if c = 1931377 then .some .top else .none
                    else
                      if c = 1998203 then .some .xyz else .none
                else
                  if c < 207469296 then
                    if c < 207417972 then
                      if c = 207403874 then .some .aqua else .none
                    else
                      if c = 207417972 then .some .arcs else .none
                  else
                    if c < 209236588 then
                      if c = 207469296 then .some .auto else .none
                    else
                      if c = 209236588 then .some .back else .none
              else
                if c < 209566453 then
                  if c < 209467109 then
                    if c < 209419110 then
                      if c = 209238630 then .some .base else .none
                    else
                      if c = 209419110 then .some .blue else .none
                  else
                    if c < 209468137 then
                      if c = 209467109 then .some .bold else .none
                    else
                      if c = 209468137 then .some .both else .none
                else
                  if c < 211514737 then
                    if c < 211400429 then
                      if c = 209566453 then .some .butt else .none
                    else
                      if c = 211400429 then .some .cell else .none
                  else
                    if c < 211564794 then
                      if c = 211514737 then .some .clip else .none
                    else
                      if c = 211564794 then .some .copy else .none
        else
          if c < 230275700 then
            if c < 217806968 then
              if c < 215905653 then
                if c < 213564004 then
                  if c < 211726703 then
                    if c = 211613809 then .some .crop else .none
                  else
                    if c < 213432812 then
                      if c = 211726703 then .some .cyan else .none
                    else
                      if c = 213432812 then .some .dark else .none
                else
                  if c < 213710961 then
                    if c < 213662831 then
                      if c = 213564004 then .some .disc else .none
                    else
                      if c = 213662831 then .some .down else .none
                  else
                    if c < 215530086 then
                      if c = 213710961 then .some .drop else .none
                    else
                      if c = 215530086 then .some .ease else .none
              else
                if c < 217757670 then
                  if c < 217627253 then
                    if c < 217625318 then
                      if c = 215905653 then .some .exit else .none
                    else
                      if c = 217625318 then .some .fade else .none
                  else
                    if c < 217757421 then
                      if c = 217627253 then .some .fast else .none
                    else
                      if c = 217757421 then .some .fill else .none
                else
                  if c < 217805689 then
                    if c < 217805173 then
                      if c = 217757670 then .some .fine else .none
                    else
                      if c = 217805173 then .some .flat else .none
                  else
                    if c < 217806193 then
                      if c = 217805689 then .some .flex else .none
                    else
                      if c = 217806193 then .some .flip else .none
            else
              if c < 220002424 then
                if c < 220000611 then
                  if c < 219724020 then
                    if c < 217905262 then
                      if c = 217806968 then .some .flow else .none
                    else
                      if c = 217905262 then .some .«from» else .none
                  else
                    if c < 219952869 then
                      if c = 219724020 then .some .gaps else .none
                    else
                      if c = 219952869 then .some .gold else .none
                else
                  if c < 220001146 then
                    if c < 220000634 then
                      if c = 220000611 then .some .grab else .none
                    else
                      if c = 220000634 then .some .gray else .none
                  else
                    if c < 220001637 then
                      if c = 220001146 then .some .grey else .none
                    else
                      if c = 220001637 then .some .grid else .none
              else
                if c < 223950959 then
                  if c < 221950694 then
                    if c < 221886193 then
                      if c = 220002424 then .some .grow else .none
                    else
                      if c = 221886193 then .some .help else .none
                  else
                    if c < 221951081 then
                      if c = 221950694 then .some .hide else .none
                    else
                      if c = 221951081 then .some .high else .none
                else
                  if c < 230210165 then
                    if c < 228176753 then
                      if c = 223950959 then .some .icon else .none
                    else
                      if c = 228176753 then .some .keep else .none
                  else
                    if c < 230274037 then
                      if c = 230210165 then .some .last else .none
                    else
                      if c = 230274037 then .some .left else .none
          else
            if c < 238597222 then
              if c < 232536550 then
                if c < 232306406 then
                  if c < 230340582 then
                    if c < 230340454 then
                      if c = 230275700 then .some .less else .none
                    else
                      if c = 230340454 then .some .lime else .none
                  else
                    if c < 230439781 then
                      if c = 230340582 then .some .line else .none
                    else
                      if c = 230439781 then .some .loud else .none
                else
                  if c < 232307433 then
                    if c < 232307180 then
                      if c = 232306406 then .some .male else .none
                    else
                      if c = 232307180 then .some .Mark else .none
                  else
                    if c < 232372214 then
                      if c = 232307433 then .some .math else .none
                    else
                      if c = 232372214 then .some .menu else .none
              else
                if c < 234633190 then
                  if c < 234404858 then
                    if c < 232537062 then
                      if c = 232536550 then .some .more else .none
                    else
                      if c = 232537062 then .some .move else .none
                  else
                    if c < 234467699 then
                      if c = 234404858 then .some .navy else .none
                    else
                      if c = 234467699 then .some .near else .none
                else
                  if c < 236745583 then
                    if c < 236713722 then
                      if c = 234633190 then .some .none else .none
                    else
                      if c = 236713722 then .some .«only» else .none
                  else
                    if c < 236843891 then
                      if c = 236745583 then .some .«open» else .none
                    else
                      if c = 236843891 then .some .over else .none
            else
              if c < 244888550 then
                if c < 238779246 then
                  if c < 238664182 then
                    if c < 238597491 then
                      if c = 238597222 then .some .page else .none
                    else
                      if c = 238597491 then .some .pair else .none
                  else
                    if c < 238729196 then
                      if c = 238664182 then .some .peru else .none
                    else
                      if c = 238729196 then .some .pink else .none
                else
                  if c < 243021941 then
                    if c < 242856565 then
                      if c = 238779246 then .some .plum else .none
                    else
                      if c = 242856565 then .some .rect else .none
                  else
                    if c < 243118586 then
                      if c = 243021941 then .some .root else .none
                    else
                      if c = 243118586 then .some .ruby else .none
              else
                if c < 245069944 then
                  if c < 245004408 then
                    if c < 244954855 then
                      if c = 244888550 then .some .safe else .none
                    else
                      if c = 244954855 then .some .self else .none
                  else
                    if c < 245022182 then
                      if c = 245004408 then .some .«show» else .none
                    else
                      if c = 245022182 then .some .size else .none
                else
                  if c < 245102712 then
                    if c < 245100913 then
                      if c = 245069944 then .some .slow else .none
                    else
                      if c = 245100913 then .some .snap else .none
                  else
                    if c < 245117941 then
                      if c = 245102712 then .some .snow else .none
                    else
                      if c = 245117941 then .some .soft else .none
      else
        if c < 29483595380 then
          if c < 27073985126 then
            if c < 26537013620 then
              if c < 247266150 then
                if c < 246985204 then
                  if c < 245167203 then
                    if c = 245133679 then .some .span else .none
                  else
                    if c < 245248369 then
                      if c = 245167203 then .some .srgb else .none
                    else
                      if c = 245248369 then .some .swap else .none
                else
                  if c < 247053557 then
                    if c < 247050605 then
                      if c = 246985204 then .some .tabs else .none
                    else
                      if c = 247050605 then .some .teal else .none
                  else
                    if c < 247100783 then
                      if c = 247053557 then .some .text else .none
                    else
                      if c = 247100783 then .some .thin else .none
              else
                if c < 253410025 then
                  if c < 253279226 then
                    if c < 253277557 then
                      if c = 247266150 then .some .true else .none
                    else
                      if c = 253277557 then .some .wait else .none
                  else
                    if c < 253342060 then
                      if c = 253279226 then .some .wavy else .none
                    else
                      if c = 253342060 then .some .weak else .none
                else
                  if c < 253555057 then
                    if c < 253506535 then
                      if c = 253410025 then .some .«with» else .none
                    else
                      if c = 253506535 then .some .woff else .none
                  else
                    if c < 26524611443 then
                      if c = 253555057 then .some .wrap else .none
                    else
                      if c = 26524611443 then .some .after else .none
            else
              if c < 26805547628 then
                if c < 26790769766 then
                  if c < 26558084453 then
                    if c < 26537129186 then
                      if c = 26537013620 then .some .alias else .none
                    else
                      if c = 26537129186 then .some .alpha else .none
                  else
                    if c < 26566572518 then
                      if c = 26558084453 then .some .avoid else .none
                    else
                      if c = 26566572518 then .some .azure else .none
                else
                  if c < 26805318252 then
                    if c < 26790982509 then
                      if c = 26790769766 then .some .beige else .none
                    else
                      if c = 26790982509 then .some .bevel else .none
                  else
                    if c < 26805450732 then
                      if c = 26805318252 then .some .black else .none
                    else
                      if c = 26805450732 then .some .blink else .none
              else
                if c < 27065497317 then
                  if c < 26818133103 then
                    if c < 26817966444 then
                      if c = 26805547628 then .some .block else .none
                    else
                      if c = 26817966444 then .some .«break» else .none
                  else
                    if c < 27065365871 then
                      if c = 26818133103 then .some .brown else .none
                    else
                      if c = 27065365871 then .some .chain else .none
                else
                  if c < 27073818995 then
                    if c < 27073754993 then
                      if c = 27065497317 then .some .child else .none
                    else
                      if c = 27073754993 then .some .clamp else .none
                  else
                    if c < 27073984486 then
                      if c = 27073818995 then .some .clear else .none
                    else
                      if c = 27073984486 then .some .clone else .none
          else
            if c < 28160144239 then
              if c < 27612952042 then
                if c < 27086568052 then
                  if c < 27080323437 then
                    if c < 27080226931 then
                      if c = 27073985126 then .some .close else .none
                    else
                      if c = 27080226931 then .some .color else .none
                  else
                    if c < 27080389491 then
                      if c = 27080323437 then .some .coral else .none
                    else
                      if c = 27080389491 then .some .cover else .none
                else
                  if c < 27327724134 then
                    if c < 27092909030 then
                      if c = 27086568052 then .some .cross else .none
                    else
                      if c = 27092909030 then .some .curve else .none
                  else
                    if c < 27612738405 then
                      if c = 27327724134 then .some .dense else .none
                    else
                      if c = 27612738405 then .some .embed else .none
              else
                if c < 27872835301 then
                  if c < 27635790453 then
                    if c < 27615132154 then
                      if c = 27612952042 then .some .emoji else .none
                    else
                      if c = 27615132154 then .some .entry else .none
                  else
                    if c < 27856173670 then
                      if c = 27635790453 then .some .exact else .none
                    else
                      if c = 27856173670 then .some .false else .none
                else
                  if c < 27873145701 then
                    if c < 27873049205 then
                      if c = 27872835301 then .some .Field else .none
                    else
                      if c = 27873049205 then .some .first else .none
                  else
                    if c < 27885386612 then
                      if c = 27873145701 then .some .fixed else .none
                    else
                      if c = 27885386612 then .some .focus else .none
            else
              if c < 28946799673 then
                if c < 28688774003 then
                  if c < 28422566771 then
                    if c < 28416063462 then
                      if c = 28160144239 then .some .green else .none
                    else
                      if c = 28416063462 then .some .hline else .none
                  else
                    if c < 28688628213 then
                      if c = 28422566771 then .some .hover else .none
                    else
                      if c = 28688628213 then .some .inert else .none
                else
                  if c < 28705569274 then
                    if c < 28688855925 then
                      if c = 28688774003 then .some .inner else .none
                    else
                      if c = 28688855925 then .some .inset else .none
                  else
                    if c < 28946798773 then
                      if c = 28705569274 then .some .ivory else .none
                    else
                      if c = 28946798773 then .some .jis04 else .none
              else
                if c < 29466883174 then
                  if c < 28946799921 then
                    if c < 28946799796 then
                      if c = 28946799673 then .some .jis78 else .none
                    else
                      if c = 28946799796 then .some .jis83 else .none
                  else
                    if c < 29212849770 then
                      if c = 28946799921 then .some .jis90 else .none
                    else
                      if c = 29212849770 then .some .khaki else .none
                else
                  if c < 29483480309 then
                    if c < 29475090797 then
                      if c = 29466883174 then .some .large else .none
                    else
                      if c = 29475090797 then .some .legal else .none
                  else
                    if c < 29483594607 then
                      if c = 29483480309 then .some .light else .none
                    else
                      if c = 29483594607 then .some .linen else .none
        else
          if c < 31387841395 then
            if c < 30540552058 then
              if c < 30033146473 then
                if c < 29743739763 then
                  if c < 29496195686 then
                    if c < 29495996781 then
                      if c = 29483595380 then .some .links else .none
                    else
                      if c = 29495996781 then .some .«local» else .none
                  else
                    if c < 29743707238 then
                      if c = 29496195686 then .some .loose else .none
                    else
                      if c = 29743707238 then .some .merge else .none
                else
                  if c < 29752193893 then
                    if c < 29752128371 then
                      if c = 29743739763 then .some .meter else .none
                    else
                      if c = 29752128371 then .some .miter else .none
                  else
                    if c < 30012207987 then
                      if c = 29752193893 then .some .mixed else .none
                    else
                      if c = 30012207987 then .some .never else .none
              else
                if c < 30314165107 then
                  if c < 30293062249 then
                    if c < 30293061987 then
                      if c = 30033146473 then .some .notch else .none
                    else
                      if c = 30293061987 then .some .oklab else .none
                  else
                    if c < 30295112678 then
                      if c = 30293062249 then .some .oklch else .none
                    else
                      if c = 30295112678 then .some .olive else .none
                else
                  if c < 30540478453 then
                    if c < 30540444517 then
                      if c = 30314165107 then .some .outer else .none
                    else
                      if c = 30540444517 then .some .paged else .none
                  else
                    if c < 30540552057 then
                      if c = 30540478453 then .some .paint else .none
                    else
                      if c = 30540552057 then .some .panX else .none
            else
              if c < 31354320231 then
                if c < 31094043750 then
                  if c < 31077349990 then
                    if c < 31077266800 then
                      if c = 30540552058 then .some .panY else .none
                    else
                      if c = 31077266800 then .some .radio else .none
                  else
                    if c < 31085640432 then
                      if c = 31077349990 then .some .raise else .none
                    else
                      if c = 31085640432 then .some .recto else .none
                else
                  if c < 31106906085 then
                    if c < 31094093045 then
                      if c = 31094043750 then .some .ridge else .none
                    else
                      if c = 31094093045 then .some .right else .none
                  else
                    if c < 31350077553 then
                      if c = 31106906085 then .some .round else .none
                    else
                      if c = 31350077553 then .some .scoop else .none
              else
                if c < 31375193445 then
                  if c < 31368852070 then
                    if c < 31362478964 then
                      if c = 31354320231 then .some .serif else .none
                    else
                      if c = 31362478964 then .some .sides else .none
                  else
                    if c < 31370819309 then
                      if c = 31368852070 then .some .slice else .none
                    else
                      if c = 31370819309 then .some .small else .none
                else
                  if c < 31385500149 then
                    if c < 31377109606 then
                      if c = 31375193445 then .some .solid else .none
                    else
                      if c = 31377109606 then .some .space else .none
                  else
                    if c < 31385892582 then
                      if c = 31385500149 then .some .start else .none
                    else
                      if c = 31385892582 then .some .style else .none
          else
            if c < 32985954280 then
              if c < 32434139509 then
                if c < 31910081397 then
                  if c < 31628898924 then
                    if c < 31614105318 then
                      if c = 31387841395 then .some .super else .none
                    else
                      if c = 31614105318 then .some .table else .none
                  else
                    if c < 31909835635 then
                      if c = 31628898924 then .some .thick else .none
                    else
                      if c = 31909835635 then .some .under else .none
                else
                  if c < 32174159846 then
                    if c < 32159627888 then
                      if c = 31910081397 then .some .unset else .none
                    else
                      if c = 32159627888 then .some .verso else .none
                  else
                    if c < 32423588915 then
                      if c = 32174159846 then .some .vline else .none
                    else
                      if c = 32423588915 then .some .wcag2 else .none
              else
                if c < 32449032948 then
                  if c < 32436222697 then
                    if c < 32434207462 then
                      if c = 32434139509 then .some .wheat else .none
                    else
                      if c = 32434207462 then .some .white else .none
                  else
                    if c < 32448836531 then
                      if c = 32436222697 then .some .width else .none
                    else
                      if c = 32448836531 then .some .woff2 else .none
                else
                  if c < 32578959480 then
                    if c < 32578844645 then
                      if c = 32449032948 then .some .words else .none
                    else
                      if c = 32578844645 then .some .xEnd else .none
                  else
                    if c < 32847280101 then
                      if c = 32578959480 then .some .xLow else .none
                    else
                      if c = 32847280101 then .some .yEnd else .none
            else
              if c < 3433536780399 then
                if c < 3429212371430 then
                  if c < 3396767104372 then
                    if c < 3394345024486 then
                      if c = 32985954280 then .some .young else .none
                    else
                      if c = 3394345024486 then .some .active else .none
                  else
                    if c < 3398361266149 then
                      if c = 3396767104372 then .some .always else .none
                    else
                      if c = 3398361266149 then .some .around else .none
                else
                  if c < 3431909127027 then
                    if c < 3430313409382 then
                      if c = 3429212371430 then .some .before else .none
                    else
                      if c = 3430313409382 then .some .bisque else .none
                  else
                    if c < 3431926167662 then
                      if c = 3431909127027 then .some .bolder else .none
                    else
                      if c = 3431926167662 then .some .bottom else .none
              else
                if c < 3465470096229 then
                  if c < 3463588967283 then
                    if c < 3462515257716 then
                      if c = 3433536780399 then .some .button else .none
                    else
                      if c = 3462515257716 then .some .Canvas else .none
                  else
                    if c < 3464670820070 then
                      if c = 3463588967283 then .some .center else .none
                    else
                      if c = 3464670820070 then .some .circle else .none
                else
                  if c < 3466269144943 then
                    if c < 3466246027878 then
                      if c = 3465470096229 then .some .closed else .none
                    else
                      if c = 3466246027878 then .some .coarse else .none
                  else
                    if c < 3467059444454 then
                      if c = 3466269144943 then .some .column else .none
                    else
                      if c = 3467059444454 then .some .create else .none
    else
      if c < 487180503612130 then
        if c < 4016305713509 then
          if c < 3806120917103 then
            if c < 3672142165104 then
              if c < 3500647446246 then
                if c < 3496885252965 then
                  if c < 3468934477156 then
                    if c = 3467894421614 then .some .custom else .none
                  else
                    if c < 3496883204975 then
                      if c = 3468934477156 then .some .cyclic else .none
                    else
                      if c = 3496883204975 then .some .darken else .none
                else
                  if c < 3499007589108 then
                    if c < 3496885252980 then
                      if c = 3496885252965 then .some .dashed else .none
                    else
                      if c = 3496885252980 then .some .dashes else .none
                  else
                    if c < 3500645643109 then
                      if c = 3499007589108 then .some .digits else .none
                    else
                      if c = 3500645643109 then .some .dotted else .none
              else
                if c < 3568536672122 then
                  if c < 3567737598821 then
                    if c < 3566665774822 then
                      if c = 3500647446246 then .some .double else .none
                    else
                      if c = 3566665774822 then .some .female else .none
                  else
                    if c < 3568536672121 then
                      if c = 3567737598821 then .some .filled else .none
                    else
                      if c = 3568536672121 then .some .flipX else .none
                else
                  if c < 3635376960757 then
                    if c < 3604519599078 then
                      if c = 3568536672122 then .some .flipY else .none
                    else
                      if c = 3604519599078 then .some .groove else .none
                  else
                    if c < 3636440167279 then
                      if c = 3635376960757 then .some .height else .none
                    else
                      if c = 3636440167279 then .some .hidden else .none
            else
              if c < 3771775859573 then
                if c < 3673746535780 then
                  if c < 3672173558261 then
                    if c < 3672158943206 then
                      if c = 3672142165104 then .some .indigo else .none
                    else
                      if c = 3672158943206 then .some .inline else .none
                  else
                    if c < 3672173621990 then
                      if c = 3672173558261 then .some .insert else .none
                    else
                      if c = 3672173621990 then .some .inside else .none
                else
                  if c < 3705190199734 then
                    if c < 3705190199733 then
                      if c = 3673746535780 then .some .italic else .none
                    else
                      if c = 3705190199733 then .some .JISB4 else .none
                  else
                    if c < 3771761046387 then
                      if c = 3705190199734 then .some .JISB5 else .none
                    else
                      if c = 3771761046387 then .some .larger else .none
              else
                if c < 3773900108147 then
                  if c < 3772811620986 then
                    if c < 3772805428083 then
                      if c = 3771775859573 then .some .layout else .none
                    else
                      if c = 3772805428083 then .some .ledger else .none
                  else
                    if c < 3772839195507 then
                      if c = 3772811620986 then .some .legacy else .none
                    else
                      if c = 3772839195507 then .some .letter else .none
                else
                  if c < 3806112625005 then
                    if c < 3775510754163 then
                      if c = 3773900108147 then .some .linear else .none
                    else
                      if c = 3775510754163 then .some .longer else .none
                  else
                    if c < 3806120850291 then
                      if c = 3806112625005 then .some .manual else .none
                    else
                      if c = 3806120850291 then .some .marker else .none
          else
            if c < 3978964087398 then
              if c < 3879372223845 then
                if c < 3844238717293 then
                  if c < 3808238860006 then
                    if c < 3807165201262 then
                      if c = 3806120917103 then .some .maroon else .none
                    else
                      if c = 3807165201262 then .some .medium else .none
                  else
                    if c < 3840480704632 then
                      if c = 3808238860006 then .some .middle else .none
                    else
                      if c = 3840480704632 then .some .narrow else .none
                else
                  if c < 3878831307622 then
                    if c < 3844249284977 then
                      if c = 3844238717293 then .some .normal else .none
                    else
                      if c = 3844249284977 then .some .nowrap else .none
                  else
                    if c < 3879368127590 then
                      if c = 3878831307622 then .some .«opaque» else .none
                    else
                      if c = 3879368127590 then .some .orange else .none
              else
                if c < 3909199968245 then
                  if c < 3880213361525 then
                    if c < 3879384790383 then
                      if c = 3879372223845 then .some .orchid else .none
                    else
                      if c = 3879384790383 then .some .origin else .none
                  else
                    if c < 3909190663025 then
                      if c = 3880213361525 then .some .outset else .none
                    else
                      if c = 3909190663025 then .some .panUp else .none
                else
                  if c < 3913736354554 then
                    if c < 3909206487909 then
                      if c = 3909199968245 then .some .parent else .none
                    else
                      if c = 3909206487909 then .some .paused else .none
                  else
                    if c < 3914568857318 then
                      if c = 3913736354554 then .some .pretty else .none
                    else
                      if c = 3914568857318 then .some .purple else .none
            else
              if c < 4012816217837 then
                if c < 3981681670886 then
                  if c < 3978988990837 then
                    if c < 3978970183791 then
                      if c = 3978964087398 then .some .reduce else .none
                    else
                      if c = 3978970183791 then .some .region else .none
                  else
                    if c < 3979001575925 then
                      if c = 3978988990837 then .some .«repeat» else .none
                    else
                      if c = 3979001575925 then .some .revert else .none
                else
                  if c < 4012266731631 then
                    if c < 3983278847343 then
                      if c = 3981681670886 then .some .rotate else .none
                    else
                      if c = 3983278847343 then .some .runIn else .none
                  else
                    if c < 4012816053103 then
                      if c = 4012266731631 then .some .salmon else .none
                    else
                      if c = 4012816053103 then .some .screen else .none
              else
                if c < 4014414084085 then
                  if c < 4014158297068 then
                    if c < 4013354956646 then
                      if c = 4012816217837 then .some .scroll else .none
                    else
                      if c = 4013354956646 then .some .sesame else .none
                  else
                    if c < 4014399551458 then
                      if c = 4014158297068 then .some .shrink else .none
                    else
                      if c = 4014399551458 then .some .sienna else .none
                else
                  if c < 4015494281961 then
                    if c < 4014414361459 then
                      if c = 4014414084085 then .some .silent else .none
                    else
                      if c = 4014414361459 then .some .silver else .none
                  else
                    if c < 4016270029684 then
                      if c = 4015494281961 then .some .smooth else .none
                    else
                      if c = 4016270029684 then .some .spaces else .none
        else
          if c < 443682985195509 then
            if c < 4170094000757 then
              if c < 4017379620840 then
                if c < 4017344050532 then
                  if c < 4016580377062 then
                    if c = 4016305713509 then .some .spread else .none
                  else
                    if c < 4017343756006 then
                      if c = 4016580377062 then .some .square else .none
                    else
                      if c = 4017343756006 then .some .stable else .none
                else
                  if c < 4017379521141 then
                    if c < 4017360549498 then
                      if c = 4017344050532 then .some .static else .none
                    else
                      if c = 4017360549498 then .some .sticky else .none
                  else
                    if c < 4017379620454 then
                      if c = 4017379521141 then .some .strict else .none
                    else
                      if c = 4017379620454 then .some .stroke else .none
              else
                if c < 4084490351590 then
                  if c < 4046877078504 then
                    if c < 4046877077992 then
                      if c = 4017379620840 then .some .strong else .none
                    else
                      if c = 4046877077992 then .some .tbdBg else .none
                  else
                    if c < 4050386467568 then
                      if c = 4046877078504 then .some .tbdFg else .none
                    else
                      if c = 4050386467568 then .some .tomato else .none
                else
                  if c < 4150773036277 then
                    if c < 4117499704181 then
                      if c = 4084490351590 then .some .«unsafe» else .none
                    else
                      if c = 4117499704181 then .some .violet else .none
                  else
                    if c < 4151857215608 then
                      if c = 4150773036277 then .some .weight else .none
                    else
                      if c = 4151857215608 then .some .Window else .none
            else
              if c < 438803325776486 then
                if c < 4170121491445 then
                  if c < 4170106813285 then
                    if c < 4170098324585 then
                      if c = 4170094000757 then .some .xFast else .none
                    else
                      if c = 4170098324585 then .some .xHigh else .none
                  else
                    if c < 4170121443448 then
                      if c = 4170106813285 then .some .xLoud else .none
                    else
                      if c = 4170121443448 then .some .xSlow else .none
                else
                  if c < 4219498887288 then
                    if c < 4170129715564 then
                      if c = 4170121491445 then .some .xSoft else .none
                    else
                      if c = 4170129715564 then .some .xWeak else .none
                  else
                    if c < 433016822101091 then
                      if c = 4219498887288 then .some .yellow else .none
                    else
                      if c = 433016822101091 then .some .a98Rgb else .none
              else
                if c < 443202485794927 then
                  if c < 439388292854643 then
                    if c < 438942958203759 then
                      if c = 438803325776486 then .some .balance else .none
                    else
                      if c = 438942958203759 then .some .between else .none
                  else
                    if c < 439490543467252 then
                      if c = 439388292854643 then .some .browser else .none
                    else
                      if c = 439490543467252 then .some .bullets else .none
                else
                  if c < 443682708304501 then
                    if c < 443339388023149 then
                      if c = 443202485794927 then .some .caption else .none
                    else
                      if c = 443339388023149 then .some .central else .none
                  else
                    if c < 443682985129327 then
                      if c = 443682708304501 then .some .compact else .none
                    else
                      if c = 443682985129327 then .some .contain else .none
          else
            if c < 452441191183205 then
              if c < 447874577789306 then
                if c < 443890215336934 then
                  if c < 443784707782767 then
                    if c < 443684046354932 then
                      if c = 443682985195509 then .some .content else .none
                    else
                      if c = 443684046354932 then .some .corners else .none
                  else
                    if c < 443890213173237 then
                      if c = 443784707782767 then .some .crimson else .none
                    else
                      if c = 443890213173237 then .some .current else .none
                else
                  if c < 447734458593645 then
                    if c < 447601050448741 then
                      if c = 443890215336934 then .some .cursive else .none
                    else
                      if c = 447601050448741 then .some .darkred else .none
                  else
                    if c < 447735247255285 then
                      if c = 447734458593645 then .some .decimal else .none
                    else
                      if c = 447735247255285 then .some .default else .none
              else
                if c < 451999351682415 then
                  if c < 447876179737061 then
                    if c < 447874577789818 then
                      if c = 447874577789306 then .some .dimgray else .none
                    else
                      if c = 447874577789818 then .some .dimgrey else .none
                  else
                    if c < 447876207178106 then
                      if c = 447876179737061 then .some .discard else .none
                    else
                      if c = 447876207178106 then .some .display else .none
                else
                  if c < 452373568403445 then
                    if c < 452067017373562 then
                      if c = 451999351682415 then .some .easeIn else .none
                    else
                      if c = 452067017373562 then .some .economy else .none
                  else
                    if c < 452375439243878 then
                      if c = 452373568403445 then .some .element else .none
                    else
                      if c = 452375439243878 then .some .ellipse else .none
            else
              if c < 470035262666101 then
                if c < 456396088326778 then
                  if c < 452785346556646 then
                    if c < 452717168046821 then
                      if c = 452441191183205 then .some .enabled else .none
                    else
                      if c = 452717168046821 then .some .evenodd else .none
                  else
                    if c < 452789895164660 then
                      if c = 452785346556646 then .some .exclude else .none
                    else
                      if c = 452789895164660 then .some .«extends» else .none
                else
                  if c < 465192154216424 then
                    if c < 457080305431906 then
                      if c = 456396088326778 then .some .fantasy else .none
                    else
                      if c = 457080305431906 then .some .fuchsia else .none
                  else
                    if c < 465674820040684 then
                      if c = 465192154216424 then .some .hanging else .none
                    else
                      if c = 465674820040684 then .some .hotpink else .none
              else
                if c < 482918283261928 then
                  if c < 470208954809062 then
                    if c < 470035562410349 then
                      if c = 470035262666101 then .some .inherit else .none
                    else
                      if c = 470035562410349 then .some .initial else .none
                  else
                    if c < 474676811445242 then
                      if c = 470208954809062 then .some .isolate else .none
                    else
                      if c = 474676811445242 then .some .justify else .none
                else
                  if c < 483057341395827 then
                    if c < 483057341395823 then
                      if c = 482918283261928 then .some .leading else .none
                    else
                      if c = 483057341395823 then .some .lighten else .none
                  else
                    if c < 483060587493497 then
                      if c = 483057341395827 then .some .lighter else .none
                    else
                      if c = 483060587493497 then .some .listbox else .none
      else
        if c < 57956968068379493 then
          if c < 518207913686758 then
            if c < 496667310338790 then
              if c < 492044015171697 then
                if c < 487457268939630 then
                  if c < 487183468837364 then
                    if c = 487180503612130 then .some .magenta else .none
                  else
                    if c < 487185075387246 then
                      if c = 487183468837364 then .some .markers else .none
                    else
                      if c = 487185075387246 then .some .maximum else .none
                else
                  if c < 491719778693485 then
                    if c < 491714405579381 then
                      if c = 487457268939630 then .some .minimum else .none
                    else
                      if c = 491714405579381 then .some .nearest else .none
                  else
                    if c < 492044012975473 then
                      if c = 491719778693485 then .some .neutral else .none
                    else
                      if c = 492044012975473 then .some .noClip else .none
              else
                if c < 492267355567460 then
                  if c < 492061509401072 then
                    if c < 492044046513521 then
                      if c = 492044015171697 then .some .noDrop else .none
                    else
                      if c = 492044046513521 then .some .noSkip else .none
                  else
                    if c < 492267349064180 then
                      if c = 492061509401072 then .some .nonzero else .none
                    else
                      if c = 492267349064180 then .some .numbers else .none
                else
                  if c < 496353762914918 then
                    if c < 496012306987878 then
                      if c = 492267355567460 then .some .numeric else .none
                    else
                      if c = 496012306987878 then .some .oblique else .none
                  else
                    if c < 496559915266413 then
                      if c = 496353762914918 then .some .oldlace else .none
                    else
                      if c = 496559915266413 then .some .ordinal else .none
            else
              if c < 509859828774888 then
                if c < 509306993400241 then
                  if c < 500375198987109 then
                    if c < 496697641496954 then
                      if c = 496667310338790 then .some .outside else .none
                    else
                      if c = 496697641496954 then .some .overlay else .none
                  else
                    if c < 500856235324275 then
                      if c = 500375198987109 then .some .painted else .none
                    else
                      if c = 500856235324275 then .some .pointer else .none
                else
                  if c < 509310605505126 then
                    if c < 509307403187045 then
                      if c = 509306993400241 then .some .rec2020 else .none
                    else
                      if c = 509307403187045 then .some .reduced else .none
                  else
                    if c < 509312201718374 then
                      if c = 509310605505126 then .some .replace else .none
                    else
                      if c = 509312201718374 then .some .reverse else .none
              else
                if c < 514223788290917 then
                  if c < 513917205576550 then
                    if c < 513811475690355 then
                      if c = 509859828774888 then .some .running else .none
                    else
                      if c = 513811475690355 then .some .shorter else .none
                  else
                    if c < 513979503571827 then
                      if c = 513917205576550 then .some .skyblue else .none
                    else
                      if c = 513979503571827 then .some .smaller else .none
                else
                  if c < 514254639527269 then
                    if c < 514224570593897 then
                      if c = 514223788290917 then .some .stopped else .none
                    else
                      if c = 514224570593897 then .some .stretch else .none
                  else
                    if c < 514395020736244 then
                      if c = 514254639527269 then .some .subgrid else .none
                    else
                      if c = 514395020736244 then .some .symbols else .none
          else
            if c < 55692115175929205 then
              if c < 536388631616305 then
                if c < 527041029535462 then
                  if c < 522812084990694 then
                    if c < 522812084763238 then
                      if c = 518207913686758 then .some .thistle else .none
                    else
                      if c = 522812084763238 then .some .unicase else .none
                  else
                    if c < 522883232838901 then
                      if c = 522812084990694 then .some .unicode else .none
                    else
                      if c = 522883232838901 then .some .upright else .none
                else
                  if c < 533775546627821 then
                    if c < 533773642691686 then
                      if c = 527041029535462 then .some .visible else .none
                    else
                      if c = 533773642691686 then .some .xLarge else .none
                  else
                    if c < 533775561308661 then
                      if c = 533775546627821 then .some .xSmall else .none
                    else
                      if c = 533775561308661 then .some .xStart else .none
              else
                if c < 55608518064847590 then
                  if c < 538173607819765 then
                    if c < 536388631616438 then
                      if c = 536388631616305 then .some .xyzD50 else .none
                    else
                      if c = 536388631616438 then .some .xyzD65 else .none
                  else
                    if c < 544838307788143 then
                      if c = 538173607819765 then .some .yStart else .none
                    else
                      if c = 544838307788143 then .some .zoomIn else .none
                else
                  if c < 55661502920243686 then
                    if c < 55616797167762406 then
                      if c = 55608518064847590 then .some .absolute else .none
                    else
                      if c = 55616797167762406 then .some .additive else .none
                  else
                    if c < 55692115175846629 then
                      if c = 55661502920243686 then .some .anywhere else .none
                    else
                      if c = 55692115175846629 then .some .autoAdd else .none
            else
              if c < 57292934424001382 then
                if c < 56791351229708902 then
                  if c < 56758403209984745 then
                    if c < 56167067287205862 then
                      if c = 55692115175929205 then .some .autoFit else .none
                    else
                      if c = 56167067287205862 then .some .baseline else .none
                  else
                    if c < 56760321990785145 then
                      if c = 56758403209984745 then .some .chWidth else .none
                    else
                      if c = 56760321990785145 then .some .checkbox else .none
                else
                  if c < 56791422105025268 then
                    if c < 56791386698660468 then
                      if c = 56791351229708902 then .some .collapse else .none
                    else
                      if c = 56791386698660468 then .some .compress else .none
                  else
                    if c < 56791557962643180 then
                      if c = 56791422105025268 then .some .contents else .none
                    else
                      if c = 56791557962643180 then .some .cornsilk else .none
              else
                if c < 57310081304934380 then
                  if c < 57292934434582906 then
                    if c < 57292934426308975 then
                      if c = 57292934424001382 then .some .darkblue else .none
                    else
                      if c = 57292934426308975 then .some .darkcyan else .none
                  else
                    if c < 57292934434583418 then
                      if c = 57292934434582906 then .some .darkgray else .none
                    else
                      if c = 57292934434583418 then .some .darkgrey else .none
                else
                  if c < 57855917015448437 then
                    if c < 57627184383835622 then
                      if c = 57310081304934380 then .some .deeppink else .none
                    else
                      if c = 57627184383835622 then .some .eResize else .none
                  else
                    if c < 57904056223217012 then
                      if c = 57855917015448437 then .some .easeOut else .none
                    else
                      if c = 57904056223217012 then .some .ellipsis else .none
        else
          if c < 63577298099206264 then
            if c < 60164994657776485 then
              if c < 59055964543432680 then
                if c < 58466769544263653 then
                  if c < 58418695853848552 then
                    if c < 58418628440666732 then
                      if c = 57956968068379493 then .some .expanded else .none
                    else
                      if c = 58418628440666732 then .some .fallback else .none
                  else
                    if c < 58453812701624441 then
                      if c = 58418695853848552 then .some .fangsong else .none
                    else
                      if c = 58453812701624441 then .some .fillBox else .none
                else
                  if c < 58480306343918310 then
                    if c < 58467112873211877 then
                      if c = 58466769544263653 then .some .flexEnd else .none
                    else
                      if c = 58467112873211877 then .some .flowEnd else .none
                  else
                    if c < 58480410201223924 then
                      if c = 58480306343918310 then .some .footnote else .none
                    else
                      if c = 58480410201223924 then .some .forwards else .none
              else
                if c < 60114112697957097 then
                  if c < 59544426900010982 then
                    if c < 59055970755132661 then
                      if c = 59055964543432680 then .some .grabbing else .none
                    else
                      if c = 59055970755132661 then .some .GrayText else .none
                  else
                    if c < 59606167887377272 then
                      if c = 59544426900010982 then .some .hairline else .none
                    else
                      if c = 59606167887377272 then .some .honeydew else .none
                else
                  if c < 60164445967137530 then
                    if c < 60164445967137510 then
                      if c = 60114112697957097 then .some .icWidth else .none
                    else
                      if c = 60164445967137510 then .some .infinite else .none
                  else
                    if c < 60164447590268149 then
                      if c = 60164445967137530 then .some .infinity else .none
                    else
                      if c = 60164447590268149 then .some .InfoText else .none
            else
              if c < 62420539110405487 then
                if c < 61831581022141685 then
                  if c < 61250730838243053 then
                    if c < 60758424506972133 then
                      if c = 60164994657776485 then .some .inverted else .none
                    else
                      if c = 60758424506972133 then .some .jumpEnd else .none
                  else
                    if c < 61796669904745331 then
                      if c = 61250730838243053 then .some .keepAll else .none
                    else
                      if c = 61796669904745331 then .some .lavender else .none
                else
                  if c < 62376941457160821 then
                    if c < 62359484042427637 then
                      if c = 61831581022141685 then .some .LinkText else .none
                    else
                      if c = 62359484042427637 then .some .MarkText else .none
                  else
                    if c < 62376941473873141 then
                      if c = 62376941457160821 then .some .menulist else .none
                    else
                      if c = 62376941473873141 then .some .MenuText else .none
              else
                if c < 62922470731773298 then
                  if c < 62447241207248634 then
                    if c < 62420574042372838 then
                      if c = 62420539110405487 then .some .moccasin else .none
                    else
                      if c = 62420574042372838 then .some .moderate else .none
                  else
                    if c < 62693733964627430 then
                      if c = 62447241207248634 then .some .multiply else .none
                    else
                      if c = 62693733964627430 then .some .nResize else .none
                else
                  if c < 63550908775971046 then
                    if c < 62981636070552949 then
                      if c = 62922470731773298 then .some .nastaliq else .none
                    else
                      if c = 62981636070552949 then .some .noLimit else .none
                  else
                    if c < 63551422819201389 then
                      if c = 63550908775971046 then .some .opentype else .none
                    else
                      if c = 63551422819201389 then .some .optional else .none
          else
            if c < 65508483731733990 then
              if c < 64109940376778863 then
                if c < 64048179787349103 then
                  if c < 64047955396049638 then
                    if c < 63577298111739878 then
                      if c = 63577298099206264 then .some .overflow else .none
                    else
                      if c = 63577298111739878 then .some .overline else .none
                  else
                    if c < 64048126133891956 then
                      if c = 64047955396049638 then .some .paginate else .none
                    else
                      if c = 64048126133891956 then .some .palettes else .none
                else
                  if c < 64065909429024742 then
                    if c < 64048179803960309 then
                      if c = 64048179787349103 then .some .panDown else .none
                    else
                      if c = 64048179803960309 then .some .panLeft else .none
                  else
                    if c < 64109908965504373 then
                      if c = 64065909429024742 then .some .perLine else .none
                    else
                      if c = 64109908965504373 then .some .portrait else .none
              else
                if c < 64122996536228468 then
                  if c < 64122637380284785 then
                    if c < 64122637357070310 then
                      if c = 64109940376778863 then .some .position else .none
                    else
                      if c = 64122637357070310 then .some .preLine else .none
                  else
                    if c < 64122656133020646 then
                      if c = 64122637380284785 then .some .preWrap else .none
                    else
                      if c = 64122656133020646 then .some .preserve else .none
                else
                  if c < 65191755625879417 then
                    if c < 65191617152859110 then
                      if c = 64122996536228468 then .some .progress else .none
                    else
                      if c = 65191617152859110 then .some .relative else .none
                  else
                    if c < 65191755625879418 then
                      if c = 65191755625879417 then .some .repeatX else .none
                    else
                      if c = 65191755625879418 then .some .repeatY else .none
            else
              if c < 65802571001477093 then
                if c < 65754704540908262 then
                  if c < 65754193955763949 then
                    if c < 65754190755509103 then
                      if c = 65508483731733990 then .some .sResize else .none
                    else
                      if c = 65754190755509103 then .some .seagreen else .none
                  else
                    if c < 65754568299493349 then
                      if c = 65754193955763949 then .some .seashell else .none
                    else
                      if c = 65754568299493349 then .some .selfEnd else .none
                else
                  if c < 65780856183633645 then
                    if c < 65771885494320500 then
                      if c = 65754704540908262 then .some .separate else .none
                    else
                      if c = 65771885494320500 then .some .sideways else .none
                  else
                    if c < 65802571001411309 then
                      if c = 65780856183633645 then .some .skipAll else .none
                    else
                      if c = 65802571001411309 then .some .spanAll else .none
              else
                if c < 65820301163345893 then
                  if c < 65807655045248742 then
                    if c < 65802571001722993 then
                      if c = 65802571001477093 then .some .spanEnd else .none
                    else
                      if c = 65802571001722993 then .some .spanTop else .none
                  else
                    if c < 65820163302799845 then
                      if c = 65807655045248742 then .some .squircle else .none
                    else
                      if c = 65820163302799845 then .some .standard else .none
                else
                  if c < 65842562654238052 then
                    if c < 65824597349020277 then
                      if c = 65820301163345893 then .some .stepEnd else .none
                    else
                      if c = 65824597349020277 then .some .subtract else .none
                  else
                    if c < 66317934328117361 then
                      if c = 65842562654238052 then .some .symbolic else .none
                    else
                      if c = 66317934328117361 then .some .textTop else .none
  else
    if c < 136809540476316621059061 then
      if c < 929958929981419403878 then
        if c < 7917859446273391206 then
          if c < 7417634875414068710 then
            if c < 7123489028310677477 then
              if c < 67460774390986873 then
                if c < 66374591657392101 then
                  if c < 66374588572514022 then
                    if c = 66317934437135202 then .some .textarea else .none
                  else
                    if c < 66374591657326317 then
                      if c = 66374588572514022 then .some .triangle else .none
                    else
                      if c = 66374591657326317 then .some .trimAll else .none
                else
                  if c < 66895899336176999 then
                    if c < 66375001975994598 then
                      if c = 66374591657392101 then .some .trimEnd else .none
                    else
                      if c = 66375001975994598 then .some .truetype else .none
                  else
                    if c < 67443628202078573 then
                      if c = 66895899336176999 then .some .uiSerif else .none
                    else
                      if c = 67443628202078573 then .some .vertical else .none
              else
                if c < 68650719910606573 then
                  if c < 68323271883110376 then
                    if c < 67760283545419238 then
                      if c = 67460774390986873 then .some .viewBox else .none
                    else
                      if c = 67760283545419238 then .some .wResize else .none
                  else
                    if c < 68650718006670438 then
                      if c = 68323271883110376 then .some .xStrong else .none
                    else
                      if c = 68650718006670438 then .some .xxLarge else .none
                else
                  if c < 3374813771711822586 then
                    if c < 69739303396981621 then
                      if c = 68650719910606573 then .some .xxSmall else .none
                    else
                      if c = 69739303396981621 then .some .zoomOut else .none
                  else
                    if c < 7123475417133710182 then
                      if c = 3374813771711822586 then .some .«-infinity» else .none
                    else
                      if c = 7123475417133710182 then .some .aliceblue else .none
            else
              if c < 7261376238235384678 then
                if c < 7189314453112681204 then
                  if c < 7128590742518937325 then
                    if c < 7123523867879455462 then
                      if c = 7123489028310677477 then .some .allowEnd else .none
                    else
                      if c = 7123523867879455462 then .some .alternate else .none
                  else
                    if c < 7128590742518986872 then
                      if c = 7128590742518937325 then .some .autoFill else .none
                    else
                      if c = 7128590742518986872 then .some .autoFlow else .none
                else
                  if c < 7198893051485927149 then
                    if c < 7195559400950052837 then
                      if c = 7189314453112681204 then .some .backwards else .none
                    else
                      if c = 7195559400950052837 then .some .blockEnd else .none
                  else
                    if c < 7200639457821472869 then
                      if c = 7198893051485927149 then .some .breakAll else .none
                    else
                      if c = 7200639457821472869 then .some .burlywood else .none
              else
                if c < 7270995246735471987 then
                  if c < 7269293064904850408 then
                    if c < 7265365196380093158 then
                      if c = 7261376238235384678 then .some .cadetblue else .none
                    else
                      if c = 7265365196380093158 then .some .chocolate else .none
                  else
                    if c < 7269301479687402341 then
                      if c = 7269293064904850408 then .some .colorSVG else .none
                    else
                      if c = 7269301479687402341 then .some .condensed else .none
                else
                  if c < 7333495608679380586 then
                    if c < 7333495607626675055 then
                      if c = 7270995246735471987 then .some .crosshair else .none
                    else
                      if c = 7333495607626675055 then .some .darkgreen else .none
                  else
                    if c < 7405487112305948646 then
                      if c = 7333495608679380586 then .some .darkkhaki else .none
                    else
                      if c = 7405487112305948646 then .some .eachLine else .none
          else
            if c < 7701110520085525094 then
              if c < 7487106042264550132 then
                if c < 7482114187829359212 then
                  if c < 7418435118015625327 then
                    if c < 7418197481749099765 then
                      if c = 7417634875414068710 then .some .ewResize else .none
                    else
                      if c = 7418197481749099765 then .some .exHeight else .none
                  else
                    if c < 7482057254283885813 then
                      if c = 7418435118015625327 then .some .exclusion else .none
                    else
                      if c = 7482057254283885813 then .some .FieldText else .none
                else
                  if c < 7483790447798401141 then
                    if c < 7483746501667813496 then
                      if c = 7482114187829359212 then .some .firebrick else .none
                    else
                      if c = 7483746501667813496 then .some .flexFlow else .none
                  else
                    if c < 7485491819490949093 then
                      if c = 7483790447798401141 then .some .flowRoot else .none
                    else
                      if c = 7485491819490949093 then .some .forceEnd else .none
              else
                if c < 7559198700442762356 then
                  if c < 7549628913588910576 then
                    if c < 7487167803896379381 then
                      if c = 7487106042264550132 then .some .fragments else .none
                    else
                      if c = 7487167803896379381 then .some .fromFont else .none
                  else
                    if c < 7557523059746076773 then
                      if c = 7549628913588910576 then .some .gainsboro else .none
                    else
                      if c = 7557523059746076773 then .some .goldenrod else .none
                else
                  if c < 7694605908878963957 then
                    if c < 7626181103138256117 then
                      if c = 7559198700442762356 then .some .gridRows else .none
                    else
                      if c = 7626181103138256117 then .some .Highlight else .none
                  else
                    if c < 7701040284221371237 then
                      if c = 7694605908878963957 then .some .icHeight else .none
                    else
                      if c = 7701040284221371237 then .some .indianred else .none
            else
              if c < 7914411481422855014 then
                if c < 7841817221983353709 then
                  if c < 7777078336886160105 then
                    if c < 7701110520100270709 then
                      if c = 7701110520085525094 then .some .interlace else .none
                    else
                      if c = 7701110520100270709 then .some .intersect else .none
                  else
                    if c < 7777078336911325158 then
                      if c = 7777078336886160105 then .some .jumpBoth else .none
                    else
                      if c = 7777078336911325158 then .some .jumpNone else .none
                else
                  if c < 7909978453241869167 then
                    if c < 7909938530415589606 then
                      if c = 7841817221983353709 then .some .khmerMul else .none
                    else
                      if c = 7909938530415589606 then .some .landscape else .none
                  else
                    if c < 7912155696682824436 then
                      if c = 7909978453241869167 then .some .lawngreen else .none
                    else
                      if c = 7912155696682824436 then .some .leftwards else .none
              else
                if c < 7914411481452165100 then
                  if c < 7914411481433436538 then
                    if c < 7914411481425162607 then
                      if c = 7914411481422855014 then .some .lightblue else .none
                    else
                      if c = 7914411481425162607 then .some .lightcyan else .none
                  else
                    if c < 7914411481433437050 then
                      if c = 7914411481433436538 then .some .lightgray else .none
                    else
                      if c = 7914411481433437050 then .some .lightgrey else .none
                else
                  if c < 7914442159602594915 then
                    if c < 7914437763166483311 then
                      if c = 7914411481452165100 then .some .lightpink else .none
                    else
                      if c = 7914437763166483311 then .some .limegreen else .none
                  else
                    if c < 7914464651253740398 then
                      if c = 7914442159602594915 then .some .linearRGB else .none
                    else
                      if c = 7914464651253740398 then .some .listItem else .none
        else
          if c < 8422728725146679021 then
            if c < 8198160141644313455 then
              if c < 7986522265711557222 then
                if c < 7982022631377189616 then
                  if c < 7921193301890036326 then
                    if c = 7917859446273391206 then .some .lowercase else .none
                  else
                    if c < 7981996119657560570 then
                      if c = 7921193301890036326 then .some .luminance else .none
                    else
                      if c = 7981996119657560570 then .some .mandatory else .none
                else
                  if c < 7986499894281958245 then
                    if c < 7982040275119698789 then
                      if c = 7982022631377189616 then .some .mathAuto else .none
                    else
                      if c = 7982040275119698789 then .some .maximized else .none
                  else
                    if c < 7986500269573255534 then
                      if c = 7986499894281958245 then .some .minimized else .none
                    else
                      if c = 7986500269573255534 then .some .mintcream else .none
              else
                if c < 8063901421941734886 then
                  if c < 8056020122593836518 then
                    if c < 7989877801785799270 then
                      if c = 7986522265711557222 then .some .mistyrose else .none
                    else
                      if c = 7989877801785799270 then .some .monospace else .none
                  else
                    if c < 8061649622121689461 then
                      if c = 8056020122593836518 then .some .neResize else .none
                    else
                      if c = 8061649622121689461 then .some .noRepeat else .none
                else
                  if c < 8132282386504020323 then
                    if c < 8066153221755420134 then
                      if c = 8063901421941734886 then .some .nsResize else .none
                    else
                      if c = 8066153221755420134 then .some .nwResize else .none
                  else
                    if c < 8135624627513520997 then
                      if c = 8132282386504020323 then .some .olivedrab else .none
                    else
                      if c = 8135624627513520997 then .some .orangered else .none
            else
              if c < 8353491019915377254 then
                if c < 8204304351942524149 then
                  if c < 8200363494491403239 then
                    if c < 8198167016525935861 then
                      if c = 8198160141644313455 then .some .palegreen else .none
                    else
                      if c = 8198167016525935861 then .some .panRight else .none
                  else
                    if c < 8202716519136588645 then
                      if c = 8200363494491403239 then .some .peachpuff else .none
                    else
                      if c = 8202716519136588645 then .some .pixelated else .none
                else
                  if c < 8350188101246401647 then
                    if c < 8207744138353490682 then
                      if c = 8204304351942524149 then .some .plaintext else .none
                    else
                      if c = 8207744138353490682 then .some .proximity else .none
                  else
                    if c < 8350213667542498150 then
                      if c = 8350188101246401647 then .some .rosybrown else .none
                    else
                      if c = 8350213667542498150 then .some .royalblue else .none
              else
                if c < 8418225572195924089 then
                  if c < 8415485556870934899 then
                    if c < 8353491019953192181 then
                      if c = 8353491019915377254 then .some .rubyBase else .none
                    else
                      if c = 8353491019953192181 then .some .rubyText else .none
                  else
                    if c < 8416308092783476198 then
                      if c = 8415485556870934899 then .some .Scrollbar else .none
                    else
                      if c = 8416308092783476198 then .some .seResize else .none
                else
                  if c < 8420477509570457978 then
                    if c < 8420477509559876454 then
                      if c = 8418225572195924089 then .some .shapeBox else .none
                    else
                      if c = 8420477509559876454 then .some .slateblue else .none
                  else
                    if c < 8420477509570458490 then
                      if c = 8420477509570457978 then .some .slategray else .none
                    else
                      if c = 8420477509570458490 then .some .slategrey else .none
          else
            if c < 911808815895567758692 then
              if c < 8495947732139916009 then
                if c < 8426441191945059814 then
                  if c < 8422746628449647477 then
                    if c < 8422729088203600885 then
                      if c = 8422728725146679021 then .some .spaceAll else .none
                    else
                      if c = 8422729088203600885 then .some .spanLeft else .none
                  else
                    if c < 8424998187856264038 then
                      if c = 8422746628449647477 then .some .spellOut else .none
                    else
                      if c = 8424998187856264038 then .some .steelblue else .none
                else
                  if c < 8486346777167722616 then
                    if c < 8427875023813589866 then
                      if c = 8426441191945059814 then .some .swResize else .none
                    else
                      if c = 8427875023813589866 then .some .systemUi else .none
                  else
                    if c < 8488695609276610277 then
                      if c = 8486346777167722616 then .some .tableRow else .none
                    else
                      if c = 8488695609276610277 then .some .textfield else .none
              else
                if c < 8787619596595950694 then
                  if c < 8565731279796615142 then
                    if c < 8497676321212250726 then
                      if c = 8495947732139916009 then .some .trimBoth else .none
                    else
                      if c = 8497676321212250726 then .some .turquoise else .none
                  else
                    if c < 8566909956242586214 then
                      if c = 8565731279796615142 then .some .underline else .none
                    else
                      if c = 8566909956242586214 then .some .uppercase else .none
                else
                  if c < 911162554469477629173 then
                    if c < 911153036791868078822 then
                      if c = 8787619596595950694 then .some .xxxLarge else .none
                    else
                      if c = 911153036791868078822 then .some .accumulate else .none
                  else
                    if c < 911806305229780825837 then
                      if c = 911162554469477629173 then .some .ActiveText else .none
                    else
                      if c = 911806305229780825837 then .some .allScroll else .none
            else
              if c < 921250610727658205804 then
                if c < 912528833372915020902 then
                  if c < 912528833372894229369 then
                    if c < 912171888241274435558 then
                      if c = 911808815895567758692 then .some .alphabetic else .none
                    else
                      if c = 912171888241274435558 then .some .aquamarine else .none
                  else
                    if c < 912528833372906764262 then
                      if c = 912528833372894229369 then .some .avoidFlex else .none
                    else
                      if c = 912528833372906764262 then .some .avoidLine else .none
                else
                  if c < 921034990211504501621 then
                    if c < 920232249453224769509 then
                      if c = 912528833372915020902 then .some .avoidPage else .none
                    else
                      if c = 920232249453224769509 then .some .Background else .none
                  else
                    if c < 921249469163873302649 then
                      if c = 921034990211504501621 then .some .blueviolet else .none
                    else
                      if c = 921249469163873302649 then .some .borderBox else .none
              else
                if c < 921683011339424480501 then
                  if c < 921458310590244862437 then
                    if c < 921250610728446604148 then
                      if c = 921250610727658205804 then .some .bothBlock else .none
                    else
                      if c = 921250610728446604148 then .some .bothEdges else .none
                  else
                    if c < 921683011339395052134 then
                      if c = 921458310590244862437 then .some .breakWord else .none
                    else
                      if c = 921683011339395052134 then .some .ButtonFace else .none
                else
                  if c < 929462667191447598325 then
                    if c < 929461862112199032053 then
                      if c = 921683011339424480501 then .some .ButtonText else .none
                    else
                      if c = 929461862112199032053 then .some .CanvasText else .none
                  else
                    if c < 929462931485487709670 then
                      if c = 929462667191447598325 then .some .capHeight else .none
                    else
                      if c = 929462931485487709670 then .some .capitalize else .none
      else
        if c < 1078109323293164681189 then
          if c < 985742146554082114021 then
            if c < 939264483635980122292 then
              if c < 930470659771418390893 then
                if c < 930469512307785185775 then
                  if c < 930469222051783294438 then
                    if c = 929958929981419403878 then .some .chartreuse else .none
                  else
                    if c < 930469498681502120047 then
                      if c = 930469222051783294438 then .some .colResize else .none
                    else
                      if c = 930469498681502120047 then .some .collection else .none
                else
                  if c < 930469512307820524921 then
                    if c < 930469512307786969845 then
                      if c = 930469512307785185775 then .some .colorBurn else .none
                    else
                      if c = 930469512307786969845 then .some .colorCBDT else .none
                  else
                    if c < 930470655509468395509 then
                      if c = 930469512307820524921 then .some .colorSbix else .none
                    else
                      if c = 930470655509468395509 then .some .consistent else .none
              else
                if c < 938687438183982676079 then
                  if c < 938687438051084072038 then
                    if c < 930684013778541622132 then
                      if c = 930470659771418390893 then .some .contextual else .none
                    else
                      if c = 930684013778541622132 then .some .crispEdges else .none
                  else
                    if c < 938687438051088168293 then
                      if c = 938687438051084072038 then .some .darkorange else .none
                    else
                      if c = 938687438051088168293 then .some .darkorchid else .none
                else
                  if c < 938967254616136923112 then
                    if c < 938687438289215648629 then
                      if c = 938687438183982676079 then .some .darksalmon else .none
                    else
                      if c = 938687438289215648629 then .some .darkviolet else .none
                  else
                    if c < 939257121070124888678 then
                      if c = 938967254616136923112 then .some .decreasing else .none
                    else
                      if c = 939257121070124888678 then .some .difference else .none
            else
              if c < 958571960837326091119 then
                if c < 957921768832427932149 then
                  if c < 957919552216986335733 then
                    if c < 939688345132485802854 then
                      if c = 939264483635980122292 then .some .displayP3 else .none
                    else
                      if c = 939688345132485802854 then .some .dodgerblue else .none
                  else
                    if c < 957921768827847979628 then
                      if c = 957919552216986335733 then .some .flexStart else .none
                    else
                      if c = 957921768827847979628 then .some .flipBlock else .none
                else
                  if c < 958357478899537458278 then
                    if c < 957925177318474037749 then
                      if c = 957921768832427932149 then .some .flipStart else .none
                    else
                      if c = 957925177318474037749 then .some .flowStart else .none
                  else
                    if c < 958571958437494225641 then
                      if c = 958357478899537458278 then .some .fromImage else .none
                    else
                      if c = 958571958437494225641 then .some .fullWidth else .none
              else
                if c < 975580893142840915189 then
                  if c < 967577433655033459572 then
                    if c < 966860303827581188838 then
                      if c = 958571960837326091119 then .some .fullscreen else .none
                    else
                      if c = 966860303827581188838 then .some .ghostwhite else .none
                  else
                    if c < 967577433655874253683 then
                      if c = 967577433655033459572 then .some .gridLanes else .none
                    else
                      if c = 967577433655874253683 then .some .gridOrder else .none
                else
                  if c < 985732633146752153576 then
                    if c < 976589724096120320365 then
                      if c = 975580893142840915189 then .some .hardLight else .none
                    else
                      if c = 976589724096120320365 then .some .horizontal else .none
                  else
                    if c < 985737660424078866405 then
                      if c = 985732633146752153576 then .some .increasing else .none
                    else
                      if c = 985737660424078866405 then .some .inlineEnd else .none
          else
            if c < 1068384901848868123380 then
              if c < 1022271986465912896362 then
                if c < 1013912742645693332218 then
                  if c < 1013044669622400119149 then
                    if c < 995466027126002072053 then
                      if c = 985742146554082114021 then .some .interWord else .none
                    else
                      if c = 995466027126002072053 then .some .jumpStart else .none
                  else
                    if c < 1013044669623479939951 then
                      if c = 1013044669622400119149 then .some .lightcoral else .none
                    else
                      if c = 1013044669623479939951 then .some .lightgreen else .none
                else
                  if c < 1021698876839309194983 then
                    if c < 1021697768583249590393 then
                      if c = 1013912742645693332218 then .some .luminosity else .none
                    else
                      if c = 1021697768583249590393 then .some .marginBox else .none
                  else
                    if c < 1021978126868306164582 then
                      if c = 1021698876839309194983 then .some .matchSelf else .none
                    else
                      if c = 1021978126868306164582 then .some .mediumblue else .none
              else
                if c < 1049656097341026709869 then
                  if c < 1041218086943831374566 then
                    if c < 1022707192965296126697 then
                      if c = 1022271986465912896362 then .some .minimalUi else .none
                    else
                      if c = 1022707192965296126697 then .some .mostWidth else .none
                  else
                    if c < 1049366732952049448305 then
                      if c = 1041218086943831374566 then .some .openQuote else .none
                    else
                      if c = 1049366732952049448305 then .some .papayawhip else .none
                else
                  if c < 1050379492429718584166 then
                    if c < 1049942076002471262318 then
                      if c = 1049656097341026709869 then .some .perceptual else .none
                    else
                      if c = 1049942076002471262318 then .some .pinchZoom else .none
                  else
                    if c < 1068094179857125849330 then
                      if c = 1050379492429718584166 then .some .powderblue else .none
                    else
                      if c = 1068094179857125849330 then .some .rec2100Pq else .none
            else
              if c < 1077322847023863019493 then
                if c < 1077039188582833240175 then
                  if c < 1077035736357104532591 then
                    if c < 1068825995054092565990 then
                      if c = 1068384901848868123380 then .some .rightwards else .none
                    else
                      if c = 1068825995054092565990 then .some .rowResize else .none
                  else
                    if c < 1077035799720998270311 then
                      if c = 1077035736357104532591 then .some .sandybrown else .none
                    else
                      if c = 1077035799720998270311 then .some .sansSerif else .none
                else
                  if c < 1077322847018089722476 then
                    if c < 1077172567678706793583 then
                      if c = 1077039188582833240175 then .some .saturation else .none
                    else
                      if c = 1077172567678706793583 then .some .scaleDown else .none
                  else
                    if c < 1077322847022669674997 then
                      if c = 1077322847018089722476 then .some .selfBlock else .none
                    else
                      if c = 1077322847022669674997 then .some .selfStart else .none
              else
                if c < 1077965216895408550508 then
                  if c < 1077611686491189850981 then
                    if c < 1077322847024131454949 then
                      if c = 1077322847023863019493 then .some .selfXEnd else .none
                    else
                      if c = 1077322847024131454949 then .some .selfYEnd else .none
                  else
                    if c < 1077893143859601914100 then
                      if c = 1077611686491189850981 then .some .simplified else .none
                    else
                      if c = 1077893143859601914100 then .some .smallCaps else .none
                else
                  if c < 1078109323291679929589 then
                    if c < 1078040106834077562101 then
                      if c = 1077965216895408550508 then .some .snapBlock else .none
                    else
                      if c = 1078040106834077562101 then .some .softLight else .none
                  else
                    if c < 1078109323291971336693 then
                      if c = 1078109323291679929589 then .some .spanRight else .none
                    else
                      if c = 1078109323291971336693 then .some .spanStart else .none
        else
          if c < 122613702683874415194477 then
            if c < 116794830725773610498662 then
              if c < 1087481309718482827765 then
                if c < 1078399814264029755893 then
                  if c < 1078397555553060272102 then
                    if c < 1078109323293433116645 then
                      if c = 1078109323293164681189 then .some .spanXEnd else .none
                    else
                      if c = 1078109323293433116645 then .some .spanYEnd else .none
                  else
                    if c < 1078397582530154393971 then
                      if c = 1078397555553060272102 then .some .standalone else .none
                    else
                      if c = 1078397582530154393971 then .some .statusBar else .none
                else
                  if c < 1086252387477436872429 then
                    if c < 1078407130341774522489 then
                      if c = 1078399814264029755893 then .some .stepStart else .none
                    else
                      if c = 1078407130341774522489 then .some .strokeBox else .none
                  else
                    if c < 1086765767063401706086 then
                      if c = 1086252387477436872429 then .some .tableCell else .none
                    else
                      if c = 1086765767063401706086 then .some .ThreeDFace else .none
              else
                if c < 1114430882599124350566 then
                  if c < 1096413603815833221606 then
                    if c < 1096022410670290596709 then
                      if c = 1087481309718482827765 then .some .trimStart else .none
                    else
                      if c = 1096022410670290596709 then .some .uiRounded else .none
                  else
                    if c < 1104708125437894342644 then
                      if c = 1096413603815833221606 then .some .underscore else .none
                    else
                      if c = 1104708125437894342644 then .some .variations else .none
                else
                  if c < 116627579706521159432307 then
                    if c < 1114505684918870850805 then
                      if c = 1114430882599124350566 then .some .whitesmoke else .none
                    else
                      if c = 1114505684918870850805 then .some .WindowText else .none
                  else
                    if c < 116748424209797563988079 then
                      if c = 116627579706521159432307 then .some .AccentColor else .none
                    else
                      if c = 116748424209797563988079 then .some .application else .none
            else
              if c < 119100097575397027837030 then
                if c < 117919932052975780688738 then
                  if c < 117790877218762615534197 then
                    if c < 117790370849127671576301 then
                      if c = 116794830725773610498662 then .some .autoPhrase else .none
                    else
                      if c = 117790370849127671576301 then .some .balanceAll else .none
                  else
                    if c < 117892045225169436326389 then
                      if c = 117790877218762615534197 then .some .baseSelect else .none
                    else
                      if c = 117892045225169436326389 then .some .blockStart else .none
                else
                  if c < 118971261374694998785269 then
                    if c < 117920078173381299189734 then
                      if c = 117919932052975780688738 then .some .borderArea else .none
                    else
                      if c = 117920078173381299189734 then .some .bothInline else .none
                  else
                    if c < 119072645826697288760038 then
                      if c = 118971261374694998785269 then .some .CaptionText else .none
                    else
                      if c = 119072645826697288760038 then .some .closeQuote else .none
              else
                if c < 120151992061160144501474 then
                  if c < 119100244450397805672569 then
                    if c < 119100243953551014622053 then
                      if c = 119100097575397027837030 then .some .colorDodge else .none
                    else
                      if c = 119100243953551014622053 then .some .constrained else .none
                  else
                    if c < 119127553761729444459380 then
                      if c = 119100244450397805672569 then .some .contentBox else .none
                    else
                      if c = 119127553761729444459380 then .some .«crisp-edges» else .none
                else
                  if c < 121332652080573536025461 then
                    if c < 120187951642071539612518 then
                      if c = 120151992061160144501474 then .some .darkmagenta else .none
                    else
                      if c = 120187951642071539612518 then .some .deepskyblue else .none
                  else
                    if c < 122587071447683250632693 then
                      if c = 121332652080573536025461 then .some .easeInOut else .none
                    else
                      if c = 122587071447683250632693 then .some .fitContent else .none
          else
            if c < 130850780447140902189045 then
              if c < 126174420534282099160421 then
                if c < 123849624126738854017144 then
                  if c < 122614420110473629973222 then
                    if c < 122613986410205590239206 then
                      if c = 122613702683874415194477 then .some .flexVisual else .none
                    else
                      if c = 122613986410205590239206 then .some .flipInline else .none
                  else
                    if c < 122642299160452354650991 then
                      if c = 122614420110473629973222 then .some .floralwhite else .none
                    else
                      if c = 122642299160452354650991 then .some .forestgreen else .none
                else
                  if c < 126173777043192845005165 then
                    if c < 126081685758129334809956 then
                      if c = 123849624126738854017144 then .some .greenyellow else .none
                    else
                      if c = 126081685758129334809956 then .some .ideographic else .none
                  else
                    if c < 126174420534282096964473 then
                      if c = 126173777043192845005165 then .some .incremental else .none
                    else
                      if c = 126174420534282096964473 then .some .inlineFlex else .none
              else
                if c < 129669717712420432738424 then
                  if c < 127420086332929653389037 then
                    if c < 126174420534282124180966 then
                      if c = 126174420534282099160421 then .some .inlineGrid else .none
                    else
                      if c = 126174420534282124180966 then .some .inlineSize else .none
                  else
                    if c < 129669717712213200582767 then
                      if c = 127420086332929653389037 then .some .justifyAll else .none
                    else
                      if c = 129669717712213200582767 then .some .lightsalmon else .none
                else
                  if c < 130777714046786443261941 then
                    if c < 129670222651506869254004 then
                      if c = 129669717712420432738424 then .some .lightyellow else .none
                    else
                      if c = 129670222651506869254004 then .some .liningNums else .none
                  else
                    if c < 130814286644386876422265 then
                      if c = 130777714046786443261941 then .some .maxContent else .none
                    else
                      if c = 130814286644386876422265 then .some .messageBox else .none
            else
              if c < 132160890852148011253222 then
                if c < 132082059008472832916084 then
                  if c < 131958190856502073015014 then
                    if c < 130906520699041444672757 then
                      if c = 130850780447140902189045 then .some .minContent else .none
                    else
                      if c = 130906520699041444672757 then .some .mostHeight else .none
                  else
                    if c < 131994880288583786872294 then
                      if c = 131958190856502073015014 then .some .navajowhite else .none
                    else
                      if c = 131994880288583786872294 then .some .neswResize else .none
                else
                  if c < 132082065794384233461880 then
                    if c < 132082060121142357472628 then
                      if c = 132082059008472832916084 then .some .noCompress else .none
                    else
                      if c = 132082060121142357472628 then .some .noEllipsis else .none
                  else
                    if c < 132087144636743950414693 then
                      if c = 132082065794384233461880 then .some .noOverflow else .none
                    else
                      if c = 132087144636743950414693 then .some .notAllowed else .none
              else
                if c < 134475670431944605875174 then
                  if c < 134356128018112859126004 then
                    if c < 134318078745657248118905 then
                      if c = 132160890852148011253222 then .some .nwseResize else .none
                    else
                      if c = 134318078745657248118905 then .some .paddingBox else .none
                  else
                    if c < 134474956554676514560613 then
                      if c = 134356128018112859126004 then .some .petiteCaps else .none
                    else
                      if c = 134474956554676514560613 then .some .preserve3d else .none
                else
                  if c < 136716055021712108582632 then
                    if c < 134503266248002337683567 then
                      if c = 134475670431944605875174 then .some .progressive else .none
                    else
                      if c = 134503266248002337683567 then .some .punctuation else .none
                  else
                    if c < 136717453114655278741222 then
                      if c = 136716055021712108582632 then .some .rec2100Hlg else .none
                    else
                      if c = 136717453114655278741222 then .some .revertRule else .none
    else
      if c < 2260959026099051609816937327 then
        if c < 17042853095411598812247802 then
          if c < 15100854457784514884760435 then
            if c < 139197032053918563678197 then
              if c < 137979547762853343311846 then
                if c < 137896538777879555192549 then
                  if c < 136809727366924645235302 then
                    if c = 136809540476316621059061 then .some .rotateLeft else .none
                  else
                    if c < 137859853620693186657391 then
                      if c = 136809727366924645235302 then .some .rowReverse else .none
                    else
                      if c = 137859853620693186657391 then .some .saddlebrown else .none
                else
                  if c < 137933641208185225983731 then
                    if c < 137897324418556533323750 then
                      if c = 137896538777879555192549 then .some .searchfield else .none
                    else
                      if c = 137897324418556533323750 then .some .selfInline else .none
                  else
                    if c < 137933641208185225984493 then
                      if c = 137933641208185225983731 then .some .sidewaysLr else .none
                    else
                      if c = 137933641208185225984493 then .some .sidewaysRl else .none
              else
                if c < 138016865715367383249267 then
                  if c < 137997993380786913245294 then
                    if c < 137997987432804525079157 then
                      if c = 137979547762853343311846 then .some .snapInline else .none
                    else
                      if c = 137997987432804525079157 then .some .spaceFirst else .none
                  else
                    if c < 137999215831178460902255 then
                      if c = 137997993380786913245294 then .some .spanBottom else .none
                    else
                      if c = 137999215831178460902255 then .some .springgreen else .none
                else
                  if c < 139078788611461514885230 then
                    if c < 138044185979692573703142 then
                      if c = 138016865715367383249267 then .some .srgbLinear else .none
                    else
                      if c = 138044185979692573703142 then .some .subtractive else .none
                  else
                    if c < 139197026380578144645485 then
                      if c = 139078788611461514885230 then .some .textBottom else .none
                    else
                      if c = 139197026380578144645485 then .some .traditional else .none
            else
              if c < 14928487292427305672602483 then
                if c < 141476499172985507790069 then
                  if c < 141439539771245484292589 then
                    if c < 141439539771245484291827 then
                      if c = 139197032053918563678197 then .some .transparent else .none
                    else
                      if c = 141439539771245484291827 then .some .verticalLr else .none
                  else
                    if c < 141476499094061427898093 then
                      if c = 141439539771245484292589 then .some .verticalRl else .none
                    else
                      if c = 141476499094061427898093 then .some .visibleFill else .none
                else
                  if c < 142656727669611737692006 then
                    if c < 142656587767065526137958 then
                      if c = 141476499172985507790069 then .some .VisitedText else .none
                    else
                      if c = 142656587767065526137958 then .some .willChange else .none
                  else
                    if c < 144980877811310961210223 then
                      if c = 142656727669611737692006 then .some .WindowFrame else .none
                    else
                      if c = 144980877811310961210223 then .some .yellowgreen else .none
              else
                if c < 14950872405981396794718063 then
                  if c < 14941473797510921379822310 then
                    if c < 14941316926987682335913317 then
                      if c = 14928487292427305672602483 then .some .ActiveBorder else .none
                    else
                      if c = 14941316926987682335913317 then .some .anchorValid else .none
                  else
                    if c < 14943799094931636369273446 then
                      if c = 14941473797510921379822310 then .some .antiquewhite else .none
                    else
                      if c = 14943799094931636369273446 then .some .AppWorkspace else .none
                else
                  if c < 15093779692872653348599929 then
                    if c < 14950872405981909495756911 then
                      if c = 14950872405981396794718063 then .some .avoidColumn else .none
                    else
                      if c = 14950872405981909495756911 then .some .avoidRegion else .none
                  else
                    if c < 15097172960710434619994996 then
                      if c = 15093779692872653348599929 then .some .boundingBox else .none
                    else
                      if c = 15097172960710434619994996 then .some .breakSpaces else .none
          else
            if c < 16150325828388111917824501 then
              if c < 15686252660987046565294453 then
                if c < 15244812489650785220361138 then
                  if c < 15241298666125199977132774 then
                    if c < 15100854457785097085614200 then
                      if c = 15100854457784514884760435 then .some .ButtonBorder else .none
                    else
                      if c = 15100854457785097085614200 then .some .ButtonShadow else .none
                  else
                    if c < 15244812489650785220361137 then
                      if c = 15241298666125199977132774 then .some .closestSide else .none
                    else
                      if c = 15244812489650785220361137 then .some .colorCOLRv0 else .none
                else
                  if c < 15251951588748197459884147 then
                    if c < 15244831289694899614103542 then
                      if c = 15244812489650785220361138 then .some .colorCOLRv1 else .none
                    else
                      if c = 15244831289694899614103542 then .some .contextMenu else .none
                  else
                    if c < 15379454987223584789345135 then
                      if c = 15251951588748197459884147 then .some .currentColor else .none
                    else
                      if c = 15379454987223584789345135 then .some .darkseagreen else .none
              else
                if c < 15852788672964966315964404 then
                  if c < 15691131751870770450363251 then
                    if c < 15691131751870534996572405 then
                      if c = 15686252660987046565294453 then .some .featuresAat else .none
                    else
                      if c = 15691131751870534996572405 then .some .firstExcept else .none
                  else
                    if c < 15698214140229184610988911 then
                      if c = 15691131751870770450363251 then .some .firstLetter else .none
                    else
                      if c = 15698214140229184610988911 then .some .forceHidden else .none
                else
                  if c < 16150298948075339680315130 then
                    if c < 15993260917378416541088506 then
                      if c = 15852788672964966315964404 then .some .gridColumns else .none
                    else
                      if c = 15993260917378416541088506 then .some .highQuality else .none
                  else
                    if c < 16150325828388107337871980 then
                      if c = 16150298948075339680315130 then .some .initialOnly else .none
                    else
                      if c = 16150325828388107337871980 then .some .inlineBlock else .none
            else
              if c < 16739514398135244554039910 then
                if c < 16597723867163636738521958 then
                  if c < 16150399329449322919671919 then
                    if c < 16150325828388112146429670 then
                      if c = 16150325828388111917824501 then .some .inlineStart else .none
                    else
                      if c = 16150325828388112146429670 then .some .inlineTable else .none
                  else
                    if c < 16593057341867970656860271 then
                      if c = 16150399329449322919671919 then .some .intersection else .none
                    else
                      if c = 16593057341867970656860271 then .some .lemonchiffon else .none
                else
                  if c < 16739459495068602350614639 then
                    if c < 16597788174629959030912105 then
                      if c = 16597723867163636738521958 then .some .lightskyblue else .none
                    else
                      if c = 16597788174629959030912105 then .some .lineThrough else .none
                  else
                    if c < 16739514398135137710225397 then
                      if c = 16739459495068602350614639 then .some .manipulation else .none
                    else
                      if c = 16739514398135137710225397 then .some .matchParent else .none
              else
                if c < 16748812350599588581440358 then
                  if c < 16744089630610776450037093 then
                    if c < 16739514757015222701601133 then
                      if c = 16739514398135244554039910 then .some .matchSource else .none
                    else
                      if c = 16739514757015222701601133 then .some .mathematical else .none
                  else
                    if c < 16744089630610811646670566 then
                      if c = 16744089630610776450037093 then .some .mediumorchid else .none
                    else
                      if c = 16744089630610811646670566 then .some .mediumpurple else .none
                else
                  if c < 16907099182854618985707631 then
                    if c < 16906503412377786514977382 then
                      if c = 16748812350599588581440358 then .some .midnightblue else .none
                    else
                      if c = 16906503412377786514977382 then .some .noAutospace else .none
                  else
                    if c < 16914177544405166359049978 then
                      if c = 16907099182854618985707631 then .some .nonRotation else .none
                    else
                      if c = 16914177544405166359049978 then .some .numericOnly else .none
        else
          if c < 1968570238368559945890888550 then
            if c < 17663742391398948312708858 then
              if c < 17511621180968529114576117 then
                if c < 17212885815288909425865075 then
                  if c < 17197561611634956352141037 then
                    if c < 17066401009837702645560687 then
                      if c = 17042853095411598812247802 then .some .obliqueOnly else .none
                    else
                      if c = 17066401009837702645560687 then .some .overlapJoin else .none
                  else
                    if c < 17205858431674847386760051 then
                      if c = 17197561611634956352141037 then .some .perLineAll else .none
                    else
                      if c = 17205858431674847386760051 then .some .plusLighter else .none
                else
                  if c < 17499778648873501028266604 then
                    if c < 17212886458221769984373859 then
                      if c = 17212885815288909425865075 then .some .progressBar else .none
                    else
                      if c = 17212886458221769984373859 then .some .prophotoRgb else .none
                  else
                    if c < 17499833998675874026533747 then
                      if c = 17499778648873501028266604 then .some .repeatBlock else .none
                    else
                      if c = 17499833998675874026533747 then .some .revertLayer else .none
              else
                if c < 17650857525643373528529397 then
                  if c < 17650857483965006838854510 then
                    if c < 17648552366561178636827366 then
                      if c = 17511621180968529114576117 then .some .rotateRight else .none
                    else
                      if c = 17648552366561178636827366 then .some .scrollState else .none
                  else
                    if c < 17650857525638975482018293 then
                      if c = 17650857483965006838854510 then .some .SelectedItem else .none
                    else
                      if c = 17650857525638975482018293 then .some .selfXStart else .none
                else
                  if c < 17662747347201343266321267 then
                    if c < 17659021179772669827594736 then
                      if c = 17650857525643373528529397 then .some .selfYStart else .none
                    else
                      if c = 17659021179772669827594736 then .some .slashedZero else .none
                  else
                    if c < 17663742391398809821100005 then
                      if c = 17662747347201343266321267 then .some .sourceOrder else .none
                    else
                      if c = 17663742391398809821100005 then .some .spaceAround else .none
            else
              if c < 18270567389974688033471078 then
                if c < 17797159769118520519800692 then
                  if c < 17663743152839611953756661 then
                    if c < 17663743152835213907245557 then
                      if c = 17663742391398948312708858 then .some .spaceEvenly else .none
                    else
                      if c = 17663743152835213907245557 then .some .spanXStart else .none
                  else
                    if c < 17797159116430328402392943 then
                      if c = 17663743152839611953756661 then .some .spanYStart else .none
                    else
                      if c = 17797159116430328402392943 then .some .tableColumn else .none
                else
                  if c < 17806769872630523618703604 then
                    if c < 17805570327567222103963768 then
                      if c = 17797159769118520519800692 then .some .tabularNums else .none
                    else
                      if c = 17805570327567222103963768 then .some .ThreeDShadow else .none
                  else
                    if c < 17957230816103323030565478 then
                      if c = 17806769872630523618703604 then .some .titlingCaps else .none
                    else
                      if c = 17957230816103323030565478 then .some .uiMonospace else .none
              else
                if c < 1931085218476694426089059700 then
                  if c < 1912488566654422687239992179 then
                    if c < 1910846373430699042600040559 then
                      if c = 18270567389974688033471078 then .some .wrapReverse else .none
                    else
                      if c = 1910846373430699042600040559 then .some .ActiveCaption else .none
                  else
                    if c < 1931076986188821438316327654 then
                      if c = 1912488566654422687239992179 then .some .anchorCenter else .none
                    else
                      if c = 1931076986188821438316327654 then .some .bidiOverride else .none
                else
                  if c < 1951338405075317653763619561 then
                    if c < 1932002676230911057828083825 then
                      if c = 1931085218476694426089059700 then .some .bikeshedThis else .none
                    else
                      if c = 1932002676230911057828083825 then .some .bottomToTop else .none
                  else
                    if c < 1968570237505605496077088869 then
                      if c = 1951338405075317653763619561 then .some .contentWidth else .none
                    else
                      if c = 1968570237505605496077088869 then .some .darkgoldenrod else .none
          else
            if c < 2142657842961249622881318901 then
              if c < 2007255946810081376923726566 then
                if c < 1969780269699170758209401715 then
                  if c < 1968570238368559945901470586 then
                    if c < 1968570238368559945901470074 then
                      if c = 1968570238368559945890888550 then .some .darkslateblue else .none
                    else
                      if c = 1968570238368559945901470074 then .some .darkslategray else .none
                  else
                    if c < 1968570238445758757543262822 then
                      if c = 1968570238368559945901470586 then .some .darkslategrey else .none
                    else
                      if c = 1968570238445758757543262822 then .some .darkturquoise else .none
                else
                  if c < 1970689316808826278121125606 then
                    if c < 1969780269699170760373564275 then
                      if c = 1969780269699170758209401715 then .some .discardAfter else .none
                    else
                      if c = 1969780269699170760373564275 then .some .discardInner else .none
                  else
                    if c < 1991378165850524413104666600 then
                      if c = 1970689316808826278121125606 then .some .doubleCircle else .none
                    else
                      if c = 1991378165850524413104666600 then .some .exitCrossing else .none
              else
                if c < 2123314001831540412829579238 then
                  if c < 2047137401959500812058737909 then
                    if c < 2029147593027469424558143603 then
                      if c = 2007255946810081376923726566 then .some .farthestSide else .none
                    else
                      if c = 2029147593027469424558143603 then .some .grammarError else .none
                  else
                    if c < 2048057093067626922094869219 then
                      if c = 2047137401959500812058737909 then .some .HighlightText else .none
                    else
                      if c = 2048057093067626922094869219 then .some .horizontalTb else .none
                else
                  if c < 2123903117060470671184377077 then
                    if c < 2123317409940709081635207785 then
                      if c = 2123314001831540412829579238 then .some .lastBaseline else .none
                    else
                      if c = 2123317409940709081635207785 then .some .lavenderblush else .none
                  else
                    if c < 2124508654996918290972521327 then
                      if c = 2123903117060470671184377077 then .some .leftToRight else .none
                    else
                      if c = 2124508654996918290972521327 then .some .lightseagreen else .none
            else
              if c < 2200676856921811033490373222 then
                if c < 2182987001206414838375233396 then
                  if c < 2164032565542826167475387110 then
                    if c < 2164032454795398995062403437 then
                      if c = 2142657842961249622881318901 then .some .matchElement else .none
                    else
                      if c = 2164032454795398995062403437 then .some .noContextual else .none
                  else
                    if c < 2164032574910280132414141030 then
                      if c = 2164032565542826167475387110 then .some .noOpenQuote else .none
                    else
                      if c = 2164032574910280132414141030 then .some .noPreference else .none
                else
                  if c < 2184365931414924599645223142 then
                    if c < 2183610260835084496921015141 then
                      if c = 2182987001206414838375233396 then .some .oldstyleNums else .none
                    else
                      if c = 2183610260835084496921015141 then .some .optimizeSpeed else .none
                  else
                    if c < 2200676855981657772024199269 then
                      if c = 2184365931414924599645223142 then .some .outsideShape else .none
                    else
                      if c = 2200676855981657772024199269 then .some .palegoldenrod else .none
              else
                if c < 2240565533640582631156986869 then
                  if c < 2239955138907892308604909286 then
                    if c < 2200676857059157451902612325 then
                      if c = 2200676856921811033490373222 then .some .paleturquoise else .none
                    else
                      if c = 2200676857059157451902612325 then .some .palevioletred else .none
                  else
                    if c < 2239971667055808372666972134 then
                      if c = 2239955138907892308604909286 then .some .rebeccapurple else .none
                    else
                      if c = 2239971667055808372666972134 then .some .repeatInline else .none
                else
                  if c < 2260213008100612076157450214 then
                    if c < 2259310971533159385894843237 then
                      if c = 2240565533640582631156986869 then .some .rightToLeft else .none
                    else
                      if c = 2259310971533159385894843237 then .some .semiExpanded else .none
                  else
                    if c < 2260505762431451873362491503 then
                      if c = 2260213008100612076157450214 then .some .skipOverline else .none
                    else
                      if c = 2260505762431451873362491503 then .some .smallCaption else .none
      else
        if c < 37043554280412588877080922995189 then
          if c < 286714348220893592074933875059 then
            if c < 249771315849640659165283759349 then
              if c < 116227152874513967027689403002 then
                if c < 2280167935415440025579255918 then
                  if c < 2260959123560338676579416037 then
                    if c = 2260959026099051609816937327 then .some .spaceBetween else .none
                  else
                    if c < 2278036366903081555541538927 then
                      if c = 2260959123560338676579416037 then .some .spanSelfEnd else .none
                    else
                      if c = 2278036366903081555541538927 then .some .tableCaption else .none
                else
                  if c < 2317345419612086014653873397 then
                    if c < 2298525598792666440328344935 then
                      if c = 2280167935415440025579255918 then .some .topToBottom else .none
                    else
                      if c = 2298525598792666440328344935 then .some .uiSansSerif else .none
                  else
                    if c < 2317950961157102884324390502 then
                      if c = 2317345419612086014653873397 then .some .verticalText else .none
                    else
                      if c = 2317950961157102884324390502 then .some .visibleStroke else .none
              else
                if c < 244798536531766187668360722150 then
                  if c < 244761219280072838732846840550 then
                    if c < 244761141328742393343943162100 then
                      if c = 116227152874513967027689403002 then .some .webkitLegacy else .none
                    else
                      if c = 244761141328742393343943162100 then .some .allSmallCaps else .none
                  else
                    if c < 244761219280076762001855804148 then
                      if c = 244761219280072838732846840550 then .some .allowDiscrete else .none
                    else
                      if c = 244761219280076762001855804148 then .some .allowKeywords else .none
                else
                  if c < 249713437345795275877227688819 then
                    if c < 247235435724834506104911968229 then
                      if c = 244798536531766187668360722150 then .some .anchorVisible else .none
                    else
                      if c = 247235435724834506104911968229 then .some .blanchedalmond else .none
                  else
                    if c < 249771014872524686440231926374 then
                      if c = 249713437345795275877227688819 then .some .closestCorner else .none
                    else
                      if c = 249771014872524686440231926374 then .some .columnReverse else .none
            else
              if c < 264605269071428626998565106547 then
                if c < 254704637706624246420071954408 then
                  if c < 251976990474286697323689522031 then
                    if c < 249771913238077509630252776294 then
                      if c = 249771315849640659165283759349 then .some .contentHeight else .none
                    else
                      if c = 249771913238077509630252776294 then .some .cornflowerblue else .none
                  else
                    if c < 252131874521493857084865526246 then
                      if c = 251976990474286697323689522031 then .some .darkolivegreen else .none
                    else
                      if c = 252131874521493857084865526246 then .some .discardBefore else .none
                else
                  if c < 257084392641161067140195465327 then
                    if c < 254898065616402810521213563749 then
                      if c = 254704637706624246420071954408 then .some .entryCrossing else .none
                    else
                      if c = 254898065616402810521213563749 then .some .extraExpanded else .none
                  else
                    if c < 257314700771693675807174604770 then
                      if c = 257084392641161067140195465327 then .some .fixedPosition else .none
                    else
                      if c = 257314700771693675807174604770 then .some .fullSizeKana else .none
              else
                if c < 271937107839614003015633828710 then
                  if c < 271937107839609482337348022650 then
                    if c < 264606038650557507846807599077 then
                      if c = 264605269071428626998565106547 then .some .InactiveBorder else .none
                    else
                      if c = 264606038650557507846807599077 then .some .InfoBackground else .none
                  else
                    if c < 271937107839609482337348023162 then
                      if c = 271937107839609482337348022650 then .some .lightslategray else .none
                    else
                      if c = 271937107839609482337348023162 then .some .lightslategrey else .none
                else
                  if c < 276996154186212447323722365670 then
                    if c < 274335164507929155913647764335 then
                      if c = 271937107839614003015633828710 then .some .lightsteelblue else .none
                    else
                      if c = 274335164507929155913647764335 then .some .mediumseagreen else .none
                  else
                    if c < 276996169616832868628771289199 then
                      if c = 276996154186212447323722365670 then .some .noCloseQuote else .none
                    else
                      if c = 276996169616832868628771289199 then .some .noPunctuation else .none
          else
            if c < 33520588490468755796964792662137 then
              if c < 306523727568704511914255595245 then
                if c < 289402767814502325260780156901 then
                  if c < 289191804356095210961474761573 then
                    if c < 289191649698519154901856663525 then
                      if c = 286714348220893592074933875059 then .some .rec2100Linear else .none
                    else
                      if c = 289191649698519154901856663525 then .some .selfBlockEnd else .none
                  else
                    if c < 289307265037306182869647538150 then
                      if c = 289191804356095210961474761573 then .some .semiCondensed else .none
                    else
                      if c = 289307265037306182869647538150 then .some .skipUnderline else .none
                else
                  if c < 294280033116168970516441953125 then
                    if c < 289403370497806821479304460403 then
                      if c = 289402767814502325260780156901 then .some .spanBlockEnd else .none
                    else
                      if c = 289403370497806821479304460403 then .some .spellingError else .none
                  else
                    if c < 296697723028109155344129553253 then
                      if c = 294280033116168970516441953125 then .some .ultraExpanded else .none
                    else
                      if c = 296697723028109155344129553253 then .some .visiblePainted else .none
              else
                if c < 31970689903683158249685846390904 then
                  if c < 31329426086464831952108538870004 then
                    if c < 31306977540696353605860277730549 then
                      if c = 306523727568704511914255595245 then .some .zeroIfScroll else .none
                    else
                      if c = 31306977540696353605860277730549 then .some .AccentColorText else .none
                  else
                    if c < 31668787127852139879230412043509 then
                      if c = 31329426086464831952108538870004 then .some .allPetiteCaps else .none
                    else
                      if c = 31668787127852139879230412043509 then .some .ButtonHighlight else .none
                else
                  if c < 32626952398899410556282270987109 then
                    if c < 32272879951711172885304405947247 then
                      if c = 31970689903683158249685846390904 then .some .columnOverRow else .none
                    else
                      if c = 32272879951711172885304405947247 then .some .disclosureOpen else .none
                  else
                    if c < 32886881432536373278970220376947 then
                      if c = 32626952398899410556282270987109 then .some .extraCondensed else .none
                    else
                      if c = 32886881432536373278970220376947 then .some .farthestCorner else .none
            else
              if c < 35115096287872589860334429108335 then
                if c < 33869842253907529033360235918195 then
                  if c < 33844794809732153696687310419948 then
                    if c < 33844794809732153694625321481442 then
                      if c = 33520588490468755796964792662137 then .some .halfBorderBox else .none
                    else
                      if c = 33844794809732153694625321481442 then .some .ideographAlpha else .none
                  else
                    if c < 33869474441142864259732840560751 then
                      if c = 33844794809732153696687310419948 then .some .ideographicInk else .none
                    else
                      if c = 33869474441142864259732840560751 then .some .InactiveCaption else .none
                else
                  if c < 35114901057015013096851420920422 then
                    if c < 35114901057014935898039768546150 then
                      if c = 33869842253907529033360235918195 then .some .interCharacter else .none
                    else
                      if c = 35114901057014935898039768546150 then .some .mediumslateblue else .none
                  else
                    if c < 35114901057015150443269833159525 then
                      if c = 35114901057015013096851420920422 then .some .mediumturquoise else .none
                    else
                      if c = 35114901057015150443269833159525 then .some .mediumvioletred else .none
              else
                if c < 36724581547589900959089516459887 then
                  if c < 36097846283334779120187671623284 then
                    if c < 35139951577165796494759232716262 then
                      if c = 35115096287872589860334429108335 then .some .menulistButton else .none
                    else
                      if c = 35139951577165796494759232716262 then .some .mostBlockSize else .none
                  else
                    if c < 36097846283334779120771241948020 then
                      if c = 36097846283334779120187671623284 then .some .preserveBreaks else .none
                    else
                      if c = 36097846283334779120771241948020 then .some .preserveSpaces else .none
                else
                  if c < 37016531161475157884540125034469 then
                    if c < 37011696892638507190355247151215 then
                      if c = 36724581547589900959089516459887 then .some .rowOverColumn else .none
                    else
                      if c = 37011696892638507190355247151215 then .some .scrollPosition else .none
                  else
                    if c < 37043554280321003690482332186597 then
                      if c = 37016531161475157884540125034469 then .some .selfInlineEnd else .none
                    else
                      if c = 37043554280321003690482332186597 then .some .spanInlineEnd else .none
        else
          if c < 607083826569565236495210676487993332 then
            if c < 513303990991148000003687880536685158 then
              if c < 4336912125264616787692607325778662 then
                if c < 37340987423597462925712245273845 then
                  if c < 37043554280412588877082384775141 then
                    if c < 37043554280412588877082116339685 then
                      if c = 37043554280412588877080922995189 then .some .spanSelfStart else .none
                    else
                      if c = 37043554280412588877082116339685 then .some .spanSelfXEnd else .none
                  else
                    if c < 37323347835341176979548744203121 then
                      if c = 37043554280412588877082384775141 then .some .spanSelfYEnd else .none
                    else
                      if c = 37323347835341176979548744203121 then .some .tableRowGroup else .none
                else
                  if c < 4092250629111249147468560602035060 then
                    if c < 37667844238869479035671504827237 then
                      if c = 37340987423597462925712245273845 then .some .ThreeDHighlight else .none
                    else
                      if c = 37667844238869479035671504827237 then .some .ultraCondensed else .none
                  else
                    if c < 4293188239932861844810889135191924 then
                      if c = 4092250629111249147468560602035060 then .some .commonLigatures else .none
                    else
                      if c = 4293188239932861844810889135191924 then .some .historicalForms else .none
              else
                if c < 4738115977499159298831029156560117 then
                  if c < 4497913801885504326638294498196966 then
                    if c < 4494707335297746145716107984156646 then
                      if c = 4336912125264616787692607325778662 then .some .isolateOverride else .none
                    else
                      if c = 4494707335297746145716107984156646 then .some .mediumaquamarine else .none
                  else
                    if c < 4538464878923581199531987961560550 then
                      if c = 4497913801885504326638294498196966 then .some .mostInlineSize else .none
                    else
                      if c = 4538464878923581199531987961560550 then .some .nonScalingSize else .none
                else
                  if c < 4741574947872806097072625861310965 then
                    if c < 4738115988660537833912023345838581 then
                      if c = 4738115977499159298831029156560117 then .some .SelectedItemText else .none
                    else
                      if c = 4738115988660537833912023345838581 then .some .selfBlockStart else .none
                  else
                    if c < 4779646390220437790748151536777336 then
                      if c = 4741574947872806097072625861310965 then .some .spanBlockStart else .none
                    else
                      if c = 4779646390220437790748151536777336 then .some .ThreeDDarkShadow else .none
            else
              if c < 554920970021368281837812556668597108 then
                if c < 538975537405858720624002278193019622 then
                  if c < 528758897313167677083063793598706035 then
                    if c < 528758865128835856552826973670159205 then
                      if c = 513303990991148000003687880536685158 then .some .alternateReverse else .none
                    else
                      if c = 528758865128835856552826973670159205 then .some .disclosureClosed else .none
                  else
                    if c < 534108038544487616752606716150855910 then
                      if c = 528758897313167677083063793598706035 then .some .displayP3Linear else .none
                    else
                      if c = 534108038544487616752606716150855910 then .some .embeddedOpentype else .none
                else
                  if c < 554513118162651606132798750182929764 then
                    if c < 538975537405858720628497218654877926 then
                      if c = 538975537405858720624002278193019622 then .some .featuresGraphite else .none
                    else
                      if c = 538975537405858720628497218654877926 then .some .featuresOpentype else .none
                  else
                    if c < 554513118162651606166524896608825958 then
                      if c = 554513118162651606132798750182929764 then .some .ideographNumeric else .none
                    else
                      if c = 554513118162651606166524896608825958 then .some .ideographicSpace else .none
              else
                if c < 606721309486150883707189001918985321 then
                  if c < 591430275398443167577446350508111732 then
                    if c < 575322538918132747865798117305201519 then
                      if c = 554920970021368281837812556668597108 then .some .inlineGridLanes else .none
                    else
                      if c = 575322538918132747865798117305201519 then .some .mediumspringgreen else .none
                  else
                    if c < 606478846549608986780305412335385077 then
                      if c = 591430275398443167577446350508111732 then .some .proportionalNums else .none
                    else
                      if c = 606478846549608986780305412335385077 then .some .selfInlineStart else .none
                else
                  if c < 606921593330279856162113397880044021 then
                    if c < 606921593328779324464862534315850229 then
                      if c = 606721309486150883707189001918985321 then .some .skipLineThrough else .none
                    else
                      if c = 606921593328779324464862534315850229 then .some .spanInlineStart else .none
                  else
                    if c < 606921593330279856162117795926555125 then
                      if c = 606921593330279856162113397880044021 then .some .spanSelfXStart else .none
                    else
                      if c = 606921593330279856162117795926555125 then .some .spanSelfYStart else .none
          else
            if c < 9517515387726119363311318422999013323636 then
              if c < 75655859083946967434041642017265400294 then
                if c < 67680405844801424484733941729527085044 then
                  if c < 642826848318163803573029480943138148 then
                    if c < 611794737948225554941387824434870392 then
                      if c = 607083826569565236495210676487993332 then .some .stackedFractions else .none
                    else
                      if c = 611794737948225554941387824434870392 then .some .ThreeDLightShadow else .none
                  else
                    if c < 67047477065818317724341056439179722214 then
                      if c = 642826848318163803573029480943138148 then .some .zeroIfExtrinsic else .none
                    else
                      if c = 67047477065818317724341056439179722214 then .some .contentBlockSize else .none
                else
                  if c < 74358208576283954373132090765144241766 then
                    if c < 69654048435349283590041404460064487535 then
                      if c = 67680405844801424484733941729527085044 then .some .diagonalFractions else .none
                    else
                      if c = 69654048435349283590041404460064487535 then .some .geometricPrecision else .none
                  else
                    if c < 75028277259973740444023887465383901946 then
                      if c = 74358208576283954373132090765144241766 then .some .nonScalingStroke else .none
                    else
                      if c = 75028277259973740444023887465383901946 then .some .optimizeLegibility else .none
              else
                if c < 78272733559579896822871737232361536369 then
                  if c < 78272733559579153152837242774729014129 then
                    if c < 75703075251000725449913132867428907753 then
                      if c = 75655859083946967434041642017265400294 then .some .pictureInPicture else .none
                    else
                      if c = 75703075251000725449913132867428907753 then .some .proportionalWidth else .none
                  else
                    if c < 78272733559579606527613170769754602353 then
                      if c = 78272733559579153152837242774729014129 then .some .tableColumnGroup else .none
                    else
                      if c = 78272733559579606527613170769754602353 then .some .tableFooterGroup else .none
                else
                  if c < 9091767816088529928707487494100737441013 then
                    if c < 8582077064424744676998030533327714958822 then
                      if c = 78272733559579896822871737232361536369 then .some .tableHeaderGroup else .none
                    else
                      if c = 8582077064424744676998030533327714958822 then .some .contentInlineSize else .none
                  else
                    if c < 9343755255405887847131831152331548440687 then
                      if c = 9091767816088529928707487494100737441013 then .some .InactiveCaptionText else .none
                    else
                      if c = 9343755255405887847131831152331548440687 then .some .literalPunctuation else .none
            else
              if c < 137897458475917551702573394870012541054662630 then
                if c < 1152443942880215178696812687689763962811252 then
                  if c < 9862061501894880362334966429764453921651 then
                    if c < 9862061501850236376380725833696500511603 then
                      if c = 9517515387726119363311318422999013323636 then .some .noCommonLigatures else .none
                    else
                      if c = 9862061501850236376380725833696500511603 then .some .rubyBaseContainer else .none
                  else
                    if c < 9943803385123305163358516091471110191077 then
                      if c = 9862061501894880362334966429764453921651 then .some .rubyTextContainer else .none
                    else
                      if c = 9943803385123305163358516091471110191077 then .some .spanSelfBlockEnd else .none
                else
                  if c < 1272806833295783060909954765765404576561125 then
                    if c < 1195992048369911376804317190591719205992568 then
                      if c = 1152443942880215178696812687689763962811252 then .some .historicalLigatures else .none
                    else
                      if c = 1195992048369911376804317190591719205992568 then .some .lightgoldenrodyellow else .none
                  else
                    if c < 137680022075598409436484477036853543598617956 then
                      if c = 1272806833295783060909954765765404576561125 then .some .spanSelfInlineEnd else .none
                    else
                      if c = 137680022075598409436484477036853543598617956 then .some .absoluteColorimetric else .none
              else
                if c < 20853667156718109669948698882300388586148116981 then
                  if c < 161406626198575755343227585484413434844738916 then
                    if c < 158760006904789018770059526197032536273287283 then
                      if c = 137897458475917551702573394870012541054662630 then .some .avoidShortLastLine else .none
                    else
                      if c = 158760006904789018770059526197032536273287283 then .some .preserveParentColor else .none
                  else
                    if c < 162919274661860231796465927642662673141250549 then
                      if c = 161406626198575755343227585484413434844738916 then .some .relativeColorimetric else .none
                    else
                      if c = 162919274661860231796465927642662673141250549 then .some .spanSelfBlockStart else .none
                else
                  if c < 2554838637030056842851042497317317847928408961908 then
                    if c < 2325506082498969141371320329128550116092274340724 then
                      if c = 20853667156718109669948698882300388586148116981 then .some .spanSelfInlineStart else .none
                    else
                      if c = 2325506082498969141371320329128550116092274340724 then .some .discretionaryLigatures else .none
                  else
                    if c < 5357884865980820567938868412276215274005000666014872436 then
                      if c = 2554838637030056842851042497317317847928408961908 then .some .noHistoricalLigatures else .none
                    else
                      if c = 5357884865980820567938868412276215274005000666014872436 then .some .noDiscretionaryLigatures else .none

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
