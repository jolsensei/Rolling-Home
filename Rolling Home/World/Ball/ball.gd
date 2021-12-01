extends KinematicBody2D

onready var ray_cast = $RayCast2D

var tile_size = 16
var inputs = {'ui_up' : Vector2.UP, 'ui_down' : Vector2.DOWN, 'ui_right' : Vector2.RIGHT, 'ui_left' : Vector2.LEFT}

enum SIZE {small, medium, big}
var current_size = SIZE.small
var rolls = 0
var max_rolls = 20
var last_dir
var on_ice = false
			
func move(dir):
	last_dir = dir
	var can_move = false
	var vector_pos = inputs[dir] * tile_size
	ray_cast.cast_to = vector_pos
	ray_cast.force_raycast_update()
	$Tween.interpolate_property(self, "position", position, position + vector_pos, 
	0.4, Tween.TRANS_CIRC, Tween.EASE_IN_OUT)
	
	if !ray_cast.is_colliding():
		can_move = true
		$Tween.start()
		rotate(dir)
		if !on_ice and rolls < max_rolls: 
			rolls += 1
			SignalManager.update_roll_counter(rolls)
		if !on_ice:
			start_animation()
			SFX.play("roll")
		print("Rolls: "+str(rolls))
	print("Escarabajo se puede mover: "+str(can_move))
	return can_move
	
func check_ball_size():
	var initial_size = current_size
	if rolls < 10:
		$Sprite.frame = 0
		current_size = SIZE.small
	elif rolls >= 10 and rolls < 20:
		$Sprite.frame = 10
		current_size = SIZE.medium
	elif rolls >= 20:
		$Sprite.frame = 20
		current_size = SIZE.big
	
	if current_size != initial_size:
		SFX.play("change")
		
func rotate(dir):
	match(dir):
		'ui_up':
			$Sprite.rotation_degrees = 180
		'ui_down':
			$Sprite.rotation_degrees = 0
		'ui_left':
			$Sprite.rotation_degrees = 90
		'ui_right':
			$Sprite.rotation_degrees = 270
	
func start_animation():
	match current_size:
		SIZE.small:
			$Animation.play("roll_small")
		SIZE.medium:
			$Animation.play("roll_medium")
		SIZE.big:
			$Animation.play("roll_big")

func _on_Animation_animation_finished(anim_name):
	if rolls != 21:
		check_ball_size()
			

func _on_Tween_tween_all_completed():
	SignalManager.check_ball_on_ice(self)
	SignalManager.check_ball_on_home(self)
	SignalManager.check_ball_on_puddle(self)
	SignalManager.check_ball_on_mud(self)
	SignalManager.check_ball_on_hole(self)
