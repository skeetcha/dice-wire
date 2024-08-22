extends Control

func _on_new_game_button_pressed():
	#get_tree().change_scene_to_file("res://char_creator_5e/char_creator.tscn")
	print(tr("5E_MESSAGE"))

func _on_quit_button_pressed():
	get_tree().quit()


func _on_new_game_pf_button_pressed():
	get_tree().change_scene_to_file("res://char_creator_pf2e/char_creator.tscn")


func _on_new_game_a_5e_button_pressed():
	get_tree().change_scene_to_file("res://char_creator_a5e/char_creator.tscn")
