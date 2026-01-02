#ifndef GODOT_JSBSIM_H
#define GODOT_JSBSIM_H

#include <godot_cpp/classes/node.hpp>

namespace godot {

class GodotJSBSim : public Node {
    GDCLASS(GodotJSBSim, Node)

protected:
    static void _bind_methods();

public:
    GodotJSBSim();
    ~GodotJSBSim();

    // Virtual function overrides
    void _ready() override;
    void _physics_process(double delta) override;
    bool load_model();
};

}

#endif // GODOT_JSBSIM_H
