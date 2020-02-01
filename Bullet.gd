extends Area2D

signal free_bullet

export var bullet_speed = Vector2(0,-1)
var bullet_speed_multiplier = 500

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func _process(delta):
    position += bullet_speed * bullet_speed_multiplier * delta
    if position.y < 0:
        emit_signal("free_bullet", self)

func disable():
    hide()
    set_block_signals(true)

func enable():
    show()
    set_block_signals(false)
    
func set_speed(s):
    bullet_speed = s

func _on_Bullet_area_entered(area):
    print("COLLISION")
    emit_signal("free_bullet", self)

