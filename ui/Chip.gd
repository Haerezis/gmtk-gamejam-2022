extends Control

onready var label: Label = $TextureRect/Label

func set_label(new_label: String):
	label.text = new_label
