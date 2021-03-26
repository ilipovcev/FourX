extends Control

func _ready():
	pass


func _on_HostButton_pressed():
	Server.connectServer()
	get_tree().change_scene("res://Game.tscn")
	

func _on_JoinButton_pressed():
	var inputIP = get_node("NinePatchRect/VBoxContainer/InputIP").get_text()
	var inputPort = get_node("NinePatchRect/VBoxContainer/InputPort").get_text()

	if inputIP == "":
		print("Invalid value")
		return
		
	if inputPort == "":
		print("Invalid value")
		return

	
