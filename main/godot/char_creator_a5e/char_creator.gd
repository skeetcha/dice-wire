extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	var success = ProjectSettings.load_resource_pack("res://content.pck")
	
	if success:
		var scene: PackedScene = load("res://char_creator_3d/a5e.tscn")
		var test: Resource = load("res://char_creator_3d/a5e.gd")
		var instance = scene.instantiate()
		self.add_child(instance)
		$UI.heritage_changed.connect(instance.heritage_changed)
		$UI.heritage_gift_changed.connect(instance.heritage_gift_changed)
		$UI.culture_changed.connect(instance.culture_changed)
		$UI.class_changed.connect(instance.class_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
