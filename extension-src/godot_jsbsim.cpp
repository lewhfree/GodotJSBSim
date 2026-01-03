#include "godot_jsbsim.h"
#include <godot_cpp/variant/utility_functions.hpp>

#include <FGFDMExec.h>
#include <simgear/misc/sg_path.hxx>
#include <initialization/FGInitialCondition.h>


using namespace godot;

GodotJSBSim::GodotJSBSim() {
    // Constructor
}

GodotJSBSim::~GodotJSBSim() {
    // Destructor
}

void GodotJSBSim::_bind_methods() {
    ClassDB::bind_method(D_METHOD("SetRootDir", "rootDir"), &GodotJSBSim::SetRootDir);
    ClassDB::bind_method(D_METHOD("GetRootDir"), &GodotJSBSim::GetRootDir);
    ClassDB::bind_method(D_METHOD("GetDeltaT"), &GodotJSBSim::GetDeltaT);
    ClassDB::bind_method(D_METHOD("Setdt", "delta_t"), &GodotJSBSim::Setdt);
    ClassDB::bind_method(D_METHOD("SetAircraftPath", "path"), &GodotJSBSim::SetAircraftPath);
    ClassDB::bind_method(D_METHOD("GetAircraftPath"), &GodotJSBSim::GetAircraftPath);
    ClassDB::bind_method(D_METHOD("SetSystemsPath", "path"), &GodotJSBSim::SetSystemsPath);
    ClassDB::bind_method(D_METHOD("GetSystemsPath"), &GodotJSBSim::GetSystemsPath);
    ClassDB::bind_method(D_METHOD("SetEnginePath", "path"), &GodotJSBSim::SetEnginePath);
    ClassDB::bind_method(D_METHOD("GetEnginePath"), &GodotJSBSim::GetEnginePath);
    ClassDB::bind_method(D_METHOD("SRand"), &GodotJSBSim::SRand);
    ClassDB::bind_method(D_METHOD("LoadModel", "model", "addModelToPath"), &GodotJSBSim::LoadModel);
    ClassDB::bind_method(D_METHOD("LoadInitFile", "path", "isRelativeToAircraft"), &GodotJSBSim::LoadInitFile);
    ClassDB::bind_method(D_METHOD("RunIC"), &GodotJSBSim::RunIC);
    ClassDB::bind_method(D_METHOD("Run"), &GodotJSBSim::Run);
    ClassDB::bind_method(D_METHOD("GetPropertyValue", "property"), &GodotJSBSim::GetPropertyValue);
    ClassDB::bind_method(D_METHOD("PrintPropertyCatalog"), &GodotJSBSim::PrintPropertyCatalog);
}

void GodotJSBSim::_ready() {
    fdmex = new JSBSim::FGFDMExec();
    fdmex->SetDebugLevel(0);
}

void GodotJSBSim::_physics_process(double delta) {

}

void GodotJSBSim::SetRootDir(const String &dir) {
    fdmex->SetRootDir(SGPath(dir.utf8().get_data()));
}

String GodotJSBSim::GetRootDir(void) {
    const SGPath tmp = fdmex->GetRootDir();
    return String(tmp.c_str());
}

double GodotJSBSim::GetDeltaT(void) {
    return fdmex->GetDeltaT();
}

void GodotJSBSim::Setdt(double delta_t) {
    fdmex->Setdt(delta_t);
}

bool GodotJSBSim::SetAircraftPath(const String &path) {
    return fdmex->SetAircraftPath(SGPath(path.utf8().get_data()));
}

String GodotJSBSim::GetAircraftPath(void) {
    const SGPath tmp = fdmex->GetAircraftPath();
    return String(tmp.c_str());
}

bool GodotJSBSim::SetSystemsPath(const String &path) {
    return fdmex->SetSystemsPath(SGPath(path.utf8().get_data()));
}

String GodotJSBSim::GetSystemsPath(void) {
    const SGPath tmp = fdmex->GetSystemsPath();
    return String(tmp.c_str());
}

bool GodotJSBSim::SetEnginePath(const String &path) {
    return fdmex->SetEnginePath(SGPath(path.utf8().get_data()));
}

String GodotJSBSim::GetEnginePath(void) {
    const SGPath tmp = fdmex->GetEnginePath();
    return String(tmp.c_str());
}

int GodotJSBSim::SRand(void) {
    return fdmex->SRand();
}

bool GodotJSBSim::LoadModel(const String &model, bool addModelToPath){
    const std::string model_real = std::string(model.utf8().get_data());
    return fdmex->LoadModel(model_real, addModelToPath);
}

bool GodotJSBSim::LoadInitFile(const String &path, bool isRelativeToAircraftPath) {
    bool tmp = fdmex->GetIC()->Load(SGPath(path.utf8().get_data()), isRelativeToAircraftPath);
    return tmp;
}

bool GodotJSBSim::RunIC(void) {
    return fdmex->RunIC();
}

bool GodotJSBSim::Run(void) {
    return fdmex->Run();
}

double GodotJSBSim::GetPropertyValue(const String &property){
    return fdmex->GetPropertyValue(std::string(property.utf8().get_data()));
}

void GodotJSBSim::PrintPropertyCatalog(void){
    fdmex->PrintPropertyCatalog();
}
