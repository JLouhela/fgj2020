extends Node

onready var enemy1 = preload("res://Enemy.tscn")
onready var enemy2 = preload("res://Enemy2.tscn")
onready var enemy3 = preload("res://Enemy3.tscn")

var waves
var paths

# Called when the node enters the scene tree for the first time.
func _ready():
    paths = [
        load("res://enemy_paths/path1.tres"),
        load("res://enemy_paths/path2.tres"),
        load("res://enemy_paths/path3.tres"),
        load("res://enemy_paths/path4.tres"),
        load("res://enemy_paths/path5.tres"),
        load("res://enemy_paths/path6.tres"),
        load("res://enemy_paths/path7.tres"),
        load("res://enemy_paths/path8.tres"),
        load("res://enemy_paths/path9.tres"),
       ]
       
    waves = [
        {
    "enemy": enemy1,
    "count": 5,
    "speed": 400,
    "rotate": true,
    "shoots": false,
    "interval": 0.5,
},
{
    "enemy": enemy1,
    "count": 7,
    "speed": 350,
    "rotate": true,
    "shoots": false,
    "interval": 0.6,
},
{
    "enemy": enemy2,
    "count": 3,
    "speed": 150,
    "rotate": false,
    "shoots": true,
    "interval": 1,
    "shoot_interval": 4,
    "shoot_at_player": false,
    "bullet_interval": 0.2,
    "bullet_count": 3,
},
{
    "enemy": enemy2,
    "count": 2,
    "speed": 100,
    "rotate": false,
    "shoots": true,
    "interval": 2,
    "shoot_interval": 5,
    "shoot_at_player": false,
    "bullet_interval": 0.2,
    "bullet_count": 8,
},
{
    "enemy": enemy3,
    "count": 5,
    "speed": 600,
    "rotate": false,
    "shoots": true,
    "interval": 0.5,
    "shoot_interval": 1.2,
    "shoot_at_player": true,
    "bullet_interval": 0.3,
    "bullet_count": 1,
},
{
    "enemy": enemy3,
    "count": 5,
    "speed": 600,
    "rotate": false,
    "shoots": true,
    "interval": 0.5,
    "shoot_interval": 1.2,
    "shoot_at_player": true,
    "bullet_interval": 0.3,
    "bullet_count": 1,
},
]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
