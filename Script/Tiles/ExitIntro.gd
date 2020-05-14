extends ColorRect


func _on_Area2D_body_entered(body):
	var Player_briefcases_count = body.get_child_count()-5
	if Player_briefcases_count == 1:
		#next_level():
		get_tree().change_scene("res://Scenes/Levels/WelcomScreen.tscn")
	else:
		print("you don't have enough briefcases.")
