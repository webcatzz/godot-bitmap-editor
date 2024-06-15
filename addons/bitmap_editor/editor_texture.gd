@tool
extends ColorRect


var bitmap: BitMap

var pixel_size: float
var mouse_at: Vector2i
var pressed: bool = false


func _ready() -> void:
	bitmap = owner.bitmap
	update_size.call_deferred()


func update_size() -> void:
	pixel_size = get_parent().size.x / float(bitmap.get_size().x)
	custom_minimum_size = Vector2(bitmap.get_size()) * pixel_size
	queue_redraw()


func _draw() -> void:
	for x: int in bitmap.get_size().x:
		for y: int in bitmap.get_size().y:
			if bitmap.get_bit(x, y):
				draw_rect(Rect2(
					Vector2(x, y) * pixel_size,
					Vector2(pixel_size, pixel_size)
				), Color.WHITE)
	
	draw_rect(Rect2(
		mouse_at * pixel_size,
		Vector2(pixel_size, pixel_size)
	), Color("#80808040"))


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_at = event.position / pixel_size
		if pressed:
			_set_bit_under_mouse(event)
		queue_redraw()
	
	elif event is InputEventMouseButton:
		pressed = event.pressed
		if pressed:
			_set_bit_under_mouse(event)
			queue_redraw()


func _set_bit_under_mouse(event: InputEventMouse) -> void:
	bitmap.set_bitv(mouse_at, event.button_mask == MOUSE_BUTTON_LEFT)
