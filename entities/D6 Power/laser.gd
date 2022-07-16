extends Node2D

export var maxDistance = 4000
export var speed = 1000

var initial_position

func _ready():
	initial_position = self.position


func _process(delta):
	position += Vector2.RIGHT * speed * delta
	
	if (position - initial_position).length() > maxDistance:
		queue_free()
