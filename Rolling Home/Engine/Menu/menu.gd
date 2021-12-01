extends CanvasLayer

var first_level = 1
var last_level = 15

func _ready():
	$Animation.play("intro")
	OS.window_fullscreen = true
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $Level.visible:
		get_tree().change_scene("res://Maps/Level"+str($Level/Selector.frame)+".tscn")
		BGM.play("bgm")
	if event.is_action_pressed("ui_cancel") and $Level.visible:
		$Level.visible = false
		$Menu.visible = true
		SFX.play("menu")
		
	if event.is_action_pressed("ui_down") or event.is_action_pressed("ui_up"):
		SFX.play("menu")
		$Menu.frame = 1 if $Menu.frame == 0 else 0
	if event.is_action_pressed("ui_right") and $Level.visible and $Level/Selector.frame < last_level:
		SFX.play("menu")
		$Level/Selector.frame += 1
	if event.is_action_pressed("ui_left") and $Level.visible and $Level/Selector.frame > first_level:
		SFX.play("menu")
		$Level/Selector.frame -= 1
	if event.is_action_pressed("ui_accept") and $Menu.visible and $Menu.frame == 0:
		if !$Level.visible:
			$Level.visible = true
			$Menu.visible = false
			SFX.play("menu")
	elif event.is_action_pressed("ui_accept") and $Menu.visible and $Menu.frame == 1:
		SFX.play("menu")
		get_tree().quit()
	

func _on_Timer_timeout():
	$MenuAnimation.play("menu")
