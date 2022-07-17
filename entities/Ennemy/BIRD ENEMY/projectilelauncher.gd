extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var projectile = preload('res://entities/enemy projectile/enemy projectile.tscn')
export var damage = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func bullet(dir):
	var newprojectile = projectile.instance()
	newprojectile.dir = dir
	newprojectile.scale = newprojectile.scale * 2
	newprojectile.attack = damage
	newprojectile.position = self.position
	owner.add_child(newprojectile)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
