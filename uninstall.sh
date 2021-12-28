#!/bin/bash

banner () {
cat << EOF
+----------------------------------------------------------------------+
| Welcome to node-init uninstaller                                     |
|                                                                      |
| > With me you can uninstall the node-init script for linux           |
+----------------------------------------------------------------------+
EOF
}

reset () {
  clear
  banner
}

error () {
  >&2 echo "[X] $@"
  exit 1
}

warn () {
  >&2 echo "[W] $@"
  sleep 0.25
}

info () {
  >&2 echo "[*] $@"
  sleep 0.25
}

success () {
  echo "[+] $@"
  sleep 0.25
}

cmd () {
  local command=$@
  echo "  $ ${command}"
  $command
  if [[ $? != 0 ]]; then
    error "The command returned a status code distinct than 0, exiting..."
    exit 1
  fi
  sleep 0.1
}

check_old_installation () {
  info "Checking for old installations of node-init"
  if ! test -f /usr/bin/ni; then
    error "Cannot get an old installation of node-init, exiting..."
  fi
  success "Done"
}

check_euid() {
  info "Checking euid"
  if test "$EUID" -ne 0; then
    error "Before execute this script, check if you have the root permissions"
  fi
  reset
}

uninstall_binary () {
  info "Uninstalling the binary from /usr/bin"
  cmd "rm /usr/bin/ni"
  success "Done"
}

main () {
  check_old_installation
  uninstall_binary
}

reset
check_euid
main
