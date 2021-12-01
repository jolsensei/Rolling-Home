extends Node2D

func _ready():
	SignalManager.connect("update_roll_counter", self, "update_roll_counter")	

func update_roll_counter(rolls):
	if rolls < 21:
		$Sprite.frame = rolls

