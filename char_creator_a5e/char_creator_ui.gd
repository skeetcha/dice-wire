extends Control

var heritage: int = 0
var culture: int = 0
var class_val: int = 0
var background: int = 0
var panel: int = 0

var rand: RandomNumberGenerator

signal class_changed(idx: int)
signal heritage_changed(idx: int)
signal background_changed(idx: int)
signal culture_changed(idx: int)

var heritage_features: Dictionary
var heritage_gifts: Dictionary
var culture_features: Dictionary

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
	
	# heritage_changed.emit(heritage)
	features(key, toggle)
	
	if heritage == 0:
		set_view_panel("heritage", "")
	else:
		set_view_panel("heritage", instance.get_text())

func culture_button(toggle: bool, instance: Node):
	var index = instance.get_meta("index", -1)
	var key = instance.get_meta("key", "")
	
	if culture == 0 and toggle:
		culture = index
	elif culture == index and not toggle:
		culture = 0
		$Grid/MiddlePanel/NextButton.visible = false
	else:
		culture = index
	
	cultures(key, toggle)
	# culture_changed.emit(culture)
	
	if culture == 0:
		set_view_panel("culture", "")
	else:
		set_view_panel("culture", instance.get_text())

func class_button(toggle: bool, instance: Node):
	var index = instance.get_meta("index", -1)
	var key = instance.get_meta("key", "")
	
	if class_val == 0 and toggle:
		class_val = index
		$Grid/MiddlePanel/NextButton.visible = true
	elif class_val == index and not toggle:
		class_val = 0
		$Grid/MiddlePanel/NextButton.visible = false
	else:
		class_val = index
	
	# class_changed.emit(class_val)
	
	if class_val == 0:
		set_view_panel("class", "")
	else:
		set_view_panel("class", "Level 1 " + tr(instance.get_text()))
	
	if class_val == 0:
		for label in $Grid/CharacterPanel/StarBox.get_children():
			label.set_text("")
		
		for label in $Grid/CharacterPanel/ModBox.get_children():
			label.set_text("")
	else:
		roll_values()

func background_button(toggle: bool, instance: Node):
	var index = instance.get_meta("index", -1)
	var key = instance.get_meta("key", "")
	
	if background == 0 and toggle:
		background = index
		$Grid/MiddlePanel/NextButton.visible = true
	elif background == index and not toggle:
		background = 0
		$Grid/MiddlePanel/NextButton.visible = false
	else:
		background = index
		
	# background_changed.emit(background)

func _ready():
	for i in range($Grid/HeritagePanel/VBoxContainer/Grid.get_child_count()):
		$Grid/HeritagePanel/VBoxContainer/Grid.get_child(i).toggled.connect(heritage_button.bind($Grid/HeritagePanel/VBoxContainer/Grid.get_child(i)))
		$Grid/HeritagePanel/VBoxContainer/Grid.get_child(i).set_meta("index", i + 1)
		$Grid/HeritagePanel/VBoxContainer/Grid.get_child(i).set_meta("key", $Grid/HeritagePanel/VBoxContainer/Grid.get_child(i).name.to_lower().replace("button", ""))
	
	var heritage_buttons = $Grid/HeritagePanel/VBoxContainer/Grid.get_children()
	heritage_buttons.sort_custom(func(a, b): return tr(a.get_text()) < tr(b.get_text()))
	
	for i in range(len(heritage_buttons)):
		$Grid/HeritagePanel/VBoxContainer/Grid.move_child(heritage_buttons[i], i)
	
	for i in range($Grid/CulturePanel/Scroll/Grid.get_child_count()):
		$Grid/CulturePanel/Scroll/Grid.get_child(i).toggled.connect(culture_button.bind($Grid/CulturePanel/Scroll/Grid.get_child(i)))
		$Grid/CulturePanel/Scroll/Grid.get_child(i).set_meta("index", i + 1)
		$Grid/CulturePanel/Scroll/Grid.get_child(i).set_meta("key", $Grid/CulturePanel/Scroll/Grid.get_child(i).name.to_lower().replace("button", ""))
	
	var culture_buttons = $Grid/CulturePanel/Scroll/Grid.get_children()
	culture_buttons.sort_custom(func(a, b): return tr(a.get_text()) < tr(b.get_text()))
	
	for i in range(len(culture_buttons)):
		$Grid/CulturePanel/Scroll/Grid.move_child(culture_buttons[i], i)
	
	for i in range($Grid/ClassPanel/Grid.get_child_count()):
		$Grid/ClassPanel/Grid.get_child(i).toggled.connect(class_button.bind($Grid/ClassPanel/Grid.get_child(i)))
		$Grid/ClassPanel/Grid.get_child(i).set_meta("index", i + 1)
		$Grid/ClassPanel/Grid.get_child(i).set_meta("key", $Grid/ClassPanel/Grid.get_child(i).name.to_lower().replace("button", ""))
	
	var class_buttons = $Grid/ClassPanel/Grid.get_children()
	class_buttons.sort_custom(func(a, b): return tr(a.get_text()) < tr(b.get_text()))
	
	for i in range(len(class_buttons)):
		$Grid/ClassPanel/Grid.move_child(class_buttons[i], i)
	
	for i in range($Grid/BackgroundPanel/GridContainer.get_child_count()):
		$Grid/BackgroundPanel/GridContainer.get_child(i).toggled.connect(background_button.bind($Grid/BackgroundPanel/GridContainer.get_child(i)))
		$Grid/BackgroundPanel/GridContainer.get_child(i).set_meta("index", i + 1)
		$Grid/BackgroundPanel/GridContainer.get_child(i).set_meta("key", $Grid/BackgroundPanel/GridContainer.get_child(i).name.to_lower().replace("button", ""))
	
	var background_buttons = $Grid/BackgroundPanel/GridContainer.get_children()
	background_buttons.sort_custom(func(a, b): return tr(a.get_text()) < tr(b.get_text()))
	
	for i in range(len(background_buttons)):
		$Grid/BackgroundPanel/GridContainer.move_child(background_buttons[i], i)
	
	rand = RandomNumberGenerator.new()
	
	var f = FileAccess.open('res://char_creator_a5e/heritage_features.json', FileAccess.READ)
	var json_string = f.get_as_text()
	heritage_features = JSON.parse_string(json_string)
	f.close()
	f = FileAccess.open('res://char_creator_a5e/heritage_gifts.json', FileAccess.READ)
	json_string = f.get_as_text()
	heritage_gifts = JSON.parse_string(json_string)
	f.close()
	f = FileAccess.open('res://char_creator_a5e/culture_features.json', FileAccess.READ)
	json_string = f.get_as_text()
	culture_features = JSON.parse_string(json_string)
	f.close()

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

