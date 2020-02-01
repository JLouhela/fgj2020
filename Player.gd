extends Area2D

signal part_pickup
signal hp_update
signal break_level_update

var move_start_pos = Vector2(-1, -1)
var move_started = false
var width = 32
var height = 64

var hp = 10000
export var break_level = 1

var collision_type = "Player"
var upgrade_idx = 0

# Called when the node enters the scene tree for the first time.
func _ready():
    set_process_input(true)

func _input(event):
    if event is InputEventScreenDrag:
        position += event.relative
        $BulletSpawner.initial_velocity = event.relative
    if event is InputEventKey and event.is_pressed():
        if event.get_scancode() == KEY_B:
            break_level += 1
            print("DEBUG: break level ", break_level)
        if event.get_scancode() == KEY_V:
            _break_ship()
            print("DEBUG: break level ", break_level)
        
func _update_hp():
    if break_level == 0:
        hp += 1
    else:
        hp -= break_level
    emit_signal("hp_update", hp)

func _process(delta):
    _update_hp()
    if position.x - width / 2 < 0:
        position.x = width / 2
    elif position.x + width / 2 > get_viewport_rect().size.x:
        position.x = get_viewport_rect().size.x - width / 2
    if position.y < 0:
        position.y = height / 2
    elif position.y > get_viewport_rect().size.y:
        position.y = get_viewport_rect().size.y - height / 2

func _on_Player_area_entered(area):
    if area.collision_type == "PartPickup":
        emit_signal("part_pickup", area.type)
    else:
        _break_ship()

func upgrade():
    var update_speed = (upgrade_idx % 2) == 1
    if update_speed:
        $BulletSpawner.set_bullet_delay(max(200, $BulletSpawner.fire_delay_ms - 50))
    else:
        $BulletSpawner.bullet_count = min(15, $BulletSpawner.bullet_count + 1)
    upgrade_idx += 1

func _break_ship():
    break_level -= 1
    emit_signal("break_level_update", break_level)
    
func _repair_ship():
    break_level += 1
    emit_signal("break_level_update", break_level)

func _on_Main_ship_upgraded():
    upgrade()
    
func _on_Main_ship_repaired():
    _repair_ship()
