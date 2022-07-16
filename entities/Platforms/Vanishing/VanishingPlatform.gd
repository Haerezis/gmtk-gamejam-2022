extends Node2D

export var canVanish = false
export var reappearTime = 1.0
export var timeBeforeVanish = 1.0

func _ready():
	$ReappearTimer.wait_time = reappearTime
	
	$Platform/Area2D.connect("area_entered", self, "vanish")
	$ReappearTimer.connect("timeout", self, "reappear")

func vanish(area):
	if canVanish:
		yield(get_tree().create_timer(timeBeforeVanish), "timeout")
		
		$Platform/Area2D.set_deferred("monitoring", false)
		$Platform/CollisionShape2D.set_deferred("disabled", true)
		$Platform/Sprite.visible = false
		
		$ReappearTimer.start()

func reappear():
	$Platform/Area2D.set_deferred("monitoring", true)
	$Platform/CollisionShape2D.set_deferred("disabled", false)
	$Platform/Sprite.visible = true
