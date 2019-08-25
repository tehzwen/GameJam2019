extends Node

onready var toggled = false



func _on_Area2_body_entered(body):
		if (body.name == "Player" && !toggled):
			var bob = get_parent().get_node("RoomProps/EntranceBob")
			toggled = true
			
			bob.visible = true

		elif (body.name == "Player" && toggled):
			var bob = get_parent().get_node("RoomProps/EntranceBob")
			toggled = false
			bob.visible = false