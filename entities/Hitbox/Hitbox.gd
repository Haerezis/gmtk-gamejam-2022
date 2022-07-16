extends Area2D

export var dmg = 5

func _on_Hitbox_area_entered(object):
	if object.has_method("hit"):
		object.hit(dmg)
