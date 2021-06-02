extends shape

class_name ellipse

#function untuk membuat ellipse menggunakan midpoint
func ellipseMidpoint(centerPoint: Vector2, rx: int, ry: int, kuadran := [1,2,3,4], rotate := 0, centerRadius := Vector2(-1,-1)):
	var x = 0
	var y = ry
	var rxQuadrat = rx*rx
	var ryQuadrat = ry*ry
	var two_rxQuadrat = 2*rxQuadrat
	var two_ryQuadrat = 2*ryQuadrat
	var p
	var px = 0
	var py = two_rxQuadrat * y

	if (centerRadius == Vector2(-1,-1)):
		centerRadius = centerPoint
	
	# region 1
	p = round(ryQuadrat - (rxQuadrat * ry) + (0.25 * rxQuadrat))
	while (px < py):
		x += 1
		px += two_ryQuadrat
		if (p < 0):
			p += ryQuadrat + px
		else:
			y -= 1
#			py -= two_rxQuadrat
			p += ryQuadrat + px - py
		
		ellipsePoints(centerPoint, x, y, rotate, centerRadius, kuadran)
	
	# region 2
	p = round(ryQuadrat * (x + 0.5) * (x + 0.5) + rxQuadrat * (y-1) * (y-1) - rxQuadrat* ryQuadrat)
	while (y > 0):
		y -= 1
		py -= two_rxQuadrat
		if (p > 0):
			p += rxQuadrat - py
		else:
			x += 1
#			px += two_ryQuadrat
			p += rxQuadrat - py + px
		ellipsePoints(centerPoint, x, y, rotate, centerRadius, kuadran)

#function untuk mengelola titik-titik yang ada pada elips
func ellipsePoints(centerPoint : Vector2, x, y, rotate, centerRadius : Vector2, kuadran : Array):
	if (kuadran.size() == 4):
		centerPoint = rotatePoint(centerRadius, rotate, centerPoint)
		var point = Vector2(centerPoint.x + x, centerPoint.y + y)
		var p_rotate = rotatePoint(centerPoint, rotate, point)
		put_pixel(p_rotate.x, p_rotate.y, colour[1])
		#lineDDA(centerPoint.x, centerPoint.y, p_rotate.x, p_rotate.y)
		point = Vector2(centerPoint.x - x, centerPoint.y + y)
		p_rotate = rotatePoint(centerPoint, rotate, point)
		put_pixel(p_rotate.x, p_rotate.y, colour[1])
		#lineDDA(centerPoint.x, centerPoint.y, p_rotate.x, p_rotate.y)
		point = Vector2(centerPoint.x + x, centerPoint.y - y)
		p_rotate = rotatePoint(centerPoint, rotate, point)
		put_pixel(p_rotate.x, p_rotate.y, colour[1])
	#	lineDDA(centerPoint.x, centerPoint.y, p_rotate.x, p_rotate.y)
		point = Vector2(centerPoint.x - x, centerPoint.y - y)
		p_rotate = rotatePoint(centerPoint, rotate, point)
		put_pixel(p_rotate.x, p_rotate.y, colour[1])
	#	lineDDA(centerPoint.x, centerPoint.y, p_rotate.x, p_rotate.y)
	else:
		for j in (kuadran.size()):
			draw_kuadran(kuadran[j], centerPoint, x, y, rotate, centerRadius)

#function untuk menggambar elips
func draw_kuadran(kuadran : int, centerPoint : Vector2, x : int, y :int, rotate, centerRadius : Vector2):
	centerPoint = rotatePoint(centerRadius, rotate, centerPoint)
	var point = Vector2(centerPoint.x + x, centerPoint.y - y)
	var p_rotate = rotatePoint(centerPoint, rotate, point)
	
	match kuadran:
		1:
			put_pixel(p_rotate.x, p_rotate.y, colour[1])
		2:
			point = Vector2(centerPoint.x - x, centerPoint.y - y)
			p_rotate = rotatePoint(centerPoint, rotate, point)
			put_pixel(p_rotate.x, p_rotate.y, colour[1])
		3:
			point = Vector2(centerPoint.x - x, centerPoint.y + y)
			p_rotate = rotatePoint(centerPoint, rotate, point)
			put_pixel(p_rotate.x, p_rotate.y, colour[1])
		4:
			point = Vector2(centerPoint.x + x, centerPoint.y + y)
			p_rotate = rotatePoint(centerPoint, rotate, point)
			put_pixel(p_rotate.x, p_rotate.y, colour[1])

#function untuk melakukan rotasi titik-titik pada elips
func rotatePoint(centerPoint : Vector2, angle, point : Vector2):
	var angleRadius = deg2rad(angle)
	return Vector2(cos(angleRadius) * (point.x - centerPoint.x) - sin(angleRadius) * (point.y - centerPoint.y) + centerPoint.x,
	sin(angleRadius) * (point.x - centerPoint.x) + cos(angleRadius) * (point.y - centerPoint.y) + centerPoint.y)
		
#function untuk mengatur pixel
func put_pixel(x, y, color):
	draw_primitive(PoolVector2Array([Vector2(x, y)]),
			PoolColorArray([color]),
			PoolVector2Array())

#function untuk menggambar elips yang terisi penuh		
#func fullEllipse(centerPoint : Vector2, length, width, angle):
#	draw_set_transform(Vector2(18,68),0,Vector2(2,3))
#	draw_circle(Vector2(68,20),10.0,Color(1, 0.75, 0.8, 1))
