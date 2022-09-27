function add_buttons!(scene)
    buttongrid = GridLayout(tellwidth=false)
    buttonlabels = ["____________", "Previous", "Next", "Clear"]
    buttons = buttongrid[ 1, 1:length(buttonlabels)] = 
            [Makie.Button(scene, label=l) for l in buttonlabels]
    return buttons
end

function populate_dicts!(calib_data)
    for i=1:length(calib_data.images)
        name = "image0$i"
        calib_data.image_points[name]=[(0,0)]
        calib_data.viz_image_points[name]=[(0,0)]
    end
end

function rotate_frame(point, offset; θ=π)
    R = [
        1.0  0.0    0.0;
        0.0 cos(θ) -sin(θ);
        0.0 sin(θ) cos(θ)
        ]
    p = [point..., 0]
    tp = R*p 
    tp[2] += offset[2]
    return Tuple(tp[1:2])
end

function visualize!(calib_data; show_name=false)
    populate_dicts!(calib_data)
    images = calib_data.images
    scene = Scene(resolution=reverse(size(images[1])), camera = campixel!)
    buttons = add_buttons!(scene) 
    index = 1
    frame = Observable(rotr90(images[index]))
    image!(scene, frame) 
    image_title = Observable("image01")
    if show_name text!(scene, image_title, position=(587,53), color=:red, space=:data) end
    points = Observable(Point2f[])
    scatter!(scene, points, color=:purple)
    # scatter!(scene, [600],[60], marker=:rect, markersize=(220,50))

    on(buttons[2].clicks) do i
        index = index > 1 ? index-1 : index
        frame[] = rotr90(images[index])
        image_title[] = "image0$index"
        points[] = calib_data.viz_image_points[image_title[]]   
        # image_title[]=image_title[]
        # scatter!(scene, [600],[60], marker=:rect, markersize=(200,100))
        # if show_name text!(scene, image_title, position=(587,53), color=:red, space=:data) end
        
    end

    on(buttons[3].clicks) do i
        index = index < length(images) ? index+1 : index
        frame[] = rotr90(images[index])
        image_title[] = "image0$index"
        points[] = calib_data.viz_image_points[image_title[]] 
        # image_title[]=image_title[]
        # scatter!(scene, [600],[60], marker=:rect, markersize=(200,100))
        # if show_name text!(scene, image_title, position=(587,53), color=:red, space=:data) end

    end 

    on(buttons[4].clicks) do i 
        if !isempty(points[])
            pop!(points[])
            pop!(calib_data.viz_image_points[image_title[]])
            pop!(calib_data.image_points[image_title[]])
            points[]=points[] 
            # notify(points)
        else
            push!(points[], (0,0))
            push!(calib_data.viz_image_points[image_title[]], (0,0))
            push!(calib_data.image_points[image_title[]], (0,0))
            notify(points)
        end
        @show length(points[])
    end 
    on(events(scene).mousebutton) do event 
        if event.button == Mouse.left || event.button == Mouse.right
            if event.action == Mouse.press
                mp = events(scene).mouseposition[]
                offset = size(frame[])
                op = rotate_frame(mp, offset)
                @show op
                push!(points[], mp)
                push!(calib_data.image_points[image_title[]], op)
                push!(calib_data.viz_image_points[image_title[]], mp)
                notify(points)
            end
        end
    end 
    # on(events(scene).mouseposition) do mp
    #     # @show mp
    #     offset = size(frame[])
    #     op = rotate_frame(mp, offset)
    #     @show op
    # end
    on(image_title) do tt 
        scatter!(scene, [620],[60], marker=:rect, markersize=(180,80))
        if show_name text!(scene, image_title, position=(587,53), color=:red, space=:data) end
    end
    on(points) do o
    end
    screen = display(scene)
    # resize!(screen, size(frame[])...)
    # return scene
end