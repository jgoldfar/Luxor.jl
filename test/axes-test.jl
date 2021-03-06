#!/usr/bin/env julia

using Luxor

if VERSION >= v"0.5.0-dev+7720"
    using Base.Test
else
    using BaseTestNext
    const Test = BaseTestNext
end

function test_axes(x, y, rot, w)
    gsave()
    translate(x, y)
    rotate(rot)
    box(0, 0, w, w, :clip)
    axes()
    clipreset()
    grestore()
end

fname = "axes-test.pdf"
width, height = 2000, 2000
Drawing(width, height, fname)
origin()
background("ivory")
pagetiles = Tiler(width, height, 5, 5, margin=50)
for (pos, n) in pagetiles
  test_axes(pos.x, pos.y, rand() * 2pi, pagetiles.tilewidth)
end

@test finish() == true
println("...finished test: output in $(fname)")
