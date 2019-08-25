extends Node

export (bool) var locked = false
export (NodePath) var note3Path

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
	if (locked && global.hasReadNote2):
		get_node(note3Path).Trigger()
	if (!open && !anim.is_playing() && !locked):
		anim.play("Open")
		player.play()
		open = true
	
func CloseDoor():
	if (open && !anim.is_playing() && !locked):
		anim.play("Close")
		player.play()
		open = false

func Lock():
	locked = true
	
func Unlock():
	locked = false