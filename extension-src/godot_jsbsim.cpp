#include "godot_jsbsim.h"
#include <godot_cpp/variant/utility_functions.hpp>

using namespace godot;

GodotJSBSim::GodotJSBSim() {
    // Constructor
}

GodotJSBSim::~GodotJSBSim() {
    // Destructor
}

void GodotJSBSim::_bind_methods() {
    // No methods to bind yet, but this function is required by GDCLASS
    ClassDB::bind_method(D_METHOD("load_model"), &GodotJSBSim::load_model);
}

void GodotJSBSim::_ready() {
    UtilityFunctions::print("ready");
}

void GodotJSBSim::_physics_process(double delta) {
    // Note: This will spam the console 60 times a second!
    UtilityFunctions::print("physics");
}

bool GodotJSBSim::load_model() {
    return true;
}
