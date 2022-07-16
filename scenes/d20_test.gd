extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var d20 = preload("res://entities/D20 Power/D20.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var d20_node = d20.instance()
	d20_node.position = Vector2(500, 500)
	d20_node.init(10, $Camera2D)
	add_child(d20_node)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
