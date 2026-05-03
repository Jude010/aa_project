class_name wander extends steering_behavior

@export var offset:float = 1
var local_target:Vector3
var global_target:Vector3 

## from minature rotary phone utils
func find_sphere_point() -> Vector3:
	var theta = randf_range(0, 2*PI)
	var phi = randf_range(0, PI)
	var r = pow(randf_range(0,1),1/3)
	
	var x = r * sin(phi) * cos(theta)
	var y = r * sin(phi) * sin(theta)
	var z = r * cos(phi)
	return Vector3(x,y,z)
	
