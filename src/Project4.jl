module Project4

using Logging
Logging.disable_logging(Logging.Info)

using WGLMakie
using Images 
using FileIO
 
include("load.jl")
include("visualize.jl")

export visualize!,
       load_images
end
