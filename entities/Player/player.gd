extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2.ZERO
export var accel = 40 * 60
export var maxspeed = 400
export var jump = 150
export var gravity = 100 * 60
export var airspeedmodifer = 2
export var turnspeed = 100
var StopLandingAnimWhenFirstStart = false
var doublejump = false
var jumpbuffer =false
# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.iterations_per_second = 60
	



func _physics_process(delta):
	print(Engine.get_frames_per_second())
	var dir = Vector2.ZERO#getting the movement direction
	dir.x = (Input.get_action_strength("right") - Input.get_action_strength("left")) * delta
	if velocity.x > 0 and Input.is_action_just_pressed("left") and not Input.is_action_just_pressed("right"): #making the player turn faster when going the other direction
		dir.x = 1 * turnspeed
	elif velocity.x < 0 and Input.is_action_just_pressed("right") and not Input.is_action_just_pressed("left"): #making the player turn faster when going the other direction
			dir.x = -1 * turnspeed
	if not dir == Vector2.ZERO : 
		if is_on_floor():
			velocity.x += dir.x * accel
		else:
			velocity.x += (dir.x * accel) / airspeedmodifer
		velocity.x = clamp(velocity.x,-maxspeed,maxspeed)
	else :
		if is_on_floor():
			velocity.x = move_toward(velocity.x,0,accel * delta * 2.5)
	if Input.is_action_pressed("jump") and is_on_floor() and not jumpbuffer: #handling jumping
		$AnimationPlayer.play("jump")
		velocity.y -= sqrt(gravity) * jump * 2
		doublejump = true
	elif doublejump and Input.is_action_just_pressed("jump") and not is_on_floor()  : 
		$AnimationPlayer.play("jump")
		velocity.y -= sqrt(gravity) * jump * 2
		doublejump =false
		jumpbuffer = false
	elif Input.is_action_just_pressed("jump") and not is_on_floor() and not doublejump: 
		jumpbuffer =true
		$"jumpbuffer timer".start()
	elif not is_on_floor() :
		velocity.y += gravity * delta 
	elif jumpbuffer and is_on_floor(): 
		velocity.y -= sqrt(gravity) * jump * 2
		jumpbuffer = false
		doublejump = true
	velocity = move_and_slide(velocity,Vector2.UP) #main movement function
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_landing_body_entered(body):
	if StopLandingAnimWhenFirstStart : 
		$AnimationPlayer.play("lands")
	else :
		StopLandingAnimWhenFirstStart = true


func _on_Timer_timeout():
	jumpbuffer = false


func _on_HP_Logic_die():
	get_tree().reload_current_scene()
