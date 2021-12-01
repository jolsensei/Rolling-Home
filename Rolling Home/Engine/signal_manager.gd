extends Node

signal update_roll_counter

signal check_ball_on_ice
signal check_beetle_on_ice

signal check_ball_on_home
signal check_ball_on_puddle
signal check_ball_on_mud
signal check_ball_on_hole

signal transition_in
signal transition_out

func update_roll_counter(rolls):
	emit_signal("update_roll_counter", rolls)

func check_ball_on_ice(body):
	emit_signal("check_ball_on_ice", body)
	
func check_beetle_on_ice(body):
	emit_signal("check_beetle_on_ice", body)
	
func check_ball_on_home(body):
	emit_signal("check_ball_on_home", body)
	
func check_ball_on_puddle(body):
	emit_signal("check_ball_on_puddle", body)
	
func check_ball_on_mud(body):
	emit_signal("check_ball_on_mud", body)
	
func check_ball_on_hole(body):
	emit_signal("check_ball_on_hole", body)
	
func transition_in():
	emit_signal("transition_in")
	
func transition_out():
	emit_signal("transition_out")
