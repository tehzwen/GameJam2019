extends Spatial

var open

func _ready():
	open = false

func toggle():
	if (!open && !$AnimationPlayer.is_playing()):
		$AnimationPlayer.play("Open")
		open = true
	elif (open && !$AnimationPlayer.is_playing()):
		$AnimationPlayer.play_backwards("Open")
		open = false