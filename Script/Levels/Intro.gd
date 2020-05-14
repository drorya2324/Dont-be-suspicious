extends Node2D

onready var pointer = $ObjectivePointer
onready var target = $ObjectiveTarget
onready var lighter = $Lighter

var text


func _ready():
	$IntroGUI/Popup.show()
	text = get_from_json()
	update_target_position(0)
	$GUI/Control/DisguisesNSuspicion/Disguises.hide()


func _process(delta):
	if Input.is_action_just_pressed("toggle_disguise"):
		Global.Player.reveal()


func get_from_json():
	var file = File.new()
	file.open(Global.IntroMessages, File.READ)
	var content = file.get_as_text()
	file.close()
	return parse_json(content)

	


func update_target_position(number):
	target.show()
	var pos = $ObjectiveMarkers.get_child(0)
	$LighterTween.interpolate_property(lighter,"position",lighter.position,pos.position,2.0,Tween.EASE_IN_OUT)
	if $ObjectiveMarkers.get_child_count()>0:
		$LighterTween.start()
		target.position = pos.position
		$IntroGUI/Popup/MessagesAnimation.play("MessageTransition")
		$IntroGUI/Popup/Label.text = text[str(number)]
		$ObjectiveMarkers.remove_child(pos)
		$SFX/Target_SFX.play()
		if target.position == pointer.position:
			target.hide()
			

func _on_ObjectiveExit1_body_entered(body):
	pointer.position = $ObjectiveMarkers/SimpleDoorObjective.position
	update_target_position(1)
	$ObjectiveAreas/ObjectiveExit1/exit1.call_deferred("set","disabled",true)
	

func _on_ObjectiveSimpleDoor_body_entered(body):
	if $ObjectiveAreas/ObjectiveExit1/exit1.disabled:
		pointer.position = $ObjectiveMarkers/NightVisionObjective.position
		update_target_position(2)
		$ObjectiveAreas/ObjectiveSimpleDoor/simpledoor.call_deferred("set","disabled",true)

func _on_ObjectiveNightVision_body_entered(body):
	if $ObjectiveAreas/ObjectiveSimpleDoor/simpledoor.disabled:
		pointer.position = $ObjectiveMarkers/LockedDoorObjective.position
		update_target_position(3)
		$ObjectiveAreas/ObjectiveNightVision/nightvision.call_deferred("set","disabled",true)



func _on_ObjectiveLockedDoor_body_entered(body):
	if $ObjectiveAreas/ObjectiveNightVision/nightvision.disabled:
		pointer.position = $ObjectiveMarkers/ComputerObjective.position
		update_target_position(4)
		$ObjectiveAreas/ObjectiveLockedDoor/lockeddoor.call_deferred("set","disabled",true)


func _on_ObjectiveComputer_body_entered(body):
	if $ObjectiveAreas/ObjectiveLockedDoor/lockeddoor.disabled:
		pointer.hide()
		update_target_position(5)
		$ObjectiveAreas/ObjectiveComputer/computer.call_deferred("set","disabled",true)

func _on_ObjectiveLockedDoor2_body_entered(body):
	if $ObjectiveAreas/ObjectiveComputer/computer.disabled:
		$IntroGUI/Warning.popup_centered()
		$IntroGUI/Warning/WarningAnimation.play("fade")
	
		update_target_position(6)
		$ObjectiveAreas/ObjectiveLockedDoor2/lockeddoor2.call_deferred("set","disabled",true)

func _on_ObjectiveCameras_body_entered(body):
	if $ObjectiveAreas/ObjectiveLockedDoor2/lockeddoor2.disabled:
		update_target_position(7)
		$ObjectiveAreas/ObjectiveCamera/camera.call_deferred("set","disabled",true)

func _on_Briefcase_body_entered(body):
	if $ObjectiveAreas/ObjectiveCamera/camera.disabled:
		update_target_position(8)
	

