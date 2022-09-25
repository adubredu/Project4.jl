function load_images(;path=nothing, names=[]) 
    path = isnothing(path) ? path = "images/" : path 
    path = joinpath(@__DIR__, path)
    images = []
    if isempty(names)
        for i=1:8 
            push!(images, load(joinpath(path, "image0$i.jpg")))
        end
    else
        for name in names
            push!(images, load(joinpath(path, name)))
        end
    end
    return images 
end