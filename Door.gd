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
		
func playDoorSqueak():
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://DoorSqueak.wav")
	player.volume_db = -22
	player.play()
