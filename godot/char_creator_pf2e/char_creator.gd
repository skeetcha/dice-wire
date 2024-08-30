extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_ui_background_changed(idx):
	$"Player/mannequiny-0_3_0".set_color(idx, "background", "pf2e")

func _on_ui_class_changed(idx):
	$"Player/mannequiny-0_3_0".set_color(idx, "class", "pf2e")

func _on_ui_ancestry_changed(idx):
	$"Player/mannequiny-0_3_0".set_color(idx, "ancestry", "pf2e")
