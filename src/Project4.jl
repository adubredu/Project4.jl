module Project4

using Suppressor
# @suppress begin 
    using GLMakie 
    using Images 
    using FileIO
# end

include("types.jl")
include("load.jl")
include("visualize.jl")

export CalibrationData

export visualize!,
       load_images!
end
