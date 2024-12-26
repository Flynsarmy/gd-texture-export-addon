extends EditorContextMenuPlugin

var regex: RegEx
var texture_paths: Array[String]

func _popup_menu(paths: PackedStringArray) -> void:
	# Create a regex for texture resource filename extensions
	regex = RegEx.new()
	regex.compile(
		"\\.(%s)$" % "|".join(
			ResourceLoader.get_recognized_extensions_for_type("Texture2D")
		)
	)

	texture_paths.clear()

	# Only add the context menu item once
	var added: bool = false

	for path in paths:
		if _is_texture_resource_path(path):
			if not added:
				add_context_menu_item(
					"Export as PNG",
					_export_aas_png,
					EditorInterface.get_base_control().get_theme_icon("Image", "EditorIcons")
				)
				added = true

			texture_paths.push_back(path)

func _is_texture_resource_path(path: String) -> bool:
	# Exclude non texture extensions
	if not regex.search(path):
		return false

	# Attempt get type by cache
	var cache =  ResourceLoader.get_cached_ref(path)
	if cache is Resource:
		return cache is Texture2D

	var resource: Resource = ResourceLoader.load(path)

	return resource is Texture2D

func _export_aas_png(paths: Array[String]) -> void:
	var tex: Texture2D
	var created: Array[String] = []
	var filesystem: EditorFileSystem = EditorInterface.get_resource_filesystem()

	# This method is called with all selected resources including non-textures
	# So use our cache of only the textures selected
	for path in texture_paths:
		tex = ResourceLoader.load(path)
		var img: Image = tex.get_image()
		if not img:
			push_error("Unable to load image from resource %s, double click it in FileSystem to load it first." % path)
			continue

		var png_path: String = "%s.%s" % [path.get_basename(), 'png']

		img.clear_mipmaps()
		img.save_png(png_path)

		push_warning("PNG saved to %s" % png_path)
		created.push_back(png_path)

		# This is needed for the reimport below to work
		filesystem.update_file(png_path)

	# Reimport to show the new PNGs
	if created.size() > 0:
		filesystem.reimport_files(created)
