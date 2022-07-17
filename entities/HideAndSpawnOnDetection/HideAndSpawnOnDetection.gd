extends Area2D

var children = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in self.get_children():
		if child.name != "WeirdNameCollisionHackDontRename":
			remove_child(child)
			child.visible = false
			children.push_back(child)
	

func _on_Node2D_area_entered(area):
	for child in children:
		add_child(child)
		child.visible = true
