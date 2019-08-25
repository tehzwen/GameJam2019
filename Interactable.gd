extends Node

export (bool) var isInteractable = false

func _process(delta):
	self.visible = isInteractable
	
func Trigger():
	isInteractable = true