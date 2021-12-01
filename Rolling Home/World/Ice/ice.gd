extends Area2D

var beetle_on_ice = false
var ball_on_ice = false

func _ready():
	SignalManager.connect("check_beetle_on_ice", self, "beetle_on_ice")
	SignalManager.connect("check_ball_on_ice", self, "ball_on_ice")

func beetle_on_ice(body):
	if beetle_on_ice:
		print("Hielo mueve escarabajo")
		body.move(body.last_dir)
		
func ball_on_ice(body):
	if ball_on_ice:
		print("Hielo mueve pelota")
		body.move(body.last_dir)


func _on_Ice_body_entered(body):
	if body.name == "Ball" or body.name == "Beetle":
		SFX.play("ice_2")
	match(body.name):
		"Ball":
			ball_on_ice = true
			body.on_ice = !body.on_ice #To fix area exited
		"Beetle":
			beetle_on_ice = true
			body.on_ice = !body.on_ice #To fix area exited

func _on_Ice_body_exited(body):
	match(body.name):
		"Ball":
			ball_on_ice = false
			body.on_ice = !body.on_ice #To fix area entered
		"Beetle":
			beetle_on_ice = false
			body.on_ice = !body.on_ice #To fix area exited
