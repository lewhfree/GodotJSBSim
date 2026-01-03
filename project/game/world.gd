extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$JSBSim.SetRootDir(ProjectSettings.globalize_path("res://JSBSim_files/"))
	print($JSBSim.GetRootDir())
	$JSBSim.SetAircraftPath(ProjectSettings.globalize_path("res://JSBSim_files/aircraft/"))
	print($JSBSim.GetAircraftPath())
	$JSBSim.SetSystemsPath(ProjectSettings.globalize_path("res://JSBSim_files/systems/"))
	print($JSBSim.GetAircraftPath())
	$JSBSim.SetEnginePath(ProjectSettings.globalize_path("res://JSBSim_files/engine/"))
	print($JSBSim.GetEnginePath())
	$JSBSim.Setdt(1.0/60.0)
	print("DeltaT: ", $JSBSim.GetDeltaT())
	print("SRand: ", $JSBSim.SRand())
	print("Loaded model: ", $JSBSim.LoadModel("c172p", true))
	print("Load init file: ", $JSBSim.LoadInitFile("reset01", true))
	$JSBSim.PrintPropertyCatalog()
	print("RUNIC ", $JSBSim.RunIC())
	# for i in range(10):
	# 	print("RUNNORM ", i, ": ", $JSBSim.Run())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	# print($JSBSim.Run())
	print($JSBSim.GetPropertyValue("velocities/vc-kts"))
	
	
