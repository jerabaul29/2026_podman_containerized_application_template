#!/bin/bash

# ----------------------------------------
# preamble

# exit if a command fails; to circumvent, can add specifically on commands that can fail safely: " || true "
set -o errexit
# make sure to show the error code of the first failing command
set -o pipefail
# do not overwrite files too easily
# to override the noclobber: >| instead of > only
set -o noclobber
# exit if try to use undefined variable
set -o nounset

# on globbing that has no match, return nothing, rather than return the dubious default ie the pattern itself
# see " help shopt "; use the -u flag to unset (while -s is set)
shopt -s nullglob
# ----------------------------------------

# the bash script to be called on the first time to build the APP_NAME.sh executable and install if for the user

# ----------------------------------------
# start working :)

# ----------------------------------------
# load the config
bash ./app_config.sh

# ----------------------------------------
# copy the template into the right .sh app file
cp ./APP_NAME_TEMPLATE.sh ${APP_NAME}.sh

# ----------------------------------------
# prepare the persisting folder and populate it as needed

# ----------------------------------------
# fill in the necessary fields in the .sh app file
# - path to persistent data
# - image name to use
# - config for rebuilding frequency

# ----------------------------------------
# copy and make executable the .sh app file

# ----------------------------------------
# all good :)
