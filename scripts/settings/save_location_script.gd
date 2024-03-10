extends HBoxContainer

@onready var line_edit: LineEdit = $LineEdit
@onready var button: Button = $Button
@onready var file_dialog: FileDialog = $FileDialog
@onready var folder_error: Label = $"../FolderError"

@onready var user_global_path:String = ProjectSettings.globalize_path(SaveManager.preferences.save_location)

func _ready() -> void:
	line_edit.text = user_global_path
	folder_error.hide()


func _on_line_edit_text_submitted(new_text: String) -> void:
	if new_text == "":
		SaveManager.preferences.save_location = "user://"
		line_edit.text = user_global_path
		folder_error.hide()
		return
	if !DirAccess.dir_exists_absolute(new_text):
		folder_error.show()
		line_edit.text = ProjectSettings.globalize_path(SaveManager.preferences.save_location)
		return
	folder_error.hide()
	SaveManager.preferences.save_location = new_text
	pass # Replace with function body.


func _on_button_pressed() -> void:
	file_dialog.show()



func _on_file_dialog_dir_selected(dir: String) -> void:
	if !DirAccess.dir_exists_absolute(dir):
		folder_error.show()
		return
	folder_error.hide()
	line_edit.text = dir
	SaveManager.preferences.save_location = dir

