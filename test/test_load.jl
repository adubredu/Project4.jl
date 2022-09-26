using Revise 
using Suppressor
@suppress begin
    using Project4 
end 

images = load_images()
visualize!(images)