extends Node3D

var race_color: Color = Color("B0C4DE")
var class_color: Color = Color("B0C4DE")
var background_color: Color = Color("B0C4DE")

var class_colors: Array[String] = ["A52A2A", "DA70D6", "FFFFFF", "228B22", "808080", "FFD700", "FFFF00", "006400", "000000", "FF4500", "800080", "1E90FF"]
var race_colors: Array[String] = ["8B4513", "32CD32", "D2691E", "D3D3D3", "DC143C", "FFA07A", "778899", "2F4F4F", "8B0000"]
var background_colors: Array[String] = ["FFE4E1", "DAA520", "FF6347", "8B0000", "4B0082", "FF69B4", "708090", "8FBC8F", "CD5C5C", "FFD700", "4682B4", "B0E0E6", "2E8B57", "8B4513", "8A2BE2", "A0522D", "6A5ACD", "000080", "556B2F", "D2B48C", "778899"]

# Called when the node enters the scene tree for the first time.
func _ready():
	update_colors()

func update_colors():
	var race_mat: ShaderMaterial = $root/Skeleton3D/body_001.get_active_material(0)
	var class_mat: ShaderMaterial = $root/Skeleton3D/body_001.get_active_material(2)
	var background_mat: ShaderMaterial = $root/Skeleton3D/body_001.get_active_material(1)
	
	race_mat.set_shader_parameter("albedo", race_color)
	class_mat.set_shader_parameter("albedo", class_color)
	background_mat.set_shader_parameter("albedo", background_color)
	
	$root/Skeleton3D/body_001.set_surface_override_material(0, race_mat)
	$root/Skeleton3D/body_001.set_surface_override_material(1, background_mat)
	$root/Skeleton3D/body_001.set_surface_override_material(2, class_mat)

func set_color(color_idx: int, which: String):
	assert(which == "race" or which == "class" or which == "background")
	
	if which == "race":
		if color_idx == 0:
			race_color = Color("B0C4DE")
		else:
			race_color = Color(race_colors[color_idx - 1])
	elif which == "class":
		if color_idx == 0:
			class_color = Color("B0C4DE")
		else:
			class_color = Color(class_colors[color_idx - 1])
	elif which == "background":
		if color_idx == 0:
			background_color = Color("B0C4DE")
		else:
			background_color = Color(background_colors[color_idx - 1])
	
	update_colors()
