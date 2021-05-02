extends Control

onready var functions = get_node("/root/Functions")

var symbol = ["A","B","C","/and","/or", "/not", "/xor", "/imp", "/dmp", "/par", "/del"]

func _ready():
	var button = $"HBoxContainer/VBoxContainer2/GridContainer".get_children()
	var grid = $"HBoxContainer/VBoxContainer/GridContainer2".get_children()
	
	var B = [true, false, true, false]
	var A = [true, true, false, false]
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
	
	
	for i in range(len(button)):
		button[i].connect("pressed", self, "_on_Button_pressed", [i])
	
#	get_node("HBoxContainer/VBoxContainer2/GridContainer/Button1").connect("pressed", self, "_on_Button_pressed1")
#	get_node("HBoxContainer/VBoxContainer2/GridContainer/Button2").connect("pressed", self, "_on_Button_pressed2")

func _on_Button_pressed(i):
	get_node("HBoxContainer/VBoxContainer/HBoxContainer/ColorRect/textBox").insert_text_at_cursor(symbol[i])

#func _on_Button_pressed1():
#	get_node("HBoxContainer/VBoxContainer/HBoxContainer/ColorRect/textBox").insert_text_at_cursor("˄˄˄˄˄˄˄˄˄˄˄˄˄A")
#
#func _on_Button_pressed2():
#	get_node("HBoxContainer/VBoxContainer/HBoxContainer/ColorRect/textBox").insert_text_at_cursor("˄˄˄˄˄˄˄˄˄˄˄˄˄B")
