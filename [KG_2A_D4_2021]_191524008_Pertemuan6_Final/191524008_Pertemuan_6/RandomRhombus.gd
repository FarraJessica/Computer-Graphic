extends shape

var randomGenerator = RandomNumberGenerator.new()
var line = {thickness = 1, spacing = 0, dot = false}
var maximumX
var maximumY

func _ready():
	window_size = get_viewport().get_visible_rect()
	maximumX = window_size.end.x
	maximumY = window_size.end.y
	randomGenerator.randomize()

func rhombusGenerator(startPoint : Vector2, side : int):
	var colorindex = randomGenerator.randi_range(1,10)
	for j in range (50):
		if (side == 0):
			continue
		else:
			rotasiBelahketupat(startPoint, side, colour[colorindex], line)
		
		startPoint.x += 2
		startPoint.y -= 2
		side -= 4
		colorindex = randomGenerator.randi_range(1,10)
		
		
func _draw():
	var startPoint : Vector2
	var side = randomGenerator.randi_range(1,600)
	startPoint.x = randomGenerator.randi_range(0,maximumX)
	startPoint.y = randomGenerator.randi_range(0,maximumY)
	rhombusGenerator(startPoint, side)


func _on_Back_pressed():
	get_tree().change_scene("res://MainMenu.tscn")


func _on_Update_pressed():
	get_tree().change_scene("res://RandomRhombus.tscn")
