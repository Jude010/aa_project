extends steering_behavior

@export var center:Node3D
@export var Height_constraint:float = -0.1
@export var radius:float = 100


func _ready() -> void:
	boid=get_parent()
	
	
	
func calc_force()-> Vector3:
	var to_center:Vector3 = center.global_transform.origin - boid.global_transform.origin
	var power = max(to_center.length() - radius , 0)
	var center_force =  to_center.limit_length(power)
	var surface_force:Vector3 = Vector3.ZERO
	
	if boid.global_transform.origin.y > Height_constraint and  boid.species == boid.Species.Fish:
		var to_surface_ofset:float = Height_constraint + boid.global_transform.origin.y
		surface_force = to_surface_ofset * Vector3.DOWN
		
	if boid.global_transform.origin.y < Height_constraint and boid.species == boid.Species.Bird:
		var to_surface_ofset:float = Height_constraint + boid.global_transform.origin.y
		surface_force = to_surface_ofset * Vector3.UP
		
	return surface_force + center_force
