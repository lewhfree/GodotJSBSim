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

    double GetDeltaT(void);
    void Setdt(double delta_t);

    bool SetAircraftPath(const String &path);
    String GetAircraftPath(void);

    bool SetSystemsPath(const String &path);
    String GetSystemsPath(void);

    bool SetEnginePath(const String &path);
    String GetEnginePath(void);

    int SRand(void);

    bool LoadModel(const String &model, bool addModelToPath);

    bool LoadInitFile(const String &path, bool isRelativeToAircraftPath);

    bool RunIC(void);
    bool Run(void);

    double GetPropertyValue(const String &property);
    void PrintPropertyCatalog(void);
    };
}
#endif // GODOT_JSBSIM_H
