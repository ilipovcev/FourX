extends Control



func _ready():
	pass


func _on_HostButton_pressed():
	Server.connectServer()
	
