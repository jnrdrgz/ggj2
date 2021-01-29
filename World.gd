extends Spatial

var path_speed = 3

func _physics_process(delta):
	$Path/PathFollow.offset += delta*path_speed

