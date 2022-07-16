extends Node2D

export var damage = 5

func _ready():
	$Hitbox.dmg = damage
	get_tree().create_timer(0.5).connect("timeout", self, "scale_hitbox")
	get_tree().create_timer(1.5).connect("timeout", self, "queue_free")
	$AnimatedSprite.playing = true

func scale_hitbox():
	$Hitbox.scale = Vector2(1,1)
