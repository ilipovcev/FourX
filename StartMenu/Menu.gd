extends Control

func _ready():
	pass

func _on_JoinButton_pressed():
	var inputIP = get_node("NinePatchRect/VBoxContainer/InputIP").get_text();
	var inputNick = get_node("NinePatchRect/VBoxContainer/InputPort").get_text();

	if inputIP == "":
		print("Invalid value");
		return;
		
	if inputNick == "":
		print("Invalid value");
		return;

	Server.connectServer(inputIP, inputNick);
	get_tree().change_scene("res://Game.tscn");

