extends Node2D

onready var particles = preload("waterParticles.tscn")
var prev_particles = []

func _on_Area2D_area_entered(area):
	var particlesInstance = particles.instance()
	
	add_child(particlesInstance)
	particlesInstance.global_position = area.global_position
	particlesInstance.set_emitting(true)
	
	prev_particles.append(particlesInstance)


func _physics_process(_d):
	var i = 0
	for particle in prev_particles:
		if not particle.is_emitting():
			particle.queue_free()
			prev_particles.remove(i)
			
		i+=1
