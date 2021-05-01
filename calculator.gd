extends Control

var symbol = ["A","B","C","a","o", "!", "x", "-->", "<->", "(", ")", "/del"]

func _ready():
	var button = $"HBoxContainer/VBoxContainer2/GridContainer".get_children()
	
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
