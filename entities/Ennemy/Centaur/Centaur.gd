extends KinematicBody2D

var hp = 10

enum {CLOSE, IDLE, FOLLOW, CHARGE, DASH, MELEE}
const SPEED = 40

var currentState = CLOSE
var direction = Vector2.RIGHT

onready var animPlayer = get_node("AnimationPlayer")

var target 

var dashing = false

func _ready():
	randomize()
	
	$Hurtbox.connect("damage", self, "get_hit")
	$IFrameTimer.connect("timeout", self, "breakInvincible")
	$TriggerArea.connect("area_entered", self, "seenPlayer")
	$TriggerArea.connect("area_exited", self, "lostPlayer")
	$TriggerArea.connect("body_exited", self, "lostPlayer")
	$MeleeRange.connect("area_entered", self, "playerMeleeRange")

func _process(delta):
	match currentState:
		CLOSE:
			pass
		IDLE:
			idle()
		FOLLOW:
			follow()
		CHARGE:
			charge()
		DASH:
			dash()
		MELEE:
			melee()

func seenPlayer(p):
	target = p
	currentState = IDLE

func idle():
	if randf() < 0.7:
		currentState = FOLLOW
	else:
		pass

func follow():
	changeFlip()
	move_and_slide(getPlayerRotation() * SPEED)
	if randf() < 0.005:
		currentState = CHARGE
	else:
		pass

var chargeOnce = false
func charge():
	if not chargeOnce:
		print("charge")
		chargeOnce = true
		animPlayer.play("CHARGE")
		yield(get_tree().create_timer(1.0), "timeout")
		currentState = DASH

var a = 0.05
func dash():
	
	move_and_slide(-direction * SPEED * 30)
	dashing = true
	currentState = FOLLOW 
	
	if randf() < a:
		print("leftdash")
		currentState = FOLLOW
		dashing = false
		chargeOnce = false
		a = 0.05
	else:
		a += 0.05
		currentState = DASH
		print("dash")

func melee():
	animPlayer.play("MELEE")

func playerMeleeRange():
	currentState = MELEE

func getPlayerRotation():
	if not target == null:
		if target.global_position.x - global_position.x < 0:
			return Vector2.LEFT
			direction = Vector2.LEFT
		else:
			return Vector2.RIGHT
			direction = Vector2.RIGHT

func changeFlip():
	if getPlayerRotation() == Vector2.RIGHT:
		$Sprite.flip_h = false
		$Fist.position = Vector2(60, 0)
	else:
		$Sprite.flip_h = true
		$Fist.position = Vector2(-60, 0)

func lostPlayer(a):
	print("lost player")
	
	currentState = CLOSE
	target = null

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
