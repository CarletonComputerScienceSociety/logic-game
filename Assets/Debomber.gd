extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var truth_table = $HBoxContainer/RightSide/TruthTable/VBoxContainer/HBoxContainer/GridContainer.get_children()
	
	var headers = ["A", "B", "ANS"]
	var A = [true, false, true, false]
	var B = [true, true, false, false]
	
	for i in len(truth_table):
		var cell = truth_table[i].get_node("VBox/HBox/RichTextLabel")
		if i < 3:
			cell.text = headers[i]
		else:
			cell.text = "0"
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
