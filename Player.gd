extends Area2D

signal part_pickup
signal hp_update
signal break_part
signal unnecessary_parts_break
signal take_hit
signal player_dead

var move_start_pos = Vector2(-1, -1)
var move_started = false
var width = 32
var height = 64
var collected_spare_parts = 0

# TODO if adjusted, adjust progress bar max value
var max_hp = 10000
var hp = max_hp
var break_level = 0
var immune = false

var collision_type = "Player"
var upgrade_idx = 0
var repairing = false

onready var sprite = $AnimatedSprite

# Called when the node enters the scene tree for the first time.
func _ready():
    set_process_input(true)

func _input(event):
    if event is InputEventScreenDrag:
        position += event.relative
        $BulletSpawner.initial_velocity = event.relative
    elif event is InputEventScreenTouch:
        if event.is_pressed():
            $BulletSpawner.enable()
        else:
            $BulletSpawner.disable()

    if event is InputEventKey and event.is_pressed():
        if event.get_scancode() == KEY_R:
            _repair_ship()
            print("DEBUG: break level ", break_level)
        if event.get_scancode() == KEY_B:
            _break_ship()
            print("DEBUG: break level ", break_level)
        if event.get_scancode() == KEY_G:
            immune = !immune
            print("DEBUG: god mode ", immune)
        
func _update_hp():
    if break_level == 0 && hp < max_hp:
        hp += 2
    else:
        hp -= break_level + 1
        
    emit_signal("hp_update", hp) 
    if hp <= 0:
        emit_signal("player_dead")

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
        if area.type <= 2:
            if break_level == 0:
                collected_spare_parts += 1
                if collected_spare_parts > 2:
                    collected_spare_parts = 0
                    # TODO display notification at hud
                    emit_signal("unnecessary_parts_break")
                    _break_ship()
            else:
                collected_spare_parts = 0
    else:
        _break_ship()

func add_hp(h):
    hp = min(max_hp, hp + h)

func upgrade():
    add_hp(300)
    var update_speed = (upgrade_idx % 2) == 1
    if update_speed:
        $BulletSpawner.set_bullet_delay(max(200, $BulletSpawner.fire_delay_ms - 50))
    else:
        $BulletSpawner.bullet_count = min(15, $BulletSpawner.bullet_count + 1)
    upgrade_idx += 1

func _break_ship():
    if immune:
        return
    $ImmunityTimer.start()
    $FlickerTimer.start()
    immune = true
    emit_signal("take_hit")
    if break_level == 3:
        hp -= 200
        return

    if repairing:
        repairing = false
        break_level -= 1
    var tmp = break_level
    break_level = min(3, break_level + 1)
    emit_signal("break_part", break_level)
    
func _repair_ship():
    repairing = false
    add_hp(300)
    var tmp = break_level
    break_level = max(0, break_level -1)

func _on_Main_ship_upgraded():
    upgrade()
    
func _on_Main_ship_repaired():
    _repair_ship()

func _on_ImmunityTimer_timeout():
    immune = false

func _on_FlickerTimer_timeout():
    if is_visible():
        hide()
    else:
        show()
    if immune:
        $FlickerTimer.start()
    else:
        show()

func update_anim(hp):
    if hp < 4000:
        sprite.animation = 'Broke2'
    elif hp < 7500:
        sprite.animation = 'Broke1'
    else:
        sprite.animation = 'idle'

func _on_Main_repair_started():
    if break_level > 0:
        repairing = true
