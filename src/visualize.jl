function add_buttons!(fig)
    fig[2, 1] = buttongrid = GridLayout(tellwidth=false)
    buttonlabels = ["Previous", "Next"]
    buttons = buttongrid[1, 1:length(buttonlabels)] = 
                [Button(fig, label=l) for l in buttonlabels]
    return buttons
end

function visualize!(images)
    fig = Figure()
    ax = Axis(fig[1,1], aspect=DataAspect(), limits=(-5.,5.,-5.,5.))
    hidedecorations!(ax)
    add_buttons!(fig)
    display(fig)
    return ax
end