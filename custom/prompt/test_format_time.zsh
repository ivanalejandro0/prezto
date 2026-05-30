#!/usr/bin/env zsh

source ./format_time.zsh

cc_reset="$(tput sgr0)"
cc_reverse="$(tput rev)"

function test_format() {
  local input="$1"
  local expected="$2"
  local result=$(_prompt_ivan_format_time "$input")

  if [[ "$result" == "$expected" ]]; then
    echo "PASS: input = $input; formatted = $result"
  else
    echo "${cc_reverse}FAIL${cc_reset}: input = $input; formatted = $result; expected = $expected; "
    return 1
  fi
}

test_cases=(
  '12000' '12s'
  '12345' '12.34s'
  '754000' '12m34s'
  '5025000' '1h23m45s'
  '72300' '1m12.3s'
  '12340' '12.34s'
  '1234' '1.234s'
  '234' '234ms'
  '42' '42ms'
)

for key val in ${(kv)test_cases}; do
    test_format "$key" "$val"
done
