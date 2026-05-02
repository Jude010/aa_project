extends Node

var current:Node = null

func change_state(new:Node) -> void:
	if current :
		current.exit() 
	current = new
	current.enter()
	
