extends StaticBody2D

var blueKey = false
var greenKey = false

func open():
	print("yes")
	$AnimationPlayer.play("Open")
	yield(get_tree().create_timer(5.0), "timeout")
	get_tree().change_scene("res://scenes/Screens/StartScreen/StartScreen.tscn")
