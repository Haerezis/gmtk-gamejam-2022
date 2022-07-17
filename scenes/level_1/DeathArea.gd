extends Area2D


func _on_DeathArea_body_entered(body):
	if body.has_method("die"):
		body.die()
