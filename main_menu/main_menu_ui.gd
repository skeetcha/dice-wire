extends Control
#get_tree().change_scene("res://path/to/scene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_new_game_button_pressed():
	get_tree().change_scene_to_file("res://char_creator_5e/char_creator.tscn")

func _on_quit_button_pressed():
	get_tree().quit()


func _on_new_game_pf_button_pressed():
	get_tree().change_scene_to_file("res://char_creator_pf2e/char_creator.tscn")
