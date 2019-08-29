extends Label

export (NodePath) var DoorNodePath
var player
var door

func showLabel():
	player.play()
	get_parent().visible = false
	visible = true
	yield(get_tree().create_timer(2.0), "timeout")
	visible = false
	global.hasApartmentKey = true
	door.get_node("Pivot").Unlock()

# Called when the node enters the scene tree for the first time.
func _ready():
	door = get_node(DoorNodePath)
	player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://PickUpKey.wav")
	player.volume_db = -10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass