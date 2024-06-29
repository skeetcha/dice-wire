extends Control

var heritage: int = 0
var culture: int = 0
var class_val: int = 0
var background: int = 0
var panel: int = 0

signal class_changed(idx: int)
signal heritage_changed(idx: int)
signal background_changed(idx: int)
signal culture_changed(idx: int)

var heritage_features: Dictionary = {
	"dragonborn": [
		{
			"name": "Speed",
			"desc": "Your walking speed is 30 feet."
		},
		{
			"name": "Dragon Breath",
			"desc": "You can use your dragon breath as an action.\nChoose the type of damage dealt by your breath weapon from the following list: acid, cold, fire, force, lightning, necrotic, poison, psychic, radiant, or thunder.\nAdditionally, choose between a 30-foot line that is 5 feet wide or a 15-foot cone for the area that your breath weapon affects. Each creature in the breath's area makes a Dexterity saving throw. If your breath weapon deals psychic damage, a Wisdom saving throw is made instead of Dexterity; if cold, necrotic, poison, radiant, or thunder, a Constitution saving throw. The DC is 8 + your Constitution modifier + your proficiency bonus.\nA creature takes 2d6 damage on a failed saving throw, or half damage on a success. The damage increases to 3d6 at 4th level, 4d6 at 9th level, 5d6 at 14th level, and 6d6 at 19th level.\nAfter you use your dragon breath, you can't use it again until you finish a rest."
		}
	],
	"dwarf": [
		{
			"name": "Speed",
			"desc": "You have a walking speed of 25 feet. Your Speed is not reduced by wearing heavy armor or wielding tower shields."
		},
		{
			"name": "Darkvision",
			"desc": "You have darkvision to 60 feet."
		},
		{
			"name": "Creator's Blessing",
			"desc": "You gain proficiency with one set of artisan's tools (either brewer's supplies or mason's tools) or smith's tools. During a long rest, you can use these tools for crafting instead of sleeping and still receive the full benefits of the long rest."
		},
		{
			"name": "Tough",
			"desc": "Your character level is added to your hit point maximum."
		}
	],
	"elf": [
		{
			"name": "Speed",
			"desc": "You have a walking speed of 30 feet."
		},
		{
			"name": "Darkvision",
			"desc": "You have darkvision to 60 feet."
		},
		{
			"name": "Fey Ancestry",
			"desc": "You gain an expertise die on saving throws against being charmed, and you are immune to magical effects that would put you to sleep."
		},
		{
			"name": "Trance",
			"desc": "Instead of sleeping, elves enter a trance state. When you take a long rest, you spend 4 hours in your trance state (instead of sleeping for 6 hours). During the trance you suffer no penalty to passive Perception. A long rest remains 8 hours for you as normal, and the remainder of the time must be filled only with light activity."
		}
	],
	"gnome": [
		{
			"name": "Speed",
			"desc": "You have a walking speed of 25 feet."
		},
		{
			"name": "Darkvision",
			"desc": "You have darkvision to 60 feet."
		},
		{
			"name": "Gnome Cunning",
			"desc": "You gain an expertise die on Intelligence, Wisdom, and Charisma saving throws made against spells and magical effects."
		},
		{
			"name": "Gnomish Magic",
			"desc": "You know the [i]minor illusion[/i] cantrip. Your spellcasting ability for this spell is Intelligence, Wisdom, or Charisma (whichever is highest)."
		}
	],
	"halfling": [
		{
			"name": "Speed",
			"desc": "You have a walking speed of 25 feet."
		},
		{
			"name": "Fearless",
			"desc": "You are immune to the effects of the frightened condition."
		},
		{
			"name": "Nimble Steps",
			"desc": "If a creature is at least one size larger than you, you can move through its space."
		},
		{
			"name": "Halfling's Luck",
			"desc": "When you make an ability check, attack roll, or saving throw and roll a 1, you can choose to roll again, taking the second result."
		}
	],
	"human": [
		{
			"name": "Speed",
			"desc": "You have a walking speed of 30 feet."
		},
		{
			"name": "Fast Learner",
			"desc": "You gain proficiency in one additional skill of your choice. In addition, you require half as much time as normal to train yourself in the use of a suit of armor, tool, or weapon during downtime."
		},
		{
			"name": "Intrepid",
			"desc": "Once between rests, when you make an ability check, attack roll, or saving throw, you can choose to gain an expertise die on that roll."
		}
	],
	"orc": [
		{
			"name": "Speed",
			"desc": "You have a walking speed of 30 feet."
		},
		{
			"name": "Darkvision",
			"desc": "You have darkvision to 60 feet."
		},
		{
			"name": "Heavy Lifter",
			"desc": "When determining your carrying capacity and the weight that you can push, drag, or lift, your size is considered to be Large."
		},
		{
			"name": "Mighty Attacks",
			"desc": "When you critically hit with a melee weapon attack, roll one of the weapon's damage dice again and add the result to the attack's damage."
		}
	],
	"planetouched": [
		{
			"name": "Speed",
			"desc": "You have a walking speed of 30 feet."
		},
		{
			"name": "Darkvision",
			"desc": "You have darkvision to 60 feet."
		},
		{
			"name": "Immortal Blessing",
			"desc": "Once between long rests, when damage would reduce you to 0 hit points, you are instead reduced to 1 hit point."
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
					"desc": "While you aren't wearing armor or your only armor is a shield, your AC is 12 + your Dexterity modifier."
				}
			]
		},
		{
			"name": "Draconic Wings",
			"features": [
				{
					"name": "Flight",
					"desc": "You have a fly speed of 30 feet. To use this speed, you can't be wearing medium or heavy armor. Whenever you spend 3 full consecutive rounds airborne without landing, you gain a level of fatigue. Any fatigue gained in this way is removed upon finishing a rest."
				}
			]
		}
	],
	"dwarf": [
		{
			"name": "Dwarven Stability",
			"features": [
				{
					"name": "Dwarven Stability",
					"desc": "You gain an expertise die on saving throws against effects that would knock you prone, and on saving throws made to resist being shoved."
				}
			]
		},
		{
			"name": "Dwarven Toughness",
			"features": [
				{
					"name": "Dwarven Toughness",
					"desc": "As a bonus action, you gain a number of temporary hit points equal to 1d10 plus your level. These temporary hit points last for 1 minute. You can't use this trait again until after you finish a long rest.\nYou gain an expertise die on saving throws against poison, and you have resistance against poison damage."
				}
			]
		}
	],
	"elf": [
		{
			"name": "Mystic Rapport",
			"features": [
				{
					"name": "Arcane Sensitivity",
					"desc": "You gain proficiency with Arcana."
				},
				{
					"name": "Arcane Empathy",
					"desc": "You can speak telepathically to a creature within 30 feet of you that you can see. Though this grants the creature no ability to respond telepathically, they can understand you if you share a language. You can speak in this way to one creature at a time."
				}
			]
		},
		{
			"name": "Prescient Vision",
			"features": [
				{
					"name": "Glance the Future",
					"desc": "Your eyes can see a few moments into the future, and your mind apprehends the divergent possibilities. Once between rests you can use a bonus action to roll a d20 and record the result. Before the end of your next rest, when a creature you can see within 60 feet makes an ability check, attack roll, or saving throw, you can use your reaction to replace their roll with your recorded result. When the creature is also rolling an expertise die, only the d20 roll is replaced. When the creature is rolling more than one d20, such as when it has advantage or when a halfling is using their Halfling's Luck trait, the replacement applies to the creature's final roll."
				}
			]
		},
		{
			"name": "Preternatural Awareness",
			"features": [
				{
					"name": "Keen Senses",
					"desc": "You gain proficiency in Perception."
				},
				{
					"name": "Prophetic Instincts",
					"desc": "Your ability to detect danger is nearly supernatural. You gain a bonus to initiative rolls equal to your Wisdom modifier (minumum 1), and you can't be surprised while conscious (including during your Trance)."
				}
			]
		}
	],
	"gnome": [
		{
			"name": "Gnomish Agility",
			"features": [
				{
					"name": "Gnomish Agility",
					"desc": "You gain +1 to your Armor Class against creatures of a size category larger than your own."
				}
			]
		},
		{
			"name": "Into Mist",
			"features": [
				{
					"name": "Into Mist",
					"desc": "Once between rests, as a bonus action or as a reaction immediately after taking damage, you can turn invisible. The invisibility lasts until the end of your next turn, and it ends early if you attack, deal damage, or cast a spell."
				}
			]
		}
	],
	"halfling": [
		{
			"name": "Burrowing Claws",
			"features": [
				{
					"name": "Burrow",
					"desc": "You have a burrowing speed of 10 feet. You can use your burrowing speed to move through nonmagical sand, loose earth, loamy soil, mud, or snow, but not solid rock. You do not naturally leave any sort of tunnel behind but you can attempt to create a 5-foot by 5-foot wide tunnel in earth, soil, or snow by spending extra time and effort shoring it up and adding support. This reduces your burrowing speed to 5 feet every 15 minutes."
				},
				{
					"name": "Claws",
					"desc": "Your nails grow into strong shovel-like claws. The claws are natural weapons, which you can use to make unarmed strikes that deal slashing damage equal to 1d4 + your Strength modifier."
				}
			]
		},
		{
			"name": "Tuft Feet",
			"features": [
				{
					"name": "Big Feet",
					"desc": "You gain an expertise die on checks and saving throws made to resist being knocked prone."
				},
				{
					"name": "Thick Soles",
					"desc": "You are immune to damage from sharp terrain hazards (such as caltrops, broken glass, or the [i]spike growth[/i] spell) and ignore difficult terrain caused by them. Additionally, other kinds of difficult terrain reduce your movement speed by 5 feet instead of halving it."
				}
			]
		},
		{
			"name": "Twilight-Touched",
			"features": [
				{
					"name": "Darkvision",
					"desc": "You have darkvision to 60 feet."
				},
				{
					"name": "Telepathy",
					"desc": "You can speak telepathically to a creature within 30 feet of you that you can see. Though this grants the creature no ability to respond telepathically, they can understand you if you share a language. You can speak in this way to one creature at a time."
				}
			]
		}
	],
	"human": [
		{
			"name": "Diehard Survivor",
			"features": [
				{
					"name": "Feast and Famine",
					"desc": "You can go a number of days equal to your Constitution modifier without suffering any fatigue from lack of Supply. Afterwards you require twice as much Supply for as many days as you went without."
				},
				{
					"name": "Radical Perserverance",
					"desc": "You only die after failing 4 death saving throws instead of 3."
				}
			]
		},
		{
			"name": "Ingenious Focus",
			"features": [
				{
					"name": "Inexorable Concentration",
					"desc": "When you fail a Constitution saving throw to maintain concentration, you can immediately reroll it, taking the new result. You may use this trait a number of times equal to your Intelligence modifier (minimum 1), and regain all expended uses after a long rest."
				},
				{
					"name": "Resident Expert",
					"desc": "Choose two tools with which you are proficient, or a skill with which you are proficient from Animal Handling, Arcana, Culture, Engineering, History, Medicine, Nature, or Religion. When you make a check with that tool or skill and the d20 shows a natural result of less than 10, you can count the d20 result as being 10."
				}
			]
		},
		{
			"name": "Spirited Traveler",
			"features": [
				{
					"name": "Desperate Dash",
					"desc": "Once between rests, when you take the Dash action, your movement this turn does not provoke opportunity attacks. During this movement, you gain an expertise die on Acrobatics checks made to avoid hazards and Dexterity saving throws."
				},
				{
					"name": "Marathon Runner",
					"desc": "The first time between each long rest you would gain a level of fatigue, you do not gain that level of fatigue. You still suffer a level of fatigue from finishing a long rest without any Supply."
				}
			]
		}
	],
	"orc": [
		{
			"name": "Just Like Home",
			"features": [
				{
					"name": "Just Like Home",
					"desc": "Choose one type of terrain, reflecting the area from which your family hails: arctic, desert, mountain, or swamp. You ignore all naturally created difficult terrain of that type. Additionally, you gain an expertise die on Survival checks made within this terrain type, and gain a type of damage resistance related to your chosen terrain: arctic—cold, desert—fire, mountain—lightning, swamp—poison."
				}
			]
		},
		{
			"name": "Ancestral Blessing",
			"features": [
				{
					"name": "Divine Protection",
					"desc": "You have resistance to radiant damage."
				},
				{
					"name": "Touch of Divinity",
					"desc": "You know the [i]resistance[/i] cantrip. In addition, you can cast the [i]shield[/i] spell once per long rest."
				}
			]
		},
		{
			"name": "Magic Adept",
			"features": [
				{
					"name": "Magic Adept",
					"desc": "You are born with magic coursing through your veins, and are able to utilize it in a number of ways. You learn one cantrip of your choice from the wizard spell list. At 3rd level, choose one 1st- or 2nd-level spell from the wizard spell list. Once between long rests, you can cast the chosen spell without any material components. A 1st-level spell chosen this way can be cast at 2nd-level using this trait, if the spell allows. Your spellcasting ability for this trait is the same as the ability score used in the spellcasting class in which you have the highest level, or Charisma if you have no levels in a spellcasting class."
				}
			]
		}
	],
	"planetouched": [
		{
			"name": "Aasimar",
			"features": [
				{
					"name": "Celestial Legacy",
					"desc": "You know the [i]guidance[/i] cantrip. In addition, once between long rests you can use an action to touch a willing creature and restore a number of hit points equal to your level."
				},
				{
					"name": "Divine Protection",
					"desc": "You have resistance to radiant damage."
				},
				{
					"name": "Language",
					"desc": "You have an innate ability to recognize Celestial, and are able to speak, read, write, and sign it."
				}
			]
		},
		{
			"name": "Tiefling",
			"features": [
				{
					"name": "Hellish Resistance",
					"desc": "You have resistance to fire damage."
				},
				{
					"name": "Infernal Legacy",
					"desc": "You know the [i]produce flame[/i] cantrip. Once you reach 3rd level, you can cast [i]arcane riposte[/i] (fire damage only) once between long rests. At 5th level, you can cast [i]heat metal[/i] without material components once between long rests. Charisma is your spellcasting ability for these spells."
				}
			]
		}
	]
}

