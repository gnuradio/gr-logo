#set page(
  background: image("template.svg"), 
  width: 5.0in,
  height:4.0in,
  margin: (
  top:1.03725in, 
  left: 0.77in, 
  right: 5in-0.25in-0.455in-3.36in+0.06in
)
)
// I think that's the windows font name
#set text(font:"Avenir Next LT Pro", size: 16pt)
#set par(leading: 0.25em)
#let badge(name, handle:"", affiliation:"") = {
  align(center)[#text([#name], size:20pt, weight: "bold")]
  v(-1em)
  align(center)[#line(length:100%)]
  v(-0.8em)
  align(right)[#handle]
  v(-0.5em)
//  place(top+left, dy:0.85in, text(affiliation, size: 14pt))
  place(bottom+left, dy:-1.3in-14pt, text(affiliation, size: 14pt))
  pagebreak(weak:true)
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

