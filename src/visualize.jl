function add_buttons!(scene)
    buttongrid = GridLayout(tellwidth=false)
    buttonlabels = ["____________", "Previous", "Next", "Clear"]
    buttons = buttongrid[ 1, 1:length(buttonlabels)] = 
            [Makie.Button(scene, label=l) for l in buttonlabels]
    return buttons
end


function visualize!(calib_data)
    images = calib_data.images
    scene = Scene(camera = campixel!)
    buttons = add_buttons!(scene) 
    index = 1
    frame = Observable(rotr90(images[index]))
    image!(scene, frame) 
    image_title = Observable("image01")
    text!(scene, image_title, position=(587,53), color=:red, space=:data)
    points = Observable(Point2f[])
    scatter!(scene, points, color=:purple)

    on(buttons[2].clicks) do i
        index = index > 1 ? index-1 : index
        frame[] = rotr90(images[index])
        image_title[] = "image0$index"
    end
    on(buttons[3].clicks) do i
        index = index < length(images) ? index+1 : index
        frame[] = rotr90(images[index])
        image_title[] = "image0$index"
    end 
    on(buttons[4].clicks) do i 
        if !isempty(points[])
            pop!(points[])
            points[]=points[] 
        end
        @show length(points[])
    end 
    on(events(scene).mousebutton) do event 
        if event.button == Mouse.left || event.button == Mouse.right
            if event.action == Mouse.press
                mp = events(scene).mouseposition[]
                @show mp
                push!(points[], mp)
                notify(points)
            end
        end
    end
    # on(events(scene).mouseposition) do mp
    #     @show mp
    # end
    display(scene)
    # return scene
end