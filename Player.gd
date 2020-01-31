extends Area2D

var move_start_pos = Vector2(-1, -1)
var move_started = false

# Called when the node enters the scene tree for the first time.
func _ready():
    set_process_input(true)

func _input(event):
    if event is InputEventScreenTouch:
        if move_started:
            #print("move END")
            move_started = false
            return
        #print("move START")
        move_started = true
        move_start_pos = get_viewport().get_mouse_position()
        return
    if !(event is InputEventScreenDrag):
        return
    var move_pos = get_viewport().get_mouse_position()
    var delta_pos = move_pos - move_start_pos;
    move_start_pos = move_pos
    position = Vector2(position.x + delta_pos.x, position.y + delta_pos.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
