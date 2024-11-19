extends Node

# 画面のロード
var title_scene: PackedScene = preload("res://scene/title/title_scene.tscn")
var clear_scene: PackedScene = preload("res://scene/clear/clear_scene.tscn")

# Titleシーンに切り替え
func load_title_scene() -> void:
	get_tree().change_scene_to_packed(title_scene)

# Mainシーンに切り替え
func load_clear_scene() -> void:
	get_tree().change_scene_to_packed(clear_scene)
