extends Node

var open
var anim

func _ready():
	open = false
	anim = get_node("OpenAnimation")

func OpenDoor():
	if (!open && !anim.is_playing()):
		anim.play("Open")
		open = true
