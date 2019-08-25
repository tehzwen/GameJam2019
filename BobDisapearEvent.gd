extends Node

onready var toggled = false

func _on_Bobdisappeararea_body_entered(body):
	if (body.name == "Player" && !toggled):
		var bob = get_parent().get_node("RoomProps/EntranceBob")
		#bob.queue_free()
		toggled = true
		
		bob.visible = false

	elif (body.name == "Player" && toggled):
		var bob = get_parent().get_node("RoomProps/EntranceBob")
		toggled = false
		bob.visible = true