func move_button(button_array: Array[Node], name_array: Array, button_name: String):
	var index: int = name_array.find(button_name)
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

func cultures(key: String, toggle: bool):
	if toggle:
		for i in len(culture_features[key]):
			var feature: Dictionary = culture_features[key][i]
			var label: Node = preload("res://char_creator_a5e/feature_label.tscn").instantiate()
			label.text = feature["name"]
			label.set_tooltip_text(JSON.stringify(feature))
			label.name = "FeatureLabel" + str(i)
			label.set_mouse_filter(MOUSE_FILTER_PASS)
			label.set_autowrap_mode(TextServer.AUTOWRAP_WORD_SMART)
			$Grid/CulturePanel/FeaturesScroll/VBoxContainer.add_child(label)
		
		$Grid/MiddlePanel/NextButton.visible = true
	else:
		for child in $Grid/CulturePanel/FeaturesScroll/VBoxContainer.get_children():
			$Grid/CulturePanel/FeaturesScroll/VBoxContainer.remove_child(child)

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

func set_view_panel(field: String, value: Variant):
	if field == "heritage":
		$Grid/CharacterPanel/HeritageLabel.set_text(value)
	elif field == "culture":
		$Grid/CharacterPanel/CultureLabel.set_text(value)
	elif field == "class":
		$Grid/CharacterPanel/ClassLabel.set_text(value)

func roll_values():
	var roll_value = func(dice_amount: int, dice_val: int, bonus: int):
		var total = 0
		var values: Array[int] = []
		
		for i in range(dice_amount):
			var value = rand.randi_range(1, dice_val)
			total += value
			values.append(value)
		
		total += bonus
		return [total, values]
	
	var sum = func(vals: Array):
		var total = 0
		
		for val in vals:
			total += val
		
		return total
	
	var calculate_mod = func(val: int):
		var mod = floori(float(val - 10) / 2.0)
		var mstr = ""
		
		if mod >= 0:
			mstr += "+"
		
		mstr += str(mod)
		return mstr
	
	var get_str = func(val: int): return "{val}\n{mod}".format({"val": val, "mod": calculate_mod.call(val)})
	
	var scores: Array[int]
	
	for i in range(6):
		var roll = roll_value.call(4, 6, 0)
		roll[1].remove_at(roll[1].find(roll[1].min()))
		scores.append(sum.call(roll[1]))
	
	var set_strs = func(key: int, order: Array, scores: Array[int]):
		for label in $Grid/CharacterPanel/StarBox.get_children():
			label.set_text("")
		
		$Grid/CharacterPanel/StarBox.get_child(key).set_text("⭐")
		
		for i in range(len(order)):
			$Grid/CharacterPanel/ModBox.get_child(i).set_text(get_str.call(scores[order[i]]))
	
	scores.sort()
	scores.reverse()
	
	var orders = [
		[1, [3, 0, 1, 5, 2, 4]], # Adept (DEX,CON,WIS,STR,CHA,INT)
		[5, [5, 1, 2, 3, 4, 0]], # Bard (CHA,DEX,CON,INT,WIS,STR)
		[0, [0, 2, 1, 5, 3, 4]], # Berserker (STR,CON,DEX,WIS,CHA,INT)
		[4, [1, 4, 2, 5, 0, 3]], # Cleric (WIS,STR,CON,CHA,DEX,INT)
		[4, [4, 1, 2, 5, 0, 3]], # Druid (WIS,DEX,CON,CHA,STR,INT)
		[0, [0, 2, 1, 4, 3, 5]], # Fighter (STR,CON,DEX,WIS,INT,CHA)
		[0, [0, 3, 2, 5, 4, 1]], # Herald (STR,CHA,CON,DEX,WIS,INT)
		[0, [0, 2, 1, 4, 3, 5]], # Marshal (STR,CON,DEX,WIS,INT,CHA)
		[1, [3, 0, 2, 5, 1, 4]], # Ranger (DEX,WIS,CON,STR,CHA,INT)
		[1, [5, 0, 1, 3, 2, 4]], # Rogue (DEX,CON,WIS,INT,CHA,STR)
		[5, [5, 2, 1, 3, 4, 0]], # Sorcerer (CHA,CON,DEX,INT,WIS,STR)
		[5, [5, 2, 1, 3, 4, 0]], # Warlock (CHA,CON,DEX,INT,WIS,STR)
		[3, [5, 2, 1, 0, 4, 3]], # Wizard (INT,CON,DEX,CHA,WIS,STR)
	]
	
	print(scores)
	set_strs.call(orders[class_val - 1][0], orders[class_val - 1][1], scores)
