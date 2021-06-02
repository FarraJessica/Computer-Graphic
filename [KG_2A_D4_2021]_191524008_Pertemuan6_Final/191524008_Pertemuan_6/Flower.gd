extends ellipse

class_name flower

func _4Petals(centerPoint : Vector2, length, width):
	var ellipseCenter = Vector2(centerPoint.x, centerPoint.y + (length))
	
	for j in range (4):
		var angle = 90 * j
		ellipseMidpoint(ellipseCenter, width, length, [1,2,3,4], angle, centerPoint)

func _8Petals(centerPoint : Vector2, length, width):
	var ellipseCenter= Vector2(centerPoint.x, centerPoint.y + (length))
	for j in range (8):
		var angle = 45 * j
		ellipseMidpoint(ellipseCenter, width, length, [3,4], angle, centerPoint)
