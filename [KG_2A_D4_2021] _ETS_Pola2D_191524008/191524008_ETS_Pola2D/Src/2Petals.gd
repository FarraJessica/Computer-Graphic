extends flower

#function untuk melakukan translasi tangkai pada Vines (pola tanaman rambat)
func lineTranslation(p, dx, dy):
	p.x += dx
	p.y += dy
	return p
			
#function untuk menggambar tanaman rambat
func _draw():
	drawVines()
	lineDDA(68,0,20,700)
	for i in range(1, 9):
		var pa = lineTranslation(Vector2(xa, ya), 111*i, 0)
		var xa_translated = pa.x
		var ya_translated = pa.y
		
		var pb = lineTranslation(Vector2(xb, yb), 111*i, 0)
		var xb_translated = pb.x
		var yb_translated = pb.y
		lineDDA(xa_translated, ya_translated, xb_translated, yb_translated)
		
#function untuk melakukan animasi
func _process(delta):
	step+=5
#	size*=0.95
	update()

#function ketika button "back" diklik
func _on_Button_pressed():
	get_tree().change_scene("res://Scene/MainMenu.tscn")
