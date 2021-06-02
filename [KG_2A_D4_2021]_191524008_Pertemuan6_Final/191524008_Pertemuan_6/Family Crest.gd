extends shape

var line = {thickness = 1, spacing = 0, dot = false}
var maximumX
var maximumY
var mid

func _ready():
	window_size = get_viewport().get_visible_rect()
	maximumX = window_size.end.x
	maximumY = window_size.end.y
	mid = Vector2(maximumX/2, maximumY/2)
	
func outerCircle(center : Vector2, r : int, thickness : int, color : Color):
	for n in range (thickness):
		circleMidpoint(center, r + n, color)

func fillCircle(center : Vector2, r : int, color):
	for n in range (r):
		circleMidpoint(center, n, color)

func eightCircles():
	var circleCenter = Vector2(mid.x, mid.y - 80)
	var angle = 0
	var angleInc = (360/8)
	for j in range (8):
		angle = angleInc * j
		fillCircle(rotatePoint(mid, circleCenter, angle), 25, Color(1,1,1,1))

func _draw():
	outerCircle(mid, 130, 10, Color(1,1,1,1))
	eightCircles()
	circleMidpoint(mid, 50, Color(0,0,0,1))
	fillCircle(mid,50, Color(1,1,1,1))



func _on_Back_pressed():
	get_tree().change_scene("res://MainMenu.tscn")
