extends Node2D

export var bullet_pool_size = 50

onready var bullet = preload("res://Bullet.tscn")
var bullet_pool = []
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    for i in range (bullet_pool_size):
        var b = bullet.instance()
        b.position = Vector2(-100, -100)
        get_parent().call_deferred("add_child", b)
        b.hide()
        b.connect("area_entered", self, "onBulletGone" )
        b.getnode("VisibilityNotifier2D").connect("screenexited", self, "onBulletGone" )
        bullet_pool.append(b)

func onBulletFree(bullet):
    bullet_pool.append(bullet)
    print("BULLET_GONE")
    
func _shoot():
    var b = bullet_pool

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
