extends Node

@onready var JSBSim: Node = $JSBSim
@onready var LabelNode: Label = $Label

func _ready() -> void:
	JSBSim.SetRootDir(ProjectSettings.globalize_path("res://JSBSim_files/"))
	print(JSBSim.GetRootDir())
	JSBSim.SetAircraftPath(ProjectSettings.globalize_path("res://JSBSim_files/aircraft/"))
	print(JSBSim.GetAircraftPath())
	JSBSim.SetSystemsPath(ProjectSettings.globalize_path("res://JSBSim_files/systems/"))
	print(JSBSim.GetAircraftPath())
	JSBSim.SetEnginePath(ProjectSettings.globalize_path("res://JSBSim_files/engine/"))
	print(JSBSim.GetEnginePath())
	JSBSim.Setdt(1.0/120.0)
	print("DeltaT: ", JSBSim.GetDeltaT())
	print("SRand: ", JSBSim.SRand())
	print("Loaded model: ", JSBSim.LoadModel("c172p", true))
	print("Load init file: ", JSBSim.LoadInitFile("reset01", true))
	JSBSim.PrintPropertyCatalog()
	print("RUNIC ", JSBSim.RunIC())

func _physics_process(_delta: float) -> void:
	JSBSim.Run()

func _process(delta: float):
	LabelNode.text = "Height above sea level: " + str(JSBSim.GetPropertyValue("position/h-sl-ft"))
	LabelNode.text += "\nPitch in radians: " + str(JSBSim.GetPropertyValue("attitude/theta-rad"))
	LabelNode.text += "\nCalibrated Airspeed knots: " + str(JSBSim.GetPropertyValue("velocities/vc-kts"))
	LabelNode.text += "\nPilot GForce(?): " + str(JSBSim.GetPropertyValue("accelerations/n-pilot-z-norm"))
