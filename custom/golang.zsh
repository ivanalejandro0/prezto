# # Install / update go on custom path
# default install (pkg file) puts go on /usr/local/go/
# check ./go-version-manager.sh helper script

BASE=$HOME/golang

if [[ -d $BASE ]]; then
    export GOPATH=$BASE/workspace
    export GOROOT=$BASE/go
    pathadd "$GOROOT/bin"
    pathadd "$GOPATH/bin"
fi
