extends Node

func _ready():
	pass # Replace with function body.


func _on_Circles_pressed():
	get_tree().change_scene("res://RandomCircle.tscn")


func _on_Smileys_pressed():
	get_tree().change_scene("res://Smiley.tscn")


func _on_Logo_pressed():
	get_tree().change_scene("res://Logo.tscn")
