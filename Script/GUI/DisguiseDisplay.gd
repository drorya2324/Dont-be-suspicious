extends ItemList




func _ready():
	Global.DisguiseDisplay = self
	update_disguises(Global.disguises_count)


# Being called by Player.gd (disguise)
func update_disguises(number):
	clear()
	for disguises in range(number):
		if number >0:
			add_icon_item(Global.box_sprite, false)
		else:
			clear()
			#signal no_disguises
		
		
#func disguised_used(number):
#	if items.count() >= number:
#		items.delete()
