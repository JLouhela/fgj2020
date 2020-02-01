extends Node2D

export var speed = 200
export var alive = false

export (Curve2D) var path setget set_path

onready var _path = $Path2D
onready var _path_follow = $Path2D/PathFollow2D
onready var timer = $SpawnTimer
 
var bullet = load("res://Bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
    _path.curve = path
    self.timer.start()

func set_path(new_curve):
    path = new_curve
    if is_inside_tree():
        _path.curve = new_curve

func initialize(wave, index):
    self.path = wave.path
    self.speed = wave.speed
    self.timer.wait_time = wave.interval * (index + 1)
    self.timer.start()

func _process(delta):
    if !self.path or !self.alive:
        return

    self._path_follow.offset += self.speed * delta

    self.position = self._path_follow.position
    self.rotation = self._path_follow.rotation + PI/2
    
    if self._path_follow.unit_offset >= 1:
        self.queue_free()

func spawn():
    self.alive = true


func _on_Enemy_area_entered(area):
    $CollisionShape2D.disabled = true
    # TODO play explosion animation
    # onAnimationFinished -> delete from scene
    queue_free()
