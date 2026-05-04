class_name wander extends steering_behavior

@export var offset:float = 1
@export var radius:float = 1
@export var jitter:float = .1
var wander_target:Vector3
var global_target:Vector3 


func _ready() -> void:
	wander_target = find_random_sphere_point()
	boid = get_parent()

## from minature rotary phone utils
func find_random_sphere_point() -> Vector3:
	var theta = randf_range(0, 2*PI)
	var phi = randf_range(0, PI)
	var r = pow(randf_range(0,1),1/3)
	
	var x = r * sin(phi) * cos(theta)
	var y = r * sin(phi) * sin(theta)
	var z = r * cos(phi)
	return Vector3(x,y,z) * radius
	

func calc_force()-> Vector3:
	var delta = get_physics_process_delta_time()
	var disp = jitter * find_random_sphere_point() * delta
	wander_target += disp
	wander_target = wander_target.limit_length(radius)
	var local_target = (Vector3.FORWARD * offset) + wander_target
	
	global_target = boid.global_transform * local_target
	
	return boid.seek_force(global_target)
	
	
