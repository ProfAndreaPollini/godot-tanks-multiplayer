extends Node2D

var network = NetworkedMultiplayerENet.new()
var port = 20000
var n = 0
onready var player_list = $Control/PlayerList

func _ready():
	start_server()
	
	
func start_server():
	network.create_server(port)
	get_tree().set_network_peer(network)
	
	print("Server started")
	
	network.connect("peer_connected",self,"on_peer_connected")
	network.connect("peer_disconnected",self,"on_peer_disconnected")
	
	
func on_peer_connected(peer_id):
	player_list.add_item(str(peer_id))
	print("User " + str(peer_id) + "connected.")
	
func on_peer_disconnected(peer_id):
	
	for i in range(player_list.get_item_count()-1,-1,-1):
		if player_list.get_item_text(i) == str(peer_id):
			player_list.remove_item(i)
	print("User " + str(peer_id) + "disconnected.")

remote func say_hello(requester):
	var peer_id = get_tree().get_rpc_sender_id()
	rpc_id(peer_id,"say_hello_response",requester)
	print("server: say hello()")

remote func update_pos(dx,dy,requester):
	var peer_id = get_tree().get_rpc_sender_id()
	$Sprite.position.x += dx
	$Sprite.position.y += dy


func _on_Timer_timeout():
	n = n+1
	rpc_id(0,"pulse",n)
