extends Node

var network = NetworkedMultiplayerENet.new()
var ip = "127.0.0.1"
var port = 1909

func _ready():
  connectServer()


func connectServer():
  network.create_client(ip, port)
  get_tree().set_network_peer(network)

  network.connect("connection_succeeded", self, "_On_connection_succeeded")
  network.connect("connection_failed", self, "_On_connection_failed")


func _On_connection_succeeded():
  print("Connection suceeded")


func _On_connection_failed():
  print("Connection failed")

  
