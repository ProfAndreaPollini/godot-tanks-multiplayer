extends Node

var network = NetworkedMultiplayerENet.new()
var server_ip = "127.0.0.1"
var server_port = 20000

func _ready():
	connect_to_server()
	
func connect_to_server():
	network.create_client(server_ip,server_port)
	get_tree().set_network_peer(network)
	
	network.connect("connection_failed",self, "on_connection_failed")
	network.connect("connection_succeeded",self,"on_connection_succeed")
	
	
func on_connection_failed():
	print("connection failed")
	
func on_connection_succeed():
	print("connection succeed")
	
func say_hello(requester):
	rpc_id(1,"say_hello",requester)
	
func update_pos(x,y,requester):
	rpc_id(1,"update_pos",x,y,requester)
	
remote func pulse(n,requester):
	print("pulse  = " + str(n))
	
remote func say_hello_response(requester):
	print("day hello response.")
