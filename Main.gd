extends Node2D

signal repair_parts_needed
signal upgrade_parts_needed

signal repair_started

signal reset_repair
signal reset_upgrades

signal ship_repaired
signal ship_upgraded

var PartPickup = preload("res://PartPickup.gd").new()
var Explosion = load("res://Explosion.tscn")

onready var enemy_patterns = $EnemyPatterns
onready var wave_timer = $EnemyWaveTimer

var score = 0

var repair_parts_needed = []
var upgrade_parts_needed = []
var repair_count = 0

var repair_parts_broken = []

# Called when the node enters the scene tree for the first time.
func _ready():
    randomize()
    randomize_upgrades()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func spawn_random_wave():

    var wave = enemy_patterns.waves[randi() % enemy_patterns.waves.size()]
    var path = enemy_patterns.paths[randi() % enemy_patterns.paths.size()]
    for i in range(wave.count):
        var enemy = wave.enemy.instance()
        self.add_child(enemy)
        enemy.initialize(wave, path, i)
        enemy.connect("dead", self, "spawn_explosion")
     

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
        if repair_count > 6:
            repair_count = 9
        elif repair_count > 3:
            repair_count = 6
        else:
            repair_count = 3
        randomize_repairs(repair_count)
        return
    elif !is_upgrade:
        emit_signal("repair_started")
        repair_count -= 1
        
    if is_upgrade and parts.size() == 0:
        emit_signal(complete_signal)
        $NotificationManager.notify_upgrade($Player.position.y - 20)
        return
    elif !is_upgrade and parts.size() % 3 == 0:
        var fixed = repair_parts_broken.pop_back()
        $NotificationManager.notify_repair(fixed, $Player.position.y - 20)
        emit_signal(complete_signal)
        #lol hack no return to update ui
    emit_signal(signal_name, parts)

func _on_Player_break_part(break_lvl):
    repair_parts_broken.append($pickUpNameRandomizer.randomizePickUpName())
    $NotificationManager.notify_break(repair_parts_broken.back(), $Player.position.y - 20)
    randomize_repairs(break_lvl * 3)

func _on_ScoreTimer_timeout():
    score += 1
    $HUD/ScoreText.text = ("Score: %d" % score)

func _on_Player_player_dead():
    # TODO
    get_tree().paused = true


func spawn_explosion(pos):
    var obj = Explosion.instance()
    self.add_child(obj)
    obj.position = pos
    obj.play()




func _on_LOGO_done():
    $EnemyWaveTimer.start()
