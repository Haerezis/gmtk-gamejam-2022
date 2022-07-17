extends Node2D

var direction = Vector2.RIGHT

func shoot():
	var bullet = preload("res://entities/PokerChip/PokerChip.tscn")
	var bulletIns = bullet.instance()
	
	bulletIns.direction = direction
	bulletIns.global_position = global_position
	get_tree().current_scene.add_child(bulletIns)
