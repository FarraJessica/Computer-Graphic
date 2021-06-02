extends Node

func _ready():
	pass 

func _on_Play_pressed():
	get_tree().change_scene("res://Scene/AnimationPattern.tscn")
