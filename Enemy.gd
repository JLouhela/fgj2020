extends Node2D

export var speed = 200

export (Curve2D) var path setget set_path

onready var _path = $Path2D
onready var _path_follow = $Path2D/PathFollow2D
 
var bullet = load("res://Bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
    _path.curve = path

func set_path(new_curve):
    path = new_curve
    if is_inside_tree():
        _path.curve = new_curve

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    self._path_follow.offset += self.speed * delta

    self.position = self._path_follow.position
    self.rotation = self._path_follow.rotation + PI/2
    
