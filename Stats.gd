extends Node

export(int) var max_army = 1
onready var army = max_army setget set_army

signal no_army

func set_army(value):
	army = value
	Server.SetArmy(value);
	if army <= 0:
		emit_signal("no_army")
