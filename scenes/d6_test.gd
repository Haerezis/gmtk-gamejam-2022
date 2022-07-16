extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var dice = preload("res://entities/D6 Power/D6.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var dice_node = dice.instance()
	dice_node.position = Vector2(500, 500)
	dice_node.init(5, $Camera2D)
	add_child(dice_node)
