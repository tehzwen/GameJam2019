extends Node

func _on_FallArea_body_entered(body):
	if(body.name == "Player"):
		get_tree().change_scene("res://Credits.tscn")
