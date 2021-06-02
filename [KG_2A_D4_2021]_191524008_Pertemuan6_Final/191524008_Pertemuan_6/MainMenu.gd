extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_Batik_pressed():
	get_tree().change_scene("res://Batik.tscn")


func _on_Segitiga_pressed():
	get_tree().change_scene("res://RandomTriangle.tscn")


func _on_Belah_ketupat_pressed():
	get_tree().change_scene("res://RandomRhombus.tscn")


func _on_Elips_pressed():
	get_tree().change_scene("res://RandomEllipse.tscn")


func _on_Bunga_4_Kelopak_pressed():
	get_tree().change_scene("res://4 Petals Flower.tscn")


func _on_Bunga_8_Kelopak_pressed():
	get_tree().change_scene("res://8 Petals Flower.tscn")


func _on_Family_Crest_pressed():
	get_tree().change_scene("res://Family Crest.tscn")
