extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var substantives = ["wing","thruster","rotor","gyroscope","cockpit","plasma","magnetron","dark matter","DeLorean","X-ray","antimatter","coil","field","flux","device","mechanism","fuel","component","toroid","inductor","matter","rod","multiplexer","chamber","shroud","fluxer","inhibitor","accelerant","insulator","accelerant","injector","capacitor","stellarator","generator","superimposer"]
var adjectives = ["Humongous","Puny","Dangerous","Pulsating","Beautiful","Glowing","Van der Graaf's","photoinductionic","Heisenbergian","Cosmotronic","Space-time lost","Einsteinian","Tesla's","Cosmic","Cybernetic","Shielding","Beaming"]
var rng = RandomNumberGenerator.new()
var pickUpName
# Called when the node enters the scene tree for the first time.

func _ready():
    rng.randomize()

func randomizePickUpName():
    var pickUpNameAdjective = rng.randi_range(0, adjectives.size()-1)
    var pickUpNameSubstantive = rng.randi_range(0, substantives.size()-1)
    pickUpName = adjectives[pickUpNameAdjective] +" "+substantives[pickUpNameSubstantive]
    return pickUpName


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
