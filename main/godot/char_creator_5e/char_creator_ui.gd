extends Control

var race: int = 0
var class_val: int = 0
var background: int = 0
var panel: int = 0

signal class_changed(idx: int)
signal race_changed(idx: int)
signal background_changed(idx: int)

func _ready():
	pass

func race_button(val: int, toggle: bool):
	if race == 0 and toggle:
		race = val
		$Grid/MiddlePanel/NextButton.visible = true
	elif race == val and not toggle:
		race = 0
		$Grid/MiddlePanel/NextButton.visible = false
	else:
		race = val
	
	race_changed.emit(race)

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

func _on_dwarf_button_toggled(toggled_on):
	race_button(1, toggled_on)

func _on_elf_button_toggled(toggled_on):
	race_button(2, toggled_on)

func _on_halfling_button_toggled(toggled_on):
	race_button(3, toggled_on)

func _on_human_button_toggled(toggled_on):
	race_button(4, toggled_on)

func _on_dragonborn_button_toggled(toggled_on):
	race_button(5, toggled_on)

func _on_gnome_button_toggled(toggled_on):
	race_button(6, toggled_on)

func _on_half_elf_button_toggled(toggled_on):
	race_button(7, toggled_on)

func _on_half_orc_button_toggled(toggled_on):
	race_button(8, toggled_on)

func _on_tiefling_button_toggled(toggled_on):
	race_button(9, toggled_on)

func _on_next_button_pressed():
	if panel == 0:
		assert(race != 0)
		$Grid/RacePanel.visible = false
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
		$Grid/RacePanel.visible = true
		$Grid/ClassPanel.visible = false
		$Grid/MiddlePanel/NextButton.visible = true
		$Grid/MiddlePanel/BackButton.visible = false
		panel = 0
	elif panel == 2:
		$Grid/ClassPanel.visible = true
		$Grid/BackgroundPanel.visible = false
		$Grid/MiddlePanel/NextButton.visible = true
		panel = 1
