module Project4

using Suppressor
# @suppress begin 
    using WGLMakie 
    using Images 
    using FileIO
# end
 
include("load.jl")
include("visualize.jl")

export visualize!,
       load_images
end
