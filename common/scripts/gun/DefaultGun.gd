extends Node2D

func shoot():
	var bullet = preload("res://scenes/guns/Bullet.tscn")
	var bulletIns = bullet.instance()
	
	bulletIns.position = position
