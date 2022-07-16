extends RigidBody2D

var bomb_scn = preload("res://entities/D6 Power/bomb.tscn")
var laser_scn = preload("res://entities/D6 Power/laser.tscn")
var bouncing_dice_scn = preload("res://entities/D6 Power/bouncing_dice.tscn")

export var bomb_damage = 6
export var laser_damage = 7
export var bouncing_dice_damage = 8

export var min_activation_duration = 1000
export var min_linear_velocity_for_activation = 1
export var min_angular_velocity_for_activation = (PI / 360) * 5

var value
var camera


var can_activate = false


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().create_timer(min_activation_duration / 1000.0).connect("timeout", self, "enable_activation")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# activate when the dice is "stable" (not moving)
	if can_activate && abs(linear_velocity.length()) < min_linear_velocity_for_activation && abs(angular_velocity) < min_angular_velocity_for_activation:
		activate_power()
		can_activate = false


func init(value, camera):
	self.value = value
	self.camera = camera
	

func enable_activation():
	can_activate = true


func activate_power():
	if value == 1 or value == 2:
		activate_bomb()
	elif value == 3 or value == 4:
		activate_laser()
	else:
		activate_bounce()
				

func activate_bomb():
	var bomb = bomb_scn.instance()
	bomb.damage = bomb_damage
	bomb.global_position = global_position
	get_tree().current_scene.add_child(bomb)

func activate_laser():
	var laser = laser_scn.instance()
	laser.damage = laser_damage
	laser.global_position = Vector2(camera.get_camera_screen_center().x, global_position.y)
	get_tree().current_scene.add_child(laser)

func activate_bounce():
	var bouncing_dice = bouncing_dice_scn.instance()
	bouncing_dice.damage = bouncing_dice_damage
	bouncing_dice.global_position = global_position
	bouncing_dice.camera = camera
	get_tree().current_scene.add_child(bouncing_dice)
