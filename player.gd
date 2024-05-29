extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	var manequin = $"CharacterBody3D/mannequiny-0_3_0"
	var anim = manequin.find_child("AnimationPlayer")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
