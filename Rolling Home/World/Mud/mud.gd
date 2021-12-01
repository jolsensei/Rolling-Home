extends Area2D


var entered = false

func _ready():
	SignalManager.connect("check_ball_on_mud", self, "on_mud")


func on_mud(body):
	if entered and body.name == "Ball":
		if body.rolls >= 11:
			body.rolls = 20
		else:
			body.rolls += 10
		body.check_ball_size()
		SignalManager.update_roll_counter(body.rolls)
	



func _on_Mud_body_entered(body):
	if body.name == "Beetle":
		SFX.play("mud")
		print("Barro")
	if body.name == "Ball":
		entered = true
		
	

func _on_Mud_body_exited(body):
	if body.name == "Ball":
		entered = false
