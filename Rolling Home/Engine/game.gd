extends Node

var current_level = 1

func _unhandled_key_input(event):
	if event.is_action_pressed("full_screen"):
		OS.window_fullscreen = !OS.window_fullscreen
		if !OS.window_fullscreen:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func restart():
	SFX.play("restart")
	get_tree().change_scene('res://Maps/Level'+str(current_level)+'.tscn')
