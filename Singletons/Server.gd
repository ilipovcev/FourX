extends Node

# var PlayerData : = preload("res://Singletons/PlayerData.gd") as Script;

tool

var network = NetworkedMultiplayerENet.new()
#var ip = "25.105.171.34"
const port = 1909;
var userNick = "Unnamed";

func connectServer(ip, nick):
  userNick = nick;

  network.create_client(ip, port)
  get_tree().set_network_peer(network)

  network.connect("connection_succeeded", self, "_On_connection_succeeded")
  network.connect("connection_failed", self, "_On_connection_failed")

func _On_connection_succeeded():
  print("Connection suceeded")
  print("Player ", userNick, " register...");
  rpc_id(1, "RegPlayer", userNick);

remote func OnRegPlayer(pl: Array):
  print("Player #", pl[0], " registered with nickname ", pl[1], ".");

func _On_connection_failed():
  print("Connection failed")
