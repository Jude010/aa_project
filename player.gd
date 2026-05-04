extends CharacterBody3D

var dir:Vector3 = Vector3.ZERO

@export var speed:float = 5
@export var mouse_sensitivity:float = .1

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func getmove()-> void:
	dir = Vector3.ZERO
	if Input.is_action_pressed("Forward"):
		dir += Vector3.FORWARD
	if Input.is_action_pressed("Back"):
		dir += Vector3.BACK
	if Input.is_action_pressed("Up"):
		dir += Vector3.UP
	if Input.is_action_pressed("Left"):
		dir += Vector3.LEFT
	if Input.is_action_pressed("Right"):
		dir += Vector3.RIGHT
	if Input.is_action_pressed("Down"):
		dir += Vector3.DOWN
	dir =  (dir).normalized()

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x) * mouse_sensitivity)
		$Head.rotate_x( deg_to_rad(-event.relative.y) * mouse_sensitivity)
		$Head.rotation.x = clamp($Head.rotation.x , deg_to_rad(-89)  ,deg_to_rad(89))
		

func _physics_process(delta: float) -> void:
	getmove()
	var direction = (transform.basis * dir).normalized()
	velocity = direction * speed
	move_and_slide()
