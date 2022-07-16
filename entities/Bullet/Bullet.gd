extends KinematicBody2D

var direction
export var maxDistance = 400
var distance : int

func _physics_process(delta):
	position += direction * 10
	distance += 10
	
	if distance > maxDistance:
		queue_free()

func _on_Hitbox_area_entered(area):
	queue_free()
