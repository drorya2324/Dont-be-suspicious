extends CanvasLayer

func _ready():
	Global.CooldownBar = self
	$ProgressBar.show()

func update(time_left):
	$ProgressBar.value = time_left
