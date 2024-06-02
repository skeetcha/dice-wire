extends Control

var heritage: int = 0
var class_val: int = 0
var background: int = 0
var panel: int = 0

signal class_changed(idx: int)
signal heritage_changed(idx: int)
signal background_changed(idx: int)

var heritage_features: Dictionary = {
	"dragonborn": [
		{
			"name": "Speed",
			"desc": "Your walking speed is 30 feet."
		},
		{
			"name": "Dragon Breath",
			"desc": "You can use your dragon breath as an action.\nChoose the type of damage dealt by your breath weapon from the following list: acid, cold, fire, force, lightning, necrotic, poison, psychic, radiant, or thunder.\nAdditionally, choose between a 30-foot line that is 5 feet wide or a 15-foot cone for the area that your breath weapon affects. Each creature in the breath’s area makes a Dexterity saving throw. If your breath weapon deals psychic damage, a Wisdom saving throw is made instead of Dexterity; if cold, necrotic, poison, radiant, or thunder, a Constitution saving throw. The DC is 8 + your Constitution modifier + your proficiency bonus.\nA creature takes 2d6 damage on a failed saving throw, or half damage on a success. The damage increases to 3d6 at 4th level, 4d6 at 9th level, 5d6 at 14th level, and 6d6 at 19th level.\nAfter you use your dragon breath, you can’t use it again until you finish a rest."
		}
	]
}

var heritage_gifts: Dictionary = {
	"dragonborn": [
		{
			"name": "Draconic Armor",
			"features": [
				{
					"name": "Claws",
					"desc": "You grow retractable claws from the tips of your fingers. Extending or retracting the claws requires no action. The claws are natural weapons, which you can use to make unarmed strikes that deal slashing damage equal to 1d4 + your Strength modifier."
				}
			]
		},
		{
			"name": "Draconic Fins",
			"features": [
				{
					"name": "Swimmer",
					"desc": "You have a swimming speed of 30 feet and you can hold your breath for up to 15 minutes at a time."
				},
				{
					"name": "Deep Darkvision",
					"desc": "You have darkvision to 60 feet. In addition, your eyes are perfectly adapted for spotting movement at depth, and the radius of your darkvision increases to 120 feet while underwater."
				},
				{
					"name": "Hard to Hit",
					"desc": "While you aren’t wearing armor or your only armor is a shield, your AC is 12 + your Dexterity modifier."
				}
			]
		}
	]
}

func _ready():
	pass

func heritage_button(val: int, toggle: bool):
	if heritage == 0 and toggle:
		heritage = val
		$Grid/MiddlePanel/NextButton.visible = true
	elif heritage == val and not toggle:
		heritage = 0
		$Grid/MiddlePanel/NextButton.visible = false
	else:
		heritage = val
	
	heritage_changed.emit(heritage)

func class_button(val: int, toggle: bool):
	if class_val == 0 and toggle:
		class_val = val
		$Grid/MiddlePanel/NextButton.visible = true
	elif class_val == val and not toggle:
		class_val = 0
		$Grid/MiddlePanel/NextButton.visible = false
	else:
		class_val = val
	
	class_changed.emit(class_val)

func background_button(val: int, toggle: bool):
	if background == 0 and toggle:
		background = val
		$Grid/MiddlePanel/NextButton.visible = true
	elif background == val and not toggle:
		background = 0
		$Grid/MiddlePanel/NextButton.visible = false
	else:
		background = val
	
	background_changed.emit(background)

func features(key: String, toggled: bool):
	if toggled:
		for i in len(heritage_features[key]):
			var feature: Dictionary = heritage_features[key][i]
			var label: Node = preload("res://char_creator_a5e/feature_label.tscn").instantiate()
			label.text = feature["name"]
			label.set_tooltip_text(JSON.stringify(feature))
			label.name = "FeatureLabel" + str(i)
			label.set_mouse_filter(MOUSE_FILTER_PASS)
			$Grid/HeritagePanel/VBoxContainer/Features/Container.add_child(label)
		
		for i in len(heritage_gifts[key]):
			var gift: Dictionary = heritage_gifts[key][i]
			$Grid/HeritagePanel/VBoxContainer/GiftContainer/GiftItems.add_item(gift["name"])
	else:
		for child in $Grid/HeritagePanel/VBoxContainer/Features/Container.get_children():
			$Grid/HeritagePanel/VBoxContainer/Features/Container.remove_child(child)
		
		$Grid/HeritagePanel/VBoxContainer/GiftContainer/GiftItems.clear()
		
		for child in $Grid/HeritagePanel/VBoxContainer/GiftContainer/GiftFeatures.get_children():
			$Grid/HeritagePanel/VBoxContainer/GiftContainer/GiftFeatures.remove_child(child)

func _on_gift_items_item_activated(index):
	if heritage == 0:
		# Null
		pass
	elif heritage == 1:
		# Dwarf
		pass
	elif heritage == 2:
		# Elf
		pass
	elif heritage == 3:
		# Halfling
		pass
	elif heritage == 4:
		# Human
		pass
	elif heritage == 5:
		# Dragonborn
		for i in len(heritage_gifts["dragonborn"][index]):
			var feature: Dictionary = heritage_gifts["dragonborn"][index]["features"][i]
			var label: Node = preload("res://char_creator_a5e/feature_label.tscn").instantiate()
			label.text = feature["name"]
			label.set_tooltip_text(JSON.stringify(feature))
			label.name = "FeatureLabel" + str(i)
			label.set_mouse_filter(MOUSE_FILTER_PASS)
			$Grid/HeritagePanel/VBoxContainer/GiftContainer/GiftFeatures.add_child(label)
	elif heritage == 6:
		# Gnome
		pass
	elif heritage == 7:
		# Orc
		pass
	elif heritage == 8:
		# Planetouched
		pass

