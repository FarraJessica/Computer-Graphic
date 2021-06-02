extends Circle

var window_size : Rect2
var randomGenerator = RandomNumberGenerator.new()
var maximumX 
var maximumY

func _ready():
	window_size = get_viewport().get_visible_rect()
	randomGenerator.randomize()
	maximumX = window_size.end.x
	maximumY = window_size.end.y

func randomCircle():
	var circleCenter : Vector2
	var circleRadius = randomGenerator.randi_range(30,100)
	
	circleCenter.x = randomGenerator.randi_range(0,maximumX)
	circleCenter.y = randomGenerator.randi_range(0,maximumY)
	midpointCircle(circleCenter, circleRadius)

func _draw():
	var totalCircle = randomGenerator.randi_range(1,5)
	for i in range (totalCircle):
		randomCircle()
		
func _on_Random_pressed():
	get_tree().change_scene("res://RandomCircle.tscn")


func _on_Next_pressed():
	get_tree().change_scene("res://Smiley.tscn")


func _on_Back_pressed():
	get_tree().change_scene("res://MainMenu.tscn")
