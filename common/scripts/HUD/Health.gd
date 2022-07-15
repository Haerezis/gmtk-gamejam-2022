extends Control

var active: bool = true setget set_active
onready var health_texture: TextureRect = $TextureRect

func _ready():
	set_active(false)

func set_active(value: bool):
	active = value
	if active:
		health_texture.modulate.a = 1
	else:
		health_texture.modulate.a = 0.5
