extends Node2D

var window_size : Rect2
var line = {thick = 1, space = 0, dot = false}
var thickLine = {thick = 3, space = 0, dot = false}
var stripLine = {thick = 1, space = 5, dot = false}
var dottedLine = {thick = 1, space = 5, dot = true}
var colour : PoolColorArray

func _ready():
	window_size = get_viewport().get_visible_rect()
	colour = [Color( 1, 0.71, 0.76, 1 ), Color( 0.94, 0.5, 0.5, 1 ),
			  Color( 1, 0.94, 0.96, 1 ), Color( 0.9, 0.9, 0.98, 1 ),
			  Color( 0.58, 0.44, 0.86, 1 ),Color(  1, 0.89, 0.88, 1),
			  Color( 0.85, 0.44, 0.84, 1 ), Color( 1, 0.75, 0.8, 1 ),
			  Color( 0.63, 0.13, 0.94, 1 ), Color( 1, 0.08, 0.58, 1 )]
#[0] light pink
#[1] light coral
#[2] lavendarblush
#[3] lavender
#[4] medium purple
#[5] Misty rose
#[6] Orchid 
#[7] Pink
#[8] Purple
#[9] Deep Pink

#function untuk membuat line
func line_generator(start : Vector2, end : Vector2, color : Color, thick := 1, space := 0, dot := false):
	var dx = end.x - start.x
	var dy = end.y - start.y
	
	var step = abs(dx) if (abs(dx) > abs(dy)) else abs(dy)
	
	var x_inc = dx / step
	var y_inc = dy / step
	var x = start.x
	var y = start.y 
	
	put_pixel(x, y, color)
	
	if (space != 0):
		for k in step :
			x += x_inc
			y += y_inc
			
			if ((k / space) % 2):
				if (dot && (k%space == 1)):
					put_pixel(x, y, color)
			else:
				put_pixel(x, y, color)
	else:
		for k in step :
			x += x_inc
			y += y_inc
			put_pixel(x, y, color)
	if (thick != 1):
		start.y += 1
		end.y += 1
		thick -= 1
		line_generator(start,end,color,thick,space)

#persegi : membutuhkan 4 sisi sama panjang
func persegi(start : Vector2, s : int, color, types : Dictionary):
	draw_sides_shape(start, Vector2(start.x + s, start.y),
	Vector2(start.x + s, start.y + s),
	Vector2(start.x, start.y + s), 
	color, types)

#persegi panjang : membutuhkan 2 sisi horizontal sama panjang & 2 sisi vertikal sama panjang
func persegipanjang(start : Vector2, p : int, l : int, color, types : Dictionary):
	draw_sides_shape(start, Vector2(start.x + p, start.y),
	Vector2(start.x + p, start.y + l),
	Vector2(start.x, start.y + l), 
	color, types)

#jajar genjang : memubutuhkan titik  kanan atas, titik kanan bawah, & panjang sisi
func jajargenjang(upper_point : Vector2, lower_point : Vector2, p : int, color, types : Dictionary):
	draw_sides_shape(upper_point, Vector2(upper_point.x + p, upper_point.y),
	Vector2(lower_point.x + p, lower_point.y),
	Vector2(lower_point),
	color, types)

#belah ketupat : membutuhkan titik tengah & diagonal
func belahketupat(center_point : Vector2, d : int, color, types : Dictionary):
	draw_sides_shape(Vector2(center_point.x, center_point.y - d),
	Vector2(center_point.x + d, center_point.y),
	Vector2(center_point.x, center_point.y + d),
	Vector2(center_point.x - d, center_point.y),
	color, types)

#trapesium siku-siku : membutuhkan titik awal panjang bagian atas, tinggi,  & panjang bagian bawah
func trapesium(startPoint : Vector2, up_l : int, low_l : int, t : int, color, type : Dictionary):
	draw_sides_shape(startPoint,
	Vector2(startPoint.x + up_l, startPoint.y),
	Vector2(startPoint.x + low_l, startPoint.y + t),
	Vector2(startPoint.x, startPoint.y + t),
	color, type)

