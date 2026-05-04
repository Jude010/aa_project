extends Node
@export var fish_scene:PackedScene
@export var fish_num:int = 10
@export var radius: int = .1
@export var cell_size:int = 1
@export var spawn_height:float = -3

var cells:Dictionary[Vector3 , Array] = {}
var boids:Array =[]

func positon_to_cell(boid:Boid) -> Vector3:
	var position:Vector3 = boid.global_position
	var cell:Vector3 = Vector3( int(position.x/cell_size),int(position.y/cell_size),int(position.z/cell_size) )
	return cell
	
##func cell_to_position(cell:Vector3) -> Vector3:

func do_partition():
	cells.clear()
	for boid in boids:
		var key = positon_to_cell(boid)
		if ! cells.has(key):
			cells[key] = []
		cells[key].push_back(boid)
	
func _ready() -> void:
	randomize()
	
	for i in fish_num:
		var fish = fish_scene.instantiate()
		var pos = find_random_sphere_point() * radius
		pos.y = randf_range(spawn_height - 1 , spawn_height + 1)
		add_child(fish)
		fish.global_position = pos
		fish.global_rotation = Vector3(0, randf_range(0, PI *2),0)
		var constrain = fish.get_node('Constrain')
		if constrain :
			constrain.center = get_node("../Center")
		
		boids.push_back(fish)
		
func _process(delta: float) -> void:
	do_partition()
		
		
func find_random_sphere_point() -> Vector3:
	var theta = randf_range(0, 2*PI)
	var phi = randf_range(0, PI)
	var r = pow(randf_range(0,1),1/3)
	
	var x = r * sin(phi) * cos(theta)
	var y = r * sin(phi) * sin(theta)
	var z = r * cos(phi)
	return Vector3(x,y,z)
	
	
