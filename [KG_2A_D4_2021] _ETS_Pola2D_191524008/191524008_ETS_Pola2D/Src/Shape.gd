extends Line

class_name shape

var window_size : Rect2
var colour : PoolColorArray

func _ready():
	window_size = get_viewport().get_visible_rect()
	colour = [Color( 0.56, 0.74, 0.56, 1 ), Color( 1, 0.75, 0.8, 1 ),
			  Color( 0.13, 0.55, 0.13, 1 ), Color( 0, 1, 0, 1 ),
			  Color( 0.68, 1, 0.18, 1 ),Color(  0.49, 0.99, 0, 1),
			  Color( 0.56, 0.93, 0.56, 1 ), Color( 0.2, 0.8, 0.2, 1 ),
			  Color( 0.24, 0.7, 0.44, 1 ), Color( 0, 0.98, 0.6, 1 ), Color( 0.6, 0.98, 0.6, 1 )]
#[0] dark sea green
#[1] pink
#[2] forest green
#[3] green
#[4] greenyellow
#[5] lawn green
#[6] light green
#[7] lime green
#[8] medium sea green
#[9] medium spring green
#[10] pale green

#function untuk membuat sisi setiap shape
func drawSide(side : PoolVector2Array, color, types):
	for j in side.size():
		lineGenerator(side[j], side[((j+1)%side.size())], color, types.thickness, types.spacing, types.dot)
		
#persegi : membutuhkan 4 sisi sama panjang
func persegi(start : Vector2, side : int, color, types : Dictionary):
	drawSide(PoolVector2Array(
		[start,
		 Vector2(start.x + side, start.y),
		 Vector2(start.x + side, start.y + side),
		 Vector2(start.x, start.y + side)]),
		 color, types)

#persegi panjang : membutuhkan 2 sisi horizontal sama panjang & 2 sisi vertikal sama panjang
func persegipanjang(start : Vector2, p : int, l : int, color, types : Dictionary):
	drawSide(PoolVector2Array(
		[start,
		 Vector2(start.x + p, start.y),
		 Vector2(start.x + p, start.y + l),
		 Vector2(start.x, start.y + l)]),
		 color, types)

#jajar genjang : memubutuhkan titik  kanan atas, titik kanan bawah, & panjang sisi
func jajargenjang(upperPoint : Vector2, lowerPoint : Vector2, p : int, color, types : Dictionary):
	drawSide(PoolVector2Array(
		[upperPoint,
		 Vector2(upperPoint.x + p, upperPoint.y),
		 Vector2(lowerPoint.x + p, lowerPoint.y),
		 Vector2(lowerPoint)]),
		 color, types)

#belah ketupat : membutuhkan titik tengah & diagonal
func belahketupat(centerPoint : Vector2, d : float, color, types : Dictionary):
	drawSide(PoolVector2Array(
		[Vector2(centerPoint.x, centerPoint.y - (d/2)),
		 Vector2(centerPoint.x + (d/2), centerPoint.y),
		 Vector2(centerPoint.x, centerPoint.y + (d/2)),
		 Vector2(centerPoint.x - (d/2), centerPoint.y)]),
		 color, types)

#function untuk melakukan rotasi belah ketupat
func rotasiBelahketupat(startPoint: Vector2, d : int, color, types):
	drawSide(PoolVector2Array(
		[startPoint,
		rotatePoint(startPoint, Vector2(startPoint.x + d, startPoint.y), 60),
		Vector2(startPoint.x + d, startPoint.y),
		 rotatePoint(startPoint, Vector2(startPoint.x + d, startPoint.y), -60)]),
		 color, types)
		
#function untuk melakukan rotasi titik	
func rotatePoint(centerPoint : Vector2, point : Vector2, angle):
	var angleRadius = deg2rad(angle)
	return Vector2(cos(angleRadius) * (point.x - centerPoint.x) - sin(angleRadius) * (point.y - centerPoint.y) + centerPoint.x,
	sin(angleRadius) * (point.x - centerPoint.x) + cos(angleRadius) * (point.y - centerPoint.y) + centerPoint.y)
	
	
#trapesium siku-siku : membutuhkan titik awal panjang bagian atas, tinggi,  & panjang bagian bawah
func trapesium(startPoint : Vector2, upLength : int, lowLength : int, t : int, color, types : Dictionary):
	drawSide(PoolVector2Array(
		[startPoint,
		 Vector2(startPoint.x + upLength, startPoint.y),
		 Vector2(startPoint.x + lowLength, startPoint.y + t),
		 Vector2(startPoint.x, startPoint.y + t)]),
		 color, types)

#segitiga siku-siku : membutuhkan titik awal (titik sudut siku siku), tinggi, & alas
func segitiga(startPoint : Vector2, a : int, t : int, color, types : Dictionary):
	drawSide(PoolVector2Array(
		[startPoint,
		 Vector2(startPoint.x + a, startPoint.y),
		 Vector2(startPoint.x, startPoint.y - t)]),
		color, types)

#segitiga sama sisi : membutuhkan 3 sisi sama panjang
func segitigaSamasisi(startPoint: Vector2, side : int, color, types):
	drawSide(PoolVector2Array(
		[startPoint,
		 Vector2(startPoint.x + side, startPoint.y),
		 rotatePoint(startPoint, Vector2(startPoint.x + side, startPoint.y), -60)]),
		 color, types)	
		
#lingkaran : menggunakan midpoint
func circleMidpoint(center : Vector2, radius : int, color):
	var x = radius
	var y = 0
	
	circlePoints(center, x, y, color)
	
	var mP = 1 - radius
	while (x >= y):
		y += 1
		if (mP <= 0):
			mP = mP + 2*y + 1
		else:
			x -= 1
			mP = mP + 2*y - 2*x + 1
		
		if (x < y):
			break
			
		circlePoints(center, x, y, color)
		
#cuntion untuk mengatur titik-titik pada lingkaran	
func circlePoints(centerPoint : Vector2, x : int, y : int, color):
	put_pixel(centerPoint.x + x, centerPoint.y + y, color)
	put_pixel(centerPoint.x - x, centerPoint.y + y, color)
	put_pixel(centerPoint.x + x, centerPoint.y - y, color)
	put_pixel(centerPoint.x - x, centerPoint.y - y, color)	
	put_pixel(centerPoint.x + y, centerPoint.y + x, color)
	put_pixel(centerPoint.x - y, centerPoint.y + x, color)
	put_pixel(centerPoint.x + y, centerPoint.y - x, color)
	put_pixel(centerPoint.x - y, centerPoint.y - x, color)
	
#function untuk mengatur pixel
func put_pixel(x, y, color):
	draw_primitive(PoolVector2Array([Vector2(x, y)]),
			PoolColorArray([color]),
			PoolVector2Array())
