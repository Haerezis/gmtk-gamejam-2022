extends Area2D

func _on_Hitbox_area_entered(area):
	area.hit(5)
