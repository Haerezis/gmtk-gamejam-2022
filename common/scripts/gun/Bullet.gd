extends KinematicBody2D

var maxDistance = 200
var distance

func _physics_process(delta):
	position.x += 2
	distance += 2
	
	if distance > maxDistance:
		queue_free()
