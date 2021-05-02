extends Control

var symbol = ["A","B","C","a","o", "!", "x", "-->", "<->", "(", ")"]
var A = [false, false, true, true]
var B = [false, true, false, true]

var header = []
var data = []

#var A = [false, false, false, false, true, true, true, true]
#var B = [false, false, true, true, false, false, true, true]
#var C = [false, true, false, true, false, true, false, true]

var equation = "" #stores what is currently in the text box
var equArray = []
var textBox

func _ready():
	var button = $"HBoxContainer/VBoxContainer2/GridContainer".get_children()
	for i in range(len(button)-1):
		button[i].connect("pressed", self, "_on_Button_pressed", [i])
	button[len(button)-1].connect("pressed", self, "_on_update")
	
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
	var e = []
	for i in len(equation):
		var y = equation.substr(i,1)
		if y.to_upper() == y:
			if(y == "A"):
				e.append(A)
			elif( y == "B"):
				e.append(B)
		else:
			e.append(y)
	#print(x)
	equArray = e

#func _parse():
#	var equ = equArray
#
#
#
#
#	pass

func _parse_and_control():
	var equ = equArray
	var notFind = equ.find("!")
	#var andFind = equ.find("a")
	print(notFind)
	#print(andFind)

	if notFind > -1 && notFind < len(equ)-1: #not
		equ.remove(notFind)
		equ[notFind] = notOp(equ[notFind])
		data.append(equ[notFind])
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
