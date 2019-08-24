extends Spatial

# Public, customizable variables
export (NodePath) var lightSourceNodePath # NodePath to the OmniLight Node
export var flicker = true # boolean flicker default to true
export var delay = 0.25 # delay in the flicker
export var flickerEnergy = 0.0 # what energy the light will flicker to
export (int) var startTimer = 5 # what time to start the timer at

# Other variables
var light # OmniLight Node
var timer # timer to count down from
var startEnergy # startEnergy strength

# Initialize variables
func _ready():
	light = get_node(lightSourceNodePath) # get the lightsource node
	timer = startTimer # set the timer to the startTimer value before counting down
	startEnergy = light.light_energy # set the startEnergy to the default value
	
func _physics_process(delta):
	if (flicker):
		timer -= 1.0 * delay
		if (timer <= 0):
			light.light_energy = flickerEnergy
			timer = startTimer
		else:
			light.light_energy= startEnergy