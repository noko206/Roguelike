extends Node
@export_file("res://scene/game/game_scene.tscn") var scene_path: String

# 画面のロード
var title_scene: PackedScene = preload("res://scene/title/title_scene.tscn")
var clear_scene: PackedScene = preload("res://scene/clear/clear_scene.tscn")
var game_scene: PackedScene = preload("res://scene/game/game_scene.tscn")

# Titleシーンに切り替え
func load_title_scene() -> void:
	get_tree().change_scene_to_packed(title_scene)

# Gameシーンに切り替え
func load_game_scene() -> void:
	get_tree().change_scene_to_packed(game_scene)

# Clearシーンに切り替え
func load_clear_scene() -> void:
	get_tree().change_scene_to_packed(clear_scene)
