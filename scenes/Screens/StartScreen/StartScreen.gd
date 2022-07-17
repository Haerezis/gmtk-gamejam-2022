extends Control

func _ready():
	$Buttons/PlayButton.connect("pressed", self, "startLevel")
	$Buttons/CreditsButton.connect("pressed", self, "creditsScreen")
	$Buttons/ExitButton.connect("pressed", self, "exitGame")

func startLevel():
	get_tree().change_scene("res://scenes/level_1/level_1.tscn")

func creditsScreen():
	get_tree().change_scene("res://scenes/Screens/CreditsScreen/CreditsScreen.tscn")

func exitGame():
	get_tree().quit()
