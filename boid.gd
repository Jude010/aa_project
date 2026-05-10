class_name Boid extends CharacterBody3D

@export var slowing_dist:float = .5
@export var max_speed:float = 1
@export var max_force:float = 10
@export var mass:float = 1
@export var banking:float = .1

enum Species {Fish , Bird}
@export var species:Species

var vel:Vector3 = Vector3.ZERO
var force:Vector3 = Vector3.ZERO
var behaviors = []
var new_force:Vector3 = Vector3.ZERO
var speed:float
var accel:Vector3

var move:bool = false

func _get_cells() -> Array:
	var local_cells:Array[Boid]= []
	var cells = get_parent().cells
	var pos = get_parent().positon_to_cell(self)
	for x in range(-1,2):
		for y in range(-1,2):
			for z in range(-1,2):
				local_cells.append_array(cells[Vector3(x,y,z)])
	local_cells.erase(self)
	return local_cells
	
func _ready():
	for i in get_child_count():
		var child = get_child(i)
		if child.has_method("calc_force"):
			behaviors.push_back(child)
			child.set_process(child.enabled)

func ramp(dist) -> float:
	return (dist/slowing_dist)*max_speed

func seek_force(target:Vector3) -> Vector3:
	var pos = self.global_position
	var dir:Vector3 = pos.direction_to(target)
	dir = dir.normalized()
	var desired = dir * max_speed
	return desired - vel
	
func flee_force(target:Vector3) -> Vector3:
	var pos = self.global_position
	var dir:Vector3 = pos.direction_to(target)
	dir = dir.normalized()
	var desired = dir * max_speed * -1
	return desired - vel

func arrive_force(target:Vector3) -> Vector3:
	var pos = self.global_position
	var dist:float = pos.distance_to(target)
	var ramped:float = ramp(dist)
	var clamp:float = max(ramped , max_speed)
	var move_vec:Vector3 = clamp*pos.direction_to(target)
	return move_vec
	
func calculate() -> Vector3:
	var force_acc = Vector3.ZERO
	for b in behaviors:
		if b.enabled:
			var f = b.calc_force() * b.weight 
			force_acc += f
	
	if force_acc.length() > max_force: 
		force_acc = force_acc.limit_length(max_force)
	
	return force_acc	
	
func sperated_process(delta) -> void:
	new_force = calculate()
	force = lerp(force , new_force , delta)
	
	accel = force/mass
	vel +=  accel*delta
	speed = vel.length()
	
	if speed > 0:
		vel = vel.limit_length(max_speed)
		
	set_velocity(vel)
	
	
	
	move =true
	
func _physics_process(delta: float) -> void:
	move_and_slide()
	
	
	if move:
		if species ==  Species.Bird:
			var temp_up = global_transform.basis.y.lerp(Vector3.UP + (accel * banking), delta * 5.0)
			look_at(global_transform.origin + vel.normalized(), temp_up)
		else:
			look_at(global_transform.origin + vel.normalized())
		move = false
		
		
