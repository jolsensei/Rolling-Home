extends Area2D

var entered = false

func _ready():
	SignalManager.connect("check_ball_on_hole", self, "on_hole")


func on_hole(body):
	if entered and body.name == "Ball" and body.current_size == 0:
		body.queue_free()
		SFX.play("hole")


func _on_Hole_body_entered(body):
	if body.name == "Ball":
		entered = true
		


func _on_Hole_body_exited(body):
	if body.name == "Ball":
		entered = false
