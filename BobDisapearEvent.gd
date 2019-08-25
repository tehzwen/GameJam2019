extends Node

onready var toggled = false

func _on_Bobdisappeararea_body_entered(body):
	if (body.name == "Player"):
		pass
