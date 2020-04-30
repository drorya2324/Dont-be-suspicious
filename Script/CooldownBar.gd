extends CanvasLayer

func _ready():
	Global.CooldownBar = self
	$ProgressBar.show()

# Being called by VisionMode.gd (update_CooldownBar)
func update(time_left):
	$ProgressBar.value = time_left
