# from https://gist.github.com/knadh/123bca5cfdae8645db750bfb49cb44b0?permalink_comment_id=4502423#gistcomment-4502423
function format_time() {
    # TODO: check decimal rounding
    local time_in_ms=$1

    local d_s=$((time_in_ms / 1000))
    local ms=$((time_in_ms % 1000))
    local s=$((d_s % 60))
    local m=$(((d_s / 60) % 60))
    local h=$((d_s / 3600))

    local timeprompt=""

    # TODO: check printf usage since it may be time expensive
    if   ((h > 0)); then timeprompt=${h}h${m}m${s}s  # 1h23m45s
    elif ((m > 0)); then timeprompt=${m}m${s}.$(printf $(($ms / 100)))s  # 1m12.3s
    elif ((s > 9)); then timeprompt=${s}.$(printf %02d $(($ms / 10)))s  # 12.34s
    elif ((s > 0)); then timeprompt=${s}.$(printf %03d $ms)s  # 1.234s
    else timeprompt=${ms}ms  # 234ms
    fi

    echo "$timeprompt"
}