func heritage_button(toggle: bool, instance: Node):
	var index = instance.get_meta("index", -1)
	var key = instance.get_meta("key", "")
	
	if heritage == 0 and toggle:
		heritage = index
	elif heritage == index and not toggle:
		heritage = 0
		$Grid/MiddlePanel/NextButton.visible = false
	else:
		heritage = index
	
	heritage_changed.emit(heritage)
	features(key, toggle)

func _ready():
	for i in range($Grid/HeritagePanel/VBoxContainer/Grid.get_child_count()):
		$Grid/HeritagePanel/VBoxContainer/Grid.get_child(i).add_user_signal("toggled_with_instance", [
			{ "name": "toggle", "type": TYPE_BOOL },
			{ "name": "instance", "type": PROPERTY_HINT_NODE_TYPE }
		])
		
		$Grid/HeritagePanel/VBoxContainer/Grid.get_child(i).toggled.connect(heritage_button.bind($Grid/HeritagePanel/VBoxContainer/Grid.get_child(i)))
		$Grid/HeritagePanel/VBoxContainer/Grid.get_child(i).set_meta("index", i + 1)
		$Grid/HeritagePanel/VBoxContainer/Grid.get_child(i).set_meta("key", $Grid/HeritagePanel/VBoxContainer/Grid.get_child(i).name.to_lower().replace("button", ""))

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
		
		$Grid/HeritagePanel/VBoxContainer/GiftContainer/GiftItems.ready.emit()
	else:
		for child in $Grid/HeritagePanel/VBoxContainer/Features/Container.get_children():
			$Grid/HeritagePanel/VBoxContainer/Features/Container.remove_child(child)
		
		$Grid/HeritagePanel/VBoxContainer/GiftContainer/GiftItems.clear()
		
		for child in $Grid/HeritagePanel/VBoxContainer/GiftContainer/GiftFeatures.get_children():
			$Grid/HeritagePanel/VBoxContainer/GiftContainer/GiftFeatures.remove_child(child)

