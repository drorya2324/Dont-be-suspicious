extends CanvasModulate
# part of group: Interface
# Night vision keys are: "R" , "X" 

const DARK = Color("111111")
const NIGHTVISION = Color("1d6a0b")

var is_night_vision_ready = true


func _ready():
	visible = true
	$Timer.wait_time = 5
	color = DARK


func _process(delta):
	update_CooldownBar()

# Being called by Player.gd (_input)
func cycle_vision_mode():
	if color == NIGHTVISION:
		DARK_mode()
	elif color == DARK:
		if is_night_vision_ready == true:
			is_night_vision_ready = false
			NIGHTVISION_mode()
		else:
			print("night vision is't ready yet")
			DARK_mode()
		
		
func DARK_mode():
	if $Timer.time_left ==0 :
		$Timer.start()
	color = DARK
	#Global.PlayerDtection.Torch_visibility(true)
	# sound effects:
	$NightVision.stream = load ("res://Assets/SFX/nightvision_off.wav")
	$NightVision.play()
	get_tree().call_group("lights", "show")
	get_tree().call_group("labels", "hide")
	
func NIGHTVISION_mode():
	$Timer.stop()
	color = NIGHTVISION
	#Global.PlayerDtection.Torch_visibility(false)
	get_tree().call_group("lights","hide")
	get_tree().call_group("labels", "show")
	# sound effects:
	$NightVision.stream = load ("res://Assets/SFX/nightvision.wav")
	$NightVision.play()


func update_CooldownBar():
	if $Timer.time_left != 0:
	#	get_tree().call_group("cooldown","updating")
		Global.CooldownBar.updating($Timer.time_left)



func _on_Timer_timeout():
	$Timer.stop()
	is_night_vision_ready = true
	print ("Night vision is ready")
