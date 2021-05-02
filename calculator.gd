extends Control
onready var functions = get_node("/root/Functions")

var symbol = ["A","B","C","a","o", "!", "x", "-->", "<->", "(", ")"]
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
			grid[j*cols + i].get_node("RichTextLabel").text = text
		
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
	textBox.insert_text_at_cursor(symbol[i])

func _on_updated():
	equation = textBox.get_line(0)
	_equ_to_array()
	#_parse()
	_parse_and_control()

func _equ_to_array():
	equ_array = []
	for i in len(equation):
		var y = equation.substr(i,1)
		if y.to_upper() == y:
			if(y == "A"):
				equ_array.append(A)
			elif( y == "B"):
				equ_array.append(B)
		else:
			equ_array.append(y)
	print("hi")
	print(equ_array)


func _parse_and_control():
	data = [A, B]
	header = ["A", "B"]
	
	var notFind = equ_array.find("!")
	
	# A, a, B, a, C
	#var andFind = equ.find("a")
	print(notFind)
	#print(andFind)

	if notFind > -1 && notFind < len(equ_array)-1: #not
		equ_array.remove(notFind)
		equ_array[notFind] = notOp(equ_array[notFind])
		data.append(equ_array[notFind])
		print(data[len(data)-1])

#	if andFind > -1 && andFind < len(equ)-1: #and
#		equ.remove(notFind)
#		if equ[notFind] == "A":
#			data.append(andOp(data[0]))
#		elif equ[notFind] == "B":
#			data.append(notOp(data[1]))
#		print(data[len(data)-1])

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
