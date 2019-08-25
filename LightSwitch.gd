extends Spatial

export (NodePath) var lightPath
export (NodePath) var triggerNodePath
export (bool) var isTrigger = false
var enabled = false
var light
var triggerNode
var originalEnergy
var player

func _ready():
	if (triggerNodePath):
		triggerNode = get_node(triggerNodePath)
	if (lightPath):
		light = get_node(lightPath)
		if (light):
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
	
	if (isTrigger):
		triggerNode.Trigger()