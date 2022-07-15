extends Node2D

func shoot():
	var bullet = preload("res://scenes/guns/Bullet.tscn")
	var bulletIns = bullet.instance()
	
	bulletIns.global_position = global_position
	get_parent().get_parent().get_node("Bullets").add_child(bulletIns)