#segitiga siku-siku : membutuhkan titik awal (titik sudut siku siku), tinggi, & alas
func segitiga(startPoint : Vector2, a : int, t : int, color, type : Dictionary):
	line_generator(startPoint, Vector2(startPoint.x + a, startPoint.y), color, 
			type.thick, type.space, type.dot)
	line_generator(Vector2(startPoint.x + a, startPoint.y), Vector2(startPoint.x, startPoint.y - t), color, 
			type.thick, type.space, type.dot)
	line_generator(Vector2(startPoint.x, startPoint.y - t), startPoint, color,
			type.thick, type.space, type.dot)

#function untuk mengatur pixel
func put_pixel(x, y, color):
	draw_primitive(PoolVector2Array([Vector2(x, y)]),
			PoolColorArray([color]),
			PoolVector2Array())

#function untuk menampilkan berbagai jenis line dan shape ke layar
func _draw():
	line_generator(Vector2(100,230), Vector2(950,230), colour[0])
	line_generator(Vector2(100,250), Vector2(950,250), colour[1])
	line_generator(Vector2(100,270), Vector2(950,270), colour[2], 1, 5)
	line_generator(Vector2(100,250), Vector2(950,250), colour[1])
	line_generator(Vector2(100,290), Vector2(950,290), colour[3], 3)
	line_generator(Vector2(100,310), Vector2(950,310), colour[4], 1, 5, true)
	line_generator(Vector2(100,330), Vector2(950,330), colour[5], 5)
	line_generator(Vector2(100,350), Vector2(950,350), colour[6])
	line_generator(Vector2(100,370), Vector2(950,370), colour[7], 1, 5)
	
	persegi(Vector2(30,160), 50, colour[0], line)
	persegi(Vector2(30,400), 50, colour[0], line)
	persegi(Vector2(100,160), 50, colour[2], stripLine)
	persegi(Vector2(100,400), 50, colour[2], stripLine)
	
	persegipanjang(Vector2(170,160), 80, 50, colour[1], line)
	persegipanjang(Vector2(170,400), 80, 50, colour[1], line)
	persegipanjang(Vector2(270,160), 80, 50, colour[6], dottedLine)
	persegipanjang(Vector2(270,400), 80, 50, colour[6], dottedLine)
	
	jajargenjang(Vector2(370,160), Vector2(390,210), 80, colour[7], line)
	jajargenjang(Vector2(370,400), Vector2(390,450), 80, colour[7], line)
	jajargenjang(Vector2(470,160), Vector2(490,210), 80, colour[8], stripLine)
	jajargenjang(Vector2(470,400), Vector2(490,450), 80, colour[8], stripLine)
	
	belahketupat(Vector2(605,190), 25, colour[5], line)
	belahketupat(Vector2(605,420), 25, colour[5], line)
	belahketupat(Vector2(670,190), 25, colour[3], dottedLine)
	belahketupat(Vector2(670,420), 25, colour[3], dottedLine)
	
	trapesium(Vector2(710,160), 20, 50, 50, colour[4], line)
	trapesium(Vector2(710,400), 20, 50, 50, colour[4], line)
	trapesium(Vector2(780,160), 20, 50, 50, colour[9], stripLine)
	trapesium(Vector2(780,400), 20, 50, 50, colour[9], stripLine)
	
	segitiga(Vector2(850,210), 70, 50, colour[3],line)
	segitiga(Vector2(850,450), 70, 50, colour[3],line)
	segitiga(Vector2(930,210), 70, 50, colour[5],dottedLine)
	segitiga(Vector2(930,450), 70, 50, colour[5],dottedLine)

#function untuk menampilkan sisi-sisi shape
func draw_sides_shape(t1 : Vector2, t2 : Vector2, t3 : Vector2, t4 : Vector2, color, type : Dictionary):
	
	line_generator(t1,t2,color,type.thick, type.space, type.dot) #menyambungkan titik 1&2
	 
	line_generator(t2,t3,color,type.thick, type.space, type.dot) #menyambungkan titik 2&3
	 
	line_generator(t3,t4,color,type.thick, type.space, type.dot) #menyambungkan titik 3&4
	
	line_generator(t4,t1,color,type.thick, type.space, type.dot) #menyambungkan titik 4&1
	
