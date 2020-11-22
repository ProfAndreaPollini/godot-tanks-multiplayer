extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var pos = Vector2.ZERO
var inst = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	inst = get_instance_id()
	Server.network.connect("connection_succeeded",self,"on_connection_succeed")
	

func on_connection_succeed():
	Server.say_hello(inst)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(delta: float):
	var dx = 2*randf()- 1
	var dy  =2* randf() -1
	pos.x += dx 
	pos.y += dy
	
	Server.update_pos(dx,dy, inst) 
