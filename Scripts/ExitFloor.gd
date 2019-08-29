extends Spatial

onready var removed = false

func removeFloor():
	if(!removed):
		$AnimationPlayer.play("Disipate")
		removed = true
	
