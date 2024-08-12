@tool
extends PanelContainer


var bitmap: BitMap

@onready var texture: ColorRect = $VBox/Texture
@onready var x: SpinBox = $VBox/Resizer/X
@onready var y: SpinBox = $VBox/Resizer/Y


func _ready():
	_remove_built_in_preview.call_deferred()
	x.set_value_no_signal(bitmap.get_size().x)
	y.set_value_no_signal(bitmap.get_size().y)


func _on_size_changed():
	bitmap.resize(Vector2i(x.value, y.value))
	texture.update_size()


func _set_all_bits(value: bool):
	bitmap.set_bit_rect(Rect2i(Vector2i.ZERO, bitmap.get_size()), value)
	texture.queue_redraw()


func _remove_built_in_preview() -> void:
	get_parent().get_child(get_index() + 1).queue_free()