func _on_dwarf_button_toggled(toggled_on):
	heritage_button(1, toggled_on)

func _on_elf_button_toggled(toggled_on):
	heritage_button(2, toggled_on)

func _on_halfling_button_toggled(toggled_on):
	heritage_button(3, toggled_on)

func _on_human_button_toggled(toggled_on):
	heritage_button(4, toggled_on)

func _on_dragonborn_button_toggled(toggled_on):
	heritage_button(5, toggled_on)
	features("dragonborn", toggled_on)

func _on_gnome_button_toggled(toggled_on):
	heritage_button(6, toggled_on)

func _on_orc_button_toggled(toggled_on):
	heritage_button(7, toggled_on)

func _on_planetouched_button_toggled(toggled_on):
	heritage_button(8, toggled_on)

func _on_next_button_pressed():
	if panel == 0:
		assert(heritage != 0)
		$Grid/HeritagePanel.visible = false
		$Grid/ClassPanel.visible = true
		$Grid/MiddlePanel/NextButton.visible = false
		$Grid/MiddlePanel/BackButton.visible = true
		
		if class_val != 0:
			$Grid/MiddlePanel/NextButton.visible = true
		
		panel = 1
	elif panel == 1:
		assert(class_val != 0)
		$Grid/ClassPanel.visible = false
		$Grid/BackgroundPanel.visible = true
		$Grid/MiddlePanel/NextButton.visible = false
		
		if background != 0:
			$Grid/MiddlePanel/NextButton.visible = true
		
		panel = 2
	elif panel == 2:
		assert(background != 0)
		$Grid/BackgroundPanel.visible = false
		$Grid/MiddlePanel/NextButton.visible = false
		$Grid/SpacePanel.visible = true
		panel = 3

func _on_barbarian_button_toggled(toggled_on):
	class_button(1, toggled_on)

func _on_bard_button_toggled(toggled_on):
	class_button(2, toggled_on)

func _on_cleric_button_toggled(toggled_on):
	class_button(3, toggled_on)

func _on_druid_button_toggled(toggled_on):
	class_button(4, toggled_on)

func _on_fighter_button_toggled(toggled_on):
	class_button(5, toggled_on)

func _on_monk_button_toggled(toggled_on):
	class_button(6, toggled_on)

func _on_paladin_button_toggled(toggled_on):
	class_button(7, toggled_on)

func _on_ranger_button_toggled(toggled_on):
	class_button(8, toggled_on)

func _on_rogue_button_toggled(toggled_on):
	class_button(9, toggled_on)

func _on_sorcerer_button_toggled(toggled_on):
	class_button(10, toggled_on)

func _on_warlock_button_toggled(toggled_on):
	class_button(11, toggled_on)

func _on_wizard_button_toggled(toggled_on):
	class_button(12, toggled_on)

func _on_acolyte_button_toggled(toggled_on):
	background_button(1, toggled_on)

func _on_artisan_button_toggled(toggled_on):
	background_button(2, toggled_on)

func _on_charlatan_button_toggled(toggled_on):
	background_button(3, toggled_on)

func _on_criminal_button_toggled(toggled_on):
	background_button(4, toggled_on)

func _on_cultist_button_toggled(toggled_on):
	background_button(5, toggled_on)

func _on_entertainer_button_toggled(toggled_on):
	background_button(6, toggled_on)

func _on_exile_button_toggled(toggled_on):
	background_button(7, toggled_on)

func _on_farmer_button_toggled(toggled_on):
	background_button(8, toggled_on)

func _on_folk_hero_button_toggled(toggled_on):
	background_button(9, toggled_on)

func _on_gambler_button_toggled(toggled_on):
	background_button(10, toggled_on)

func _on_guard_button_toggled(toggled_on):
	background_button(11, toggled_on)

func _on_guild_member_button_toggled(toggled_on):
	background_button(12, toggled_on)

func _on_hermit_button_toggled(toggled_on):
	background_button(13, toggled_on)

func _on_marauder_button_toggled(toggled_on):
	background_button(14, toggled_on)

func _on_noble_button_toggled(toggled_on):
	background_button(15, toggled_on)

func _on_outlander_button_toggled(toggled_on):
	background_button(16, toggled_on)

func _on_sage_button_toggled(toggled_on):
	background_button(17, toggled_on)

func _on_sailor_button_toggled(toggled_on):
	background_button(18, toggled_on)

func _on_soldier_button_toggled(toggled_on):
	background_button(19, toggled_on)

func _on_trader_button_toggled(toggled_on):
	background_button(20, toggled_on)

func _on_urchin_button_toggled(toggled_on):
	background_button(21, toggled_on)

func _on_back_button_pressed():
	if panel == 0:
		assert(false) # this shouldn't be happening
	elif panel == 1:
		$Grid/HeritagePanel.visible = true
		$Grid/ClassPanel.visible = false
		$Grid/MiddlePanel/NextButton.visible = true
		$Grid/MiddlePanel/BackButton.visible = false
		panel = 0
	elif panel == 2:
		$Grid/ClassPanel.visible = true
		$Grid/BackgroundPanel.visible = false
		$Grid/MiddlePanel/NextButton.visible = true
		panel = 1
