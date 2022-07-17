extends Node2D


var flying = false
var time = 0
var offsetx = randf()
var offsety = randf()
var death_timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func _process(delta):
    time += delta
    position.x += sin(time+offsetx)/2
    position.y += sin(time+offsety)/5
    
    if not flying:
        return
    
    death_timer += delta
    position.y -= delta*50
    position.x += delta*10
    if death_timer > 10:
        queue_free()


func _on_Area2D_area_entered(area):
    flying = true
