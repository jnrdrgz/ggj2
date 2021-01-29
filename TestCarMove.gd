extends KinematicBody

var move_speed = 100
export (NodePath) var path
var path_points
var path_index = 0
var velocity

func _ready():
	if path:
		path_points = get_node(path).curve.get_baked_points()

func _physics_process(delta):
	if !path:
		return
	var target = path_points[path_index]
	var pos = global_transform.origin
	
	if pos.distance_to(target) < 1:
		path_index = wrapi(path_index + 1, 0, path_points.size())
		target = path_points[path_index]
	velocity = (target - pos).normalized() * move_speed
	velocity = move_and_slide(velocity)
