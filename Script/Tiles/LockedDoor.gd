extends "res://Script/Tiles/Door.gd"

func _ready():
	$Label.rect_rotation = - 90 - $DoorSprite.rotation_degrees


func _on_Door_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_click:
		# pause the scene
		$CanvasLayer/Numpad.popup_centered()
		
		
func _on_Door_body_exited(body):
	if body.collision_layer == 1  or body.collision_layer == 16:
		can_click = false
		$CanvasLayer/Numpad.hide()


func _on_Numpad_combination_correct():
	$CanvasLayer/Numpad.hide()
	open()


 
func _on_Computer_combination(numbers, lock_group):
	$CanvasLayer/Numpad.combination = numbers
	$Label.text = lock_group
