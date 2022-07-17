extends Control

func _ready():
	$AnimationPlayer.play("FadeIn")
	
	$Buttons/PlayButton.connect("pressed", self, "startLevel")
	$Buttons/CreditsButton.connect("pressed", self, "creditsScreen")
	$Buttons/ExitButton.connect("pressed", self, "exitGame")

func startLevel():
	$AnimatedSprite.visible = true
	$AnimatedSprite.play("default", true)

func creditsScreen():
	get_tree().change_scene("res://scenes/Screens/CreditsScreen/CreditsScreen.tscn")

func exitGame():
	get_tree().quit()

func transitionToLevel():
	get_tree().change_scene("res://scenes/level_1/level_1.tscn")
