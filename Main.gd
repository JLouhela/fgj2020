extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (PackedScene) var Enemy

onready var enemy_patterns = $EnemyPatterns
onready var wave_timer = $EnemyWaveTimer

# Called when the node enters the scene tree for the first time.
func _ready():
    pass


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
