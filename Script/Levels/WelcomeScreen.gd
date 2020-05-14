extends CanvasLayer



func _on_PlayTutorialButton_pressed():
	get_tree().change_scene("res://Scenes/Levels/Intro.tscn")


func _on_Level1Button_pressed():
	get_tree().change_scene("res://Scenes/Levels/level1.tscn")


func _on_QuitGameButton_pressed():
	get_tree().quit()
