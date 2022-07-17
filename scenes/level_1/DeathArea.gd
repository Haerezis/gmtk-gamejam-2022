extends Area2D


func _on_DeathArea_area_entered(object):
	if object.has_method("die"):
		object.die()
