extends Spatial

export (NodePath) var Level

var enabled
var materialDisabled
var originalMaterial
var levelLogic

func _ready():
	levelLogic = get_node(Level)
	originalMaterial = $ButtonMesh.get_surface_material(0)
	materialDisabled = originalMaterial.emission
	enabled = false

func toggle():

	if (!enabled):
		var tempMaterial = originalMaterial.duplicate()
		tempMaterial.emission.g = materialDisabled.r
		tempMaterial.emission.r = materialDisabled.g
		$ButtonMesh.set_surface_material(0, tempMaterial)
		levelLogic.handleButtonInput(name)
		enabled = true
	else:
		$ButtonMesh.set_surface_material(0, originalMaterial)
		enabled = false