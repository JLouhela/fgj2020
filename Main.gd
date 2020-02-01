extends Node2D

signal repair_parts_needed
signal upgrade_parts_needed

signal reset_repair
signal reset_upgrades

signal ship_repaired
signal ship_upgraded

var PartPickup = preload("res://PartPickup.gd").new()

const Enemy = preload("res://Enemy.tscn")

onready var enemy_patterns = $EnemyPatterns
onready var wave_timer = $EnemyWaveTimer

var repair_parts_needed = []
var upgrade_parts_needed = []

# Called when the node enters the scene tree for the first time.
func _ready():
    randomize()
    randomize_repair()
    randomize_upgrades()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func spawn_random_wave():
    var wave = enemy_patterns.wave
    for i in range(wave.count):
        var enemy = Enemy.instance()
        self.add_child(enemy)
        enemy.initialize(wave, i)

func _on_EnemyWaveTimer_timeout():
    self.spawn_random_wave()

func randomize_repair():
    self.repair_parts_needed = [
        randi() % 3,
        randi() % 3,
        randi() % 3,
    ]
    emit_signal('repair_parts_needed', self.repair_parts_needed)
    
func randomize_upgrades():
    self.upgrade_parts_needed = [
        3 + randi() % 3,
        3 + randi() % 3,
        3 + randi() % 3,
    ]
    emit_signal('upgrade_parts_needed', self.upgrade_parts_needed)


func _on_Player_part_pickup(type):
    var parts = self.repair_parts_needed
    var signal_name = "repair_parts_needed"
    var complete_signal = "ship_repaired"
    var reset_signal = "reset_repair"

    
    if type > 2:
        parts = self.upgrade_parts_needed
        signal_name = "upgrade_parts_needed"
        complete_signal = "ship_upgraded"
        reset_signal = "reset_upgrades"

    var needed = parts.pop_back()
    if type != needed:
        emit_signal(reset_signal)
        return
        
    if !parts.size():
        emit_signal(complete_signal)
        return
        
    emit_signal(signal_name, parts)
