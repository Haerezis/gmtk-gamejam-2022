extends Node2D

export(Vector2) var throw_force

var player
var camera
var d6_scene = preload("res://entities/D6 Power/D6.tscn")
var can_throw_d6 = true

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent()
	camera = get_tree().current_scene.get_node("Camera2D")
	randomize()

func _input(event):
	if event.is_action_pressed("special_attack"):
		throw_d6()


func throw_d6():
	var value = randi() % 6 + 1
	var d6 : RigidBody2D = d6_scene.instance()
	d6.global_position = global_position
	d6.init(value, camera)
	
	get_tree().current_scene.add_child(d6)
	d6.apply_central_impulse(throw_force)
