mutable struct CalibrationData 
    images 
    image_points::Dict 
    camera_points::Dict 
    function CalibrationData()
        new([], Dict(), Dict())
    end
end