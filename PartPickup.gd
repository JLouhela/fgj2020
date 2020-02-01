extends Area2D

enum Type {REPAIR_1, REPAIR_2, REPAIR_3, UPGRADE_1, UPGRADE_2, UPGRADE_3}

export (Type) var type = Type.REPAIR_1

const repair1_tex = preload("res://gfx/repair1.png")
const repair2_tex = preload("res://gfx/repair2.png")
const repair3_tex = preload("res://gfx/repair3.png")
const upgrade1_tex = preload("res://gfx/upgrade1.png")
const upgrade2_tex = preload("res://gfx/upgrade2.png")
const upgrade3_tex = preload("res://gfx/upgrade3.png")

export var fall_speed = 2
export var noise_octaves = 4
export var noise_period = 20.0
export var noise_persistence = 0.8
export var jiggleStrength = 5.0
export var jiggleDelay = 0.5
var noise = OpenSimplexNoise.new()
var jiggleCum = 0.0

const collision_type = "PartPickup"

# Called when the node enters the scene tree for the first time.
func _ready():
    noise.seed = randi()
    noise.octaves = noise_octaves
    noise.period = noise_period
    noise.persistence = noise_persistence

func randomize():
    type = randi() % 6
    if  type == Type.REPAIR_1:
        $Sprite.texture = repair1_tex
    elif  type == Type.REPAIR_2:
        $Sprite.texture = repair2_tex
    elif  type == Type.REPAIR_3:
        $Sprite.texture = repair3_tex
    elif  type == Type.UPGRADE_1:
        $Sprite.texture = upgrade1_tex
    elif  type == Type.UPGRADE_2:
        $Sprite.texture = upgrade2_tex
    elif  type == Type.UPGRADE_3:
        $Sprite.texture = upgrade3_tex

func _process(delta):
    jiggleCum += delta
    position.y += delta * fall_speed * 10
    if jiggleCum > jiggleDelay:
        jiggleCum -= jiggleDelay
        var change = noise.get_noise_2dv(position) * jiggleStrength
        position.x += change


func _on_VisibilityNotifier2D_screen_exited():
    queue_free()