extends Control
onready var functions = get_node("/root/Functions")

const treeNodeOb = preload("res://treeClass.gd")

var symbol = ["A","B","C","a","o", "n", "x", ">", "d", "(", ")"]
var A = [false, false, true, true]
var B = [false, true, false, true]

var header = []
var data = []

#var A = [false, false, false, false, true, true, true, true]
#var B = [false, false, true, true, false, false, true, true]
#var C = [false, true, false, true, false, true, false, true]

var equation = "" #stores what is currently in the text box
var equ_array = []
var textBox


func _ready():
	var button = $"HBoxContainer/VBoxContainer2/GridContainer".get_children()
	var grid = $"HBoxContainer/VBoxContainer/GridContainer2".get_children()
	
	var andlist = functions.andOp(A,B)
	var headers = [A, B, andlist]
	var rows = 4
	var cols = 8

	for i in len(headers):
		for j in range(rows):
			var text = ""
			if headers[i][j]:
				text =  "1"
			else:
				text = "0"
			grid[j*cols + i].get_node("VBox/HBox/RichTextLabel").text = text
		
#	for i in len(grid):
#		grid[i].get_node("RichTextLabel").text = str(i)
#
	
	
	for i in range(len(button)-1):
		button[i].connect("pressed", self, "_on_Button_pressed", [i])
	button[len(button)-1].connect("pressed", self, "_on_updated")
	
	textBox = get_node("HBoxContainer/VBoxContainer/HBoxContainer/ColorRect/textBox")
	#textBox.connect("text_changed", self, "_updated")
	
	data.append(A)
	data.append(B)
	print(data)

func _on_Button_pressed(i):
	print(symbol[i])
	textBox.insert_text_at_cursor(symbol[i])

func _on_updated():
	equation = textBox.get_line(0)
	print(textBox.get_line(0))
	_equ_to_array()
	#_parse()
	_parse_and_control()

func _equ_to_array():
	equ_array = []
	for i in len(equation):
		var y = equation.substr(i,1)
		print(y)
		print(y.to_upper() == y)
		if y.to_upper() == y:
			if(y == symbol[0]):
				equ_array.append(A.duplicate(true))
			elif( y == symbol[1]):
				equ_array.append(B.duplicate(true))
		else:
			equ_array.append(y)
	#print("hi")
	print(equ_array)


func _parse_and_control():
	data = [A, B]
	header = [symbol[0], symbol[1]]
	
	var tree = _buildTree()
	

func _buildTree():
	var equ = equ_array.duplicate(true)

	for i in range(len(equ)):
		equ[i] = treeNodeOb.new(equ[i])

	var flag = true
	var i = len(equ)-1
	while flag:
		print(equ)
		if typeof(equ[i].value)  == TYPE_STRING && equ[i].rightNode == null:
			if equ[i].value != symbol[5]: #not !
				equ[i].leftNode = equ[i-1]
				equ[i].rightNode = equ[i+1]
				equ.remove(i-1)
				equ.remove(i)
				i = i+-1
			else:
				equ[i].rightNode = equ[i+1]
				equ.remove(i+1)
		elif typeof(equ[i].value)  == TYPE_STRING:
			i = i-1
		elif typeof(equ[i].value) == TYPE_OBJECT:
			i = i-1
		elif typeof(equ[i].value) == TYPE_ARRAY:
			i = i-1

		if equ.size() == 1:
			return equ
	



var x = []

func andOp(list_1, list_2):	
	x = []
	for i in range(len(list_1)):
		x.append(list_1[i] && list_2[i])
	return x

func orOp(list_1, list_2):
	x = []
	for i in range(len(list_1)):
		x.append(list_1[i] || list_2[i])
	return x

func notOp(list_1):
	x = []
	print(list_1)
	for i in range(len(list_1)):
		x.append(!list_1[i])
	print(x)
	return x

func impOp(list_1, list_2):
	list_1 = notOp(list_1)
	return orOp(list_1, list_2)

func xorOp(list_1, list_2):
	return notOp(andOp(impOp(list_1, list_2), impOp(list_2, list_1)))

func dmpOp(list_1, list_2):
	return andOp(impOp(list_1, list_2), impOp(list_2, list_1))
