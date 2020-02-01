extends Node2D

signal repair_parts_needed
signal upgrade_parts_needed

signal reset_repair
signal reset_upgrades

signal ship_repaired
signal ship_upgraded

var PartPickup = preload("res://PartPickup.gd").new()

onready var enemy_patterns = $EnemyPatterns
onready var wave_timer = $EnemyWaveTimer

var repair_parts_needed = []
var upgrade_parts_needed = []
var repair_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
    randomize()
    randomize_upgrades()
    spawn_random_wave()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func spawn_random_wave():

    var wave = enemy_patterns.waves[randi() % enemy_patterns.waves.size()]
    for i in range(wave.count):
        var enemy = wave.enemy.instance()
        self.add_child(enemy)
        enemy.initialize(wave, i)
     

func _on_EnemyWaveTimer_timeout():
    self.spawn_random_wave()

func randomize_repairs(count):
    self.repair_count = count
    self.repair_parts_needed = []
    for i in range(0, count):
        self.repair_parts_needed.append(randi() % 3)
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
    var is_upgrade = type > 2
    if is_upgrade:
        parts = self.upgrade_parts_needed
        signal_name = "upgrade_parts_needed"
        complete_signal = "ship_upgraded"
        reset_signal = "reset_upgrades"

    var needed = parts.pop_back()
    if type != needed:
        emit_signal(reset_signal)
        randomize_repairs(repair_count)
        return
        
    if is_upgrade and parts.size() == 0:
        emit_signal(complete_signal)
        return
    elif !is_upgrade and parts.size() % 3 == 0:
        emit_signal(complete_signal)
        #lol hack no return to update ui
    
    emit_signal(signal_name, parts)


func _on_Player_break_part(break_lvl):
    randomize_repairs(break_lvl * 3)
