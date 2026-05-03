@export var target:Vector3

@export var slowing_dist:float = 0
@export var max_speed:float = 0

func ramp(dist) -> float:
	return (dist/slowing_dist)*max_speed

func _move(pos:Vector3) -> Vector3:
	var dist:float = pos.distance_to(target)
	var ramped:float = ramp(dist)
	var clamp:float = max(ramped , max_speed)
	var move_vec:Vector3 = clamp*pos.direction_to(target)
	return move_vec
	
	
