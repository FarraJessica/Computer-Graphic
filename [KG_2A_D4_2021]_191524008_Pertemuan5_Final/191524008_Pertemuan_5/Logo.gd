extends Circle

var window_size : Rect2
var thickness = {thick = 4, space = 0, dot = false}
var thick_ness = {thick = 2, space = 0, dot = false}
var maximumX
var maximumY
var colours : PoolColorArray

func _ready():
	window_size = get_viewport().get_visible_rect()
	maximumX = window_size.end.x
	maximumY = window_size.end.y

	colours = [Color(0.96, 0.96, 0.86, 1), Color( 0, 0, 0, 1 ), Color( 0.8, 0.36, 0.36, 1),
	Color( 0, 1, 0, 1 ), Color( 1, 0, 1, 0 ), Color( 1, 1, 0, 0 ),
	Color( 0, 0, 1, 1 ), Color( 1, 1, 1, 1 )]

#color dictionary
#[0] white
#[1] black
#[2] indian red

#full small circle
func smallCircle(circleCenter : Vector2, radius : int, colours:Color):
	for i in range (radius):
		midpoint_Circle(circleCenter, i)

func midpoint_Circle(circleCenter : Vector2, radius : int):
	var x = radius
	var y = 0
	put_pixel(circleCenter.x + x, circleCenter.y + y, colours[7])

	if (radius > 0) :
		put_pixel(circleCenter.x - x, circleCenter.y + y, colours[7])
		put_pixel(circleCenter.x + y, circleCenter.y + x, colours[7])
		put_pixel(circleCenter.x + y, circleCenter.y - x, colours[7])
	var mP = 1 - radius
	
	while (x > y):
		y += 1
		if (mP <= 0):
			mP = mP + 2*y + 1
		else:
			x -= 1
			mP = mP + 2*y - 2*x + 1
		
		if (x < y):
			break
		put_pixel(circleCenter.x + x, circleCenter.y + y, colours[7])
		put_pixel(circleCenter.x - x, circleCenter.y + y, colours[7])
		put_pixel(circleCenter.x + x, circleCenter.y - y, colours[7])
		put_pixel(circleCenter.x - x, circleCenter.y - y, colours[7])
		
		if x != y:
			put_pixel(circleCenter.x + y, circleCenter.y + x, colours[7])
			put_pixel(circleCenter.x - y, circleCenter.y + x, colours[7])
			put_pixel(circleCenter.x + y, circleCenter.y - x, colours[7])
			put_pixel(circleCenter.x - y, circleCenter.y - x, colours[7])


#function untuk membuat line
func lineGenerator(start : Vector2, end : Vector2, colours:Color, thick := 1, space := 0, dot := false):
	var dx = end.x - start.x
	var dy = end.y - start.y
	
	var step = abs(dx) if (abs(dx) > abs(dy)) else abs(dy)
	
	var x_inc = dx/step
	var y_inc = dy/step
	var x = start.x
	var y = start.y 
	
	put_pixel(x, y, colours)
	
	if (space > 0):
		for i in step :
			x += x_inc
			y += y_inc
			
			if ((i / space) % 2):
				if (dot && (i%space == 1)):
					put_pixel(round(x), round(y), colours)
			else:
				put_pixel(round(x), round(y), colours)
	else:
		for i in step :
			x += x_inc
			y += y_inc
			put_pixel(round(x), round(y), colours)
	if (thick != 1):
		start.y += 1
		end.y += 1
		thick -= 1
		lineGenerator(start,end,colours,thick,space)

#persegi : membutuhkan 4 sisi sama panjang
func persegi(start : Vector2, s : int, colours:Color, types : Dictionary):
	draw_sides_shape(start, Vector2(start.x + s, start.y),
	Vector2(start.x + s, start.y + s),
	Vector2(start.x, start.y + s), 
	colours, types)
	
#persegi panjang : membutuhkan 2 sisi horizontal sama panjang & 2 sisi vertikal sama panjang
func persegipanjang(start : Vector2, p : int, l : int, colours:Color, types : Dictionary):
	draw_sides_shape(start, Vector2(start.x + p, start.y),
	Vector2(start.x + p, start.y + l),
	Vector2(start.x, start.y + l), 
	colours, types)

#function untuk mengatur pixel
func put_pixel(x, y, colours:Color):
	draw_primitive(PoolVector2Array([Vector2(x, y)]),
			PoolColorArray([colours]),
			PoolVector2Array())

#function untuk menampilkan berbagai jenis line dan shape ke layar
func _draw():
	for i in range(1,250):
		persegi(Vector2(300,100), i, colours[2], thickness)

	for j in range(1,25):
		persegipanjang(Vector2(350,150), j, 130, colours[1], thick_ness)

	for k in range(1,5):
		persegipanjang(Vector2(1100,150), k, 150, colours[1], thick_ness)
		smallCircle(Vector2(maximumX/2.35, maximumY/3), 40, colours[7])


#function untuk menampilkan sisi-sisi shape
func draw_sides_shape(t1 : Vector2, t2 : Vector2, t3 : Vector2, t4 : Vector2, colours:Color, type : Dictionary):
	
	lineGenerator(t1,t2,colours,type.thick, type.space, type.dot) #menyambungkan titik 1&2
	 
	lineGenerator(t2,t3,colours,type.thick, type.space, type.dot) #menyambungkan titik 2&3
	 
	lineGenerator(t3,t4,colours,type.thick, type.space, type.dot) #menyambungkan titik 3&4
	
	lineGenerator(t4,t1,colours,type.thick, type.space, type.dot) #menyambungkan titik 4&1

		
func _on_Back_pressed():
	get_tree().change_scene("res://MainMenu.tscn")


func _on_Next_pressed():
	get_tree().change_scene("res://RandomCircle.tscn")
