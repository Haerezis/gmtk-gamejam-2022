extends CanvasLayer

var current_health: int = 20 setget set_current_health
onready var chip = $MarginContainer/HBoxContainer/Chip
onready var d4 = $"MarginContainer/HBoxContainer/4D"
onready var d6 = $"MarginContainer/HBoxContainer/6D"
onready var d20 = $"MarginContainer/HBoxContainer/20D"

func set_current_health(new_health: int):
	current_health = new_health
	chip.set_label(str(current_health))

func remove_health(health: int = 1):
	set_current_health(current_health - health)

func add_health(health: int = 1):
	set_current_health(current_health + health)

func set_d6_cooldown(cooldown_time):
	d6.cooldown = cooldown_time

func set_cooldowns(d4_cooldown, d6_cooldown, d20_cooldown):
	d4.cooldown = d4_cooldown
	d6.cooldown = d6_cooldown
	d20.cooldown = d20_cooldown

func use_d6():
	d6.use_die()

func use_d4():
	d4.use_die()

func use_d20():
	d20.use_die()
