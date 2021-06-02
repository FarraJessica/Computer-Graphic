extends Panel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_Button_pressed():
	pass # Replace with function body.
	get_node("Button").connect("pressed", self, "_on_Button_pressed")
	get_node("Button").text = "Press to Look Cubic Graph"

func _on_Button2_pressed():
	pass # Replace with function body.
	get_node("Button").connect("pressed", self, "_on_Button_pressed")
	get_node("Button").text = "Press to Look Quadratic Graph"


func _on_Button3_pressed():
	pass # Replace with function body.
	get_node("Button").connect("pressed", self, "_on_Button_pressed")
	get_node("Button").text = "Press to Look Sinus Graph"


func _on_Button4_pressed():
	pass # Replace with function body.
	get_node("Button").connect("pressed", self, "_on_Button_pressed")
	get_node("Button").text = "Press to Look Cosinus Graph"
