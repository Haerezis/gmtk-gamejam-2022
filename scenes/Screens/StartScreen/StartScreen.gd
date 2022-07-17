extends Control

func _ready():
	$AnimationPlayer.play("FadeIn")
	
	$Buttons/PlayButton.connect("pressed", self, "playPressed")
	$Buttons/CreditsButton.connect("pressed", self, "creditsScreen")
	$Buttons/ExitButton.connect("pressed", self, "exitGame")

func playPressed():
	$AnimatedSprite.visible = true
	$AudioStreamPlayer.play()
	$AnimatedSprite.play("default", true)

func startLevel():
	get_tree().change_scene("res://scenes/level_1/level_1.tscn")

func creditsScreen():
	$AudioStreamPlayer.play()
	yield(get_tree().create_timer(0.6), "timeout")
	get_tree().change_scene("res://scenes/Screens/CreditsScreen/CreditsScreen.tscn")

func exitGame():
	$AudioStreamPlayer2.play()
	yield(get_tree().create_timer(0.6), "timeout")
	get_tree().quit()
