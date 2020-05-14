extends Node


# Being called by LockedDoor.gd (generate_combination():)
func generate_combination(length):
	var combination = []
	for number in range(length):
		combination.append( randi() %10 )
	return combination
