extends KinematicBody2D


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

var hp = 100
var invincible = false
export var iframeTime = 1

var buffering
var prevdir = Vector2.ZERO

var state_machine

func _input(event):
	if event.is_action_pressed("shoot"):
		$ChipThrower.shoot()
	if event.is_action_pressed("right"):
		$ChipThrower.direction = Vector2.RIGHT
		$ChipThrower.position = Vector2(35, 0)
	if event.is_action_pressed("left"):
		$ChipThrower.direction = Vector2.LEFT
		$ChipThrower.position = Vector2(-35, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine = $AnimationTree.get("parameters/playback")
	$Hurtbox.connect("damage", self, "get_hit")
	$IFrame.connect("timeout", self, "breakInvincible")

func _process(delta):
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
		$Sprite.flip_h = (dir.x < 0)
		
		if is_on_floor():
			velocity.x += dir.x * accel * delta
		else:
			velocity.x += (dir.x * accel * delta) / airspeedmodifer
			
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
		velocity.y -= sqrt(gravity * jump * 2) 
		doublejump = true

	if not is_on_floor() and velocity.y < 0 and Input.is_action_just_released("jump") :
		velocity.y += abs(velocity.y) / shortjumpadjustment

##double jump
#	elif doublejump and Input.is_action_just_pressed("jump") and not is_on_floor() and latejumpbuffer == false : 
#		velocity.y -= sqrt(gravity * jump * 2) 
#		doublejump =false
#		jumpbuffer = false
#		latejumpbuffer = false

##buffering jump input
	elif Input.is_action_just_pressed("jump") and not is_on_floor() and not doublejump: 
		jumpbuffer =true
#a timer so we can buffer the input and delete it if takes longer 0.1 seconds to hit the ground
		$"jumpbuffer timer".start() 



	elif latejumpbuffer and Input.is_action_just_pressed("jump") and not is_on_floor():
		velocity.y -= sqrt(gravity * jump * 2) 
		jumpbuffer = false
		latejumpbuffer = false
		doublejump = true
		#print('aaaa')
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

	if is_on_floor() :
		if dir.x != 0 :
			state_machine.travel("move")
			#print("move")
		else :
			state_machine.travel("idle")
			#print("idle")
	else :
		if velocity.y < 0:
			state_machine.travel("jump")
			#print("jump")
		elif velocity.y > 0 :
			state_machine.travel("falling")
			#print("falling")

func _on_landing_body_entered(body):
	#this variable is here to stop the animation from playing when we first load into the scene
	if StopLandingAnimWhenFirstStart : 
		#print("lands")
		state_machine.travel("lands")
	else :
		StopLandingAnimWhenFirstStart = true

# removing the buffer because it took more than 0.1 seconds
func _on_Timer_timeout():
	jumpbuffer = false
	latejumpbuffer = false

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

