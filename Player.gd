extends Area2D

signal part_pickup

var move_start_pos = Vector2(-1, -1)
var move_started = false

# Called when the node enters the scene tree for the first time.
func _ready():
    set_process_input(true)

func _input(event):
    if event is InputEventScreenDrag:
        position += event.relative

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass


func _on_Player_area_entered(area):
    if area.collision_type == "PartPickup":
        emit_signal("part_pickup", area.type)