func _on_gift_items_item_selected(index):
	var keys: Array[String] = ["", "dragonborn", "dwarf", "elf", "gnome", "halfling", "human", "orc", "planetouched"]
	
	if heritage == 0:
		# Null
		pass
	else:
		# Others
		for child in $Grid/HeritagePanel/VBoxContainer/GiftContainer/GiftFeatures.get_children():
			$Grid/HeritagePanel/VBoxContainer/GiftContainer/GiftFeatures.remove_child(child)
		
		for i in len(heritage_gifts[keys[heritage]][index]["features"]):
			var feature: Dictionary = heritage_gifts[keys[heritage]][index]["features"][i]
			var label: Node = preload("res://char_creator_a5e/feature_label.tscn").instantiate()
			label.text = feature["name"]
			label.set_tooltip_text(JSON.stringify(feature))
			label.name = "FeatureLabel" + str(i)
			label.set_mouse_filter(MOUSE_FILTER_PASS)
			$Grid/HeritagePanel/VBoxContainer/GiftContainer/GiftFeatures.add_child(label)
		
		$Grid/MiddlePanel/NextButton.visible = true

func move_button(button_array: Array[Node], name_array: Array, name: String):
	var index: int = name_array.find(name)
	button_array[index].reparent($Grid/CulturePanel/SuggestedGrid)
	button_array.remove_at(index)
	name_array.remove_at(index)

