extends Node

var player
var d6_scene = preload("res://entities/D6 Power/D6.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent()

func _input(event):
	if event.is_action_pressed("shoot"):
		$ChipThrower.shoot()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
