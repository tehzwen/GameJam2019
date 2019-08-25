extends Node

onready var toggled = false

func _on_Bobdisappeararea_body_entered(body):
	if (body.name == "Player" && !toggled):
		var bob = get_parent().get_node("RoomProps/EntranceBob")
		var spotlight = get_parent().get_node("SpotLight")
		var beds = get_parent().get_node("RoomProps/ToggleBeds")
		beds.visible = true
		spotlight.light_energy = 0
		spotlight.flicker = false
		print(spotlight.light_energy)
		#bob.queue_free()
		toggled = true
		
		bob.visible = false
