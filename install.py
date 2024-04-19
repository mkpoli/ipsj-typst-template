# Read package info from './typst.toml'

from pathlib import Path
import toml
import shutil
import os
import sys
import subprocess

# Read package info
with open("typst.toml", "r") as f:
    data = toml.load(f)

    package = data.get("package")
    template = data.get("template")
    if package is None:
        print("No package info found in typst.toml")
        sys.exit(1)
    if template is None:
        print("No template info found in typst.toml")
        sys.exit(1)

SRC_DIR = Path("src")
if not SRC_DIR.exists() and not SRC_DIR.is_dir():
    print("src directory not found")
    sys.exit(1)

TEMPLATE_DIR = Path("template")
if not TEMPLATE_DIR.exists():
    TEMPLATE_DIR.mkdir(parents=True, exist_ok=True)

TEMPLATE_ENTRY = template.get("entry")

# Compile the package template for local usage
with (
    open(SRC_DIR / template.get("entry", "main.typ"), "r") as fi,
    open(TEMPLATE_DIR / template.get("entry", "main.typ"), "w") as fo,
):
    main = fi.read()
    main = main.replace(
        '#import "../lib.typ":',
        f'#import "@local/{package["name"]}:{package["version"]}":',
    )
    fo.write(main)
    print(f"Successfully compiled {template.get('entry', 'main.typ')}")


# `$XDG_DATA_HOME` or `~/.local/share` on Linux
# `~/Library/Application Support` on macOS
# `%APPDATA%` on Windows

# get os
if sys.platform.startswith("linux"):
    DATA_DIR = Path(os.getenv("XDG_DATA_HOME", "~/.local/share")).expanduser()
elif sys.platform.startswith("darwin"):
    DATA_DIR = Path("~/Library/Application Support").expanduser()
elif sys.platform.startswith("win32"):
    DATA_DIR = Path(os.getenv("APPDATA", "~/AppData/Roaming")).expanduser()
else:
    raise RuntimeError("Unsupported platform")
    sys.exit(1)

target = (
    DATA_DIR / "typst" / "packages" / "local" / package["name"] / package["version"]
)

# Copy template.typ into %APPDATA%\typst\packages\local\{name}\{version}
if target.exists():
    shutil.rmtree(target)
target.mkdir(parents=True, exist_ok=True)

source = Path(".")

REQUIRED_FILES = ["lib.typ", "typst.toml", "lib", "template"]

for pattern in REQUIRED_FILES:
    for file in source.glob(pattern):
        if file.is_dir():
            shutil.copytree(file, target / file.name)
        else:
            shutil.copy(file, target / file.name)
            print(f"Successfully copied {file.name} into {target}")
