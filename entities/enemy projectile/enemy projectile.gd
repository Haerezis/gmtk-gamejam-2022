extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var dir = Vector2.RIGHT
export var speed = 10
export var attack = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _physics_process(delta):
	if dir * speed > Vector2.LEFT:
		$Icon.flip_h = true
	else:
		$Icon.flip_h = false
	self.position += dir * speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
