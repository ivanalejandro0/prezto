#!/usr/bin/env zsh

set -e
set -o pipefail

# use this like so:
#   INSTALL_DIR="./go-bin" $0
INSTALL_DIR="${INSTALL_DIR:-$HOME/golang}"

tmpfile=$(mktemp --dry-run --suffix='_go-files-info.json')

cleanup() {
  rm -f $tmpfile
}
trap cleanup EXIT

# On this json file lives information about what's the latest go version
# and also the sha256 checksum for all the artifacts.
get_json() {
  curl --silent "https://go.dev/dl/?mode=json" > $tmpfile
}

get_latest_version() {
  cat $tmpfile \
    | jq -r '[ .[] | .version ] | max'
}

get_checksum() {
  cat $tmpfile \
    | jq -r '
  ([ .[] | .version ] | max) as $version
  | .[]
  | select(.version == $version)
  | .files
  | .[]
  | select(.filename == $version + ".linux-amd64.tar.gz")
  | .sha256
  '
}

cc_reset="$(tput sgr0)"
cc_reverse="$(tput rev)"

info() {
  echo "$cc_reverse$@$cc_reset"
}

_backup_location=""
if [[ "$1" == "-b" ]]; then
  _backup_location="${INSTALL_DIR}.old"
fi

prepare_location() {
  if [[ -z "$1" ]]; then
    echo "Error: missing parameter" >&2
    exit 1
  fi
  local location="$1"

  echo
  info "> Prepare location: $location"

  if [[ -d "$location" && $_backup_location == "" ]]; then
    echo "Error: location exists. Handle it manually, or run this script using -b to backup '$location' to '${location}.old' (overwrites if '${location}.old' exists)" >&2
    exit 1
  fi

  cc_red="$(tput setaf 1)"
  cc_bold="$(tput bold)"

  if [[ -d "$_backup_location" ]]; then
    echo "'$_backup_location' exists, it will be replaced with '$location' contents"
    print -n -- "${cc_red}${cc_bold}>> press ENTER to continue, Ctrl+C to terminate << ${cc_reset}"; read -r
    # read -r "?${cc_red}${cc_bold}>> press ENTER to continue, Ctrl+C to terminate << ${cc_reset}"
  fi

  # backup existing $location if exists
  [[ -d "${location}.old" ]] && rm -fr "${location}.old"
  [[ -d "$location" ]] && mv "$location" "${location}.old"

  mkdir -p $location
  cd $location || exit 1
}

download_and_install_or_upgrade_go() {
  if [[ -z "$1" || -z "$2" || -z "$3" ]]; then
    echo "Error: missing parameter(s)" >&2
    exit 1
  fi

  local version="$1"
  local checksum="$2"
  local location="$3"

  echo
  info "> Downloading tarball"
  # go_tarball="${version}.darwin-amd64.tar.gz"
  go_tarball="${version}.linux-amd64.tar.gz"
  curl --progress-bar --remote-name https://dl.google.com/go/${go_tarball}
  # curl --remote-name "https://go.dev/dl/${go_tarball}"

  echo
  info "> Verifying checksum"
  echo "$checksum $go_tarball" | sha256sum --check
  if [[ $? -ne 0 ]]; then
    echo "ERROR: checksum invalid" >&2
    exit 1
  fi

  echo
  info "> Unpacking"
  tar xzf $go_tarball

  # info "> Removing artifact"
  rm -f $go_tarball
}

info "> Downloading information about latest Go artifacts"
get_json

latest_version=$(get_latest_version)

# get the version, if installed, before touching install dir
if ! current_version=$(go version | cut -f3 -d' '); then
  echo "Go not installed"
  : # `go version` failed -> Go not installed
fi

echo "Current version: $current_version"
echo "Latest version: $latest_version"

if [[ "$current_version" == "$latest_version" ]]; then
  echo "No need to update, latest version installed"
  exit 1
fi

prepare_location "$INSTALL_DIR"

checksum=$(get_checksum)

download_and_install_or_upgrade_go "$latest_version" "$checksum" "$INSTALL_DIR"

echo "DONE"
