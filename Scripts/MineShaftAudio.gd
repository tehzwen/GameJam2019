extends Node

func _ready():
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://Audio/WaterDripping.ogg")
	player.stream.set_loop(true)
	player.play()