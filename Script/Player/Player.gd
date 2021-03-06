extends "res://Script/Character/TemplateCharacter.gd"

#INHERITED VARIABLES FROM (TemplateCharacter.gd):
#const SPEED = 10
#const MAX_SPEED = 100
#const FRICTION = 0.1 #the time to get from MAX_SPEED to 0.

export var disguise_slowdown = 0.25

var motion = Vector2()
var disguised = false
var velocity_multiplier = 1

func _ready():
	Global.Player = self
	



func _physics_process(delta):
	update_movement()
	move_and_slide(motion * velocity_multiplier)
	
func update_movement():
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("move_down") and not Input.is_action_pressed("move_up"):
		motion.y = clamp(motion.y +SPEED, 0, MAX_SPEED)
	elif Input.is_action_pressed("move_up") and not Input.is_action_pressed("move_down"):
		motion.y = clamp(motion.y -SPEED, -MAX_SPEED, 0)
	else:
		motion.y = lerp(motion.y , 0, FRICTION)
		
	if Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
		motion.x = clamp(motion.x +SPEED, 0, MAX_SPEED)
	elif Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		motion.x = clamp(motion.x -SPEED, -MAX_SPEED, 0)
	else:
		motion.x = lerp(motion.x ,0, FRICTION)

# changes to night vision mode, and to dark mode (script: VisionMode)
# night_vision key is: "R" 
func _input(event):
	if Input.is_action_just_pressed("night_vision"):
		get_tree().call_group("Interface", "cycle_vision_mode")
	if Input.is_action_just_pressed("toggle_disguise"):
		toggle_disguise()


# toggle_disguise key is: "E".
func toggle_disguise():
	if disguised:
		reveal()
	elif Global.disguises_count > 0:
		disguise()



func reveal():
	disguised = false
	velocity_multiplier = 1
	collision_layer = 1
	$Sprite.texture = Global.player_sprite
	$LightOccluder2D.occluder  = Global.character_occluder


func disguise():
	disguised = true
	velocity_multiplier = disguise_slowdown
	$DisguiseTimer.start()
	Global.disguises_count -= 1
	Global.DisguiseDisplay.update_disguises(Global.disguises_count)
	collision_layer = 16
	$Sprite.texture = Global.box_sprite
	$LightOccluder2D.occluder = Global.box_occluder
	
	
func _on_DisguiseTimer_timeout():
	reveal()

# Being called by Briefcase.gd
func Got_Briefcase():
#	print("got a briefcase!")
	Global.LootDisplay.update_loot()
	var loot = Node.new()
	loot.set_name("briefcase")
	add_child(loot)
