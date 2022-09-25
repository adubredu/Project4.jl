function add_buttons!(fig)
    fig[3, 1] = buttongrid = GridLayout(tellwidth=false)
    buttonlabels = ["Previous", "Next", "Clear"]
    buttons = buttongrid[1, 1:length(buttonlabels)] = 
                [Makie.Button(fig, label=l) for l in buttonlabels]
    return buttons
end

function visualize!(images)
    fig = Figure()
    ax = WGLMakie.Axis(fig[1,1], aspect=DataAspect(),width=1000)#, limits=(-15.,15.,-15.,15.))
    hidedecorations!(ax)
    buttons = add_buttons!(fig) 
    index = 1
    frame = Observable(rotr90(images[index]))
    image!(ax, frame) 
    image_title = Observable("image01")
    Label(fig[2,1], image_title, height=10, width=20)
    points = Observable(Point2f[])
    scatter!(ax, points, color=:purple)

    on(buttons[1].clicks) do i
        index = index > 1 ? index-1 : index
        frame[] = rotr90(images[index])
        image_title[] = "image0$index"
    end
    on(buttons[2].clicks) do i
        index = index < length(images) ? index+1 : index
        frame[] = rotr90(images[index])
        image_title[] = "image0$index"
    end 
    on(buttons[3].clicks) do i
        if !isempty(points[])
            points[] = points[][1:end-1]
        end
    end 
    on(events(ax.scene).mousebutton) do event 
        if event.button == Mouse.left || event.button == Mouse.right
            if event.action == Mouse.press
                mp = events(ax.scene).mouseposition[]
                @show mp
                push!(points[], mp)
                notify(points)
            end
        end
    end
    display(fig)
    return ax
end