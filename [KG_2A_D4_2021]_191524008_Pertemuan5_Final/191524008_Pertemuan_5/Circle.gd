extends Line

class_name Circle

var colors : PoolColorArray

func _ready():
	colors = [Color( 0, 1, 1, 1 ), Color( 0.53, 0.81, 0.98, 1 ), Color( 0, 0, 1, 1 ),
	Color( 0.25, 0.41, 0.88, 1 ), Color( 0, 0, 0.55, 1 ),Color( 0, 0, 0.8, 1 ),
	Color( 0.12, 0.56, 1, 1 ), Color( 0, 0.75, 1, 1  ), Color( 0.69, 0.77, 0.87, 1 ),
	Color( 0, 0, 0.5, 1 ), Color( 0.1, 0.1, 0.44, 1 )]

#color dictionary :
#[1] cyan
#[2] lightskyblue
#[3] blue
#[4] royalblue
#[5] darkblue
#[6] mediumblue
#[7] dodgerblue
#[8] deepskyblue
#[9] lightsteelblue
#[10] navyblue
#[11] midnightblue

func midpointCircle(circleCenter : Vector2, radius : int):
	var x = radius
	var y = 0
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
		put_pixel(circleCenter.x + x, circleCenter.y + y, colors[0])
		put_pixel(circleCenter.x - x, circleCenter.y + y, colors[1])
		put_pixel(circleCenter.x + x, circleCenter.y - y, colors[2])
		put_pixel(circleCenter.x - x, circleCenter.y - y, colors[3])
		
		if x != y:
			put_pixel(circleCenter.x + y, circleCenter.y + x, colors[4])
			put_pixel(circleCenter.x - y, circleCenter.y + x, colors[5])
			put_pixel(circleCenter.x + y, circleCenter.y - x, colors[6])
			put_pixel(circleCenter.x - y, circleCenter.y - x, colors[7])

func draw_half_midpointCircle(circleCenter : Vector2, radius : int, startQuadran : int, endQuadran : int):
	var x = radius
	var y = 0
	
	var mP = 1 - radius
	while (x > y):
		y += 1
		# Mid-point didalam parameter
		if (mP <= 0):
			mP = mP + 2*y + 1
		# Mid-point diluar parametet
		else:
			x -= 1
			mP = mP + 2*y - 2*x + 1
		
		if (x < y):
			break
		
		for i in range(startQuadran, endQuadran + 1):
			drawQuadran(i, circleCenter, x, y)

func drawQuadran(quadran : int, circleCenter : Vector2, x : int, y : int):
	match quadran:
		1:
			put_pixel(circleCenter.x + y, circleCenter.y - x, colors[0])
		2:
			put_pixel(circleCenter.x + x, circleCenter.y - y, colors[1])
		3:
			put_pixel(circleCenter.x + x, circleCenter.y + y, colors[2])
		4:
			put_pixel(circleCenter.x + y, circleCenter.y + x, colors[3])
		5:
			put_pixel(circleCenter.x - y, circleCenter.y + x, colors[4])
		6:
			put_pixel(circleCenter.x - x, circleCenter.y + y, colors[5])
		7:
			put_pixel(circleCenter.x - x, circleCenter.y - y, colors[6])
		8:
			put_pixel(circleCenter.x - y, circleCenter.y - x, colors[7])
	

func put_pixel(x, y, color):
	var point = PoolVector2Array([Vector2(x, y)])
	var colors = PoolColorArray([color])
	draw_primitive(point,colors,point)
	

func _on_Back_pressed():
	get_tree().change_scene("res://MainMenu.tscn")


func _on_Random_pressed():
	get_tree().change_scene("res://Circle.tscn")


func _on_Next_pressed():
	get_tree().change_scene("res://Smiley.tscn")
