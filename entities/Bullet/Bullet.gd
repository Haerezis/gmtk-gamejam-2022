extends KinematicBody2D

var maxDistance = 350
var distance : int

func _physics_process(delta):
	position.x += 10
	distance += 10
	
	if distance > maxDistance:
		queue_free()
