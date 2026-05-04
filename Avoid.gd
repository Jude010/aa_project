class_name avoid extends steering_behavior

@export var feeler_angle:float = 45
@export var feeler_len:float = 1
var feeler:RayCast3D = $RayCast3D

##func calc_force()-> Vector3: 
	
