extends Node2D

signal dead

export var speed = 200
export var alive = false
export var part_spawn_rate = 0.1

export (Curve2D) var path setget set_path

onready var _path = $Path2D
onready var _path_follow = $Path2D/PathFollow2D
onready var timer = $SpawnTimer
onready var bullet_timer = $BulletTimer
onready var shoot_timer = $ShootTimer
onready var visnot = $VisibilityNotifier2D

onready var bullet = preload("res://EnemyBullet.tscn")
onready var part = preload("res://PartPickup.tscn")

onready var player = get_tree().get_root().get_node("Main/Player")
onready var main = get_tree().get_root().get_node("Main")

var shoots = false
var shooting = false
var rotate = true
var shoot_at_player = true
var bullet_count = 1

const collision_type = "Enemy"

# Called when the node enters the scene tree for the first time.
func _ready():
    _path.set_as_toplevel(true)
    _path.curve = path
    self.timer.start()

func set_path(new_curve):
    path = new_curve
    if is_inside_tree():
        _path.curve = new_curve

func initialize(wave, path, index):
    self.path = path
#    self._path.position = Vector2(0, 0)
    self.speed = wave.speed
    
    self.rotate = wave.rotate
    
    if wave.shoots:
        self.shoots = wave.shoots
        self.shoot_at_player = wave.shoot_at_player
        self.bullet_count  = wave.bullet_count
        shoot_timer.wait_time = wave.shoot_interval
    
#    self._path.global_position = self.global_position
    
    self.timer.wait_time = wave.interval * (index + 1)
    self.timer.start()

func _process(delta):
    if !self.alive:
        return
    
    if shooting and !shoot_at_player:
        return
    
    self._path_follow.offset += self.speed * delta

    self.position = self._path_follow.position
    if self.rotate:
        self.rotation = self._path_follow.rotation + PI/2
    
    if self._path_follow.unit_offset >= 1:
        self.queue_free()
    

func spawn():
    self.alive = true
    if self.shoots:
        shoot_timer.start()


func _on_Enemy_area_entered(area):
    $CollisionShape2D.disabled = true
    call_deferred("_destroy")
    
func _destroy():
    $CollisionShape2D.disabled = true
    _spawn_part()
    # TODO play explosion animation
    # onAnimationFinished -> delete from scene
    emit_signal("dead", self.global_position)
    queue_free()

func _spawn_part():
    var lottery = randf() # Need RandomNumberGenerator?
    if lottery < part_spawn_rate:
        var p = part.instance()
        p.randomize()
        p.position = global_position
        p.set_as_toplevel(true)
        get_parent().add_child(p)


func _on_BulletTimer_timeout():
    pass
    

func _on_ShootTimer_timeout():
    if !visnot.is_on_screen():
        return
    self.shooting = true

    var bul_angle = PI/PI/float(bullet_count)
    
    for b in bullet_count:
        var bul = bullet.instance()
        bul.position = self.position
        bul.set_as_toplevel(true)
        bul.connect("free_bullet", bul, "_destroy")
        main.add_child(bul)
        if shoot_at_player and player:
            bul.bullet_dir = self.position.direction_to(player.position)
        else:
            var angle = bul.bullet_dir.angle() - (bul_angle * bullet_count/2) + (b * bul_angle)
            bul.bullet_dir = Vector2(cos(angle), sin(angle))
            
        bul.enable()
    self.shooting = false
