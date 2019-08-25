extends Node

func _ready():
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://ApartmentDrone.ogg")
	player.stream.set_loop(true)
	player.play()