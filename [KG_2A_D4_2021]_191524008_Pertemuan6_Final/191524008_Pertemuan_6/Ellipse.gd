extends shape

class_name ellipse

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
			py -= two_rxQuadrat
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
			px += two_ryQuadrat
			p += rxQuadrat - py + px
		ellipsePoints(centerPoint, x, y, rotate, centerRadius, kuadran)

func ellipsePoints(centerPoint : Vector2, x, y, rotate, centerRadius : Vector2, kuadran : Array):
	if (kuadran.size() == 4):
		centerPoint = rotatePoint(centerRadius, rotate, centerPoint)
		var point = Vector2(centerPoint.x + x, centerPoint.y + y)
		var p_rotate = rotatePoint(centerPoint, rotate, point)
		put_pixel(p_rotate.x, p_rotate.y, colour[1])
		point = Vector2(centerPoint.x - x, centerPoint.y + y)
		p_rotate = rotatePoint(centerPoint, rotate, point)
		put_pixel(p_rotate.x, p_rotate.y, colour[6])
		point = Vector2(centerPoint.x + x, centerPoint.y - y)
		p_rotate = rotatePoint(centerPoint, rotate, point)
		put_pixel(p_rotate.x, p_rotate.y, colour[10])
		point = Vector2(centerPoint.x - x, centerPoint.y - y)
		p_rotate = rotatePoint(centerPoint, rotate, point)
		put_pixel(p_rotate.x, p_rotate.y, colour[1])
	else:
		for j in (kuadran.size()):
			draw_kuadran(kuadran[j], centerPoint, x, y, rotate, centerRadius)

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
			put_pixel(p_rotate.x, p_rotate.y, colour[10])
		3:
			point = Vector2(centerPoint.x - x, centerPoint.y + y)
			p_rotate = rotatePoint(centerPoint, rotate, point)
			put_pixel(p_rotate.x, p_rotate.y, colour[6])
		4:
			point = Vector2(centerPoint.x + x, centerPoint.y + y)
			p_rotate = rotatePoint(centerPoint, rotate, point)
			put_pixel(p_rotate.x, p_rotate.y, colour[1])


func rotatePoint(centerPoint : Vector2, angle, point : Vector2):
	var angleRadius = deg2rad(angle)
	return Vector2(cos(angleRadius) * (point.x - centerPoint.x) - sin(angleRadius) * (point.y - centerPoint.y) + centerPoint.x,
	sin(angleRadius) * (point.x - centerPoint.x) + cos(angleRadius) * (point.y - centerPoint.y) + centerPoint.y)

			
#function untuk mengatur pixel
func put_pixel(x, y, color):
	draw_primitive(PoolVector2Array([Vector2(x, y)]),
			PoolColorArray([color]),
			PoolVector2Array())
			

#func fullEllips(center : Vector2, rx, ry, rotating := 0):
#	var x_inc = 0
#	var y_inc = 0
#	for i in range(max(rx,ry)):
#		if i <= rx:
#			x_inc += 1
#		if i <= ry:
#			y_inc += 1
#		ellips_midpoint(center, x_inc, y_inc, rotating)


func _on_Update_pressed():
	get_tree().change_scene("res://Ellipse.tscn")


func _on_Back_pressed():
	get_tree().change_scene("res://MainMenu.tscn")
