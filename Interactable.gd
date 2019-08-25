extends Node

export (bool) var isInteractable = false

func _ready():
	self.visible = isInteractable
	
func Trigger():
	isInteractable = true
	self.visible = true