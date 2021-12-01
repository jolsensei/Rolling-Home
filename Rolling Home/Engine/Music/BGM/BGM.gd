extends Node

var bgm = load("res://Engine/Music/BGM/forest-loop.wav")

var player = AudioStreamPlayer.new()

func _ready():
	add_child(player)


func play(track):
	player.connect("finished", self, "loop")
	player.set_stream(get(track))
	player.play()
	
func stop():
	player.disconnect("finished", self, "loop")
	player.stop()
	
func change_volume_db(db):
	player.set_volume_db(db)

func loop():
	player.play()
