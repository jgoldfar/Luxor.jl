# Styling

## Color and opacity

For color definitions and conversions, use Colors.jl.

`setcolor()` and `sethue()` apply a single solid or transparent color to shapes. `setblend()` applies a smooth transition between two or more colors.

The difference between the `setcolor()` and `sethue()` functions is that `sethue()` is independent of alpha opacity, so you can change the hue without changing the current opacity value.

```@docs
sethue
setcolor
setblend
setopacity
randomhue
randomcolor
```

## Styles

The `set-` functions control subsequent lines' width, end shapes, join behavior, and dash pattern:

```@example
using Luxor # hide
Drawing(400, 250, "../figures/line-ends.png") # hide
background("white") # hide
origin() # hide
translate(-100, -60) # hide
fontsize(18) # hide
for l in 1:3
  sethue("black")
  setline(20)
  setlinecap(["butt", "square", "round"][l])
  textcentred(["butt", "square", "round"][l], 80l, 80)
  setlinejoin(["round", "miter", "bevel"][l])
  textcentred(["round", "miter", "bevel"][l], 80l, 120)
  poly(ngon(Point(80l, 0), 20, 3, 0, vertices=true), :strokepreserve, close=false)
  sethue("white")
  setline(1)
  stroke()
end
finish() # hide
```

![line endings](figures/line-ends.png)

```@example
using Luxor # hide
Drawing(600, 250, "../figures/dashes.png") # hide
background("white") # hide
origin() # hide
fontsize(14) # hide
sethue("black") # hide
setline(12)
patterns = ["solid", "dotted", "dot", "dotdashed", "longdashed",
  "shortdashed", "dash", "dashed", "dotdotdashed", "dotdotdotdashed"]
tiles =  Tiler(400, 250, 10, 1, margin=10)
for (pos, n) in tiles
  setdash(patterns[n])
  textright(patterns[n], pos.x - 20, pos.y + 4)
  line(pos, Point(400, pos.y), :stroke)
end
finish() # hide
```
![dashes](figures/dashes.png)

```@docs
setline
setlinecap
setlinejoin
setdash
fillstroke
stroke
fill
strokepreserve
fillpreserve
paint
do_action
```

## Blends

A blend is a color gradient. Use `setblend()` to select a blend like you'd use `setcolor()` and `sethue()` to select a solid color.

You can make linear or radial blends. Use `blend()` in either case.

To create a simple linear blend between two colors, supply two points and two colors to `blend()`:

```@example
using Luxor # hide
Drawing(600, 200, "../figures/color-blends-basic.png") # hide
origin() # hide
background("white") # hide
orangeblue = blend(Point(-200, 0), Point(200, 0), "orange", "blue")
setblend(orangeblue)
box(O, 400, 100, :fill)
finish() # hide
finish() # hide
```

![linear blend](figures/color-blends-basic.png)

And for a radial blend, provide a two point/radius pairs, and two colors:

```@example
using Luxor # hide
Drawing(600, 200, "../figures/color-blends-radial.png") # hide
origin() # hide
background("white") # hide
greenmagenta = blend(Point(0, 0), 5, Point(0, 0), 150, "green", "magenta")
setblend(greenmagenta)
box(O, 400, 200, :fill)
finish() # hide
```
![radial blends](figures/color-blends-radial.png)

You can also use `blend()` to create an empty blend. Then you use `addstop()` to define the locations of specific colors along the blend, where `0` is the start, and `1` is the end.

```@example
using Luxor # hide
Drawing(600, 200, "../figures/color-blends-scratch.png") # hide
origin() # hide
background("white") # hide
goldblend = blend(Point(-200, 0), Point(200, 0))
addstop(goldblend, 0.0,   "gold4")
addstop(goldblend, 0.25,  "gold1")
addstop(goldblend, 0.5,   "gold3")
addstop(goldblend, 0.75,  "darkgoldenrod4")
addstop(goldblend, 0.75,  "gold2")
setblend(goldblend)
box(O, 400, 200, :fill)
finish() # hide
```
![blends from scratch](figures/color-blends-scratch.png)

When you define blends, the location of the axes (eg the current workspace as defined by `translate()`, etc.), is important. In the first example, the blend is selected before the axes are moved with `translate(pos)`.

```@example
using Luxor # hide
Drawing(600, 200, "../figures/color-blends-translate-1.png") # hide
origin() # hide
background("white") # hide
goldblend = blend(Point(0, 0), Point(200, 0))
addstop(goldblend, 0.0,   "gold4")
addstop(goldblend, 0.25,  "gold1")
addstop(goldblend, 0.5,   "gold3")
addstop(goldblend, 0.75,  "darkgoldenrod4")
addstop(goldblend, 0.75,  "gold2")
setblend(goldblend)
tiles = Tiler(600, 200, 1, 5, margin=10)
for (pos, n) in tiles
    gsave()
    setblend(goldblend)
    translate(pos)
    ellipse(O, tiles.tilewidth, tiles.tilewidth, :fill)
    grestore()
end
```
![blends 1](figures/color-blends-translate-1.png)

But in this example, the blend is relocated to the current axes, which have just been moved to the center of the shape:

```@example
using Luxor # hide
Drawing(600, 200, "../figures/color-blends-translate-2.png") # hide
origin() # hide
background("white") # hide
goldblend = blend(Point(0, 0), Point(200, 0))
addstop(goldblend, 0.0,   "gold4")
addstop(goldblend, 0.25,  "gold1")
addstop(goldblend, 0.5,   "gold3")
addstop(goldblend, 0.75,  "darkgoldenrod4")
addstop(goldblend, 0.75,  "gold2")
setblend(goldblend)
tiles = Tiler(600, 200, 1, 5, margin=10)
for (pos, n) in tiles
    gsave()
    translate(pos)
    setblend(goldblend)
    ellipse(O, tiles.tilewidth, tiles.tilewidth, :fill)
    grestore()
end
```
![blends 2](figures/color-blends-translate-2.png)

```@docs
blend
```