import os
import subprocess


if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(description="Process some integers.")
    parser.add_argument("command")
    parser.add_argument("--type")
    args = parser.parse_args()

    for f in os.listdir():
        if args.type and not f.endswith(args.type):
            continue
        cmd = args.command.split()
        cmd = [e.replace("%s", f) for e in cmd]
        result = subprocess.check_output(cmd)
        print(result.decode())
