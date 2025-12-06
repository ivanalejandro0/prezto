# # Install / update go on custom path
# default install (pkg file) puts go on /usr/local/go/

BASE=$HOME/golang

# uncomment this when needed
# function download_and_install_or_upgrade_go() {
#     mkdir -p $BASE
#     cd $BASE
#
#     go_version="1.25.5"
#     # go_tarball="go${go_version}.darwin-amd64.tar.gz"
#     go_tarball="go${go_version}.linux-amd64.tar.gz"
#     curl --remote-name https://dl.google.com/go/${go_tarball}
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
