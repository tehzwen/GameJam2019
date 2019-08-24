extends KinematicBody

var walkSpeed = 300
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
	
	if (Input.is_key_pressed(KEY_W)):
		direction -= aim.z
	if (Input.is_key_pressed(KEY_S)):
		direction += aim.z
	if (Input.is_key_pressed(KEY_A)):
		direction -= aim.x
	if (Input.is_key_pressed(KEY_D)):
		direction += aim.x
	
	direction = direction.normalized()
	direction = direction * speed * delta	
	#velocity.y = aim.y
	
	velocity.y -= aim.y.y * gravity * delta
	velocity.z = direction.z
	velocity.x = direction.x
	
	velocity = move_and_slide(velocity, Vector3(0,1,0))
	
	#iterate through collisions and detect specific ones
	for i in range (0, get_slide_count()):
		var collidedObj = get_slide_collision(i).collider
		if (collidedObj.name == "Pillar"):
			collidedObj.queue_free()
		#elif (collidedObj.name == "Wall"):
			#print(collidedObj.get_owner())
			#collidedObj.get_owner().queue_free()
		
	
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
				
	elif (lastInteracted):
		lastInteracted.disable()
		lastInteracted = null

func _input(event):
	if (event is InputEventMouseMotion):
		rotate_y(deg2rad(-event.relative.x * mouseSens))

		var change = -event.relative.y * mouseSens
		if (change + camAngle < 90 and change + camAngle > -90):
			$CameraController/Camera.rotate_x(deg2rad(change))
			camAngle += change
		