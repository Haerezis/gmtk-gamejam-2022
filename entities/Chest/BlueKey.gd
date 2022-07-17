extends StaticBody2D

func _ready():
	$Area2D.connect("area_entered", self, "trigger")
	$Area2D.connect("body_entered", self, "trigger")

func trigger():
	print("blue key")
	get_parent().get_node("Chest").blueKey = true
	print(get_parent().get_node("Chest").blueKey)
	print(get_parent().get_node("Chest").greenKey)
	get_parent().get_node("HUD").get_node("MarginContainer/HBoxContainer/bluekey").key_grabbed()
	queue_free()


func _on_Area2D_body_entered(body):
	trigger()
