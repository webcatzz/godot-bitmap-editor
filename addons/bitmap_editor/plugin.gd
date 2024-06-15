@tool
extends EditorPlugin


var plugin


func _enter_tree() -> void:
	plugin = preload("res://addons/bitmap_editor/inspector_plugin.gd").new()
	add_inspector_plugin(plugin)


func _exit_tree() -> void:
	remove_inspector_plugin(plugin)
