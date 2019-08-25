extends Spatial

export (NodePath) var lightPath
var enabled
var light
var originalEnergy
var player

func _ready():
	enabled = true
	if(lightPath):
		light = get_node(lightPath)
		if(light):
			originalEnergy = light.light_energy
	player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://LightSwitch.wav")
	player.volume_db = -22	


func toggle():
	#print(light)
	if (enabled):
		player.play()
		light.light_energy = 0
		enabled = false
	else:
		player.play()
		light.light_energy = originalEnergy
		enabled = true