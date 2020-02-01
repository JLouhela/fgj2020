extends Node2D

export var bullet_pool_size = 50
export var fire_delay_ms = 100

onready var bullet = preload("res://Bullet.tscn")
var bullet_pool = []

# Called when the node enters the scene tree for the first time.
func _ready():
    for _i in range (bullet_pool_size):
        var b = bullet.instance()
        b.position = Vector2(-100, -100)
        b.set_as_toplevel(true)
        add_child(b)
        b.disable()
        b.connect("free_bullet", self, "onBulletFree")
        bullet_pool.append(b)
        $BulletTimer.wait_time = float(fire_delay_ms / 1000.0)
        $BulletTimer.start()

func onBulletFree(b):
    bullet_pool.append(b)
    
func _shoot():
    var b = bullet_pool.pop_back()
    if (!b):
        print("BULLET POOL TOO SMALL MAYDAY")
        return
    b.position = global_position
    b.enable()

func _on_BulletTimer_timeout():
    _shoot()

