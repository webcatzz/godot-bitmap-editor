extends EditorInspectorPlugin


func _can_handle(object: Object) -> bool:
	return object is BitMap


func _parse_begin(object: Object) -> void:
	var editor = preload("res://addons/bitmap_editor/editor.tscn").instantiate()
	editor.bitmap = object
	add_custom_control(editor)
