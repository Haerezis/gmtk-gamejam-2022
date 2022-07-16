extends Node2D

var direction = Vector2.RIGHT

func shoot():
	var bullet = preload("res://entities/Bullet/Bullet.tscn")
	var bulletIns = bullet.instance()
	
	bulletIns.direction = direction
	bulletIns.global_position = global_position
	get_parent().get_parent().get_node("Bullets").add_child(bulletIns)
