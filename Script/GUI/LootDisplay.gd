extends ItemList

func _ready():
	Global.LootDisplay = self
	
# Being called by Player.gd (Got_Briefcase)
func update_loot():
	add_icon_item(Global.briefcase_sprite)
