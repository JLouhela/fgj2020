extends Node2D

signal repair_parts_needed

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
