extends Control

var cooldown: float = 5
onready var sprite: AnimatedSprite = $AnimatedSprite
onready var tween: Tween = $Tween
onready var particles: Particles2D = $AnimatedSprite/Particles2D

func use_die():
	sprite.modulate.a = 0.2
	tween.interpolate_property(sprite, "modulate", Color(1,1,1,sprite.modulate.a), Color(1,1,1,1), cooldown)
	tween.start()

func explode():
	particles.emitting = true
