extends Control

func _ready():
	$Button.connect("pressed", self, "returnToMenu")

func returnToMenu():
	get_tree().change_scene("res://scenes/Screens/StartScreen/StartScreen.tscn")
