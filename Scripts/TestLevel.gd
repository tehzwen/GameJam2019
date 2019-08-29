extends Spatial

export (NodePath) var player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("restart")):
		get_tree().reload_current_scene()

func _on_FallArea_body_entered(body):
	print(body.name)
	if (body.name == "Player"):
		get_tree().change_scene("res://MineShaft.tscn")