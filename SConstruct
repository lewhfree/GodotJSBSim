#!/usr/bin/env python
import os
from glob import glob
from pathlib import Path

env = SConscript("godot-cpp/SConstruct")

# Add source files.
env.Append(CPPPATH=["extension-src/"])
sources = Glob("extension-src/*.cpp")

jsbsim_root = "jsbsim"
jsbsim_build_dir = "jsbsim/build/src"

env.Append(CPPPATH=[os.path.join(jsbsim_root, "src")])

env.Append(LIBPATH=[jsbsim_build_dir])
env.Append(LIBS=["JSBSim"])

env.Append(LINKFLAGS=["-Wl,-rpath,'$$ORIGIN'"])

(extension_path,) = glob("project/addons/*/*.gdextension")

addon_path = Path(extension_path).parent

project_name = Path(extension_path).stem

scons_cache_path = os.environ.get("SCONS_CACHE")
if scons_cache_path != None:
    CacheDir(scons_cache_path)
    print("Scons cache enabled... (path: '" + scons_cache_path + "')")

# Create the library target (e.g. libexample.linux.debug.x86_64.so).
debug_or_release = "release" if env["target"] == "template_release" else "debug"
if env["platform"] == "macos":
    library = env.SharedLibrary(
        "{0}/bin/lib{1}.{2}.{3}.framework/{1}.{2}.{3}".format(
            addon_path,
            project_name,
            env["platform"],
            debug_or_release,
        ),
        source=sources,
    )
else:
    library = env.SharedLibrary(
        "{}/bin/lib{}.{}.{}.{}{}".format(
            addon_path,
            project_name,
            env["platform"],
            debug_or_release,
            env["arch"],
            env["SHLIBSUFFIX"],
        ),
        source=sources,
    )

jsbsim_source = os.path.join(jsbsim_build_dir, "libJSBSim.so.1")

jsbsim_destination = os.path.join(str(addon_path), "bin")

copied_jsbsim = env.Install(jsbsim_destination, jsbsim_source)

Default(copied_jsbsim)

Default(library)
