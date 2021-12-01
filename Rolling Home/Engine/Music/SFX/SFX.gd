extends Node


var menu = load("res://Engine/Music/SFX/DDBB/menu.wav")
var change = load("res://Engine/Music/SFX/DDBB/change.wav")
var transition = load("res://Engine/Music/SFX/DDBB/transition.wav")
var restart = load("res://Engine/Music/SFX/DDBB/restart.wav")

var walk = load("res://Engine/Music/SFX/DDBB/walk.wav")
var roll = load("res://Engine/Music/SFX/DDBB/roll.wav")
var mud = load("res://Engine/Music/SFX/DDBB/mud.wav")
var puddle = load("res://Engine/Music/SFX/DDBB/puddle.wav")
var ice = load("res://Engine/Music/SFX/DDBB/ice.wav")
var ice_2 = load("res://Engine/Music/SFX/DDBB/ice_2.wav")
var hole = load("res://Engine/Music/SFX/DDBB/hole.wav")


func play(sound):
	var sfx = AudioStreamPlayer.new()
	sfx.connect("finished", self, "destroy")
	sfx.pause_mode = Node.PAUSE_MODE_PROCESS
	custom_volume(sound, sfx)
	sfx.set_stream(get(sound))
	add_child(sfx)
	sfx.play()
	
func destroy():
	for child in get_children():
		if !child.playing:
			child.queue_free()
			
func custom_volume(sound, sfx):
	match(sound):
		"walk":
			sfx.set_volume_db(0)
		"transition":
			sfx.set_volume_db(0)
		"mud":
			sfx.set_volume_db(-20)
		_:
			sfx.set_volume_db(-10)
