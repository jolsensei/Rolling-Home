extends Area2D

var entered = false

func _ready():
	SignalManager.connect("check_ball_on_puddle", self, "on_puddle")


func on_puddle(body):
	if entered and body.name == "Ball":
		if body.rolls < 10:
			body.rolls = 0
		else:
			body.rolls -= 10
		body.check_ball_size()
		SignalManager.update_roll_counter(body.rolls)
		

func _on_Puddle_body_entered(body):
	if body.name == "Beetle":
		SFX.play("puddle")
	if body.name == "Ball":
		entered = true
	

func _on_Puddle_body_exited(body):
	if body.name == "Ball":
		entered = false
