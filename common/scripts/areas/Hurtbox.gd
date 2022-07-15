extends Area2D

signal damage

var invincible = false

func hit(damage):
	if not invincible:
		invincible = true
		$Timer.start()
		get_parent().hp -= damage
		emit_signal("damage")

func _on_Timer_timeout():
	invincible = false
