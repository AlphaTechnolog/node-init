#!/bin/bash

clear

error () {
  >&2 echo "[X] $@"
  exit 1
}

warn () {
  >&2 echo "[W] $@"
}

info () {
  >&2 echo "[*] $@"
}

success () {
  echo "[+] $@"
}

cmd () {
  local command=$@
  echo "  $ ${command}"
  $command
  if [[ $? != 0 ]]; then
    error "The command returned a status code distinct than 0, exiting..."
    exit 1
  fi
}

show_usage () {
cat << EOF
usage: ni [-h/help/--help] <project-name> <dependencies-manager> <dependencies> <dev-dependencies>

flags:
  -h | --help | help -> Print this message and exit

positional arguments
  project-name -> The name of the project
  dependencies-manager -> select the dependency manager for the project, like yarn or npm
    @choices: yarn | npm
  dependencies -> The dependencies of the project (not required, '' to don't install dependencies)
  dev-dependencies -> The dev dependencies of the project (not required, '' to don't install dependencies)

examples:
  create a project with npm containing the dependencies: express and morgan and call the project sample-project:
    $ ni sample-project npm express,morgan
  create a project with yarn containing express and morgan as dependencies and @types/node, @types/express, typescript and @types/morgan as subdependencies:
    $ ni sample-project yarn express,morgan @types/node,@types/morgan,typescript,@types/express
  create a project with npm containing uuid as dependency and call the project sample-project-uuid
    $ ni sample-project-uuid npm uuid
EOF
exit 1
}

banner () {
cat << EOF
+----------------------------------------------------------------------+
| Welcome to node-init                                                 |
|                                                                      |
| > With me you can init more easy your node projects with npm or yarn |
+----------------------------------------------------------------------+
EOF
}

check_flags () {
  directory=$1
  dependencies_manager=$2
  dependencies=$3
  dev_dependencies=$4

  if [[ $1 == "--help" || $1 == "help" || $1 == "-h" ]]; then
    show_usage
  fi

  if [[ $directory == "" ]]; then
    echo "Missing argument: directory"
    show_usage
  fi

  if [[ $dependencies_manager == "" ]]; then
    dependencies_manager=npm
  fi

  if [[ $dependencies_manager != "npm" && $dependencies_manager != "yarn" ]]; then
    echo "Invalid argument dependencies manager ($dependencies_manager), only accepted choices: npm | yarn"
    show_usage
  fi
}

create_project () {
  info "Creating project ($directory)"
  if test -d "$directory"; then
    warn "Found another project named equal, moving it to ${directory}.$(date | sed 's/ /-/g' | sed 's/--/-/g')"
    cmd mv "$directory" "${directory}.$(date | sed 's/ /-/g' | sed 's/--/-/g')"
  fi
  cmd mkdir -p "$directory"
  cmd cd "$directory"
  cmd "$dependencies_manager" init -y
  cmd cd ".."
  success "Done"
}

install_dependencies () {
  info "Installing dependencies: $(echo $dependencies | sed 's/,/, /g')"
  if ! test -d "$directory"; then
    warn "Not found the directory, this is a likely a bug, or the directory cannot be created, recreating..."
    create_project
    install_dependencies
  else
    cmd cd "$directory"
    if [[ "$dependencies_manager" == "yarn" ]]; then
      cmd yarn add $(echo $dependencies | sed 's/,/ /g')
    else
      cmd npm install $(echo $dependencies | sed 's/,/ /g')
    fi
    cmd cd ".."
    success "Done"
  fi
}

install_dev_dependencies () {
  info "Installing dev dependencies: $(echo $dev_dependencies | sed 's/,/, /g')..."
  if ! test -d "$directory"; then
    warn "Not found the directory, this is a likely a bug, or the directory cannot be created, recreating..."
    create_project
    if [[ $dependencies != "" ]]; then
      install_dependencies
    fi
    install_dev_dependencies
  else
    cmd cd "$directory"
    if [[ "$dependencies_manager" == "yarn" ]]; then
      cmd yarn add $(echo "$dev_dependencies" | sed 's/,/ /g') -D
    else
      cmd npm install $(echo "$dev_dependencies" | sed 's/,/ /g') -D
    fi
    cmd cd ".."
    success "Done"
  fi
}

main () {
  create_project
  if [[ $dependencies != "" ]]; then
    install_dependencies
  fi
  if [[ $dev_dependencies != "" ]]; then
    install_dev_dependencies
  fi
  success "Created the project successfully, execute: $ cd ./$directory to start using your new node project"
}

banner
check_flags $@
main
