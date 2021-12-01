extends Node2D

enum DIRECTIONS {ui_up, ui_down, ui_left, ui_left}

export (DIRECTIONS) var direction

func _ready():
	pass # Replace with function body.


func correct_direction(dir):
	print(dir)
	print(direction)
	var result = false
	if dir != DIRECTIONS.keys()[direction]:
		result = true
	return result

