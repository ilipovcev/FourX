extends KinematicBody2D


signal army_change

func _ready():
	print(PlayerStats.max_army)
	print(PlayerStats.army)


func _on_Area2D_area_entered(area):
	PlayerStats.army += 1
	emit_signal("army_change")
	print(PlayerStats.army)
