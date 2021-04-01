extends KinematicBody2D


func _on_Area2D_area_entered(area):
	if PlayerStats.army > 0:
		Server.playerWin()
		queue_free()
