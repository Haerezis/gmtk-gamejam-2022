extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var hp = 0
export var max_hp = 20
export onready var iframes = $"i-frames".wait_time
signal die

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
func take_damage(damage):
	hp -= damage
	if hp <= 0:
		die()
	else:
		$"i-frames".start()
func heal_damage(heal):
	hp += heal
	if hp > max_hp : 
		hp = max_hp
func  die():
	emit_signal("die")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
