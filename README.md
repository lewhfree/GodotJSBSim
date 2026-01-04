# GodotJSBSim

## Requirements

- I use Godot 4.5 because that is what comes in my package manager.
- Scons build tool
- Git
- Cmake
- Appropriate build tools for your platform
    - Make and a C/C++ compiler for *nix
    - Android NDK full install for Android (See [docs/ANDROID.md](docs/ANDROID.md))
    - Other platforms you're on your own

## Build:
```
    #Get source
    git clone --recursive https://github.com/lewhfree/GDJSBSim

    cd GDJSBSim/jsbsim

    mkdir build && cd build
    cmake ..
    make

    cd ../..
    scons

    cd project
    godot --editor
```

## Notes

To see what JSBSim::FGFDMExec methods have an equivilant, and notes for important ones (like loadmodel()), see [the methods_todo file](extension-src/methods_todo.md) </br>
I will be trying to match the GDscript api as closely to the native c++ JSBSim api as possible, but at some point, I will stop. 

The android build is working, but it is janky because jsbsim was never built to be ran on android. It wouldn't be that hard of a PR to generate, but for right now, we'll just force include headers that should exist for android (it complies with bsd sockets and stuff like that) (linux enough). Other than that, android should work great. You have to have the android export templates installed in godot to use. 

## Thanks/Licences

Thanks to [nathanfranke](https://github.com/nathanfranke) for the [gdextension](https://github.com/nathanfranke/gdextension) starter code licensed under the unlicense

Thanks to [JSBSim](https://github.com/JSBSim-Team) for the great library. They license under LGPL 2.1, which this game complies with.

This library is licensed (or unlicensed I guess) under the unlicense (see LICENSE). You can do anything with this codebase, it is public domain.
