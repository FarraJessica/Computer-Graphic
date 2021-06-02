extends ellipse

class_name flower

var maximumX
var maximumY:int
var step :int
var xa = 68
var ya = 0
var xb = 68
var yb = 700
var size :int


func _ready():
	window_size = get_viewport().get_visible_rect()
	maximumX = window_size.end.x
	maximumY = window_size.end.y
#	size = maximumX / 30

#function untuk membuat 2 kelopak daun
func _2Petals(centerPoint : Vector2, length, width, angle):
	var ellipseCenter = Vector2(centerPoint.x, centerPoint.y + (length))

	ellipseMidpoint(ellipseCenter, width, length, [1,2,3,4], -angle, centerPoint)
	ellipseMidpoint(ellipseCenter, width, length, [1,2,3,4], angle, centerPoint)

#function untuk membuat kumpulan tanaman merambat (tangkai + kelopak daun)
func drawVines():
	var petalsLength = maximumX / 30
	var petalsWidth = petalsLength / 6
#	var petalsLength = size
#	var petalsWidth = size / 3
	var centerPoint = Vector2(petalsLength*2, petalsLength*2)
	for j in range(6):    #looping untuk jumlah baris
		for k in range (9):   #looping untuk jumlah kolom
			if k & 1:
				_2Petals(Vector2(centerPoint.x, (int(centerPoint.y) + step) % maximumY), petalsLength, petalsWidth, 45)
			else:
				_2Petals(Vector2(centerPoint.x, maximumY - ((int(centerPoint.y) + step) % maximumY)), petalsLength, petalsWidth, 135)

#			draw_set_transform(Vector2(18,64),0,Vector2(2,3))
#			draw_circle(Vector2(centerPoint.x,centerPoint.y),5.0,Color(1, 0.75, 0.8, 1))
			centerPoint.x += petalsLength*3.25
		centerPoint.x = petalsLength*2
		centerPoint.y += petalsLength*3
