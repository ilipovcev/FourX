extends Node

#var ip = "25.105.171.34"
const port = 1909;
var userNick = "Unnamed";
var player_spawn_point = -1
var players_done = []

func connectServer(ip, nick):
  var network = NetworkedMultiplayerENet.new()
  userNick = nick;

  network.create_client(ip, port)
  get_tree().set_network_peer(null)
  get_tree().set_network_peer(network)

  get_tree().change_scene("res://LoadScreen.tscn") #Смена сцены на загрузочный экран
  network.connect("connection_succeeded", self, "_On_connection_succeeded")
  network.connect("connection_failed", self, "_On_connection_failed")


func _On_connection_succeeded():
  print("Connection succeeded")
  print("Player ", userNick, " register...")
  
  rpc_id(1, "RegPlayer", userNick) #Регистрация клиента на сервере

#Подтверждение от сервера об успешной регистрации клиента
remote func OnRegPlayer(pl: Array):
  print("Player #", pl[0], " registered with nickname ", pl[1], ".");
  get_tree().change_scene("res://Game.tscn") #Смена сцены на игру. Для работы игры заменить на сцену ожидания
  #get_tree().change_scene("res://Screen/WaitingOtherPlayers.tscn") #Сцена ожидание остальных игркоков

#Не удалось подключиться к серверу, возврат в меню. Нужна сцена с сообщением об ошибке
func _On_connection_failed():
  get_tree().change_scene("res://StartMenu/Menu.tscn")
  print("Connection failed")

#Сервер запускает игру для вех клиентов
remote func StartGame():
  get_tree().change_scene("res://Game.tscn") #Смена сцены на игру

#Соообщение серверу о том, что у игрока изменилось ХП
func SetArmy(HP):
  rpc_id(1, "PlayerStatsChanged", HP)

#Соообщение серверу о том, что игрок победил
func playerWin():
  rpc_id(1, "PlayerWin")

#Сообщение о том, что игрок победил. Смена сцены на главное меню. Нужна сцена сообщения
remote func getWinner(playerName):
  print(playerName, " is winner")
  get_tree().set_network_peer(null)
  get_tree().change_scene("res://StartMenu/Menu.tscn")

#Возвращает место где должен появиться игрок. От 1 до 4
remote func PlayerSpawnPoint(point):
  player_spawn_point = point

#Если игрок покинул игру
remote func PlayerLeftGame(player_left_name):
  print("Player ", player_left_name, " left the game")