extends Spatial

var path_speed = 3
onready var path_follow = $Path/PathFollow
func _physics_process(delta):
	path_follow.offset += delta*path_speed
	if path_follow.offset < 0.1:
		
		print(path_follow.offset)
	
func _on_sedan_mouse_entered():
	print("mouse in")	
