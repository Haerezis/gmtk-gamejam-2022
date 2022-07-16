extends KinematicBody2D

var hp = 10

var direction = -1

var invincible = false

func _ready(): 
	$Hurtbox.connect("damage", self, "get_hit")
	
	$DirectionTimer.connect("timeout", self, "switchState")
	$IFrame.connect("timeout", self, "breakInvincible")

func _process(delta):
	move_and_slide(Vector2(5 * direction, 0) / delta)
	pass

func switchState():
	direction = direction * -1
	print("switch")
	$DirectionTimer.start()



func get_hit(damage):
	if not invincible:
		hp -= damage
		invincible = true
		$IFrame.start()
		
		print("oof" + String(hp))
		
		if not hp > 0:
			queue_free()

func breakInvincible():
	invincible = false
