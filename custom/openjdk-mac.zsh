if [[ "$OSTYPE" == darwin* && -x /usr/local/opt/openjdk@8/bin/java ]]; then
    # $ brew install openjdk@8
    # path update recommended by `brew info java`
    pathadd "/usr/local/opt/openjdk@8/bin"
fi
