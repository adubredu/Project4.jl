function load_images!(calib_data; path=nothing, names=[]) 
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
    calib_data.images = images 
end

function post_process!(calib_data)
    for name in keys(calib_data.image_points)
        deleteat!(calib_data.image_points[name], findall(x->x==(0,0), calib_data.image_points[name]))
        deleteat!(calib_data.viz_image_points[name], findall(x->x==(0,0), calib_data.viz_image_points[name])) 
    end
end