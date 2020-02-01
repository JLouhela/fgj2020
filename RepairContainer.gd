extends VBoxContainer

var PP = preload("res://PartPickup.gd").new()

onready var part1 = $Part1
onready var part2 = $Part2
onready var part3 = $Part3

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass


func _new_repair_parts_needed(parts):
    part1.texture = PP.texture_lookup[parts[0]]
    part2.texture = PP.texture_lookup[parts[1]]
    part3.texture = PP.texture_lookup[parts[2]]
