mutable struct CalibrationData 
    images 
    viz_image_points::Dict
    image_points::Dict 
    camera_points::Dict 
    function CalibrationData()
        new([], Dict(), Dict(), Dict())
    end
end