extends Control

var names = []

func _ready():
	randomize()
	
	$Button.connect("pressed", self, "returnToMenu")
	
	hideNames()
	#print(names)
	
	for a in names.size():
		showName()
		#print(a)
		yield(get_tree().create_timer(0.2),"timeout")
	
	

func returnToMenu():
	get_tree().change_scene("res://scenes/Screens/StartScreen/StartScreen.tscn")

func hideNames():
	for i in $Names/Names.get_children():
		i.visible = false
		names.push_back(i)

func showName():
	names.shuffle()
	names[0].visible = true
	names.remove(0)
