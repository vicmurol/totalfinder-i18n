#!/bin/bash
TOTALFINDER_RESOURCES='/Library/ScriptingAdditions/TotalFinder.osax/Contents/Resources/TotalFinder.bundle/Contents/Resources'
TOTALFINDER_RESOURCES_BACKUP='/Library/ScriptingAdditions/TotalFinder.osax/Contents/Resources/TotalFinder.bundle/Contents/ResourcesOrig'

# need absolute path of the repo's root
pushd . > /dev/null
cd "$(dirname "$0")"
cd ..
ROOT=$PWD

if [ ! -d "$TOTALFINDER_RESOURCES" ]; then # is it a folder?
  echo "Please install TotalFinder. Folder '$TOTALFINDER_RESOURCES' not found".
  popd > /dev/null
  exit
fi

if [ -L "$TOTALFINDER_RESOURCES" ]; then # is is a symlink?
  echo "TotalFinder is already in dev mode. Folder '$TOTALFINDER_RESOURCES' is a symlink! Exiting.".
  popd > /dev/null
  exit
fi

# ok, we should be safe to do the replacement
sudo mv "$TOTALFINDER_RESOURCES" "$TOTALFINDER_RESOURCES_BACKUP"
sudo ln -s "$ROOT/plugin" "$TOTALFINDER_RESOURCES"
sudo cp "$TOTALFINDER_RESOURCES_BACKUP/"*.nib "$TOTALFINDER_RESOURCES" # steal compiled nibs from production

popd > /dev/null
