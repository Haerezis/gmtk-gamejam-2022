extends RigidBody2D

var laser_scn = preload("res://entities/D6 Power/laser.tscn")

export var damage = 10

var value
var camera

export var min_activation_duration = 1000
export var min_linear_velocity_for_activation = 1
export(float) var min_angular_velocity_for_activation = (PI / 360) * 5
var can_activate = false


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().create_timer(min_activation_duration / 1000.0).connect("timeout", self, "enable_activation")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_activate && abs(linear_velocity.length()) < min_linear_velocity_for_activation && abs(angular_velocity) < min_angular_velocity_for_activation:
		activate_laser()
		can_activate = false


func init(value, camera):
	self.value = value
	self.camera = camera
	

func enable_activation():
	can_activate = true

func activate_laser():
	var laser = laser_scn.instance()
	laser.global_position = Vector2(camera.get_camera_screen_center().x, global_position.y)
	get_tree().current_scene.add_child(laser)
