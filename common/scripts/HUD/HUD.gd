extends CanvasLayer

var max_health: int = 5 setget set_max_health
var current_health: int = max_health setget set_current_health
var health_scene: PackedScene = preload("res://scenes/HUD/Health.tscn")
onready var lives_container: HBoxContainer = $MarginContainer/HSplitContainer/Lives


# Called when the node enters the scene tree for the first time.
func _ready():
	set_max_health(max_health)
	set_current_health(3)

func set_max_health(new_max_health: int):
	max_health = new_max_health
	clear_lives()
	populate_lives(max_health)

func set_current_health(new_current_health: int):
	current_health = new_current_health
	for health_index in range(lives_container.get_child_count()):
		if health_index < current_health:
			lives_container.get_child(health_index).active = true
		else:
			lives_container.get_child(health_index).active = false

func populate_lives(health_count: int):
	for _i in range(health_count):
		var health = health_scene.instance()
		lives_container.add_child(health)

func clear_lives():
	for health in lives_container.get_children():
		health.queue_free()
