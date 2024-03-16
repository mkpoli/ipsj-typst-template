# Read package info from './typst.toml'

from pathlib import Path
import toml
import shutil
import os
import sys
import subprocess

# Read package info
with open("typst.toml", "r") as f:
    package = toml.load(f).get("package")
    if package is None:
        print("No package info found in typst.toml")
        sys.exit(1)

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

REQUIRED_FILES = ["template.typ", "typst.toml", "lib"]

for pattern in REQUIRED_FILES:
    print(pattern)
    for file in source.glob(pattern):
        if file.is_dir():
            shutil.copytree(file, target / file.name)
        else:
            shutil.copy(file, target / file.name)
            print(f"Successfully copied {file.name} into {target}")
