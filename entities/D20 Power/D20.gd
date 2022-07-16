extends Node2D


export var damage = 10
export var speed = 1
export var number_of_bounce = 10

var value
var camera

var initial_direction
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_direction = Vector2(1,-1)
	velocity = initial_direction * speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var next_position = self.position + velocity * delta
	
	var from = camera.get_camera_screen_center()
	var to = from + get_viewport().size
	
	if next_position.x < from.x or next_position.x > to.x:
		velocity.x = -velocity.x
		number_of_bounce -= 1
	if next_position.y < from.y or next_position.y > to.y:
		velocity.y = -velocity.y
		number_of_bounce -= 1
		
	if number_of_bounce <= 0:
		queue_free()
	
	self.position += velocity * delta


func init(value, camera):
	self.value = value
	self.camera = camera
	
	# player layer
	$Hitbox.set_collision_mask_bit(1, (value == 1))
	# ennemy layer
	$Hitbox.set_collision_mask_bit(2, true)
