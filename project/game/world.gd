extends Node

@onready var JSBSim: Node = $JSBSim
@onready var LabelNode: Label = $Label
@onready var Airplane: Node3D = $Airplane
@onready var fps: Label = $fps
@onready var fps2: Label = $fps2

func _ready() -> void:
	PhysicsServer3D.set_active(false)
	PhysicsServer2D.set_active(false)
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
	JSBSim.LoadInitFile("reset00", true)
	
	#Get sim setup after loaded init conditions
	JSBSim.RunIC()
	JSBSim.SetPropertyValue("fcs/throttle-cmd-norm", 1.0)
	JSBSim.SetPropertyValue("fcs/mixture-cmd-norm", 1.0)
	JSBSim.SetPropertyValue("propulsion/magneto_cmd", 3)
	JSBSim.SetPropertyValue("propulsion/starter_cmd", 1)

func _physics_process(_delta: float) -> void:
	fps2.text = "physics FPS: " + str(1.0 / _delta)
	JSBSim.Run()

func _process(_delta: float):
	var lat = JSBSim.GetPropertyValue("position/lat-geod-rad")
	var long = JSBSim.GetPropertyValue("position/long-gc-rad")
	var alt = JSBSim.GetPropertyValue("position/geod-alt-ft") * 0.3048
	
	var rot = Airplane.rotation
	rot = Vector3(JSBSim.GetPropertyValue("attitude/pitch-rad"), -1 * JSBSim.GetPropertyValue("attitude/heading-true-rad"), JSBSim.GetPropertyValue("attitude/roll-rad"))
	Airplane.rotation = rot
	
	var pos = Vector3((long - 2.12930168703915) * 4337000, alt, (lat - 0.82365420189374) * -6378137)
	Airplane.position = pos
	
	fps.text = "FPS: " + str(1.0 / _delta)
	
	LabelNode.text = "Lat (rad): " + str(JSBSim.GetPropertyValue("position/lat-geod-rad"))
	LabelNode.text += "\n"
	LabelNode.text += "Long (rad): " + str(JSBSim.GetPropertyValue("position/long-gc-rad"))
	LabelNode.text += "\nHeight above sea level (m): " + str(JSBSim.GetPropertyValue("position/h-sl-ft") * 0.3048)
	LabelNode.text += "\nPitch in deg " + str(57.2958 * JSBSim.GetPropertyValue("attitude/pitch-rad"))
	LabelNode.text += "\nCalibrated Airspeed knots: " + str(JSBSim.GetPropertyValue("velocities/vc-kts"))
	LabelNode.text += "\nPilot GForce(?): " + str(JSBSim.GetPropertyValue("accelerations/n-pilot-z-norm"))
