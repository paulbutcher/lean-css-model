/-
Copyright (c) 2026 Paul Butcher. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import CssModel
meta import CssModelBench.Timing

/-! A stylesheet of 85 rules and 425 declarations, of the properties sites use most. -/

namespace CssModelBench.Stylesheet

open CssModel

def cls (name : String) (h : name.isEmpty = false := by decide +kernel) : SelectorList :=
  .one (.last (Compound.of none [.cls ⟨name, h⟩]))

#bench "425 declarations in 85 rules"
  def sheet : Stylesheet := { rules := [
    .style (cls "c1") [
      .decl (decl .display [kw .flex]),
      .decl (decl .display [kw .block]),
      .decl (decl .display [kw .grid]),
      .decl (decl .display [kw .none]),
      .decl (decl .display [kw .inlineBlock])
    ],
    .style (cls "c2") [
      .decl (decl .position [kw .relative]),
      .decl (decl .position [kw .absolute]),
      .decl (decl .position [kw .sticky]),
      .decl (decl .top [px 0]),
      .decl (decl .left [zero])
    ],
    .style (cls "c3") [
      .decl (decl .right [rem 1]),
      .decl (decl .bottom [pct 50]),
      .decl (decl .color [kw .white]),
      .decl (decl .color [hex "333"]),
      .decl (decl .color [hex "1a73e8"])
    ],
    .style (cls "c4") [
      .decl (decl .color [fn .rgb [num 255, num 0, num 0]]),
      .decl (decl .color [kw .currentColor]),
      .decl (decl .backgroundColor [hex "f8f9fa"]),
      .decl (decl .backgroundColor [kw .transparent]),
      .decl (decl .backgroundColor [fn .rgb [num 0, num 0, num 0, slash, num 0.5]])
    ],
    .style (cls "c5") [
      .decl (decl .margin [px 0, kw .auto]),
      .decl (decl .margin [zero]),
      .decl (decl .margin [rem 1, rem 2]),
      .decl (decl .marginTop [em 1.5]),
      .decl (decl .marginBottom [px 16])
    ],
    .style (cls "c6") [
      .decl (decl .padding [px 8, px 16]),
      .decl (decl .padding [rem 0.5]),
      .decl (decl .paddingLeft [px 24]),
      .decl (decl .paddingInline [rem 1]),
      .decl (decl .width [pct 100])
    ],
    .style (cls "c7") [
      .decl (decl .width [px 320]),
      .decl (decl .width [kw .auto]),
      .decl (decl .maxWidth [px 1200]),
      .decl (decl .minHeight [vh 100]),
      .decl (decl .height [kw .fitContent])
    ],
    .style (cls "c8") [
      .decl (decl .fontSize [rem 1.125]),
      .decl (decl .fontSize [px 14]),
      .decl (decl .fontSize [kw .small]),
      .decl (decl .fontWeight [num 700]),
      .decl (decl .fontWeight [kw .bold])
    ],
    .style (cls "c9") [
      .decl (decl .fontFamily [str "Inter", comma, kw .sansSerif]),
      .decl (decl .fontFamily [kw .systemUi, comma, kw .serif]),
      .decl (decl .lineHeight [num 1.5]),
      .decl (decl .lineHeight [px 24]),
      .decl (decl .textAlign [kw .center])
    ],
    .style (cls "c10") [
      .decl (decl .textDecoration [kw .none]),
      .decl (decl .textTransform [kw .uppercase]),
      .decl (decl .letterSpacing [em 0.05]),
      .decl (decl .border [px 1, kw .solid, hex "ddd"]),
      .decl (decl .border [kw .none])
    ],
    .style (cls "c11") [
      .decl (decl .borderBottom [px 2, kw .dashed, kw .red]),
      .decl (decl .borderRadius [px 4]),
      .decl (decl .borderRadius [pct 50]),
      .decl (decl .borderRadius [px 8, px 8, zero, zero]),
      .decl (decl .boxShadow [zero, px 1, px 3, fn .rgb [num 0, num 0, num 0, slash, num 0.2]])
    ],
    .style (cls "c12") [
      .decl (decl .boxSizing [kw .borderBox]),
      .decl (decl .opacity [num 0.8]),
      .decl (decl .zIndex [int 10]),
      .decl (decl .overflow [kw .hidden]),
      .decl (decl .overflowX [kw .auto])
    ],
    .style (cls "c13") [
      .decl (decl .cursor [kw .pointer]),
      .decl (decl .flexDirection [kw .column]),
      .decl (decl .justifyContent [kw .spaceBetween]),
      .decl (decl .alignItems [kw .center]),
      .decl (decl .gap [px 12])
    ],
    .style (cls "c14") [
      .decl (decl .gap [rem 1, rem 2]),
      .decl (decl .flex [num 1]),
      .decl (decl .flex [num 1, num 1, px 0]),
      .decl (decl .flexWrap [kw .wrap]),
      .decl (decl .gridTemplateColumns [fn .trackRepeat [int 3, comma, fr 1]])
    ],
    .style (cls "c15") [
      .decl (decl .transition [ident "opacity", sec 0.2, kw .easeInOut]),
      .decl (decl .transition [kw .all, ms 150, kw .ease]),
      .decl (decl .transform [fn .translateX [pct 50]]),
      .decl (decl .transform [fn .rotate [deg 45]]),
      .decl (decl .animation [ident "spin", sec 1, kw .linear, kw .infinite])
    ],
    .style (cls "c16") [
      .decl (decl .outline [px 2, kw .solid, kw .blue]),
      .decl (decl .visibility [kw .hidden]),
      .decl (decl .whiteSpace [kw .nowrap]),
      .decl (decl .listStyle [kw .none]),
      .decl (decl .content [str ""])
    ],
    .style (cls "c17") [
      .decl (decl .verticalAlign [kw .middle]),
      .decl (decl .objectFit [kw .cover]),
      .decl (decl .pointerEvents [kw .none]),
      .decl (decl .userSelect [kw .none]),
      .decl (decl .display [kw .flex])
    ],
    .style (cls "c18") [
      .decl (decl .display [kw .block]),
      .decl (decl .display [kw .grid]),
      .decl (decl .display [kw .none]),
      .decl (decl .display [kw .inlineBlock]),
      .decl (decl .position [kw .relative])
    ],
    .style (cls "c19") [
      .decl (decl .position [kw .absolute]),
      .decl (decl .position [kw .sticky]),
      .decl (decl .top [px 0]),
      .decl (decl .left [zero]),
      .decl (decl .right [rem 1])
    ],
    .style (cls "c20") [
      .decl (decl .bottom [pct 50]),
      .decl (decl .color [kw .white]),
      .decl (decl .color [hex "333"]),
      .decl (decl .color [hex "1a73e8"]),
      .decl (decl .color [fn .rgb [num 255, num 0, num 0]])
    ],
    .style (cls "c21") [
      .decl (decl .color [kw .currentColor]),
      .decl (decl .backgroundColor [hex "f8f9fa"]),
      .decl (decl .backgroundColor [kw .transparent]),
      .decl (decl .backgroundColor [fn .rgb [num 0, num 0, num 0, slash, num 0.5]]),
      .decl (decl .margin [px 0, kw .auto])
    ],
    .style (cls "c22") [
      .decl (decl .margin [zero]),
      .decl (decl .margin [rem 1, rem 2]),
      .decl (decl .marginTop [em 1.5]),
      .decl (decl .marginBottom [px 16]),
      .decl (decl .padding [px 8, px 16])
    ],
    .style (cls "c23") [
      .decl (decl .padding [rem 0.5]),
      .decl (decl .paddingLeft [px 24]),
      .decl (decl .paddingInline [rem 1]),
      .decl (decl .width [pct 100]),
      .decl (decl .width [px 320])
    ],
    .style (cls "c24") [
      .decl (decl .width [kw .auto]),
      .decl (decl .maxWidth [px 1200]),
      .decl (decl .minHeight [vh 100]),
      .decl (decl .height [kw .fitContent]),
      .decl (decl .fontSize [rem 1.125])
    ],
    .style (cls "c25") [
      .decl (decl .fontSize [px 14]),
      .decl (decl .fontSize [kw .small]),
      .decl (decl .fontWeight [num 700]),
      .decl (decl .fontWeight [kw .bold]),
      .decl (decl .fontFamily [str "Inter", comma, kw .sansSerif])
    ],
    .style (cls "c26") [
      .decl (decl .fontFamily [kw .systemUi, comma, kw .serif]),
      .decl (decl .lineHeight [num 1.5]),
      .decl (decl .lineHeight [px 24]),
      .decl (decl .textAlign [kw .center]),
      .decl (decl .textDecoration [kw .none])
    ],
    .style (cls "c27") [
      .decl (decl .textTransform [kw .uppercase]),
      .decl (decl .letterSpacing [em 0.05]),
      .decl (decl .border [px 1, kw .solid, hex "ddd"]),
      .decl (decl .border [kw .none]),
      .decl (decl .borderBottom [px 2, kw .dashed, kw .red])
    ],
    .style (cls "c28") [
      .decl (decl .borderRadius [px 4]),
      .decl (decl .borderRadius [pct 50]),
      .decl (decl .borderRadius [px 8, px 8, zero, zero]),
      .decl (decl .boxShadow [zero, px 1, px 3, fn .rgb [num 0, num 0, num 0, slash, num 0.2]]),
      .decl (decl .boxSizing [kw .borderBox])
    ],
    .style (cls "c29") [
      .decl (decl .opacity [num 0.8]),
      .decl (decl .zIndex [int 10]),
      .decl (decl .overflow [kw .hidden]),
      .decl (decl .overflowX [kw .auto]),
      .decl (decl .cursor [kw .pointer])
    ],
    .style (cls "c30") [
      .decl (decl .flexDirection [kw .column]),
      .decl (decl .justifyContent [kw .spaceBetween]),
      .decl (decl .alignItems [kw .center]),
      .decl (decl .gap [px 12]),
      .decl (decl .gap [rem 1, rem 2])
    ],
    .style (cls "c31") [
      .decl (decl .flex [num 1]),
      .decl (decl .flex [num 1, num 1, px 0]),
      .decl (decl .flexWrap [kw .wrap]),
      .decl (decl .gridTemplateColumns [fn .trackRepeat [int 3, comma, fr 1]]),
      .decl (decl .transition [ident "opacity", sec 0.2, kw .easeInOut])
    ],
    .style (cls "c32") [
      .decl (decl .transition [kw .all, ms 150, kw .ease]),
      .decl (decl .transform [fn .translateX [pct 50]]),
      .decl (decl .transform [fn .rotate [deg 45]]),
      .decl (decl .animation [ident "spin", sec 1, kw .linear, kw .infinite]),
      .decl (decl .outline [px 2, kw .solid, kw .blue])
    ],
    .style (cls "c33") [
      .decl (decl .visibility [kw .hidden]),
      .decl (decl .whiteSpace [kw .nowrap]),
      .decl (decl .listStyle [kw .none]),
      .decl (decl .content [str ""]),
      .decl (decl .verticalAlign [kw .middle])
    ],
    .style (cls "c34") [
      .decl (decl .objectFit [kw .cover]),
      .decl (decl .pointerEvents [kw .none]),
      .decl (decl .userSelect [kw .none]),
      .decl (decl .display [kw .flex]),
      .decl (decl .display [kw .block])
    ],
    .style (cls "c35") [
      .decl (decl .display [kw .grid]),
      .decl (decl .display [kw .none]),
      .decl (decl .display [kw .inlineBlock]),
      .decl (decl .position [kw .relative]),
      .decl (decl .position [kw .absolute])
    ],
    .style (cls "c36") [
      .decl (decl .position [kw .sticky]),
      .decl (decl .top [px 0]),
      .decl (decl .left [zero]),
      .decl (decl .right [rem 1]),
      .decl (decl .bottom [pct 50])
    ],
    .style (cls "c37") [
      .decl (decl .color [kw .white]),
      .decl (decl .color [hex "333"]),
      .decl (decl .color [hex "1a73e8"]),
      .decl (decl .color [fn .rgb [num 255, num 0, num 0]]),
      .decl (decl .color [kw .currentColor])
    ],
    .style (cls "c38") [
      .decl (decl .backgroundColor [hex "f8f9fa"]),
      .decl (decl .backgroundColor [kw .transparent]),
      .decl (decl .backgroundColor [fn .rgb [num 0, num 0, num 0, slash, num 0.5]]),
      .decl (decl .margin [px 0, kw .auto]),
      .decl (decl .margin [zero])
    ],
    .style (cls "c39") [
      .decl (decl .margin [rem 1, rem 2]),
      .decl (decl .marginTop [em 1.5]),
      .decl (decl .marginBottom [px 16]),
      .decl (decl .padding [px 8, px 16]),
      .decl (decl .padding [rem 0.5])
    ],
    .style (cls "c40") [
      .decl (decl .paddingLeft [px 24]),
      .decl (decl .paddingInline [rem 1]),
      .decl (decl .width [pct 100]),
      .decl (decl .width [px 320]),
      .decl (decl .width [kw .auto])
    ],
    .style (cls "c41") [
      .decl (decl .maxWidth [px 1200]),
      .decl (decl .minHeight [vh 100]),
      .decl (decl .height [kw .fitContent]),
      .decl (decl .fontSize [rem 1.125]),
      .decl (decl .fontSize [px 14])
    ],
    .style (cls "c42") [
      .decl (decl .fontSize [kw .small]),
      .decl (decl .fontWeight [num 700]),
      .decl (decl .fontWeight [kw .bold]),
      .decl (decl .fontFamily [str "Inter", comma, kw .sansSerif]),
      .decl (decl .fontFamily [kw .systemUi, comma, kw .serif])
    ],
    .style (cls "c43") [
      .decl (decl .lineHeight [num 1.5]),
      .decl (decl .lineHeight [px 24]),
      .decl (decl .textAlign [kw .center]),
      .decl (decl .textDecoration [kw .none]),
      .decl (decl .textTransform [kw .uppercase])
    ],
    .style (cls "c44") [
      .decl (decl .letterSpacing [em 0.05]),
      .decl (decl .border [px 1, kw .solid, hex "ddd"]),
      .decl (decl .border [kw .none]),
      .decl (decl .borderBottom [px 2, kw .dashed, kw .red]),
      .decl (decl .borderRadius [px 4])
    ],
    .style (cls "c45") [
      .decl (decl .borderRadius [pct 50]),
      .decl (decl .borderRadius [px 8, px 8, zero, zero]),
      .decl (decl .boxShadow [zero, px 1, px 3, fn .rgb [num 0, num 0, num 0, slash, num 0.2]]),
      .decl (decl .boxSizing [kw .borderBox]),
      .decl (decl .opacity [num 0.8])
    ],
    .style (cls "c46") [
      .decl (decl .zIndex [int 10]),
      .decl (decl .overflow [kw .hidden]),
      .decl (decl .overflowX [kw .auto]),
      .decl (decl .cursor [kw .pointer]),
      .decl (decl .flexDirection [kw .column])
    ],
    .style (cls "c47") [
      .decl (decl .justifyContent [kw .spaceBetween]),
      .decl (decl .alignItems [kw .center]),
      .decl (decl .gap [px 12]),
      .decl (decl .gap [rem 1, rem 2]),
      .decl (decl .flex [num 1])
    ],
    .style (cls "c48") [
      .decl (decl .flex [num 1, num 1, px 0]),
      .decl (decl .flexWrap [kw .wrap]),
      .decl (decl .gridTemplateColumns [fn .trackRepeat [int 3, comma, fr 1]]),
      .decl (decl .transition [ident "opacity", sec 0.2, kw .easeInOut]),
      .decl (decl .transition [kw .all, ms 150, kw .ease])
    ],
    .style (cls "c49") [
      .decl (decl .transform [fn .translateX [pct 50]]),
      .decl (decl .transform [fn .rotate [deg 45]]),
      .decl (decl .animation [ident "spin", sec 1, kw .linear, kw .infinite]),
      .decl (decl .outline [px 2, kw .solid, kw .blue]),
      .decl (decl .visibility [kw .hidden])
    ],
    .style (cls "c50") [
      .decl (decl .whiteSpace [kw .nowrap]),
      .decl (decl .listStyle [kw .none]),
      .decl (decl .content [str ""]),
      .decl (decl .verticalAlign [kw .middle]),
      .decl (decl .objectFit [kw .cover])
    ],
    .style (cls "c51") [
      .decl (decl .pointerEvents [kw .none]),
      .decl (decl .userSelect [kw .none]),
      .decl (decl .display [kw .flex]),
      .decl (decl .display [kw .block]),
      .decl (decl .display [kw .grid])
    ],
    .style (cls "c52") [
      .decl (decl .display [kw .none]),
      .decl (decl .display [kw .inlineBlock]),
      .decl (decl .position [kw .relative]),
      .decl (decl .position [kw .absolute]),
      .decl (decl .position [kw .sticky])
    ],
    .style (cls "c53") [
      .decl (decl .top [px 0]),
      .decl (decl .left [zero]),
      .decl (decl .right [rem 1]),
      .decl (decl .bottom [pct 50]),
      .decl (decl .color [kw .white])
    ],
    .style (cls "c54") [
      .decl (decl .color [hex "333"]),
      .decl (decl .color [hex "1a73e8"]),
      .decl (decl .color [fn .rgb [num 255, num 0, num 0]]),
      .decl (decl .color [kw .currentColor]),
      .decl (decl .backgroundColor [hex "f8f9fa"])
    ],
    .style (cls "c55") [
      .decl (decl .backgroundColor [kw .transparent]),
      .decl (decl .backgroundColor [fn .rgb [num 0, num 0, num 0, slash, num 0.5]]),
      .decl (decl .margin [px 0, kw .auto]),
      .decl (decl .margin [zero]),
      .decl (decl .margin [rem 1, rem 2])
    ],
    .style (cls "c56") [
      .decl (decl .marginTop [em 1.5]),
      .decl (decl .marginBottom [px 16]),
      .decl (decl .padding [px 8, px 16]),
      .decl (decl .padding [rem 0.5]),
      .decl (decl .paddingLeft [px 24])
    ],
    .style (cls "c57") [
      .decl (decl .paddingInline [rem 1]),
      .decl (decl .width [pct 100]),
      .decl (decl .width [px 320]),
      .decl (decl .width [kw .auto]),
      .decl (decl .maxWidth [px 1200])
    ],
    .style (cls "c58") [
      .decl (decl .minHeight [vh 100]),
      .decl (decl .height [kw .fitContent]),
      .decl (decl .fontSize [rem 1.125]),
      .decl (decl .fontSize [px 14]),
      .decl (decl .fontSize [kw .small])
    ],
    .style (cls "c59") [
      .decl (decl .fontWeight [num 700]),
      .decl (decl .fontWeight [kw .bold]),
      .decl (decl .fontFamily [str "Inter", comma, kw .sansSerif]),
      .decl (decl .fontFamily [kw .systemUi, comma, kw .serif]),
      .decl (decl .lineHeight [num 1.5])
    ],
    .style (cls "c60") [
      .decl (decl .lineHeight [px 24]),
      .decl (decl .textAlign [kw .center]),
      .decl (decl .textDecoration [kw .none]),
      .decl (decl .textTransform [kw .uppercase]),
      .decl (decl .letterSpacing [em 0.05])
    ],
    .style (cls "c61") [
      .decl (decl .border [px 1, kw .solid, hex "ddd"]),
      .decl (decl .border [kw .none]),
      .decl (decl .borderBottom [px 2, kw .dashed, kw .red]),
      .decl (decl .borderRadius [px 4]),
      .decl (decl .borderRadius [pct 50])
    ],
    .style (cls "c62") [
      .decl (decl .borderRadius [px 8, px 8, zero, zero]),
      .decl (decl .boxShadow [zero, px 1, px 3, fn .rgb [num 0, num 0, num 0, slash, num 0.2]]),
      .decl (decl .boxSizing [kw .borderBox]),
      .decl (decl .opacity [num 0.8]),
      .decl (decl .zIndex [int 10])
    ],
    .style (cls "c63") [
      .decl (decl .overflow [kw .hidden]),
      .decl (decl .overflowX [kw .auto]),
      .decl (decl .cursor [kw .pointer]),
      .decl (decl .flexDirection [kw .column]),
      .decl (decl .justifyContent [kw .spaceBetween])
    ],
    .style (cls "c64") [
      .decl (decl .alignItems [kw .center]),
      .decl (decl .gap [px 12]),
      .decl (decl .gap [rem 1, rem 2]),
      .decl (decl .flex [num 1]),
      .decl (decl .flex [num 1, num 1, px 0])
    ],
    .style (cls "c65") [
      .decl (decl .flexWrap [kw .wrap]),
      .decl (decl .gridTemplateColumns [fn .trackRepeat [int 3, comma, fr 1]]),
      .decl (decl .transition [ident "opacity", sec 0.2, kw .easeInOut]),
      .decl (decl .transition [kw .all, ms 150, kw .ease]),
      .decl (decl .transform [fn .translateX [pct 50]])
    ],
    .style (cls "c66") [
      .decl (decl .transform [fn .rotate [deg 45]]),
      .decl (decl .animation [ident "spin", sec 1, kw .linear, kw .infinite]),
      .decl (decl .outline [px 2, kw .solid, kw .blue]),
      .decl (decl .visibility [kw .hidden]),
      .decl (decl .whiteSpace [kw .nowrap])
    ],
    .style (cls "c67") [
      .decl (decl .listStyle [kw .none]),
      .decl (decl .content [str ""]),
      .decl (decl .verticalAlign [kw .middle]),
      .decl (decl .objectFit [kw .cover]),
      .decl (decl .pointerEvents [kw .none])
    ],
    .style (cls "c68") [
      .decl (decl .userSelect [kw .none]),
      .decl (decl .display [kw .flex]),
      .decl (decl .display [kw .block]),
      .decl (decl .display [kw .grid]),
      .decl (decl .display [kw .none])
    ],
    .style (cls "c69") [
      .decl (decl .display [kw .inlineBlock]),
      .decl (decl .position [kw .relative]),
      .decl (decl .position [kw .absolute]),
      .decl (decl .position [kw .sticky]),
      .decl (decl .top [px 0])
    ],
    .style (cls "c70") [
      .decl (decl .left [zero]),
      .decl (decl .right [rem 1]),
      .decl (decl .bottom [pct 50]),
      .decl (decl .color [kw .white]),
      .decl (decl .color [hex "333"])
    ],
    .style (cls "c71") [
      .decl (decl .color [hex "1a73e8"]),
      .decl (decl .color [fn .rgb [num 255, num 0, num 0]]),
      .decl (decl .color [kw .currentColor]),
      .decl (decl .backgroundColor [hex "f8f9fa"]),
      .decl (decl .backgroundColor [kw .transparent])
    ],
    .style (cls "c72") [
      .decl (decl .backgroundColor [fn .rgb [num 0, num 0, num 0, slash, num 0.5]]),
      .decl (decl .margin [px 0, kw .auto]),
      .decl (decl .margin [zero]),
      .decl (decl .margin [rem 1, rem 2]),
      .decl (decl .marginTop [em 1.5])
    ],
    .style (cls "c73") [
      .decl (decl .marginBottom [px 16]),
      .decl (decl .padding [px 8, px 16]),
      .decl (decl .padding [rem 0.5]),
      .decl (decl .paddingLeft [px 24]),
      .decl (decl .paddingInline [rem 1])
    ],
    .style (cls "c74") [
      .decl (decl .width [pct 100]),
      .decl (decl .width [px 320]),
      .decl (decl .width [kw .auto]),
      .decl (decl .maxWidth [px 1200]),
      .decl (decl .minHeight [vh 100])
    ],
    .style (cls "c75") [
      .decl (decl .height [kw .fitContent]),
      .decl (decl .fontSize [rem 1.125]),
      .decl (decl .fontSize [px 14]),
      .decl (decl .fontSize [kw .small]),
      .decl (decl .fontWeight [num 700])
    ],
    .style (cls "c76") [
      .decl (decl .fontWeight [kw .bold]),
      .decl (decl .fontFamily [str "Inter", comma, kw .sansSerif]),
      .decl (decl .fontFamily [kw .systemUi, comma, kw .serif]),
      .decl (decl .lineHeight [num 1.5]),
      .decl (decl .lineHeight [px 24])
    ],
    .style (cls "c77") [
      .decl (decl .textAlign [kw .center]),
      .decl (decl .textDecoration [kw .none]),
      .decl (decl .textTransform [kw .uppercase]),
      .decl (decl .letterSpacing [em 0.05]),
      .decl (decl .border [px 1, kw .solid, hex "ddd"])
    ],
    .style (cls "c78") [
      .decl (decl .border [kw .none]),
      .decl (decl .borderBottom [px 2, kw .dashed, kw .red]),
      .decl (decl .borderRadius [px 4]),
      .decl (decl .borderRadius [pct 50]),
      .decl (decl .borderRadius [px 8, px 8, zero, zero])
    ],
    .style (cls "c79") [
      .decl (decl .boxShadow [zero, px 1, px 3, fn .rgb [num 0, num 0, num 0, slash, num 0.2]]),
      .decl (decl .boxSizing [kw .borderBox]),
      .decl (decl .opacity [num 0.8]),
      .decl (decl .zIndex [int 10]),
      .decl (decl .overflow [kw .hidden])
    ],
    .style (cls "c80") [
      .decl (decl .overflowX [kw .auto]),
      .decl (decl .cursor [kw .pointer]),
      .decl (decl .flexDirection [kw .column]),
      .decl (decl .justifyContent [kw .spaceBetween]),
      .decl (decl .alignItems [kw .center])
    ],
    .style (cls "c81") [
      .decl (decl .gap [px 12]),
      .decl (decl .gap [rem 1, rem 2]),
      .decl (decl .flex [num 1]),
      .decl (decl .flex [num 1, num 1, px 0]),
      .decl (decl .flexWrap [kw .wrap])
    ],
    .style (cls "c82") [
      .decl (decl .gridTemplateColumns [fn .trackRepeat [int 3, comma, fr 1]]),
      .decl (decl .transition [ident "opacity", sec 0.2, kw .easeInOut]),
      .decl (decl .transition [kw .all, ms 150, kw .ease]),
      .decl (decl .transform [fn .translateX [pct 50]]),
      .decl (decl .transform [fn .rotate [deg 45]])
    ],
    .style (cls "c83") [
      .decl (decl .animation [ident "spin", sec 1, kw .linear, kw .infinite]),
      .decl (decl .outline [px 2, kw .solid, kw .blue]),
      .decl (decl .visibility [kw .hidden]),
      .decl (decl .whiteSpace [kw .nowrap]),
      .decl (decl .listStyle [kw .none])
    ],
    .style (cls "c84") [
      .decl (decl .content [str ""]),
      .decl (decl .verticalAlign [kw .middle]),
      .decl (decl .objectFit [kw .cover]),
      .decl (decl .pointerEvents [kw .none]),
      .decl (decl .userSelect [kw .none])
    ],
    .style (cls "c85") [
      .decl (decl .display [kw .flex]),
      .decl (decl .display [kw .block]),
      .decl (decl .display [kw .grid]),
      .decl (decl .display [kw .none]),
      .decl (decl .display [kw .inlineBlock])
    ]
  ] }

end CssModelBench.Stylesheet
