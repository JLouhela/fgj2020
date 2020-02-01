extends Area2D

signal part_pickup

var move_start_pos = Vector2(-1, -1)
var move_started = false
var width = 32
var height = 64

var collision_type = "Player"
var upgrade_idx = 0

# Called when the node enters the scene tree for the first time.
func _ready():
    set_process_input(true)

func _input(event):
    if event is InputEventScreenDrag:
        position += event.relative
        $BulletSpawner.initial_velocity = event.relative

func _process(delta):
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

func upgrade():
    var update_speed = (upgrade_idx % 2) == 1
    if update_speed:
        $BulletSpawner.set_bullet_delay(max(200, $BulletSpawner.fire_delay_ms - 50))
    else:
        $BulletSpawner.bullet_count = min(15, $BulletSpawner.bullet_count + 1)
    upgrade_idx += 1


func _on_Main_ship_upgraded():
    upgrade()

