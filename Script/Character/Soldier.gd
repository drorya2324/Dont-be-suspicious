extends "res://Script/Character/NPCs/PlayerDetection.gd"

# Inheriting the following:
#const SPEED = 50
#const MAX_SPEED = 300
#const FRICTION = 0.25 #the time to get from MAX_SPEED to 0.



onready var navigation = get_tree().get_root().find_node("Navigation2D", true, false)
onready var destinations = navigation.get_node("Destinations")

var motion
var possible_destinations
var path

export var minimum_arrival_distance = 5
export var walk_speed = 0.5


func _ready():
	randomize()
	possible_destinations = destinations.get_children()
	make_path()
	
func make_path():
	var new_destination = possible_destinations[randi() % possible_destinations.size() -1]
	path = navigation.get_simple_path(position , new_destination.position , false)

func _physics_process(delta):
	navigate()
	
func navigate():
	var distance_to_destination = position.distance_to(path[0])
	if distance_to_destination > minimum_arrival_distance:
		move()
	else:
		update_path()	



func move():
	look_at(path[0])
	motion = (path[0] - position).normalized() * (MAX_SPEED * walk_speed)
	update_rotation(motion)
	move_and_slide(motion)
	if is_on_wall():
		$Stall.start()
	#	make_path()


func update_rotation(motion):
	var vec0 = Vector2(1,0)
	var rot = vec0.angle_to(motion)
	rotation = lerp(rotation,rot,0.2)


func update_path():
	if path.size() == 1 :
		if $Timer.is_stopped():
			$Timer.start()
	else:
		path.remove(0)


func _on_Timer_timeout():
	make_path()


func _on_Stall_timeout():
	print("stall timeout")
	move_and_slide(motion)
	if is_on_wall():
		make_path()
		

	


