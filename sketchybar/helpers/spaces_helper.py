#!/usr/bin/env python3
import json
import os
import subprocess
import sys

CACHE_DIR = os.path.expanduser("~/.config/sketchybar/app-icons")
WORKSPACE_COUNT = 9


def find_app_path(bundle_id):
    try:
        r = subprocess.run(
            ["mdfind", f"kMDItemCFBundleIdentifier == '{bundle_id}'"],
            capture_output=True, text=True, timeout=5
        )
        for p in r.stdout.strip().split("\n"):
            p = p.strip()
            if p.endswith(".app") and os.path.isdir(p):
                return p
    except:
        pass
    return None


def extract_icon(app_name, bundle_id):
    os.makedirs(CACHE_DIR, exist_ok=True)
    cache = os.path.join(CACHE_DIR, f"{app_name}.png")
    if os.path.exists(cache):
        return cache

    app_path = find_app_path(bundle_id)
    if not app_path:
        return None

    try:
        r = subprocess.run(
            ["find", os.path.join(app_path, "Contents", "Resources"),
             "-name", "*.icns", "-maxdepth", "1"],
            capture_output=True, text=True, timeout=5
        )
        icns = [f.strip() for f in r.stdout.strip().split("\n") if f.strip()]
        if not icns:
            return None

        subprocess.run(
            ["sips", "-s", "format", "png", icns[0], "--out", cache,
             "--resampleWidth", "32"],
            capture_output=True, timeout=30
        )
        return cache if os.path.exists(cache) else None
    except:
        return None


def main():
    try:
        r = subprocess.run(
            ["aerospace", "list-workspaces", "--focused", "--format", "%{workspace}"],
            capture_output=True, text=True, timeout=5
        )
        active = int(r.stdout.strip())
    except:
        active = -1

    print(f"active:{active}")

    by_ws = {}
    seen = set()

    try:
        r = subprocess.run(
            ["aerospace", "list-windows", "--all", "--format", "%{app-name}|%{app-bundle-id}|%{workspace}"],
            capture_output=True, text=True, timeout=5
        )
        for line in r.stdout.strip().split("\n"):
            line = line.strip()
            if not line:
                continue
            parts = line.split("|")
            if len(parts) < 3:
                continue
            name, bid, ws_str = parts[0], parts[1], parts[2]
            try:
                n = int(ws_str)
            except:
                continue
            if name and (n, name) not in seen:
                seen.add((n, name))
                path = extract_icon(name, bid)
                by_ws.setdefault(n, []).append((name, path or ""))
    except:
        pass

    for i in range(1, WORKSPACE_COUNT + 1):
        apps = by_ws.get(i, [])
        parts = [f"{name}|{path}" for name, path in apps]
        print(f"{i}:" + ",".join(parts))


if __name__ == "__main__":
    main()
