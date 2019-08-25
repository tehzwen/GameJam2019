extends KinematicBody

export (int) var walkSpeed
export (int) var sprintEnergy
export (bool) var isInteracting
export (NodePath) var apartmentKeyPath

var originalSprintEnergy
var sprintThreshold
var camAngle = 0
var mouseSens = 0.3
var speed
var runSpeed
var gravity = 9.8 * 3
var raycast
var lastInteracted = null
var pageTurnSound

var velocity = Vector3()
var direction = Vector3()

func _ready():
	sprintThreshold = 0
	speed = walkSpeed
	runSpeed = walkSpeed * 3
	raycast = $CameraController/Camera/RayCast
	isInteracting = false
	originalSprintEnergy = sprintEnergy
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	# prepare page turn sound
	pageTurnSound = AudioStreamPlayer.new()
	self.add_child(pageTurnSound)
	pageTurnSound.stream = load("res://PageTurn.wav")
	pageTurnSound.volume_db = -22
	
func _process(delta):
#	$"/root/global".lives -= 1
#	print($"/root/global".lives)
	#print(sprintEnergy)
	pass
	
func _physics_process(delta):
	direction = Vector3()
	var aim = $CameraController/Camera.get_global_transform().basis
	
	handleMovementInput(aim)
		
	direction = direction.normalized()
	direction = direction * speed * delta	
	#velocity.y = aim.y
	
	velocity.y -= gravity * delta
	velocity.z = direction.z
	velocity.x = direction.x
	
	velocity = move_and_slide(velocity, Vector3(0,1,0))
	
	#iterate through collisions and detect specific ones
	for i in range (0, get_slide_count()):
		var collidedObj = get_slide_collision(i).collider
		if (collidedObj.name == "Pillar"):
			collidedObj.queue_free()
		
	
	#handle jumping
	if (Input.is_key_pressed(KEY_SPACE) and is_on_floor()):
		velocity.y = 5
	
	#handle sprinting
	#if (Input.is_key_pressed(KEY_SHIFT) && sprintEnergy > sprintThreshold):
	#	speed = runSpeed
	#	sprintEnergy -= 1
	
	#elif (Input.is_key_pressed(KEY_SHIFT) && sprintEnergy <= sprintThreshold):
	#	speed = walkSpeed
	
	#else:
	#	speed = walkSpeed
	#	if (sprintEnergy < originalSprintEnergy):
	#		sprintEnergy += 1
		
			
	#perform raycast to see current target in sight
	if (raycast.is_colliding()):
		var raycastObj = raycast.get_collider()

		var raycastObjGroups = raycastObj.get_groups()
		if (len(raycastObjGroups) > 0):
			if (("Interactable" in raycastObjGroups) or ("Obtainable" in raycastObjGroups)):
				var outline = raycastObj.get_node("Outline")
				lastInteracted = outline
				if (outline && !outline.glowEnabled):
					outline.enable(0.65)		
			elif ("LightSwitch" in raycastObjGroups):
				var outline = raycastObj.get_node("Outline")
				lastInteracted = outline
				if (outline && !outline.glowEnabled):
					outline.enable(0.65)	
			elif (lastInteracted):
				lastInteracted.disable()
				lastInteracted = null
		else:
			if(lastInteracted):
				lastInteracted.disable()
				lastInteracted = null
		
	else:
		if(lastInteracted):
			lastInteracted.disable()
			lastInteracted = null

	#if we are looking at an interactable object and we press interact key
	if (Input.is_action_just_pressed("Use") && raycast.is_colliding()):
		var selectedObj = raycast.get_collider()
		var selectedObjGroups = selectedObj.get_groups()
		# interact with object if e key is pressed and object is interactable
		if ("Interactable" in selectedObjGroups && selectedObj.get_parent().isInteractable):
			isInteracting = true
			selectedObj.get_parent().get_node("Popup").popup_centered()
			pageTurnSound.play()
			print("test")
			print(selectedObj.name)
			if (selectedObj.get_parent().name == "Note1"):
				handleNote1()
			elif (selectedObj.get_parent().name == "Note2"):
				handleNote2()
			elif (selectedObj.get_parent().name == "Note3"):
				handleNote3()
			elif (selectedObj.get_parent().name == "Note4"):
				handleNote4()
			elif (selectedObj.get_parent().name == "Note5"):
				handleNote5()
			elif (selectedObj.get_parent().name == "Note6"):
				handleNote6()
			elif (selectedObj.get_parent().name == "Note7"):
				handleNote7()
			elif (selectedObj.get_parent().name == "Note8"):
				handleNote8()
			elif (selectedObj.get_parent().name == "Note9"):
				handleNote9()
			elif (selectedObj.get_parent().name == "Note10"):
				handleNote10()
				
		# pick up object if e key is pressed and object is obtainable
		elif ("Obtainable" in selectedObjGroups && selectedObj.get_parent().isInteractable):
			selectedObj.get_parent().get_node("Label").showLabel()
		elif ("Door" in selectedObjGroups):
			if (!selectedObj.get_parent().get_parent().open):
				selectedObj.get_parent().get_parent().OpenDoor()
			else:
				selectedObj.get_parent().get_parent().CloseDoor()
				
		elif ("LightSwitch" in selectedObjGroups):
			selectedObj.get_parent().get_parent().toggle()
			
		elif ("Buttons" in selectedObjGroups):
			selectedObj.get_parent().get_parent().toggle()

	if (Input.is_key_pressed(KEY_ESCAPE) && isInteracting == true):
		isInteracting = false
	
	if (Input.is_key_pressed(KEY_Q)):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		

#handling movement function
func handleMovementInput(aim):
	if (is_on_floor()):
		if (Input.is_action_pressed("ui_up") && isInteracting == false):
			direction -= aim.z
		if (Input.is_action_pressed("ui_down") && isInteracting == false):
			direction += aim.z
		if (Input.is_action_pressed("ui_left") && isInteracting == false):
			direction -= aim.x
		if (Input.is_action_pressed("ui_right") && isInteracting == false):
			direction += aim.x
			
func handleNote1():
	yield(get_tree().create_timer(2.0), "timeout")
	print("read note 1")
	
func handleNote2():
	pass
	
func handleNote3():
	pass

func handleNote4():
	pass

func handleNote5():
	pass
	
func handleNote6():
	pass
	
func handleNote7():
	pass
	
func handleNote8():
	pass
	
func handleNote9():
	pass
	
func handleNote10():
	get_node(apartmentKeyPath).Trigger()

#handle mouse camera movement controls
func _input(event):
	if (event is InputEventMouseMotion && isInteracting == false):
		rotate_y(deg2rad(-event.relative.x * mouseSens))
		var change = -event.relative.y * mouseSens
		if (change + camAngle < 90 and change + camAngle > -90):
			$CameraController/Camera.rotate_x(deg2rad(change))
			camAngle += change

func _on_Area_body_entered(body):
	if (body.name == "Player"):
		print("Trigger")
