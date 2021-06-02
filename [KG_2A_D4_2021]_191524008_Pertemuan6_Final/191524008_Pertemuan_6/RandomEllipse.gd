extends ellipse

var randomGenerator = RandomNumberGenerator.new()

var maximumX
var maximumY

func _ready():
	window_size = get_viewport().get_visible_rect()
	maximumX = window_size.end.x
	maximumY = window_size.end.y
	randomGenerator.randomize()


func randomEllipse():
	var centerPoint : Vector2
	var radiusX = randomGenerator.randi_range(10,100)
	var radiusY = randomGenerator.randi_range(10,100)
	centerPoint.x = randomGenerator.randi_range(0,maximumX)
	centerPoint.y = randomGenerator.randi_range(0,maximumY)
	ellipseMidpoint(centerPoint, radiusX,radiusY)

func _draw():
	var totalCircle = randomGenerator.randi_range(1,5)
	for n in range (totalCircle):
		randomEllipse()


func _on_Update3_pressed():
	get_tree().change_scene("res://RandomEllipse.tscn")


func _on_Back2_pressed():
	get_tree().change_scene("res://MainMenu.tscn")
