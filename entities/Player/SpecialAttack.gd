extends Node2D

export(Vector2) var throw_force
export var cooldown = 10

var player
var camera
var d6_scene = preload("res://entities/D6 Power/D6.tscn")
var can_throw_d6 = true

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent()
	camera = get_tree().current_scene.get_node("Camera2D")
	randomize()

func enable_throw():
	can_throw_d6 = true

func throw_d6():
	if !can_throw_d6:
		return false

	can_throw_d6 = false
	get_tree().create_timer(cooldown).connect("timeout", self, "enable_throw")
	var value = randi() % 6 + 1
	var d6 : RigidBody2D = d6_scene.instance()
	d6.global_position = global_position
	d6.init(value, camera)
	
	get_tree().current_scene.add_child(d6)
	d6.apply_central_impulse(throw_force)

	return true
