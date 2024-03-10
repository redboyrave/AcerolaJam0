extends CanvasLayer

func _on_tab_container_tab_changed(_tab: int) -> void:
	SaveManager.save_preferences()


func _on_tree_exiting() -> void:
	SaveManager.save_preferences()
