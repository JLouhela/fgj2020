extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
    set_process_input(true)

func _input(event):
    if event is InputEventMouseMotion:
        print("LOL")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
