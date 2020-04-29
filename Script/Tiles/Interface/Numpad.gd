extends Popup

# NOTES:
# after the combination has been guessed correctly,
# the Numpad WILL NOT clear, and will save the
# combination on the display for later use.
# 
# !!! need to make sure this function won't collide with additional locked doors. !!!
# 
# if bugging:
# 1. go to <func reset_lock():> , and enable <$StatusLight.texture = load()> .
# 2. go to <func _on_Timer_timeout():> , and enable <reset_lock()> .

# combination is being set by LockedDoor.gd (generate_combination():)
var combination = []
var guess = []

onready var display = $VBoxContainer/DisplayContainer/Display
onready var light = $VBoxContainer/ButtonContainer/GridContainer/StatusLight

signal combination_correct
signal green_light

func _ready():
	connect_buttons()
	reset_lock()



func connect_buttons():
	for child in $VBoxContainer/ButtonContainer/GridContainer.get_children():
		if child is Button:
			child.connect("pressed",self, "Button_pressed", [child.text])


func Button_pressed(button):
	if button == "OK":
		check_guess()
	else:
		enter( int(button) )



func check_guess():
	if guess == combination:
		$AudioStreamPlayer.stream = load("res://Assets/SFX/twoTone1.ogg")
		$AudioStreamPlayer.play()
		# green light:
		$VBoxContainer/ButtonContainer/GridContainer/StatusLight.texture = load("res://Assets/GFX/Interface/PNG/dotGreen.png")
		emit_signal("green_light")
	else:
		reset_lock()


func enter(button):
	guess.append(button)
	$AudioStreamPlayer.stream = load("res://Assets/SFX/threeTone1.ogg")
	$AudioStreamPlayer.play()
	update_display()
	

func update_display():
	display.text = PoolStringArray(guess).join("")
	if guess.size() > combination.size():
		reset_lock()


func reset_lock():
#	$VBoxContainer/ButtonContainer/GridContainer/StatusLight.texture = load("res://Assets/GFX/Interface/PNG/dotRed.png")
	display.text = ""
	guess.clear()


func _on_Numpad_green_light():
	$Timer.start()
	


func _on_Timer_timeout():
	$Timer.stop()
#	reset_lock()
	emit_signal("combination_correct") 
		# ^ combination_correct is being called by LockedDoor (_on_Numpad_combination_correct)
	
