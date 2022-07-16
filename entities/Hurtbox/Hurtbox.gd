extends Area2D

signal damage

func hit(damage):
	emit_signal("damage", damage)
