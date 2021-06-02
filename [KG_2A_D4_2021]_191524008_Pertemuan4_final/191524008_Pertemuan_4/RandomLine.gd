extends Node2D

var window_size : Rect2
var start : Vector2
var end : Vector2
var randomGenerator = RandomNumberGenerator.new()
var colour : PoolColorArray
var list_color : int

func _ready():
	window_size = get_viewport().get_visible_rect()
	randomGenerator.randomize()
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
	
#function untuk menggambar line
func lineDDA(xa, ya, xb, yb) :
	var dx = xb-xa
	var dy = yb-ya
	var steps
	var xIncrement
	var yIncrement
	var x = xa
	var y = ya
	var color = colour[list_color]
	
	if abs(dx) > abs(dy):
		steps = abs (dx)
	else:
		steps = abs (dy)
	xIncrement = dx/steps
	yIncrement = dy/steps

	for k in range (steps + 1) :
		x = x + xIncrement
		y = y + yIncrement
		put_pixel(round(x),round(y),color)

#function untuk melakukan random line
func random_line(maximal_x, maximal_y):
		start.x = randomGenerator.randf_range(0,maximal_x)
		end.x = randomGenerator.randf_range(0,maximal_x)
		start.y = randomGenerator.randf_range(0,maximal_y)
		end.y = randomGenerator.randf_range(0,maximal_y)
		list_color = randomGenerator.randf_range(0,9)
		lineDDA(start.x,start.y,end.x,end.y)
		
#function untuk mengatur pixel		
func put_pixel(x, y, color):
	var point = PoolVector2Array([Vector2(x, y)])
	var colour = PoolColorArray([color])
	draw_primitive(point,colour,point)
	
#function untuk menampilkan line ke layar	
func _draw():
	window_size = get_viewport().get_visible_rect()
	var maximal_x = window_size.end.x
	var maximal_y = window_size.end.y
	for n in range(200):
		random_line(maximal_x, maximal_y)

func _on_Back_pressed():
	get_tree().change_scene("res://Main.tscn")
