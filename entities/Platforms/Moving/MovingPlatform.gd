extends Node2D

export var idleTime = 1.0
export var speed = 3.0
export var endPos : Vector2

onready var tween = $Platform/MoveTween

export var direction = 1

func _ready():
	if direction == 1:
		moveForward()
	else:
		moveBack()

func moveForward():
	#print("for")
	
	tween.interpolate_property($Platform, "position", Vector2.ZERO, endPos, speed, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, idleTime)
	tween.start()
	direction = direction * -1

func moveBack():
	#print("bac")
	
	tween.interpolate_property($Platform, "position", endPos, Vector2.ZERO, speed, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, idleTime)
	tween.start()
	direction = direction * -1

func _on_MoveTween_tween_all_completed():
	#print("a")
	if direction == 1:
		moveForward()
	else:
		moveBack()
