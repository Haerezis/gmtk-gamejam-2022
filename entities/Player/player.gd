extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2.ZERO
export var shortjumpadjustment = 4
export var accel = 40 * 60
export var airdeaccel = 20*60
export var maxspeed = 400
export var jump = 150
export var gravity = 100 * 60
export var airspeedmodifer = 2
export var turnspeed = 100
var StopLandingAnimWhenFirstStart = false
var doublejump = false
var jumpbuffer =false
var latejumpbuffer =false
# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.iterations_per_second = 60
	Engine.time_scale = 1



func _physics_process(delta):
#getting the movement direction
	var dir = Vector2.ZERO
	dir.x = (Input.get_action_strength("right") - Input.get_action_strength("left")) * delta

 #making the player turn faster when going the other direction
	if velocity.x > 0 and Input.is_action_just_pressed("left") and not Input.is_action_just_pressed("right"):
		dir.x = 1 * turnspeed
	if velocity.x < 0 and Input.is_action_just_pressed("right") and not Input.is_action_just_pressed("left"): 
		dir.x = -1 * turnspeed

#handling movement for x axis
	if not dir == Vector2.ZERO : 
		if is_on_floor():
			velocity.x += dir.x * accel
		else:
			velocity.x += (dir.x * accel) / airspeedmodifer
		velocity.x = clamp(velocity.x,-maxspeed,maxspeed)
#making the player slow down when touching the ground
	else :
		if is_on_floor():
			velocity.x = move_toward(velocity.x,0,accel * delta * 3)
		else:
			velocity.x = move_toward(velocity.x,0,airdeaccel * delta)
#handling movement for y axis
##jumping when on the ground
	if Input.is_action_just_pressed("jump") and is_on_floor() and not jumpbuffer and latejumpbuffer == false :
		$AnimationPlayer.play("jump")
		velocity.y -= sqrt(gravity * jump * 2) 
		doublejump = true
		print('a')

#	if Input.is_action_just_pressed("jump") and latejumpbuffer and not is_on_floor() :
#		$AnimationPlayer.play("jump")
#		velocity.y -= sqrt(gravity * jump * 2) 

	if not is_on_floor() and velocity.y < 0 and Input.is_action_just_released("jump") :
		velocity.y += abs(velocity.y) / shortjumpadjustment

##double jump
	elif doublejump and Input.is_action_just_pressed("jump") and not is_on_floor() and latejumpbuffer == false : 
		$AnimationPlayer.play("jump")
		velocity.y -= sqrt(gravity * jump * 2) 
		doublejump =false
		jumpbuffer = false
		latejumpbuffer = false
		print('aa')

##buffering jump input
	elif Input.is_action_just_pressed("jump") and not is_on_floor() and not doublejump: 
		jumpbuffer =true
		$AnimationPlayer.play("jump")
		print('aaa')
#a timer so we can buffer the input and delete it if takes longer 0.1 seconds to hit the ground
		$"jumpbuffer timer".start() 



	elif latejumpbuffer and Input.is_action_just_pressed("jump") and not is_on_floor():
		$AnimationPlayer.play("jump")
		velocity.y -= sqrt(gravity * jump * 2) 
		jumpbuffer = false
		latejumpbuffer = false
		doublejump = true
		print('aaaa')
##gravity
	elif not is_on_floor() :
		velocity.y += gravity * delta 
##using the buffered input
	elif jumpbuffer and is_on_floor() : 
		$AnimationPlayer.play("jump")
		velocity.y -= sqrt(gravity * jump * 2) 
		jumpbuffer = false
		latejumpbuffer = false
		doublejump = true
	if is_on_floor():
		latejumpbuffer = true
		doublejump = true
		$"jumpbuffer timer".start()
	else:
		latejumpbuffer = false
#main movement function
	velocity = move_and_slide(velocity,Vector2.UP) 


#registering the ground so we can play the "lands" animation
func _on_landing_body_entered(body):
#this variable is here to stop the animation from playing when we first load into the scene
	if StopLandingAnimWhenFirstStart : 
		$AnimationPlayer.play("lands")
	else :
		StopLandingAnimWhenFirstStart = true

# removing the buffer because it took more than 0.1 seconds
func _on_Timer_timeout():
	jumpbuffer = false
	latejumpbuffer = false


#on player death respawn
func _on_HP_Logic_die():
	respawn()

var hp = 10

func respawn():
	pass


func _on_HP_Logic_iframes():
	pass # Replace with function body.

var invincible = false
export var iframeTime = 1.0

func get_hit(damage):
	if not invincible:
		invincible = true
		$IFrame.wait_time = iframeTime
		$IFrame.start()
		
		hp -= damage
		
		print("oof" + String(hp))
		
		if not hp > 0:
			queue_free()

func breakInvincible():
	invincible =false

