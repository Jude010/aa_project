class_name steering_behavior extends Node

@export var weight:float = 1 

var boid:Boid

@export var enabled:bool = true: get = get_enabled, set = set_enabled

func set_enabled(e:bool) -> void:
	enabled = e
	set_process(enabled)
	
func get_enabled() -> bool:
	return enabled
	
