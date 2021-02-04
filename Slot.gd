extends Area

onready var car_scn = preload("res://CarWoModel.tscn") 
var rng = RandomNumberGenerator.new()
var has_car = false

func _ready():
	rng.randomize()
	var n = rng.randi_range(1,4)
	if n == 2:
		var car_inst = car_scn.instance()
		car_inst.scale = Vector3(0.5,0.5,0.5)

		add_child(car_inst)
	
		var mod_rand = rng.randi_range(0,1)		
		if mod_rand == 0:
			car_inst.set_model("police")
		if mod_rand == 1:
			car_inst.set_model("sedan")
	
		has_car = true
