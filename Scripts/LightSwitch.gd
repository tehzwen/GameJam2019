extends Spatial

export (NodePath) var lightPath
export (NodePath) var triggerNodePath
export (bool) var isTrigger = false
var enabled = true
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
	player.stream = load("res://Audio/LightSwitch.wav")
	player.volume_db = -22


func toggle():
	#print(light)
	if (enabled):
		player.play()
		light.light_energy = 0
		enabled = false
	else:
		if (self.name == "KitchenLightSwitch"):
			print(self.get_parent().get_node("Table").get_node("Note2").Trigger())
		player.play()
		light.light_energy = originalEnergy
		enabled = true
	
	if (isTrigger):
		triggerNode.Trigger()