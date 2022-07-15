extends KinematicBody2D

func _input(event):
	if event.is_action_pressed("ui_right"):
		position.x += 15
	if event.is_action_pressed("ui_left"):
		position.x -= 15
