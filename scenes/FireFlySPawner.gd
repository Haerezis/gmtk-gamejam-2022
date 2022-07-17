extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var tile_map = get_parent()
var FireFly = preload("res://entities/miscellaneous/FireFly.tscn")

func random_fireFly(cell):
    var particle_position = to_global(tile_map.map_to_world(cell))
    var new_particle = FireFly.instance()
    new_particle.global_position = particle_position + rand_vec(1)
    add_child(new_particle)

func rand_vec(mult):
    return Vector2(randf(), randf()) * mult
# Called when the node enters the scene tree for the first time.
func _ready():
    var tiles =  tile_map.get_used_cells()
    if not tiles.size():
        return
    var i = 0
    while i<100:
        var rand_index:int = randi() % tiles.size()
        var cell =tiles[rand_index]
        cell.y -=1
        var above = tile_map.get_cellv(cell)
        if above == -1:
            random_fireFly(cell)
            i+=1
        
        
