extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$JSBSim.SetRootDir(ProjectSettings.globalize_path("res://JSBSim_files/"))
	print($JSBSim.GetRootDir())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
