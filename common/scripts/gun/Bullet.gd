extends KinematicBody2D

var maxDistance = 200
var distance : int

func _physics_process(delta):
	position.x += 5
	distance += 5
	
	if distance > maxDistance:
		queue_free()
