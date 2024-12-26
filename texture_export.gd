@tool
extends EditorPlugin

const NoiseExportPlugin = preload("texture_export_plugin.gd")
var inspector_plugin: EditorContextMenuPlugin = NoiseExportPlugin.new()


func _enter_tree() -> void:
	add_context_menu_plugin(
		EditorContextMenuPlugin.ContextMenuSlot.CONTEXT_SLOT_FILESYSTEM,
		inspector_plugin
	)


func _exit_tree() -> void:
	remove_context_menu_plugin(inspector_plugin)
