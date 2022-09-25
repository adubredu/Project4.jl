function add_buttons!(fig)
    fig[3, 1] = buttongrid = GridLayout(tellwidth=false)
    buttonlabels = ["Previous", "Next"]
    buttons = buttongrid[1, 1:length(buttonlabels)] = 
                [Makie.Button(fig, label=l) for l in buttonlabels]
    return buttons
end

function visualize!(images)
    fig = Figure()
    ax = WGLMakie.Axis(fig[1,1], aspect=DataAspect(),width=1000)#, limits=(-15.,15.,-15.,15.))
    hidedecorations!(ax)
    buttons = add_buttons!(fig)
    labelbutton = 
    index = 1
    frame = Observable(rotr90(images[index]))
    image!(ax, frame) 
    image_title = Observable("image01")
    Label(fig[2,1], image_title, height=10, width=20)
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
    # on(image_title) do image_title 
    #     text!(ax, image_title, position=(500,50), space=:data, color=:red, textsize=20)
    # end

    display(fig)
    return ax
end