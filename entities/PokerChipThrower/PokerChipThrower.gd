extends Node2D

var direction = Vector2.RIGHT

func shoot():
	var bullet = preload("res://entities/PokerChip/PokerChip.tscn")
	var bulletIns = bullet.instance()
	
	bulletIns.direction = direction
	#bulletIns.global_position = global_position
	bulletIns.global_position = global_position
	#get_parent().get_parent().get_node("Bullets").add_child(bulletIns)
	#add_child(bulletIns)
	get_tree().current_scene.add_child(bulletIns)
