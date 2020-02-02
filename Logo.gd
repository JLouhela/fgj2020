extends Node2D

signal done

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    $Tween.interpolate_property(
        $Sprite, "position",
        $Sprite.position, Vector2($Sprite.position.x, -200),
        3,
        $Tween.TRANS_CUBIC, $Tween.EASE_IN
       )
    $Tween.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass


func _on_Tween_tween_all_completed():
    emit_signal("done")
    queue_free()
