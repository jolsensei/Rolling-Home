extends CanvasLayer

func _ready():
	SignalManager.connect("transition_in", self, "transition")

func transition():
	$Animation.play("in")
	SFX.play("transition")
	add_child(self)

func _on_Animation_animation_finished(anim_name):
	if anim_name == "in":
		SignalManager.transition_out()
		$Animation.play("out")
