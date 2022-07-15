extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2.ZERO
export var accel = 40 * 60
export var deaccel = 40 * 90
export var maxspeed = 400
export var jump = 150
export var shortjumpadjustment = 4
export var gravity = 100 * 60
export var airspeedmodifer = 2
export var turnspeed = 100
var firstly = false
var buffering
var prevdir = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.iterations_per_second = 60



func _physics_process(delta):
	var dir = Vector2.ZERO
	dir.x = (Input.get_action_strength("right") - Input.get_action_strength("left")) 
	if not dir == Vector2.ZERO : 
		if is_on_floor():
			velocity.x += dir.x * accel * delta
		else:
			velocity.x += (dir.x * accel * delta) / airspeedmodifer
		velocity.x = clamp(velocity.x,-maxspeed,maxspeed)
	else :
		if is_on_floor():
			velocity.x = move_toward(velocity.x,0,deaccel * delta * 2.5)
	if Input.is_action_just_pressed("jump") and is_on_floor(): # Changed to just_pressed so player doesn't keep kumping while holding jump key
		$AnimationPlayer.play("jump")
		velocity.y -= sqrt(gravity * jump * 2) # fixed this to proper formula
	if not is_on_floor() :
		velocity.y += gravity * delta 
	if not is_on_floor() and velocity.y < 0 and Input.is_action_just_released("jump") :
		velocity.y += abs(velocity.y) / shortjumpadjustment
	if prevdir != dir and is_on_floor():
		velocity.x = 0 + dir.x * turnspeed
	prevdir = dir
	velocity = move_and_slide(velocity,Vector2.UP)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_landing_body_entered(body):
	if firstly:
		$AnimationPlayer.play("lands")
	else:
		firstly = true
