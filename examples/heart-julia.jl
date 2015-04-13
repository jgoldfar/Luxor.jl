#!/Applications/Julia-0.3.2.app/Contents/Resources/julia/bin/julia

using Luxor, Color

include("./julia-logo.jl")

Drawing(1000, 1000, "/tmp/heart-julia.pdf")
origin()
background(color("white"))

function heart()
    move(127,1)
    curve(134.2, -6.5, 134.2, -6.5, 156.1, -29.6)
    curve(185.8, -60.5, 198.1, -74.3, 213.7, -95.3)
    curve(240.4, -131, 253.3, -163.7, 253.3, -194.9)
    curve(253.3, -218, 246.4, -237.8, 232.6, -253.7)
    curve(219.1, -268.7, 204.1, -275.3, 181.9, -275.3)
    curve(154, -275.3, 136.3, -265.1, 127, -243.8)
    curve(124, -252.5, 120.4, -257.6, 112.9, -263.6)
    curve(103.6, -270.8, 88.3, -275.3, 73.3, -275.3)
    curve(59.2, -275.3, 46, -271.4, 35.2, -264.5)
    curve(14.5, -250.7, 1, -223.4, 1, -194.6)
    curve(1, -167.3, 13, -136.4, 37.3, -101)
    curve(53.8, -77, 86.5, -39.8, 127, 1)
    closepath()
end

function clipheart(x, y)
    save()
    translate(x,y)
    heart()
    clip()
    translate(-50,-300)
    for y in 0:30:500
        save()
        for x in 0:30:250
            translate(30,0)
            save()
                scale(0.1, 0.1)
                julialogo()
            restore()
        end
        restore()
        translate(0,20)
    end
    clipreset()
    restore()
end

setcolor(color("red"))
for y in -200:300:400
    for x in -500:300:350
        clipheart(x,y)
        save()
            translate(x,y)
            heart()
            stroke()
        restore()
    end
end

finish()

preview()