extends StaticBody2D

func _ready():
	$Area2D.connect("area_entered", self, "trigger")
	$Area2D.connect("body_entered", self, "trigger")

func trigger():
	$sfxKey.play()
	print("green key")
	get_parent().get_node("Chest").greenKey = true
	queue_free()
