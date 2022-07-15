extends KinematicBody2D

var hp = 10

func _ready(): 
	$Hurtbox.connect("damage", self, "get_hit")

func get_hit():
	print("oof" + String(hp))
	
	if not hp > 0:
		queue_free()
