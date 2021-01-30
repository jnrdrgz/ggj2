extends KinematicBody

var patente
var rng = RandomNumberGenerator.new()

func rand_pat_lets():
	var chars = ""
	var abc = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	
	for i in range(3):
		chars += abc[rng.randi_range(0,len(abc)-1)]
	
	return chars

func random_patente():
	var num = rng.randi_range(100,999)
		
	return rand_pat_lets() + "-" + str(num)
	
func _ready():
	rng.randomize()
	patente = random_patente()
	$CanvasL/Patente.text = patente	

func _on_sedan_mouse_entered():
	var pat = $CanvasL/Patente
	pat.visible = true
	pat.set_global_position(get_viewport().get_mouse_position()) 
	
func _on_sedan_mouse_exited():
	$CanvasL/Patente.visible = false	

