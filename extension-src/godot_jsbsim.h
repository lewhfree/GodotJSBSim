#ifndef GODOT_JSBSIM_H
#define GODOT_JSBSIM_H

#include <godot_cpp/classes/node.hpp>
#include <FGFDMExec.h>
// #include <simgear/misc/sg_path.hxx>
namespace JSBSim {
    class FGFDMExec;
}

namespace godot {

class GodotJSBSim : public Node {
    GDCLASS(GodotJSBSim, Node)

protected:
    JSBSim::FGFDMExec* fdmex;
    // SGPath globalRootDir;
    static void _bind_methods();

public:
    GodotJSBSim();
    ~GodotJSBSim();

    void _ready() override;
    void _physics_process(double delta) override;

    void SetRootDir(const String &dir);
    String GetRootDir(void);
};

}

#endif // GODOT_JSBSIM_H
