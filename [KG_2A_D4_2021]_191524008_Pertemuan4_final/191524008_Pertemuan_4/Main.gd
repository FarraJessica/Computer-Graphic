extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	get_viewport().set_clear_mode(0)


func _on_RandomLine_pressed():
	get_tree().change_scene("res://RandomLine.tscn")


func _on_DottedLine_pressed():
	get_tree().change_scene("res://DottedLine.tscn")


func _on_Shapes_pressed():
	get_tree().change_scene("res://Shapes.tscn")
