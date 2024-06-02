extends Label

func _make_custom_tooltip(for_text):
	var label_data: Dictionary = JSON.parse_string(for_text)
	var tooltip = preload("res://tooltip/tooltip.tscn").instantiate()
	tooltip.get_node("Header").text = label_data["name"]
	tooltip.get_node("Body").text = label_data["desc"]
	return tooltip

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
