extends Area2D

func _ready():
	Global.briefcase_count +=1

func _on_Briefcase_body_entered(body):
	Global.Player.Got_Briefcase()
	queue_free()
	
