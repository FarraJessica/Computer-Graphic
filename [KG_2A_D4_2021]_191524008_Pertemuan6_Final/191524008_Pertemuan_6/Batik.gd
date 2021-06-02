extends flower

var randomGenerator = RandomNumberGenerator.new()
var maximumX
var maximumY

func _ready():
	window_size = get_viewport().get_visible_rect()
	maximumX = window_size.end.x
	maximumY = window_size.end.y
	randomGenerator.randomize()


func randomFlowers(centerPoint : Vector2, petalsLength, petalsWidth):
	var random_flower = randomGenerator.randi_range(0,1)
	if (random_flower % 2 == 0):
		_8Petals(centerPoint, petalsLength, petalsWidth)
	else:
		_4Petals(centerPoint, petalsLength, petalsWidth)


func drawFlowers():
	var petalsLength = maximumY / 23
	var petalsWidth = petalsLength / 2
	var centerPoint = Vector2(petalsLength * 2, petalsLength*2)
	for j in range(6):
		for k in range (10):
			randomFlowers(centerPoint, petalsLength, petalsWidth)
			centerPoint.x += petalsLength * 4
		centerPoint.x = petalsLength * 2
		centerPoint.y += petalsLength * 4
		
func _draw():
	drawFlowers()


func _on_Update_pressed():
	get_tree().change_scene("res://Batik.tscn")


func _on_Back2_pressed():
	get_tree().change_scene("res://MainMenu.tscn")
