## @author Copyright (C) 2016 Robin Schneider <ypid@riseup.net>
## @license AGPLv3 <https://www.gnu.org/licenses/agpl-3.0.html>
## This file is sourced from all sandboxes scripts.

## Debugging functions
function debug_echo() {
    if [ $DEBUG -gt 0 ]; then
        echo "$@"
    fi
}
## Functions
function xpra_attach() {
    ## Execute xpra if enabled.
    if [ "$XPRA_ENABLED" == "1" ]; then
        sleep "$FIREJAIL_STARTUP_TIME"
        xpra attach $XPRA_COMMON_FLAGS $@
    fi
}

SANDBOX_NAME="$(basename "$0")"

## Figure out the $DISPLAY number to use for `xpra`.
SANDBOX_DISPLAY="$(echo "$SANDBOX_NAME" | sha512sum | sed 's/[^0-9]//g' | cut -c 1-6 | tr 0 4)"

## Define defaults for config.sh {{{
SANDBOX_HOME_DIR="$HOME/.sandboxes/homes/$SANDBOX_NAME"
FIREJAIL_STARTUP_TIME="3"
FIREJAIL_PROFILE_DIR="/etc/firejail"
XPRA_ENABLED=1
FIREJAIL_PATH="firejail"
DEBUG=0
HIDE_UNSANDBOXED_APPS=""
REENABLE_UNSANDBOXED_APPS=""
USER_DESKTOP_ENTRIES_DIR="$HOME/.local/share/applications"

## Setup `firejail` flags used by all sandboxes.
FIREJAIL_COMMON_FLAGS="--name=$SANDBOX_NAME --private-dev --shell=none --ipc-namespace --blacklist=/tmp/.X11-unix"

FIREJAIL_NOLOCAL="--netfilter=$FIREJAIL_PROFILE_DIR/nolocal.net --net=nat0"
# If a new network namespaces is not created, --netfilter option does nothing.

if [ $DEBUG -gt 0 ]; then
    FIREJAIL_COMMON_FLAGS="$FIREJAIL_COMMON_FLAGS --debug"
fi
FIREJAIL_PRIVATE_FLAGS="--private="$SANDBOX_HOME_DIR""

## Setup `xpra` flags used by all sandboxes which use XPRA for X11 isolation.
XPRA_COMMON_FLAGS=":$SANDBOX_DISPLAY --socket-dir=/tmp"
XPRA_START_FLAGS="xpra start $XPRA_COMMON_FLAGS --no-daemon --exit-with-children"


## }}}

## Include config.sh
test -r "$SANDBOX_CONF_DIR/config.sh" && . "$SANDBOX_CONF_DIR/config.sh"
test -r "$SANDBOX_CONF_DIR/config_local.sh" && . "$SANDBOX_CONF_DIR/config_local.sh"

if [ "$SANDBOX_NAME" != 'handle_desktop_entries' ]
then
    mkdir --parents "$SANDBOX_HOME_DIR"
fi
