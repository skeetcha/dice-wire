extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_ui_background_changed(idx):
	#$Player.set_color(idx, "background")
	$"Player/mannequiny-0_3_0".set_color(idx, "background")

func _on_ui_class_changed(idx):
	#$Player.set_color(idx, "class")
	$"Player/mannequiny-0_3_0".set_color(idx, "class")

func _on_ui_race_changed(idx):
	#$Player.set_color(idx, "race")
	$"Player/mannequiny-0_3_0".set_color(idx, "race")
