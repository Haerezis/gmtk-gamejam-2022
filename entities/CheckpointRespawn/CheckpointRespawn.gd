extends Area2D

var used = false

func _on_Checkpoint_body_entered(object):
	if used:
		return

	if object.has_method("set_respawn"):
		object.set_respawn($Respawn)
		used = true
