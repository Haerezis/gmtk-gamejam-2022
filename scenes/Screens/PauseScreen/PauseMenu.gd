extends Control

func _input(event):
	if event.is_action_pressed("pause"):
		stop()

func _ready():
	visible = false
	
	$ContinueButton.connect("pressed", self, "resume")
	$RestartButton.connect("pressed", self, "restart")
	$ExitButton.connect("pressed", self, "exit")

func stop():
	visible = true
	
	get_tree().paused = true

func resume():
	visible = false
	
	get_tree().paused = false

func restart():
	get_tree().paused = false

func exit():
	get_tree().paused = false
	
	get_tree().change_scene("res://scenes/Screens/StartScreen/StartScreen.tscn")
