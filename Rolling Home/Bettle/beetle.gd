extends KinematicBody2D

onready var ray_cast = $RayCast2D

var tile_size = 16
var inputs = {'ui_up' : Vector2.UP, 'ui_down' : Vector2.DOWN, 'ui_right' : Vector2.RIGHT, 'ui_left' : Vector2.LEFT}
var last_dir
var on_ice = false

enum DIRECTIONS {ui_up, ui_down, ui_right, ui_left}

export (DIRECTIONS) var initial_direction

func _ready():
	rotate(DIRECTIONS.keys()[initial_direction])

func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir) and !$Tween.is_active():
			move(dir)
	if event.is_action_pressed("restart"):
		Game.restart()
	if event.is_action_pressed("ui_cancel"):
		BGM.stop()
		get_tree().change_scene("res://Engine/Menu/Menu.tscn")
		
			
func move(dir):
	last_dir = dir
	var vector_pos = inputs[dir] * tile_size
	ray_cast.cast_to = vector_pos
	ray_cast.force_raycast_update()
	rotate(dir)
	$Tween.interpolate_property(self, "position", position, position + vector_pos, 
	0.4, Tween.TRANS_CIRC, Tween.EASE_IN_OUT, 0.05) #Somehow delaying the tween fixed it
	if !ray_cast.is_colliding():
		print("Anda sin bola")
		if !on_ice:
			$Animation.play("walk")
			SFX.play("walk")
		$Tween.start()
	else:
		var collider = ray_cast.get_collider()
		if collider.is_in_group('ball') and collider.move(dir):
			print("Anda con bola")
			if !on_ice:
				$Animation.play("walk")
				SFX.play("walk")
			$Tween.start()
			
func rotate(dir):
	match(dir):
		'ui_up':
			$Sprite.rotation_degrees = 0
		'ui_down':
			$Sprite.rotation_degrees = 180
		'ui_left':
			$Sprite.rotation_degrees = 270
		'ui_right':
			$Sprite.rotation_degrees = 90
			
func cant(dir):
	match(dir):
		'ui_up':
			$Animation.play("cant_up")
		'ui_down':
			$Animation.play("cant_down")
		'ui_left':
			$Animation.play("cant_left")
		'ui_right':
			$Animation.play("cant_right")


func _on_Tween_tween_all_completed():
	SignalManager.check_beetle_on_ice(self)
