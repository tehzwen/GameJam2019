extends Node

func _ready():
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://ApartmentDrone.ogg")
	player.play()
	
func playDoorCreak():
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://DoorSqeak.wav")
	player.play()