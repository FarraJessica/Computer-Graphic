extends Node2D

var xa = 0
var inc = 0.3
func _ready():
	pass # Replace with function body.
	get_viewport().set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)
	
#function untuk set pixel
func put_pixel(x, y, color):
	var points = PoolVector2Array()
	var colors = PoolColorArray()
	points.append(Vector2(x,y))
	colors.append(color)
	draw_primitive(points,colors,points)

#function untuk garis horizontal
func lineDDA(xa, ya, xb, yb):
	var dx = xb-xa
	var dy = yb-ya
	var steps
	var xIncrement
	var yIncrement
	var x = xa
	var y = ya
	
	if abs(dx)>abs(dy):
		steps = abs (dx)
	else:
		steps = abs (dy)
	xIncrement = dx/steps
	yIncrement = dy/steps
	
	for k in range (steps + 1) :
		x = x + xIncrement
		y = y + yIncrement
		put_pixel (round(x),round(y),Color( 1, 0.71, 0.76, 1 ))
			

#function untuk garis vertikal
func bresenham(xa, ya, xb, yb) :
	var dx = abs(xa-xb)
	var dy = abs(ya-yb)
	var delta = dy - dx
	var p = 2 * dy - dx
	var twoDy = 2 * dy
	var twoDyDx = 2 * delta
	var x
	var y
	var xEnd 
	var color = Color( 1, 0.71, 0.76, 1 )
	
	if xa > xb :
		x = xb
		y = yb
		xEnd = xa
	else :
		x = xa
		y = ya
		xEnd = xb

	while (x < xEnd):
		x = x + 1
		if p < 0 :
			p = p + twoDy
		else :
			y = y + 1
			p = p + twoDyDx
			
		put_pixel(round(x),round(y),color)

#function untuk menggambar frame
func frame():
	var windowSize : Rect2 = get_viewport().get_visible_rect()
	var left = windowSize.position.x + 10
	var top = windowSize.position.y + 10
	var right = windowSize.end.x - 10
	var bottom = windowSize.end.y - 10
	var color = Color( 0.53, 0.81, 0.98, 1 )
		
	#frame kiri
	for i in range(top,bottom):
		put_pixel(left,i,color)
	#frame kanan
	for i in range(top,bottom):
		put_pixel(right,i,color)
	#frame atas
	for i in range(left,right):
		put_pixel(i,top,color)
	#frame bawah
	for i in range(left,right):
		put_pixel(i,bottom,color)

			
func cosinus(a, t):
	var window_size : Rect2 = get_viewport().get_visible_rect()
	var middle_y = window_size.end.y / 2
	var middle_x = window_size.end.x / 2
	var color = Color(1, 1, 0.88, 1) #light yellow color
	var ya
		
	ya = a * cos(xa*t)
	if(middle_x-xa>10):
		put_pixel(middle_x + xa, middle_y - ya, color)
		
func _process(delta):
	var width = get_viewport().size.x
	if (xa < (width)):
		xa += inc
	
	update()
		
func _draw():
	var width = get_viewport().size.x
	var heigh = get_viewport().size.y
	var middle_x = get_viewport().size.x/2
	var middle_y = get_viewport().size.y/2

	#garis koordinat
	lineDDA(middle_x,10,middle_x,heigh-10) #vertikal
	bresenham(10,middle_y,width-10,middle_y) #horizontal
	
	#frame
	lineDDA(10,10,10,heigh-10) #frame kiri
	lineDDA(width-10,10,width-10,heigh-10)#frame kanan
	bresenham(10,heigh-10,width-10,heigh-10) #frame bawah
	bresenham(10,10,10,width-10)#frame atas
	
	frame()
	cosinus(40, 0.050)


func _on_Back_pressed():
	get_tree().change_scene("res://MainScene.tscn")
	


func _on_Next_pressed():
	get_tree().change_scene("res://Sinus.tscn")
