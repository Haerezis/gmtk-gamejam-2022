extends KinematicBody2D

var direction
export var maxDistance = 400
export var speed = 500

var initial_position

func _ready():
	initial_position = self.position


func _process(delta):
	position += direction * speed * delta
	
	if (position - initial_position).length() > maxDistance:
		queue_free()
