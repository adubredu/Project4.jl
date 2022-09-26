using Suppressor
@suppress begin
    using WGLMakie 
    using FileIO
    using Images
end 
points = Observable(Point2f[])

scene = Scene(camera = campixel!)
image!(scene, rotr90(load("src/images/image01.jpg")))
linesegments!(scene, points, color = :black)
scatter!(scene, points, color = :purple)

# prev_butt = Makie.Button(scene, label="Previous")
# next_butt = Makie.Button(scene, label="Next")
# clear_butt = Makie.Button(scene, label="Clear")
# subwindow = Scene(scene, px_area=Rect(100, 100, 200, 200), clear=true, backgroundcolor=:white)

buttongrid = GridLayout(tellwidth=false)
buttonlabels = ["____________", "Previous", "Next", "Clear"]
buttons = buttongrid[1, 1:length(buttonlabels)] = 
            [Makie.Button(scene, label=l) for l in buttonlabels]

on(events(scene).mousebutton) do event
    if event.button == Mouse.left && event.action == Mouse.press
        mp = events(scene).mouseposition[]
        @show mp
        push!(points[], mp, mp)
        notify(points)
    end
end

# on(events(scene).mouseposition) do mp
#     mb = events(scene).mousebutton[]
#     if mb.button == Mouse.left && (mb.action == Mouse.press || mb.action == Mouse.repeat)
#         points[][end] = mp
#         notify(points)
#     end
# end

display(scene)