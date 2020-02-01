extends Node2D

export var fire_delay_ms = 100
var bullet_count = 1

onready var bullet = preload("res://Bullet.tscn")
var bullet_pool = []
var initial_velocity = Vector2(0,0)

const bullet_sep = 24

# Called when the node enters the scene tree for the first time.
func _ready():
    $BulletTimer.wait_time = float(fire_delay_ms / 1000.0)
    $BulletTimer.start()

func onBulletFree(b):
    b.disable()
    bullet_pool.append(b)
    
func set_bullet_delay(d):
    fire_delay_ms = d
    $BulletTimer.wait_time = float(fire_delay_ms / 1000.0)

func _get_bullet():
    if bullet_pool.size() > 0:
        return bullet_pool.pop_back()
    var b = bullet.instance()
    b.position = Vector2(-100, -100)
    b.set_as_toplevel(true)
    add_child(b)
    b.disable()
    b.connect("free_bullet", self, "onBulletFree")
    return b
    
func _shoot():
    var start_offset_x = (bullet_count / 2) * -bullet_sep
    if bullet_count % 2 == 0:
        start_offset_x += bullet_sep / 2

    for i in range (0, bullet_count):
        var b = _get_bullet()
        var bullet_offset = bullet_sep * i
        b.position = global_position
        b.position.x += start_offset_x + bullet_offset
        if initial_velocity.y < 0:
            b.position.y += initial_velocity.y * 2
        b.enable()

func _on_BulletTimer_timeout():
    _shoot()

