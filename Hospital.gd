extends Spatial

export (Array,NodePath) var Buttons

var correctOrder = ["Button4", "Button2", "Button1", "Button3"]
var inputted = []
var buttonObjectArray = []
var allInputted = []

func _ready():
	for i in range(len(Buttons)):
		#print(get_node(Buttons[i]))
		buttonObjectArray.append(get_node(Buttons[i]))
	
func _process(delta):	
	if (len(inputted) == len(correctOrder)):
		#check if the order is correct
		if (correctOrder == inputted):
			print("Correct!")
			#open door, finish shit etc
			
		else:
			for i in range(len(buttonObjectArray)):
				buttonObjectArray[i].toggle()		
			inputted = []
	
func handleButtonInput(buttonName):
	#print(buttonName)
	inputted.append(buttonName)