#!/usr/bin/env zsh

source ./format_time.zsh

function test_format() {
  local input="$1"
  local expected="$2"
  local result=$(format_time "$input")

  if [[ "$result" == "$expected" ]]; then
    echo "PASS: input = $input; formatted = $result"
  else
    echo "FAIL: input = $input; formatted = $result; expected = $expected; "
    return 1
  fi
}

test_cases=(
  '12345' '12.34s'
  '754000' '12m34s'
  '5025000' '1h23m45s'
  '72300' '1m12.3s'
  '12340' '12.34s'
  '1234' '1.234s'
  '234' '234ms'
)

for key val in ${(kv)test_cases}; do
    test_format "$key" "$val"
done
