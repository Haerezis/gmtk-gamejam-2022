extends Control

func _ready():
	$Button.connect("pressed", self, "menu")
	
	$AnimationPlayer.play("FadeIn")

func menu():
	get_tree().change_scene("res://scenes/Screens/StartScreen/StartScreen.tscn")
