extends Control

var army = 4 setget set_army
var max_army = 4 setget set_max_army
var DisplayValue = 0

onready var timer = get_node("Timer")
onready var label = $Label

func set_army(value):
	army = clamp(value , 0 , max_army)
	if label != null:
		label.text = "HP = " +str(PlayerStats.army)

func set_max_army(value):
	max_army = max(value, 1)

func _ready():
	timer.set_wait_time(0.01)
	timer.start()
	self.max_army = PlayerStats.max_army
	self.army = PlayerStats.army
	PlayerStats.connect("army_change", self, "set_army")
	


func _on_Timer_timeout():
	if label != null:
		label.text = "HP = " +str(PlayerStats.army)
