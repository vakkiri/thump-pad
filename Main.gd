extends Node2D

var cutoff_rate = 4000
var min_cutoff = 400
var max_cutoff = 5000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func mod1_down(delta):
	var effect = AudioServer.get_bus_effect(1, 0)
	effect.cutoff_hz -= cutoff_rate * delta
	effect.cutoff_hz = max(min_cutoff, effect.cutoff_hz)
	effect.resonance = 1.0 - (effect.cutoff_hz / max_cutoff)


func mod1_up(delta):
	var effect = AudioServer.get_bus_effect(1, 0)
	effect.cutoff_hz += cutoff_rate * delta
	effect.cutoff_hz = min(max_cutoff, effect.cutoff_hz)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("mod1_down"):
		mod1_down(delta)
	if Input.is_action_pressed("mod1_up"):
		mod1_up(delta)
