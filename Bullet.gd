extends Area2D

signal free_bullet

export var bullet_dir = Vector2(0,-1)
export var bullet_speed = 500

const collision_type = "Bullet"

# Called when the node enters the scene tree for the first time.
func _ready():
    rotation = bullet_dir.angle() + PI/2

func _process(delta):
    position += bullet_dir * bullet_speed * delta

func disable():
    hide()
    set_block_signals(true)

func enable():
    rotation = bullet_dir.angle() + PI/2
    show()
    set_block_signals(false)


func _on_Bullet_area_entered(area):
    emit_signal("free_bullet", self)

func _on_VisibilityNotifier2D_screen_exited():
    emit_signal("free_bullet", self)
    
func _destroy(_foo):
    disable()
    queue_free()
