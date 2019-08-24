extends KinematicBody

export (int) var walkSpeed

var speed = walkSpeed
var camAngle = 0
var mouseSens = 0.3
var runSpeed = walkSpeed * 2
var gravity = 9.8 * 3
var raycast
var lastInteracted = null

var velocity = Vector3()
var direction = Vector3()

func _ready():
	raycast = $CameraController/Camera/RayCast
	
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
	if (Input.is_key_pressed(KEY_SHIFT)):
		speed = runSpeed
	else:
		speed = walkSpeed
		
	#perform raycast to see current target in sight
	if (raycast.is_colliding()):
		var raycastObj = raycast.get_collider()

		var raycastObjGroups = raycastObj.get_groups()
		if (len(raycastObjGroups) > 0):
			if ("Interactable" in raycastObjGroups):
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
	
	# interact with object if e key is pressed
	if (Input.is_key_pressed(KEY_E) && raycast.is_colliding()):
		var selectedObj = raycast.get_collider()
		if ("Interactable" in selectedObj.get_groups()):
			selectedObj.get_parent().get_node("Popup").popup_centered()

func handleMovementInput(aim):
	if (Input.is_action_pressed("ui_up")):
		direction -= aim.z
	if (Input.is_action_pressed("ui_down")):
		direction += aim.z
	if (Input.is_action_pressed("ui_left")):
		direction -= aim.x
	if (Input.is_action_pressed("ui_right")):
		direction += aim.x

func _input(event):
	if (event is InputEventMouseMotion):
		rotate_y(deg2rad(-event.relative.x * mouseSens))

		var change = -event.relative.y * mouseSens
		if (change + camAngle < 90 and change + camAngle > -90):
			$CameraController/Camera.rotate_x(deg2rad(change))
			camAngle += change
		