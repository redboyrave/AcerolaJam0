extends CanvasLayer

func _on_tab_container_tab_changed(_tab: int) -> void:
	SaveManager.save_preferences()


func _on_tree_exiting() -> void:
	SaveManager.save_preferences()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("ctrl_menu"):
		get_viewport().set_input_as_handled()
		queue_free()


func _on_button_pressed() -> void:
	queue_free()
	pass # Replace with function body.
