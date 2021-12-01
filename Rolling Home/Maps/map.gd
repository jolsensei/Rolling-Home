extends TileMap

var original_offset
var diff
var tween_lenght = 1
var tween_animation = Tween.TRANS_EXPO
var extra_delay = 0.5

func _ready():
	var home_pos = $Home.position
	var beetle_pos = $Beetle.position
	var tween = Tween.new()
	add_child(tween)

	diff = home_pos - beetle_pos
	tween.interpolate_property($Beetle/Camera2D, "offset", 
	$Beetle/Camera2D.offset, diff, tween_lenght, tween_animation , Tween.EASE_OUT)
	tween.interpolate_property($Beetle/Camera2D, "offset", 
	diff, $Beetle/Camera2D.offset, tween_lenght, tween_animation , Tween.EASE_OUT, tween_lenght+extra_delay)
	tween.start()




