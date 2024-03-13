extends CanvasLayer


@onready var button: Button = $Panel/Button

func _ready() -> void:
	button.grab_focus()

func _on_button_pressed() -> void:
	queue_free()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		button.pressed.emit()
