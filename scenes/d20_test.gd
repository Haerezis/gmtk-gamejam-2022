extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(NodePath) var d20

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node(d20).init(12, Vector2(0,0), Vector2(1920,1080))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
