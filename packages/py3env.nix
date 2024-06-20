{ writers, ... }:

writers.writePython3Bin "py3env" { libraries = [ ]; } ''
  import sys
  import os

  if len(sys.argv) == 1:
      raise RuntimeError("at least 1 package is required")

  args = sys.argv[1:]
  shell_args = [f"python3Packages.{arg}" for arg in args]

  cmd = "nix-shell --run ipython3 -p python3Packages.ipython " + " ".join(shell_args)  # noqa: E501

  print(f"Running: {cmd}")
  os.system(cmd)
''
