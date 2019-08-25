extends Spatial

var initiallyTurnedOff
var player

func _read():
	initiallyTurnedOff = false
	
func _on_InitialLightsOff_body_entered(body):
	if (initiallyTurnedOff == false):
		initiallyTurnedOff = true
		print("Entered collider")
		player = AudioStreamPlayer.new()
		self.add_child(player)
		player.stream = load("res://PowerOff.wav")
		player.volume_db = -5
		player.play()
		#  turn off lights here
