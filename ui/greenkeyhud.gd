extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.

func key_grabbed():
	print($GreenKey.self_modulate)
	$GreenKey.self_modulate = Color(1, 1,1,1)
	print($GreenKey.self_modulate)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
