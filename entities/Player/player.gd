extends KinematicBody2D


var velocity = Vector2.ZERO
export var accel = 40 * 60
export var deaccel = 40 * 90
export var maxspeed = 400
export var jump = 150
export var gravity = 100 * 60
export var airspeedmodifer = 2
export var turnspeed = 100

var hp = 100
var invincible = false
export var iframeTime = 1

var buffering
var prevdir = Vector2.ZERO

var state_machine

func _input(event):
	if event.is_action_pressed("shoot"):
		get_node("DefaultGun").shoot()
	if event.is_action_pressed("right"):
		$DefaultGun.direction = Vector2.RIGHT
		$DefaultGun.position = Vector2(35, 0)
	if event.is_action_pressed("left"):
		$DefaultGun.direction = Vector2.LEFT
		$DefaultGun.position = Vector2(-35, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine = $AnimationTree.get("parameters/playback")
	$Hurtbox.connect("damage", self, "get_hit")
	$IFrame.connect("timeout", self, "breakInvincible")


func _input(event):
	if event.is_action_pressed("shoot"):
		get_node("DefaultGun").shoot()

func _process(delta):
	var dir = Vector2.ZERO
	dir.x = (Input.get_action_strength("right") - Input.get_action_strength("left")) 
	
	if not dir == Vector2.ZERO :
		$Sprite.flip_h = (dir.x < 0)
		
		if is_on_floor():
			velocity.x += dir.x * accel * delta
		else:
			velocity.x += (dir.x * accel * delta) / airspeedmodifer
			
		velocity.x = clamp(velocity.x,-maxspeed,maxspeed)
	else :
		if is_on_floor():
			velocity.x = move_toward(velocity.x,0,deaccel * delta * 2.5)
			
			
	if Input.is_action_pressed("jump") and is_on_floor(): 
		velocity.y -= sqrt(gravity) * jump * 2
	
	if not is_on_floor() :
		velocity.y += gravity * delta 
	
	if prevdir != dir and is_on_floor():
		velocity.x = 0 + dir.x * turnspeed
		
	prevdir = dir
	velocity = move_and_slide(velocity,Vector2.UP)
	
	if is_on_floor() :
		if dir.x != 0 :
			state_machine.travel("move")
			print("move")
		else :
			state_machine.travel("idle")
			print("idle")
	else :
		if velocity.y < 0:
			state_machine.travel("jump")
			print("jump")
		elif velocity.y > 0 :
			state_machine.travel("falling")
			print("falling")

func _on_landing_body_entered(body):
	print("lands")
	state_machine.travel("lands")


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
