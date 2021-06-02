extends Node2D

func _ready():
	pass # Replace with function body.
	
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

#function untuk menggampar midpoint
func midPoint(xa,ya,xb,yb) :
	var dx = xb-xa
	var dy = yb-ya
	var color = Color(0.87, 0.63, 0.87, 1)
	var window_size : Rect2 = get_viewport().get_visible_rect()
	var midy = window_size.end.y / 2
	var midx = window_size.end.x / 2
	if dy <= dx :
		var d = dy - (dx/2)
		var x = xa
		var y = ya
		put_pixel(round(x),round(y),color)
		while (x < xb):
			x=x+1
			if d < 0:
				d=d+dy
			else:
				d +=(dy-dx)
				y = y+1
			put_pixel(round(x),round(y),color)
	elif(dx<dy):
		var d=dx-(dy-2)
		var x=xa
		var y=ya
		put_pixel(round(x),round(y),color)
		while (y < yb):
			y=y+1
			if d < 0 :
				d = d+dx
			else:
				d+=(dx-dy)
				x=x+1
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


func kuadrat(a, b, c):
	var window_size : Rect2 = get_viewport().get_visible_rect()
	var middle_y = window_size.end.y / 2
	var middle_x = window_size.end.x / 2
	var color = Color( 0.13, 0.7, 0.67, 1) #warna light green
	var xa = 0
	var ya = c
	var xb
	var yb
	while (xa < middle_x):
		xb = xa + 0.05
		yb = (a * xb * xb) + (b * xb) + c
		xa = xb
		ya = yb
		if (middle_y - ya > 10):
			put_pixel(middle_x + xa, middle_y - ya, color)
			
func kubik(a, b, c, d):
	var window_size : Rect2 = get_viewport().get_visible_rect()
	var middle_y = window_size.end.y / 2
	var middle_x = window_size.end.x / 2
	var color = Color(1,1,1,1) #warna white
	var xa = 0
	var ya = c
	var xb
	var yb
	while (xa < middle_x):
		xb = xa + 0.05
		yb = (a * xb * xb * xb) + (b * xb * xb) + (c * xb) + d
		xa = xb
		ya = yb
		if (middle_y - ya > 10):
			put_pixel(middle_x + xa, middle_y - ya, color)


func sinus(a, t):
	var window_size : Rect2 = get_viewport().get_visible_rect()
	var middle_y = window_size.end.y / 2
	var middle_x = window_size.end.x / 2
	var color = Color(0.39, 0.58, 0.93, 1) #warna cornflower
	var xa = 0
	var ya
	while (xa < middle_x):
		xa += 0.5 
		ya = a * sin(xa*t)
		if(middle_x-xa>10):
			put_pixel(middle_x + xa, middle_y - ya, color)
			
func cosinus(a, t):
	var window_size : Rect2 = get_viewport().get_visible_rect()
	var middle_y = window_size.end.y / 2
	var middle_x = window_size.end.x / 2
	var color = Color(1, 1, 0.88, 1) #warna light yellow
	var xa = 0
	var ya
	while (xa < middle_x):
		xa += 0.5 
		ya = a * cos(xa*t)
		if(middle_x-xa>10):
			put_pixel(middle_x + xa, middle_y - ya, color)
			
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
	midPoint(middle_x - 100, middle_y - 200, middle_x + 100, middle_y + 200)
	#kuadrat(0.01, 0, 0)
	#kubik(0.0005, 0.0009, 0.00005,  0)
	#sinus(40, 0.030)
	#cosinus(40, 0.030)
