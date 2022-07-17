extends StaticBody2D

func _ready():
	$Area2D.connect("area_entered", self, "trigger")
	$Area2D.connect("body_entered", self, "trigger")

func trigger():
	print("blue key")
	get_parent().get_node("Chest").blueKey = true
	queue_free()
