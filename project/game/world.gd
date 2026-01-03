extends Node

@onready var JSBSim: Node = $JSBSim
@onready var LabelNode: Label = $Label

func _ready() -> void:
	JSBSimUtils.install_jsbsim_files_to_user_dir()
	#must be setup for relative paths
	JSBSim.SetRootDir(ProjectSettings.globalize_path("user://JSBSim_files/"))
	#must be setup to load airplanes
	JSBSim.SetAircraftPath(ProjectSettings.globalize_path("user://JSBSim_files/aircraft/"))
	#ditto for systems
	JSBSim.SetSystemsPath(ProjectSettings.globalize_path("user://JSBSim_files/systems/"))
	#ditto for engines
	JSBSim.SetEnginePath(ProjectSettings.globalize_path("user://JSBSim_files/engine/"))
	#set the time step. Godot defaults to 60fps, but you can change it
	JSBSim.Setdt(1.0/120.0)
	
	#load example files. Starts the cessna 2000 ft in the air with 90 kts i think
	JSBSim.LoadModel("c172p", true)
	JSBSim.LoadInitFile("reset01", true)
	
	#Get sim setup after loaded init conditions
	JSBSim.RunIC()

func _physics_process(_delta: float) -> void:
	#keep this function as minimal as possible. It should be able to run at stable 120hz
	JSBSim.Run()

func _process(delta: float):
	#simple hud
	LabelNode.text = "Height above sea level: " + str(JSBSim.GetPropertyValue("position/h-sl-ft"))
	LabelNode.text += "\nPitch in radians: " + str(JSBSim.GetPropertyValue("attitude/theta-rad"))
	LabelNode.text += "\nCalibrated Airspeed knots: " + str(JSBSim.GetPropertyValue("velocities/vc-kts"))
	LabelNode.text += "\nPilot GForce(?): " + str(JSBSim.GetPropertyValue("accelerations/n-pilot-z-norm"))
