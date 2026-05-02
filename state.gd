@abstract class_name State

@export var slowing_dist:float = 0
@export var max_speed:float = 0

func _ramp(dist) -> float:
	return (dist/slowing_dist)*max_speed

@abstract func _exit() -> void
@abstract func _enter() -> void
@abstract func _move() -> void
