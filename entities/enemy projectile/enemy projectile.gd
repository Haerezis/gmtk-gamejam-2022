extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var dir = Vector2.ZERO
export var speed = 10
export var attack = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.play()
func _physics_process(delta):
	self.position += dir * speed
	look_at(self.global_position + dir * speed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
