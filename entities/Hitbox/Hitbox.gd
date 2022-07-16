extends Area2D

export var dmg = 5

func _on_Hitbox_area_entered(area):
	area.hit(dmg)
