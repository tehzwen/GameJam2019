extends MeshInstance

var glowEnabled = false
var timer = 0
var secondaryTimer
var originalMaterial
var originalEmission
var currentEmission

func disable():
	timer = 0
	secondaryTimer = 0
	glowEnabled = false
	visible = false
	
func enable(time):
	timer = time
	secondaryTimer = time
	glowEnabled = true
	visible = true

func _ready():
	originalMaterial = get_surface_material(0)
	originalEmission = originalMaterial.emission
	currentEmission = originalEmission

func _process(delta):
	if (timer > 0 && glowEnabled):
		currentEmission.r -= 0.008
		currentEmission.g -= 0.008
		currentEmission.b -= 0.008
		var tempMaterial = originalMaterial
		tempMaterial.emission = currentEmission
		set_surface_material(0, tempMaterial)
		timer -= delta
		return
		
	elif(timer <= 0 && glowEnabled):
		if (secondaryTimer > 0):
			secondaryTimer -= delta
			currentEmission.r += 0.008
			currentEmission.g += 0.008
			currentEmission.b += 0.008
			var tempMaterial = originalMaterial
			tempMaterial.emission = currentEmission
			set_surface_material(0, tempMaterial)
			
		else:
			glowEnabled = false
			var tempMaterial = originalMaterial
	
	else:
		visible = false
			
			
			
			
			
			
			
			