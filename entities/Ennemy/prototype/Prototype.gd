extends KinematicBody2D

var hp = 10

var direction = -1

func _ready(): 
	$Hurtbox.connect("damage", self, "get_hit")
	
	$Timer.connect("timeout", self, "switchState")

func _process(delta):
	move_and_slide(Vector2(5 * direction, 0) / delta)

func switchState():
	direction = direction * -1
	print("switch")
	$Timer.start()

func get_hit():
	print("oof" + String(hp))
	
	if not hp > 0:
		queue_free()
