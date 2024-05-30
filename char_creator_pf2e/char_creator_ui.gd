extends Control

var ancestry: int = 0
var class_val: int = 0
var background: int = 0
var panel: int = 0

signal class_changed(idx: int)
signal ancestry_changed(idx: int)
signal background_changed(idx: int)

func _ready():
	pass

func ancestry_button(val: int, toggle: bool):
	if ancestry == 0 and toggle:
		ancestry = val
		$Grid/MiddlePanel/NextButton.visible = true
	elif ancestry == val and not toggle:
		ancestry = 0
		$Grid/MiddlePanel/NextButton.visible = false
	else:
		ancestry = val
	
	ancestry_changed.emit(ancestry)

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

func _on_next_button_pressed():
	if panel == 0:
		assert(ancestry != 0)
		$Grid/AncestryPanel.visible = false
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

func _on_back_button_pressed():
	if panel == 0:
		assert(false) # this shouldn't be happening
	elif panel == 1:
		$Grid/AncestryPanel.visible = true
		$Grid/ClassPanel.visible = false
		$Grid/MiddlePanel/NextButton.visible = true
		$Grid/MiddlePanel/BackButton.visible = false
		panel = 0
	elif panel == 2:
		$Grid/ClassPanel.visible = true
		$Grid/BackgroundPanel.visible = false
		$Grid/MiddlePanel/NextButton.visible = true
		panel = 1


func _on_dwarf_button_toggled(toggled_on):
	ancestry_button(1, toggled_on)

func _on_elf_button_toggled(toggled_on):
	ancestry_button(2, toggled_on)

func _on_gnome_button_toggled(toggled_on):
	ancestry_button(3, toggled_on)

func _on_goblin_button_toggled(toggled_on):
	ancestry_button(4, toggled_on)

func _on_halfling_button_toggled(toggled_on):
	ancestry_button(5, toggled_on)

func _on_human_button_toggled(toggled_on):
	ancestry_button(6, toggled_on)

func _on_leshy_button_toggled(toggled_on):
	ancestry_button(7, toggled_on)

func _on_orc_button_toggled(toggled_on):
	ancestry_button(8, toggled_on)

func _on_bard_button_toggled(toggled_on):
	class_button(1, toggled_on)

func _on_cleric_button_toggled(toggled_on):
	class_button(2, toggled_on)

func _on_druid_button_toggled(toggled_on):
	class_button(3, toggled_on)

func _on_fighter_button_toggled(toggled_on):
	class_button(4, toggled_on)

func _on_ranger_button_toggled(toggled_on):
	class_button(5, toggled_on)

func _on_rogue_button_toggled(toggled_on):
	class_button(6, toggled_on)

func _on_witch_button_toggled(toggled_on):
	class_button(7, toggled_on)

func _on_wizard_button_toggled(toggled_on):
	class_button(8, toggled_on)


func _on_acolyte_button_toggled(toggled_on):
	background_button(1, toggled_on)

func _on_acrobat_button_toggled(toggled_on):
	background_button(2, toggled_on)

func _on_animal_whisperer_button_toggled(toggled_on):
	background_button(3, toggled_on)

func _on_artisan_button_toggled(toggled_on):
	background_button(4, toggled_on)

func _on_artist_button_toggled(toggled_on):
	background_button(5, toggled_on)

func _on_bandit_button_toggled(toggled_on):
	background_button(6, toggled_on)

func _on_barkeep_button_toggled(toggled_on):
	background_button(7, toggled_on)

func _on_barrister_button_toggled(toggled_on):
	background_button(8, toggled_on)

func _on_charlatan_button_toggled(toggled_on):
	background_button(9, toggled_on)

func _on_bounty_hunter_button_toggled(toggled_on):
	background_button(10, toggled_on)

func _on_cook_button_toggled(toggled_on):
	background_button(11, toggled_on)

func _on_criminal_button_toggled(toggled_on):
	background_button(12, toggled_on)

func _on_cultist_button_toggled(toggled_on):
	background_button(13, toggled_on)

func _on_detective_button_toggled(toggled_on):
	background_button(14, toggled_on)

func _on_emissary_button_toggled(toggled_on):
	background_button(15, toggled_on)

func _on_entertainer_button_toggled(toggled_on):
	background_button(16, toggled_on)

func _on_farmhand_button_toggled(toggled_on):
	background_button(17, toggled_on)

func _on_field_medic_button_toggled(toggled_on):
	background_button(18, toggled_on)

func _on_fortune_teller_button_toggled(toggled_on):
	background_button(19, toggled_on)

func _on_gambler_button_toggled(toggled_on):
	background_button(20, toggled_on)

func _on_gladiator_button_toggled(toggled_on):
	background_button(21, toggled_on)

func _on_guard_button_toggled(toggled_on):
	background_button(22, toggled_on)

func _on_herbalist_button_toggled(toggled_on):
	background_button(23, toggled_on)

func _on_hermit_button_toggled(toggled_on):
	background_button(24, toggled_on)

func _on_hunter_button_toggled(toggled_on):
	background_button(25, toggled_on)

func _on_laborer_button_toggled(toggled_on):
	background_button(26, toggled_on)

func _on_martial_disciple_button_toggled(toggled_on):
	background_button(27, toggled_on)

func _on_merchant_button_toggled(toggled_on):
	background_button(28, toggled_on)

func _on_miner_button_toggled(toggled_on):
	background_button(29, toggled_on)

func _on_noble_button_toggled(toggled_on):
	background_button(30, toggled_on)

func _on_nomad_button_toggled(toggled_on):
	background_button(31, toggled_on)

func _on_prisoner_button_toggled(toggled_on):
	background_button(32, toggled_on)

func _on_sailor_button_toggled(toggled_on):
	background_button(33, toggled_on)

func _on_scholar_button_toggled(toggled_on):
	background_button(34, toggled_on)

func _on_scout_button_toggled(toggled_on):
	background_button(35, toggled_on)

func _on_street_urchin_button_toggled(toggled_on):
	background_button(36, toggled_on)

func _on_teacher_button_toggled(toggled_on):
	background_button(37, toggled_on)

func _on_tinker_button_toggled(toggled_on):
	background_button(38, toggled_on)

func _on_warrior_button_toggled(toggled_on):
	background_button(39, toggled_on)
