extends Area2D

enum SIZE {small, medium, big}

export (SIZE) var goal

export var next_level = 0

var entered = false

func _ready():
	SignalManager.connect("check_ball_on_home", self, "home")
	SignalManager.connect("transition_out", self, "change_level")
	Game.current_level = next_level-1
	$Sprite.frame = goal
	$SizeGoal.frame = goal
	$Animation.play("alert")

func home(body):
	if entered and body.get('current_size') != null and body.current_size == goal:
		SignalManager.transition_in()
		
func change_level():
	get_tree().change_scene('res://Maps/Level'+str(next_level)+'.tscn')

func _on_Home_body_entered(body):
	if body.name == "Ball":
		entered = true
