extends Node2D

class_name Line

func lineGenerator(startPoint : Vector2, endPoint : Vector2, color : Color, thick := 1, space := 0, dot := false):
	var dx = endPoint.x - startPoint.x
	var dy = endPoint.y - startPoint.y
	var steps = abs(dx) if (abs(dx) > abs(dy)) else abs(dy)
	var x_inc = dx / steps
	var y_inc = dy / steps
	var x = startPoint.x
	var y = startPoint.y 
	
	put_pixel(x, y, color)
	
	if (space > 0):
		for i in steps:
			x += x_inc
			y += y_inc
			
			if ((i / space) % 2):
				if (dot && (i%space == 1)):
					put_pixel(round(x), round(y), color)
			else:
				put_pixel(round(x), round(y), color)
	else:
		for i in steps:
			x += x_inc
			y += y_inc
			put_pixel(round(x), round(y), color)
	
	if (thick > 1):
		if (dx == 0):
			startPoint.x += 1
			endPoint.x += 1
			thick -= 1
		else:
			startPoint.y += 1
			endPoint.y += 1
			thick -= 1
		lineGenerator(startPoint, endPoint, color, thick, space, dot)

func put_pixel(x, y, color):
	draw_primitive(PoolVector2Array(
		[Vector2(x, y)]), 
		PoolColorArray([color]), 
		PoolVector2Array()
	)
