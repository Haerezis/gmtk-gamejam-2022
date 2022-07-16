extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2.ZERO
export var accel = 40 * 60
export var deaccel = 40 * 90
export var maxspeed = 400
export var jump = 5
export var air_jump = 250
export var gravity = 100 * 60
export var airspeedmodifer = 2
export var turnspeed = 100
var buffering
var prevdir = Vector2.ZERO
var state_machine

# Called when the node enters the scene tree for the first time.
func _ready():
    Engine.iterations_per_second = 60
    state_machine = $AnimationTree.get("parameters/playback")



func _physics_process(delta):
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
    
    if Input.is_action_pressed("jump"): 
        velocity.y -= delta * air_jump
    
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

func _process(delta):
    pass


func _on_landing_body_entered(body):
    print("lands")
    state_machine.travel("lands")
