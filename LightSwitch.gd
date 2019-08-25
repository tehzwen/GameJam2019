extends Spatial

export (NodePath) var lightPath
var enabled = false
var light
var originalEnergy

func _ready():
	if(lightPath):
		light = get_node(lightPath)
		if(light):
			originalEnergy = light.light_energy

func toggle():
	#print(light)
	if (enabled):
		light.light_energy = 0
		enabled = false
	else:
		light.light_energy = originalEnergy
		enabled = true