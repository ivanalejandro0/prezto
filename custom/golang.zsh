# # Install / update go on custom path
# default install (pkg file) puts go on /usr/local/go/

BASE=$HOME/golang

# # uncomment this when needed
# function download_and_install_or_upgrade_go() {
#     mkdir -p $BASE
#     cd $BASE || exit 1
#
#     go_version="1.26.3"
#     # TODO: compare with current version, use
#     # $ go version
#     # go version go1.26.3 linux/amd64
#
#     # go_tarball="go${go_version}.darwin-amd64.tar.gz"
#     go_tarball="go${go_version}.linux-amd64.tar.gz"
#
#     # curl --remote-name https://dl.google.com/go/${go_tarball}
#     curl --remote-name https://go.dev/dl/${go_tarball}
#
#     # TODO: verify checksum
#     # see https://github.com/golang/go/issues/68282#issuecomment-2205939815
#     # download sha256 from https://go.dev/dl/?mode=json
#
#     [[ -d go.old ]] && rm -fr go.old
#     [[ -d go ]] && mv go go.old
#     tar xzf ${go_tarball}
# }

if [[ -d $BASE ]]; then
    export GOPATH=$BASE/workspace
    export GOROOT=$BASE/go
    pathadd "$GOROOT/bin"
    pathadd "$GOPATH/bin"
fi
