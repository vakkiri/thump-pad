extends AudioStreamPlayer

export var bpm = 180.0
export var key = "trigger_1"
export var oneTrigger = false
export var use_loop = false

var beat_length = 1

var loop_continue = 0

var loop = {
	"enabled": false,
	"start": 0,
	"duration": beat_length / 4.0,
	"loop_speed": 1.0,
}


func playSample():
	if playing:
		stop()
	play()


func stopSample():
	stop()


# Called when the node enters the scene tree for the first time.
func _ready():
	beat_length = 60.0 / bpm


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if use_loop:
		var stick_y = round(Input.get_joy_axis(0, 1))
		var stick_x = round(Input.get_joy_axis(0, 0))
#		if stick_y < 0.001 and stick_y > -0.001:
#			stick_y = 0
		if stick_y != 0 and not loop["enabled"]:
			loop["start"] = get_playback_position()
			loop_continue = loop["start"]
			print(loop["start"])
			
		if stick_y != 0 or stick_x != 0:
			loop["enabled"] = true
		else:
			if loop["enabled"]:
				seek(loop_continue)
			loop["enabled"] = false
		
	if loop["enabled"]:
		loop_continue += delta
		# Y AXIS ======================================================
		var speed_scale = (Input.get_joy_axis(0, 1) * 2.0) + 2.0
		var duration = loop["duration"]
		duration = duration * float(speed_scale)
		var end = loop["start"] + duration
		
		#var start = start - beat_length * scale
		if get_playback_position() > end:
			seek(loop["start"])
		
			
			
			
	if Input.is_action_just_pressed(key):
		playSample()
	if not oneTrigger:
		if not Input.is_action_pressed(key):
			stop()
