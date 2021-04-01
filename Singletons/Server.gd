extends Node

tool


#var ip = "25.105.171.34"
const port = 1909;
var userNick = "Unnamed";

func connectServer(ip, nick):
  var network = NetworkedMultiplayerENet.new()
  userNick = nick;

  network.create_client(ip, port)
  get_tree().set_network_peer(null)
  get_tree().set_network_peer(network)

  get_tree().change_scene("res://LoadScreen.tscn");
  network.connect("connection_succeeded", self, "_On_connection_succeeded")
  network.connect("connection_failed", self, "_On_connection_failed")

func _On_connection_succeeded():
  print("Connection suceeded")
  print("Player ", userNick, " register...")
  rpc_id(1, "RegPlayer", userNick)
  get_tree().change_scene("res://Game.tscn")

remote func OnRegPlayer(pl: Array):
  print("Player #", pl[0], " registered with nickname ", pl[1], ".");

func _On_connection_failed():
  get_tree().change_scene("res://StartMenu/Menu.tscn")
  print("Connection failed")

func SetArmy(HP):
  rpc_id(1, "PlayerStatsChanged", HP)