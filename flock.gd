extends steering_behavior

var cells:Array[Boid] = []


func _calc_force() -> Vector3:
	var force_acc:Vector3 = Vector3.ZERO
	cells = boid.get_cells()
	force_acc += seperate()
	force_acc += align()
	force_acc += cohere()
	return force_acc * weight
	

func seperate() -> Vector3:
	var force:Vector3 =Vector3.ZERO
	for other in cells:
		var away:Vector3 = other.global_transform.origin - boid.global_transform.origin
		force += away.normalized() / away.length()
	return force
	
func align() -> Vector3:
	var force:Vector3 =Vector3.ZERO
	for other in cells:
		force += other.global_transform.basis.z
	if cells.size() > 0 :
		force = force/cells.size()
	return force
	
func cohere() -> Vector3:
	var force:Vector3 =Vector3.ZERO
	var com:Vector3 =Vector3.ZERO
	for other in cells:
		com += other.global_transform.origin
	if cells.size() > 0:
		com = com/cells.size()
		force = boid.seek_force(com).normalized()
	return force
