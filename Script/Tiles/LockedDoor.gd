extends "res://Script/Tiles/Door.gd"

# to close Numpad: Q


func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	$Label.rect_rotation = -90 - $DoorSprite.rotation_degrees
	

func _on_Door_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_click:
		Numpad_show()


#func _on_Door_body_entered(body) - inherited from Door.gd


func _on_Door_body_exited(body):
	if body.collision_layer == 1  or body.collision_layer == 16:
		can_click = false
		Numpad_hide()


func _on_Numpad_combination_correct():
	Numpad_hide()
	open()



func Numpad_show():
	get_tree().paused = true
	$CanvasLayer/Numpad.popup_centered()

func Numpad_hide():
	get_tree().paused = false
	$CanvasLayer/Numpad.hide()

func _input(event):
	if Input.is_action_just_pressed("Quit"):
		Numpad_hide()
	
