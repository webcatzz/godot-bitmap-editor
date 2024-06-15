@tool
extends PanelContainer


var bitmap: BitMap

@onready var texture: ColorRect = $VBox/Texture
@onready var x: SpinBox = $VBox/Resizer/Vector/X
@onready var y: SpinBox = $VBox/Resizer/Vector/Y


func _ready():
	x.value = bitmap.get_size().x
	y.value = bitmap.get_size().y
	x.value_changed.connect(_on_size_changed.unbind(1))
	y.value_changed.connect(_on_size_changed.unbind(1))
	
	$VBox/Shortcuts/Fill.pressed.connect(_set_all_bits.bind(true))
	$VBox/Shortcuts/Clear.pressed.connect(_set_all_bits.bind(false))


func _on_size_changed():
	bitmap.resize(Vector2i(x.value, y.value))
	texture.update_size()


func _set_all_bits(value: bool):
	bitmap.set_bit_rect(Rect2i(Vector2i.ZERO, bitmap.get_size()), value)
	texture.queue_redraw()
