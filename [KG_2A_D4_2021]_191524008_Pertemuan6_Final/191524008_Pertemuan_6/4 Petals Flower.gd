extends flower

var maximumX
var maximumY

func _ready():
	window_size = get_viewport().get_visible_rect()
	maximumX = window_size.end.x
	maximumY = window_size.end.y

func _draw():
	draw_flowers()

func draw_flowers():
	var petalsLength = maximumX / 20
	var petalsWidth = petalsLength / 2
	var centerPoint = Vector2(petalsLength*2, petalsLength*2)
	for j in range(4):
		for k in range (5):
			_4Petals(centerPoint, petalsLength, petalsWidth)
			centerPoint.x += petalsLength*4
		centerPoint.x = petalsLength*2
		centerPoint.y += petalsLength*4


func _on_Back2_pressed():
	get_tree().change_scene("res://MainMenu.tscn")
