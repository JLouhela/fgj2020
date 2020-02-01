extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (PackedScene) var Enemy


# Called when the node enters the scene tree for the first time.
func _ready():
    var enemy = Enemy.instance()
    var path = load("res://enemy_paths/path1.tres")
    enemy.path = path
    self.add_child(enemy)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
