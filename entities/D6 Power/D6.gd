extends RigidBody2D

export var damage = 10

var value
var camera


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func init(value, camera):
	self.value = value
	self.camera = camera
	
	# player layer
	#$Hitbox.set_collision_mask_bit(1, (value == 1))
	# ennemy layer
	#$Hitbox.set_collision_mask_bit(2, true)
