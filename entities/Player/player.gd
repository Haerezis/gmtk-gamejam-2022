extends KinematicBody2D

var hp = 5

var velocity = Vector2.ZERO
export var accel = 40 * 60
export var deaccel = 40 * 90
export var maxspeed = 400
export var jump = 150
export var gravity = 100 * 60
export var airspeedmodifer = 2
export var turnspeed = 100
var firstly = false
var buffering
var prevdir = Vector2.ZERO

func _input(event):
	if event.is_action_pressed("shoot"):
		get_node("DefaultGun").shoot()

func _ready():
	Engine.iterations_per_second = 60
	
	$Hurtbox.connect("damage", self, "get_hit")

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
	if Input.is_action_pressed("jump") and is_on_floor(): 
		$AnimationPlayer.play("jump")
		velocity.y -= sqrt(gravity) * jump * 2
	if not is_on_floor() :
		velocity.y += gravity * delta 
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


func get_hit():
	print("oof" + String(hp))
	
	if not hp > 0:
		queue_free()
