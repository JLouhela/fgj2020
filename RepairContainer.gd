extends VBoxContainer

var PP = preload("res://PartPickup.gd").new()

var parts = []

# Called when the node enters the scene tree for the first time.
func _ready():
    self.parts = [
    $Part1,
    $Part2,
    $Part3
    ]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass


func _new_repair_parts_needed(p):
    for i in range(0, 3):
        if i < p.size():
            parts[i].texture = PP.texture_lookup[p[i]]
        else:
            parts[i].hide()
