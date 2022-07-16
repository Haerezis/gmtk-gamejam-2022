extends KinematicBody2D

export var velocity = Vector2()
export var speeeeed = 4000
onready var go_right = true
var playerdetected = false
onready var raycasteight = get_node('RayCast2D')
onready var raycastleft = get_node('RayCast2D2')
onready var player = get_parent().get_node("Player")
func _physics_process(delta: float) -> void:
	velocity.x = 0
	if not playerdetected :
		if go_right :
			velocity.x += speeeeed * delta
			$"player detection/CollisionShape2D2".disabled = true
			$"player detection/CollisionShape2D".disabled = false
		else:
			velocity.x -= speeeeed * delta
			$"player detection/CollisionShape2D2".disabled = false
			$"player detection/CollisionShape2D".disabled = true
		velocity = move_and_slide(velocity, Vector2.UP)
	else : 
		if player.position.x > position.x :
			position.x = lerp(position.x + 158,player.position.x,0.03) - 158
		else:
			position.x = lerp(position.x - 158,player.position.x,0.03) + 158
		move_and_slide(velocity, Vector2.UP)
	turnaruond()


func turnaruond():
	if raycasteight.is_colliding() :
		go_right = 0
	if raycastleft.is_colliding():
		go_right = 2


func _on_player_detection_body_entered(body):
	playerdetected = true
	player = body
	$"time between bullets".start()


func _on_player_detection_body_exited(body):
	playerdetected = false
	$"time between bullets".stop()

func _on_change_dir_timeout():
	if go_right :
		go_right = false 
		$"change dir".start()
	else: 
		go_right =true
		$"change dir".start()


func _on_time_between_bullets_timeout():
	$projectilelauncher.bullet(self.position.direction_to(player.position))
	$"time between bullets".start()
