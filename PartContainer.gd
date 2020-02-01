extends VBoxContainer

var PP = preload("res://PartPickup.gd").new()

var parts = []
var orig_colors = []

# Called when the node enters the scene tree for the first time.
func _ready():
    self.parts = [
    $Part1,
    $Part2,
    $Part3
    ]
    self.orig_colors = [
        $Part1.modulate,
        $Part2.modulate,
        $Part3.modulate,
    ]
    blah(3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass


func blah(cunt):
    var part
    for i in range(cunt - 2, -1, -1):
        part = self.parts[i]
        part.modulate = self.orig_colors[i].darkened(0.3)

    part = self.parts[cunt - 1]
    part.rect_min_size = Vector2(54, 54)
    part.modulate = self.orig_colors[cunt - 1]

func _new_parts_needed(p):
    for i in range(0, 3):
        if i < p.size():
            parts[i].texture = PP.texture_lookup[p[i]]
            parts[i].show()
        else:
            parts[i].hide()
        parts[i].rect_min_size = Vector2(32, 32)
            
    blah(p.size())
