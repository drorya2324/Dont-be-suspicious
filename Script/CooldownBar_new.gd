extends ProgressBar


func _ready():
	Global.CooldownBar = self
	show()

# Being called by VisionMode.gd (update_CooldownBar)
func updating(time_left):
	value = time_left
