extends KinematicBody2D

export var rad = 500
export var hp = 40

enum {CLOSE, IDLE, FOLLOW, CHARGE, DASH, MELEE}
export var SPEED = 50
export var DASHSPEED = 200

var currentState = CLOSE
var direction = Vector2.RIGHT

onready var animPlayer = get_node("AnimationPlayer")

var target 

var dashing = false

func _ready():
	randomize()
	
	$TriggreArea/CollisionShape2D.radius = rad
	
	$Hurtbox.connect("damage", self, "get_hit")
	$IFrameTimer.connect("timeout", self, "breakInvincible")
	$TriggerArea.connect("area_entered", self, "seenPlayer")
	$TriggerArea.connect("area_exited", self, "lostPlayer")
	$TriggerArea.connect("body_exited", self, "lostPlayer")
	#$MeleeRange.connect("area_entered", self, "playerMeleeRange")

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
	animPlayer.play("IDLE")
	if randf() < 0.7:
		currentState = FOLLOW
	else:
		pass

var b = 0.0005
func follow():
	changeFlip()
	
	move_and_slide(getPlayerRotation() * SPEED)
	
	animPlayer.play("MOVE")
	if randf() < b:
		currentState = CHARGE
		b = 0.0005
	else:
		b += 0.0001

var chargeOnce = false
func charge():
	if not chargeOnce:
		print("charge")
		chargeOnce = true
		animPlayer.play("CHARGE")
		direction = getPlayerRotation()
		yield(get_tree().create_timer(1.0), "timeout")
		currentState = DASH

var a = 0.05
var dashDuration : float
export var minDashDuration = 30
func dash():
	
	animPlayer.play("DASH")
	
	move_and_slide(direction * DASHSPEED)
	
	dashing = true
	currentState = IDLE 
	
	if randf() < a and dashDuration > minDashDuration:
		currentState = FOLLOW
		dashing = false
		chargeOnce = false
		dashDuration = 0
		a = 0.05
	else:
		a += 0.05
		dashDuration += 1
		currentState = DASH

func melee():
	animPlayer.play("MELEE")

func playerMeleeRange():
	currentState = MELEE

func getPlayerRotation():
	if not target == null:
		#print(global_position.x - target.global_position.x)
		
		if global_position.x - target.global_position.x < 0:
			return Vector2(1, 0)
			#direction = Vector2(1, 0)
		elif global_position.x - target.global_position.x > 0:
			return Vector2(-1, 0)
			#direction = Vector2(-1, 0)

func changeFlip():
	if getPlayerRotation() == Vector2.RIGHT:
		$Sprite.flip_h = true
		$Fist.position = Vector2(60, 0)
	else:
		$Sprite.flip_h = false
		$Fist.position = Vector2(-60, 0)

func lostPlayer(a):
	print("lost player")
	
	#currentState = CLOSE
	#target = null

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
