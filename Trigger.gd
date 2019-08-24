extends Area

export (NodePath) var TriggerNodePath # NodePath for the Node to be Triggered
export (NodePath) var PlayerNodePath # NodePath for the Player Node

var triggerNode
var playerNode
var triggered # whether or not the trigger was fired

func _ready():
	triggerNode = get_node(TriggerNodePath)
	playerNode = get_node(PlayerNodePath)
	triggered = false # initially, the trigger was not fired

func _physics_process(delta):
	# if the player node overlaps the trigger
	# and the trigger has not been fired yet
	# fire the trigger
	if (overlaps_body(playerNode) && !triggered):
		triggerNode.Trigger()
		triggered = true
	

