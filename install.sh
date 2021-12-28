#!/bin/bash

banner () {
cat << EOF
+----------------------------------------------------------------------+
| Welcome to node-init installer                                       |
|                                                                      |
| > With me you can install the node-init script for linux             |
+----------------------------------------------------------------------+
EOF
}

reset () {
  cd $(dirname $0)
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

check_fs () {
  info "Checking the filesystem to search the binaries of node-init"
  declare -a required_files=('ni')
  for file in ${required_files[@]}; do
    if ! test -f "${file}"; then
      error "Cannot find the required file $file"
    fi
  done
  success "Done"
  reset
}

check_old_installation () {
  info "Checking for old installations of node-init"
  if test -f /usr/bin/ni; then
    warn "Found old installation of node-init, moving it to /usr/bin/ni.old"
    cmd "mv /usr/bin/ni /usr/bin/ni.old"
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

install_binary () {
  info "Installing the binary to /usr/bin"
  cmd "cp -r ./ni /usr/bin/ni"
  cmd "chmod +x /usr/bin/ni"
  success "Done"
}

main () {
  check_old_installation
  install_binary
}

reset
check_euid
check_fs
main
