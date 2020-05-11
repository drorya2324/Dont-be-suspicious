extends Node



var IntroMessages = "res://JSON files/IntroMessages.json"

var Player
var CooldownBar
var PlayerDtection
var DisguiseDisplay
var disguises_count = 3
var LootDisplay
var briefcase_count = 0

# Being used by Player.gd
var box_sprite = load("res://Assets/GFX/PNG/Tiles/tile_129.png")
var player_sprite = load("res://Assets/GFX/PNG/Hitman 1/hitman1_stand.png")
var briefcase_sprite = load("res://Assets/GFX/Loot/suitcase.png")
var box_occluder = load("res://Scenes/Character/BoxOccluder.tres")
var character_occluder = load("res://Scenes/Character/CharacterOccluder.tres")
#var character_collision = load()

var Level1 = "res://Scenes/Levels/level1.tscn"

