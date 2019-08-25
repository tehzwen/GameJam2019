extends Node

var open
var anim
var player

func _ready():
	open = false
	anim = get_node("OpenAnimation")
	player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://DoorSqueak.wav")
	player.volume_db = -22

func OpenDoor():
	if (!open && !anim.is_playing()):
		anim.play("Open")
		player.play()
		open = true
	
func CloseDoor():
	if (open && !anim.is_playing()):
		anim.play("Close")
		player.play()
		open = false
