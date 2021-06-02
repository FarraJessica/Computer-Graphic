extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#draw a circle smiley face
func draw_circle_arc(color):
	var nb_points = 100
	var radius = 100
	var center = Vector2(200, 200)
	var colors = PoolColorArray([color["bisque"]])
	var points_arc = PoolVector2Array()

	for i in range(nb_points + 1):
		var angle_point = i * PI * 2.0/nb_points
		points_arc.push_back(center+Vector2(cos(angle_point), sin(angle_point)) * radius)

	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color["bisque"])
		draw_polygon(points_arc,colors)
	

# draw a left eye on smiley
func draw_left_eye(color):
	var nb_points = 100
	var radius = 10
	var center = Vector2(155, 170)
	var colors = PoolColorArray([color["chocolate"]])
	var points_arc = PoolVector2Array()

	for i in range(nb_points + 1):
		var angle_point = i * PI * 2.0/nb_points
		points_arc.push_back(center+Vector2(cos(angle_point), sin(angle_point)) * radius)

	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color["chocolate"])
		draw_polygon(points_arc,colors)
		
# draw a right eye on smiley
func draw_right_eye(color):
	var nb_points = 100
	var radius = 10
	var center = Vector2(255, 170)
	var colors = PoolColorArray([color["chocolate"]])
	var points_arc = PoolVector2Array()

	for i in range(nb_points + 1):
		var angle_point = i * PI * 2.0/nb_points
		points_arc.push_back(center+Vector2(cos(angle_point), sin(angle_point)) * radius)

	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color["chocolate"])
		draw_polygon(points_arc,colors)

# draw a smile mouth on smiley
func draw_smile(color):
	var center = Vector2(200,200)
	var radius = 50
	var nb_points = 32
	var points_arc = PoolVector2Array()
	var angle_from = 150
	var angle_to = 260

	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i*(angle_to-angle_from)/nb_points) - 90
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color["chocolate"])		


# draw put pixel
func put_pixel(x, y, color):
	var points = PoolVector2Array()
	var colors = PoolColorArray()
	points.append(Vector2(x,y))
	colors.append(color)
	draw_primitive(points,colors,points)


# draw a frame
func draw_frame():
	var windowSize : Rect2 = get_viewport().get_visible_rect()
	var left = windowSize.position.x + 50
	var top = windowSize.position.y + 50
	var right = windowSize.end.x - 675
	var bottom = windowSize.end.y - 250
	var color = Color(0.96, 0.96, 0.86, 1)
	
	# top frame
	for i in range(left,right):
		put_pixel(i,top,color)
	# bottom frame
	for i in range(left,right):
		put_pixel(i,bottom,color)
	# left frame
	for i in range(top,bottom):
		put_pixel(left,i,color)
	# right frame
	for i in range(top,bottom):
		put_pixel(right,i,color)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _draw():
	var color = {"chocolate":Color(0.82, 0.41, 0.12, 1), "bisque" : Color( 1, 0.89, 0.77, 1 ), "beige" : Color (0.96, 0.96, 0.86, 1)}
	draw_circle_arc(color)
	draw_right_eye(color)
	draw_left_eye(color)
	draw_smile(color)
	#put_pixel(200,200,color["chocolate"])
	draw_frame()


