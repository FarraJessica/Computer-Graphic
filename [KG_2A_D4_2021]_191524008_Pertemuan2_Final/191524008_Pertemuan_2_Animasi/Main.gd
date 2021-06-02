extends Node


func _ready():
	pass # Replace with function body.
	
	get_viewport().set_clear_mode(0)

func _on_Cubic_pressed():
	get_tree().change_scene("res://Cubic.tscn")

func _on_Quadratic_pressed():
	get_tree().change_scene("res://Quadratic.tscn")

func _on_Sinus_pressed():
	get_tree().change_scene("res://Sinus.tscn")

func _on_Cosinus_pressed():
	get_tree().change_scene("res://Sinus.tscn")


