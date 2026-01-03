extends Node
class_name JSBSimUtils

static func install_jsbsim_files_to_user_dir():
	var source_root = "res://JSBSim_files"
	var dest_root = "user://JSBSim_files"
	
	if not DirAccess.dir_exists_absolute(dest_root):
		DirAccess.make_dir_absolute(dest_root)
	
	_recursive_copy(source_root, dest_root)
	print("JSBSim files copied to: " + ProjectSettings.globalize_path(dest_root))

static func _recursive_copy(src_dir: String, dest_dir: String):
	var dir = DirAccess.open(src_dir)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name == "." or file_name == "..":
				file_name = dir.get_next()
				continue
			
			var src_path = src_dir + "/" + file_name
			var dest_path = dest_dir + "/" + file_name
			
			if dir.current_is_dir():
				if not DirAccess.dir_exists_absolute(dest_path):
					DirAccess.make_dir_absolute(dest_path)
				_recursive_copy(src_path, dest_path)
			else:
				if not FileAccess.file_exists(dest_path):
					var file = FileAccess.open(src_path, FileAccess.READ)
					var content = file.get_buffer(file.get_length())
					var dest_file = FileAccess.open(dest_path, FileAccess.WRITE)
					dest_file.store_buffer(content)
			
			file_name = dir.get_next()
	else:
		print("Failed to open source directory: " + src_dir)
