extends CanvasLayer

func _ready():
	Global.CooldownBar = self


func update(time_left):
	$ProgressBar.value = time_left
