extends Node

#var ip = "25.105.171.34"
const port = 1909;
var userNick = "Unnamed";
var player_spawn_point = -1
var player_hp
var player_steps

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
remote func OnRegPlayer(id, name, HP):
  print("Player #", id, " registered with nickname ", name, ".");
  player_hp = HP #Здоровье игрока. Её использовать в label
  get_tree().change_scene("res://Game.tscn") #Смена сцены на игру. Для работы игры заменить на сцену ожидания
  #get_tree().change_scene("res://Screen/WaitingOtherPlayers.tscn") #Сцена ожидание остальных игркоков

#Не удалось подключиться к серверу, возврат в меню. Нужна сцена с сообщением об ошибке
func _On_connection_failed():
  get_tree().change_scene("res://StartMenu/Menu.tscn")
  print("Connection failed")

#Сервер запускает игру для вех клиентов
remote func StartGame():
  get_tree().change_scene("res://Game.tscn") #Смена сцены на игру

#Вызывать для определения кол-ва ходов
func IsRoll():
  rpc_id(1, "IsRoll")

#Возвращает кол-во ходов и устанавливает в переменную player_steps
remote func SetRoll(steps_number):
  if steps_number == -1:
    player_steps = -1
  player_steps = steps_number

#Вызывать при ходе на клетку с -хп
func OnDecHP():
  rpc_id(1, "DecHP")

#Вызывать при ходе на клетку с +хп
func OnIncHP():
  rpc_id(1, "IncHP")

#Возвращет значение хп для игрока после хода на клетку
remote func SetPlayerHP(hp):
  player_hp = hp

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