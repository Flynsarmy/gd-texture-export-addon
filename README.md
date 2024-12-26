# Texture Export Addon for Godot

One-click exporting of Texture resources to PNG files.

https://github.com/user-attachments/assets/b300b896-2665-499f-abfe-4506746dfdd3

## Usage

* Extract to `addons/texture_export`
* Enable *Project Settings - Plugins - Texture Export*
* Right click one or more resources that inherit from `Texture2D` in the FileSystem and click *Export as PNG*
* PNGs will be created beside the resources with the same file name but PNG extension.

## Notes

* Only works on resources in the FileSystem at time of writing due to limitations in Godot's API
* You may need to double click the resource in FileSystem first before export will work. Attempting to export a resource that hasn't been loaded by Godot before will result in a failed export and a warning will display in console.

## Requirements

* Requires Godot 4.4+