func setup_culture_buttons(forward: bool):
	if forward:
		if len($Grid/CulturePanel/SuggestedGrid.get_children()) != 0:
			var old_buttons: Array[Node] = $Grid/CulturePanel/SuggestedGrid.get_children()
			
			for button in old_buttons:
				button.reparent($Grid/CulturePanel/Scroll/Grid)
		
		var culture_buttons: Array[Node] = $Grid/CulturePanel/Scroll/Grid.get_children()
		culture_buttons.sort_custom(func(a, b): return a.name.naturalnocasecmp_to(b.name))
		culture_buttons.reverse()
		var culture_names: Array = culture_buttons.map(func(x) -> String: return x.name.replace("Button", ""))
		assert(heritage != 0)
		
		if heritage == 2:
			# Dwarf
			# Deep Dwarf, Forsaken, Godbound, Hill Dwarf, Mountain Dwarf
			move_button(culture_buttons, culture_names, "DeepDwarf")
			move_button(culture_buttons, culture_names, "Forsaken")
			move_button(culture_buttons, culture_names, "Godbound")
			move_button(culture_buttons, culture_names, "HillDwarf")
			move_button(culture_buttons, culture_names, "MountainDwarf")
		elif heritage == 3:
			# Elf
			# Eladrin, High Elf, Shadow Elf, Wood Elf
			move_button(culture_buttons, culture_names, "Eladrin")
			move_button(culture_buttons, culture_names, "HighElf")
			move_button(culture_buttons, culture_names, "ShadowElf")
			move_button(culture_buttons, culture_names, "WoodElf")
		elif heritage == 5:
			# Halfling
			# Kithbáin Halfling, Mistbairn Halfling, Stout Halfling, Tunnel Halfling
			move_button(culture_buttons, culture_names, "KithbainHalfling")
			move_button(culture_buttons, culture_names, "MistbairnHalfling")
			move_button(culture_buttons, culture_names, "StoutHalfling")
			move_button(culture_buttons, culture_names, "TunnelHalfling")
		elif heritage == 6:
			# Human
			# Cosmopolitan, Imperial, Settler, Villager
			move_button(culture_buttons, culture_names, "Cosmopolitan")
			move_button(culture_buttons, culture_names, "Imperial")
			move_button(culture_buttons, culture_names, "Settler")
			move_button(culture_buttons, culture_names, "Villager")
		elif heritage == 1:
			# Dragonborn
			# Dragonbound, Dragoncult
			move_button(culture_buttons, culture_names, "Dragonbound")
			move_button(culture_buttons, culture_names, "Dragoncult")
		elif heritage == 4:
			# Gnome
			# Deep Gnome, Forest Gnome, Forgotten Folx, Tinker Gnome
			move_button(culture_buttons, culture_names, "DeepGnome")
			move_button(culture_buttons, culture_names, "ForestGnome")
			move_button(culture_buttons, culture_names, "ForgottenFolx")
			move_button(culture_buttons, culture_names, "TinkerGnome")
		elif heritage == 7:
			# Orc
			# Caravanner, Stoic Orc, Wildling
			move_button(culture_buttons, culture_names, "Caravanner")
			move_button(culture_buttons, culture_names, "StoicOrc")
			move_button(culture_buttons, culture_names, "Wildling")
	else:
		pass

