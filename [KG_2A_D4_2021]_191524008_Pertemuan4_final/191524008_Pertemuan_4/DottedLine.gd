extends Node2D

var window_size : Rect2
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
func line_generator(startLine : Vector2, endLine : Vector2, color : Color, thick := 1, space := 0, dot := false):
	var dx = endLine.x - startLine.x
	var dy = endLine.y - startLine.y
	var steps = abs(dx) if (abs(dx) > abs(dy)) else abs(dy)
	var x_inc = dx / steps
	var y_inc = dy / steps
	var x = startLine.x
	var y = startLine.y 
	
	put_pixel(x, y, color)
	
	if (space != 0):
		for k in steps:
			x += x_inc
			y += y_inc
			
			if ((k / space) % 2): 
				if (dot && (k%space == 1)):
					put_pixel(x, y, color)
			else:
				put_pixel(x, y, color)
	else:
		for k in steps:
			x += x_inc
			y += y_inc
			put_pixel(x, y, color)
	
	
	if (thick > 1):
		startLine.y += 1
		endLine.y += 1
		thick -= 1
		line_generator(startLine,endLine,color,thick,space)
		
#function untuk mengatur pixel
func put_pixel(x, y, color):
	draw_primitive(PoolVector2Array(
		[Vector2(x, y)]), 
		PoolColorArray([color]), 
		PoolVector2Array()
	)

#function untuk menampilkan semua jenis line ke layar
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
	
func _on_Back_pressed():
	get_tree().change_scene("res://Main.tscn")
