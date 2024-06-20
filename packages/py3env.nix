{ writers, ... }:

writers.writePython3Bin "py3env" { libraries = [ ]; } ''
  import sys
  import os

  args = sys.argv[1:]
  shell_args = [f"python3Packages.{arg}" for arg in args]

  cmd = "nix-shell --run ipython3 -p python3Packages.ipython " + " ".join(shell_args)  # noqa: E501

  print(f"Running: {cmd}")
  os.system(cmd)
''
