extends Circle

var random_Generator = RandomNumberGenerator.new()
var window_size : Rect2
var maximumX
var maximumY

func _ready():
	window_size = get_viewport().get_visible_rect()
	maximumX = window_size.end.x
	maximumY = window_size.end.y
	random_Generator.randomize()

func random_smiley():
	var circleCenter : Vector2
	var radius = random_Generator.randi_range(30,100)
	circleCenter.x = random_Generator.randi_range(0,maximumX)
	circleCenter.y = random_Generator.randi_range(0,maximumY)
	smiley(circleCenter, radius)

func smiley(center : Vector2, radius : int):
	# draw face
	midpointCircle(center, radius)
	# draw left eye
	midpointCircle(Vector2(center.x + radius/3, center.y - radius/2), radius/4) 
	# draw right eye
	midpointCircle(Vector2(center.x - radius/3, center.y - radius/2), radius/4)
	# draw nose
	lineGenerator(Vector2(center.x - radius/50, center.y - radius/2), Vector2(center.x - radius/50, center.y), colors[9], radius/20, radius/30)
	# draw smile
	lineGenerator(Vector2(center.x - radius/2, center.y + radius/2), Vector2(center.x + radius/2, center.y + radius/2), colors[10], 1, radius/40)
	draw_half_midpointCircle(center, radius - radius/3.5, 4, 5)
	
func _draw():
	var totalCircle = random_Generator.randi_range(1,10)
	for i in range (totalCircle):
		random_smiley()
		
func _on_Back_pressed():
	get_tree().change_scene("res://MainMenu.tscn")

func _on_Logo_pressed():
	get_tree().change_scene("res://Logo.tscn")

func _on_Random_pressed():
	get_tree().change_scene("res://Smiley.tscn")
