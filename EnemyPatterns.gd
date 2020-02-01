extends Node

onready var enemy1 = preload("res://Enemy.tscn")
onready var enemy2 = preload("res://Enemy2.tscn")



var waves

# Called when the node enters the scene tree for the first time.
func _ready():
    waves = [
        {
    "enemy": enemy1,
    "count": 5,
    "speed": 400,
    "rotate": true,
    "shoots": false,
    "interval": 0.5,
    "path": load("res://enemy_paths/path1.tres"),
    "rand_loc": false,
},
{
    "enemy": enemy1,
    "count": 7,
    "speed": 350,
    "rotate": true,
    "shoots": false,
    "interval": 0.6,
    "path": load("res://enemy_paths/path3.tres"),
    "rand_loc": false,
},
{
    "enemy": enemy2,
    "count": 3,
    "speed": 150,
    "rotate": false,
    "shoots": false,
    "interval": 1,
    "path": load("res://enemy_paths/path2.tres"),
    "rand_loc": true,
},
{
    "enemy": enemy2,
    "count": 5,
    "speed": 600,
    "rotate": false,
    "shoots": false,
    "interval": 0.5,
    "path": load("res://enemy_paths/path4.tres"),
    "rand_loc": true,
},
    ]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
