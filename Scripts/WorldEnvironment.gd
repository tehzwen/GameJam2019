extends WorldEnvironment



func _on_AmbientChangeArea_body_entered(body):
	if (body.name == "Player"):
		var env = get_environment()
		env.ambient_light_energy = 0
		env.dof_blur_far_distance *= 0.5
		get_parent().get_node("Lights/HallwayLights").visible = false
		var camera = get_parent().get_node("Player/CameraController/Camera")
		camera.fov *= 1.25
		
