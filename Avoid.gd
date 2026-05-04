class_name avoid extends steering_behavior

@export var feeler_angle:float = 45
var feeler:RayCast3D

func _ready() -> void:
	feeler = self.get_node('Feeler')
	boid = get_parent()
	
func calc_force()-> Vector3:
	var feeler_length = feeler.target_position.length()
	var forwards = Vector3.FORWARD * feeler_length
	var force:Vector3 = Vector3.ZERO
	feeler.global_basis = boid.global_basis
	feeler.global_position = boid.global_position
	if feeler.is_colliding():
		var target_distance = boid.global_position.distance_to(feeler.get_collision_point())
		var force_magnitude = (feeler_length - target_distance) / feeler_length
		force += feeler.get_collision_normal() * force_magnitude
	feeler.quaternion = Quaternion(Vector3.UP , deg_to_rad(feeler_angle)) * feeler_length
	if feeler.is_colliding():
		var target_distance = boid.global_position.distance_to(feeler.get_collision_point())
		var force_magnitude = (feeler_length - target_distance) / feeler_length
		force += feeler.get_collision_normal() * force_magnitude
	feeler.quaternion = Quaternion(Vector3.UP , deg_to_rad(-feeler_angle)) * feeler_length
	if feeler.is_colliding():
		var target_distance = boid.global_position.distance_to(feeler.get_collision_point())
		var force_magnitude = (feeler_length - target_distance) / feeler_length
		force += feeler.get_collision_normal() * force_magnitude
	feeler.quaternion = Quaternion(Vector3.RIGHT , deg_to_rad(feeler_angle)) * feeler_length
	if feeler.is_colliding():
		var target_distance = boid.global_position.distance_to(feeler.get_collision_point())
		var force_magnitude = (feeler_length - target_distance) / feeler_length
		force += feeler.get_collision_normal() * force_magnitude
	feeler.quaternion = Quaternion(Vector3.RIGHT, deg_to_rad(-feeler_angle)) * feeler_length
	if feeler.is_colliding():
		var target_distance = boid.global_position.distance_to(feeler.get_collision_point())
		var force_magnitude = (feeler_length - target_distance) / feeler_length
		force += feeler.get_collision_normal() * force_magnitude
	
	return force
	

		
		