func _on_next_button_pressed():
	if panel == 0:
		assert(heritage != 0)
		$Grid/HeritagePanel.visible = false
		$Grid/CulturePanel.visible = true
		$Grid/MiddlePanel/NextButton.visible = false
		$Grid/MiddlePanel/BackButton.visible = true
		
		if culture != 0:
			$Grid/MiddlePanel/NextButton.visible = true
		
		setup_culture_buttons(true)
		panel = 1
	elif panel == 1:
		assert(culture != 0)
		$Grid/CulturePanel.visible = false
		$Grid/ClassPanel.visible = true
		$Grid/MiddlePanel/NextButton.visible = false
		
		if class_val != 0:
			$Grid/MiddlePanel/NextButton.visible = true
		
		panel = 2
	elif panel == 2:
		assert(class_val != 0)
		$Grid/ClassPanel.visible = false
		$Grid/BackgroundPanel.visible = true
		$Grid/MiddlePanel/NextButton.visible = false
		
		if background != 0:
			$Grid/MiddlePanel/NextButton.visible = true
		
		panel = 3
	elif panel == 3:
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
		$Grid/CulturePanel.visible = false
		$Grid/MiddlePanel/NextButton.visible = true
		$Grid/MiddlePanel/BackButton.visible = false
		setup_culture_buttons(false)
		panel = 0
	elif panel == 2:
		$Grid/CulturePanel.visible = true
		$Grid/ClassPanel.visible = false
		$Grid/MiddlePanel/NextButton.visible = true
		panel = 1
	elif panel == 3:
		$Grid/ClassPanel.visible = true
		$Grid/BackgroundPanel.visible = false
		$Grid/MiddlePanel/NextButton.visible = true
		panel = 2

func _on_caravanner_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_circusfolk_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_collegiate_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_cosmopolitan_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_deep_dwarf_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_dragonbound_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_deep_gnome_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_dragoncult_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_eladrin_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_forest_gnome_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_forgotten_folx_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_forsaken_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_godbound_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_high_elf_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_hill_dwarf_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_imperial_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_kithbain_halfling_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_lone_wanderer_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_mountain_dwarf_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_mistbairn_halfling_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_nomad_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_settler_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_shadow_elf_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_steamforged_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_stoic_orc_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_stoneworthy_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_stout_halfling_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_tinker_gnome_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_tunnel_halfling_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_tyrannized_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_villager_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_warhordling_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_wildling_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_wood_elf_button_toggled(toggled_on):
	pass # Replace with function body.
