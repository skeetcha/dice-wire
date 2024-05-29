extends Control

var race: int = 0
var class_val: int = 0
var panel: int = 0

func race_button(val: int, toggle: bool):
	if race == 0 and toggle:
		race = val
		$Grid/MiddlePanel.visible = true
	elif race == val and not toggle:
		race = 0
		$Grid/MiddlePanel.visible = false
	else:
		race = val

func class_button(val: int, toggle: bool):
	if class_val == 0 and toggle:
		class_val = val
		$Grid/MiddlePanel.visible = true
	elif class_val == val and not toggle:
		class_val = 0
		$Grid/MiddlePanel.visible = false
	else:
		class_val = val

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
		$Grid/MiddlePanel.visible = false
		panel = 1
	elif panel == 1:
		assert(class_val != 0)
		$Grid/ClassPanel.visible = false
		$Grid/MiddlePanel.visible = false
		panel = 2

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
