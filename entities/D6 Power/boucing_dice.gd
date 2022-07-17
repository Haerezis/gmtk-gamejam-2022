extends Node2D


export var damage = 10
export var speed = 1
export var number_of_bounce = 20

var value
var camera

var initial_direction
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("rolling")
	$Hitbox.dmg = damage
	initial_direction = Vector2(1,-1)
	velocity = initial_direction * speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var next_position = self.position + velocity * delta
	
	var screen_size = get_viewport().size * camera.zoom
	var from = camera.get_camera_screen_center() - screen_size / 2
	var to = from + screen_size

	if next_position.x < from.x or next_position.x > to.x:
		if number_of_bounce > 0:
			velocity.x = -velocity.x
		number_of_bounce -= 1
	if next_position.y < from.y or next_position.y > to.y:
		if number_of_bounce > 0:
			velocity.y = -velocity.y
		number_of_bounce -= 1
		
	if number_of_bounce <= -10:
		queue_free()
	
	self.position += velocity * delta
