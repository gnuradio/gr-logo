#set page(
  background: image("template.svg"),
  width: 5.0in,
  height: 4.0in,
  margin: (
    top: 1.48in,
    left: 0.75in,
    right: 0.75in,
  ),
)
// I think that's the windows font name
#set text(font: "Avenir Next LT Pro", size: 24pt, fill: white)
#set par(leading: 0.25em)
#let badge(name, handle: "", affiliation: "") = {
  align(center)[#line(length: 100%, stroke: gradient.linear(
    (white.transparentize(100%), 0%),
    (white, 10%),
    (white, 25%),
    (white.transparentize(100%), 100%),
  ))]
  v(-2.0em)
  align(left)[#text([#name], weight: "extrabold")]
  v(-1em)
  align(right)[
    #text([#handle], size: 18pt, weight: "regular")
  ]
  v(-0.5em)
  //  place(top+left, dy:0.85in, text(affiliation, size: 14pt))
  place(bottom + left, dy: -1.3in - 14pt, text(affiliation, size: 14pt))
  pagebreak(weak: true)
}
#let processed = json("lists/latest.json")
#for (name, handle, affiliation) in processed.list [
  #badge(name, handle: handle, affiliation: affiliation)
]

#let rest-pages = state("rest-pages", 0)
#context {
  let curpage = here().page()
  rest-pages.update(processed.total_pages - curpage)
}
#context [
  #for _ in range(rest-pages.final() + 1) [
    #pagebreak()
  ]
]

