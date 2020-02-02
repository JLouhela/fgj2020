extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func reset_bg():
    $Sprite2.position.y = -2000
    $Sprite.position.y = 0

func _process(delta):
    $Sprite2.position.y += 50 * delta
    $Sprite.position.y += 50 * delta
    if $Sprite.position.y > 2000:
        reset_bg()

        
