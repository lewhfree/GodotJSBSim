#!/usr/bin/env python
import os
from glob import glob
from pathlib import Path

env = SConscript("godot-cpp/SConstruct")

platform = env["platform"]
arch = env["arch"]        
debug_or_release = "release" if env["target"] == "template_release" else "debug"

ROOT = os.getcwd()
JSBSIM_ROOT = os.path.join(ROOT, "jsbsim")
JSBSIM_BUILD = os.path.join(JSBSIM_ROOT, "build", "src")
JSBSIM_LIB = ""

if platform == "linux":
    JSBSIM_LIB = os.path.join(JSBSIM_BUILD, "libJSBSim.so.1")
elif platform == "android":
    JSBSIM_LIB = os.path.join(JSBSIM_BUILD, "libJSBSim.so")

EXT_SRC = os.path.join(ROOT, "extension-src")
EXTENSION_PATH = glob("project/addons/*/*.gdextension")[0]
ADDON_PATH = Path(EXTENSION_PATH).parent
PROJECT_NAME = Path(EXTENSION_PATH).stem

RES_LIBS = os.path.join(ROOT, "project", "addons", "JSBSim", "bin")
ANDROID_LIBS = RES_LIBS

sources = glob(os.path.join(EXT_SRC, "*.cpp"))
env.Append(CPPPATH=[EXT_SRC, os.path.join(JSBSIM_ROOT, "src")])
env.Append(LIBPATH=[JSBSIM_BUILD])
env.Append(LIBS=["JSBSim"])

if platform == "linux":
    env.Append(LINKFLAGS=["-Wl,-rpath,'$$ORIGIN'"])
elif platform == "android":
    pass

glue_output = os.path.join(
    RES_LIBS if platform == "linux" else ANDROID_LIBS,
    f"lib{PROJECT_NAME}.{platform}.{debug_or_release}.{arch}{env['SHLIBSUFFIX']}"
)

library = env.SharedLibrary(glue_output, source=sources)

jsbsim_destination = RES_LIBS if platform == "linux" else ANDROID_LIBS
copied_jsbsim = env.Install(jsbsim_destination, JSBSIM_LIB)

JSBSIM_DATA_DIRS = ["aircraft", "engine", "systems", "scripts"]
JSBSIM_DEST = os.path.join(ROOT, "project", "JSBSim_files")
install_targets = []

for src_dir in JSBSIM_DATA_DIRS:
    src_path = os.path.join(JSBSIM_ROOT, src_dir)
    tgt = env.Install(JSBSIM_DEST, src_path)
    install_targets.extend(tgt)

Default([library, copied_jsbsim] + install_targets)
