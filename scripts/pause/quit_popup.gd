extends Popup

@onready var no: Button = $Panel/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/No

func _ready() -> void:
	no.grab_focus()

func _on_yes_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_no_pressed() -> void:
	queue_free()
	pass # Replace with function body.
