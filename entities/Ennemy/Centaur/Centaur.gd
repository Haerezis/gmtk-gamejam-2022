extends KinematicBody2D

var hp = 10

enum {IDLE, MOVE, CHANGE, CHARGE, DASH}
const SPEED = 200

var currentState = MOVE
var direction = Vector2.RIGHT

onready var animPlayer = get_node("AnimationPlayer")

export var maxDistance = 400

func _ready():
	
	$Hurtbox.connect("damage", self, "get_hit")
	$IFrameTimer.connect("timeout", self, "breakInvincible")

func _process(delta):
	if checkPlayer():
		currentState = CHARGE
	
	match currentState:
		IDLE:
			idle()
		MOVE:
			move(delta)
		CHANGE:
			newDirection()
		CHARGE:
			charge()
		DASH:
			dash(delta)

func randomise(array : Array):
	array.shuffle()
	return array.front()

func idle():
	animPlayer.play("IDLE")
	yield(get_tree().create_timer(3.0), "timeout")
	
	currentState = MOVE

func move(delta):
	
	for i in 3:
		position += direction * SPEED * delta / 2
		animPlayer.play("MOVE")
	
	currentState = CHANGE

func newDirection():
	direction = randomise([Vector2.RIGHT, Vector2.LEFT])
	currentState = IDLE
	
	$RayCast2D.cast_to = direction * 400

var charging = false
export var chargeTime = 2.0

func charge():
	charging = true
	animPlayer.play("CHARGE")
	yield(get_tree().create_timer(chargeTime), "timeout")
	currentState = DASH

func dash(delta):
	
	for i in 3:
		position += direction * SPEED * delta * 2
	
	
	currentState = IDLE
	charging = false

func checkPlayer():
	return $RayCast2D.is_colliding()

var invincible = false
export var iframeTime = 1.0

func get_hit(damage):
	if not invincible:
		invincible = true
		$IFrameTimer.wait_time = iframeTime
		$IFrameTimer.start()
		
		hp -= damage
		
		print("oof" + String(hp))
		
		if not hp > 0:
			queue_free()

func breakInvincible():
	invincible = false
