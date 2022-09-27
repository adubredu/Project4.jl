using Revise 
using Suppressor
@suppress begin
    using Project4 
end 

calib_data = CalibrationData()
images = load_images!(calib_data)
visualize!(calib_data; show_name=true)