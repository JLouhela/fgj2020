extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var substantives = ["wing","thruster","rotor","gyroscope","cockpit"]
var adjectives = ["humongous","puny","dangerous","pulsating","beautiful"]
var rng = RandomNumberGenerator.new()
var pickUpName
# Called when the node enters the scene tree for the first time.

func _ready():
	rng.randomize()

func randomizePickUpName():
	var pickUpNameAdjective = rng.randi_range(0, adjectives.size()-1)
	var pickUpNameSubstantive = rng.randi_range(0, substantives.size()-1)
	pickUpName = "You got "+ adjectives[pickUpNameAdjective] +" "+substantives[pickUpNameSubstantive] + "!"
	return pickUpName


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
