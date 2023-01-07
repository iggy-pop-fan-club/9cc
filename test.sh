#!/bin/bash
assert() {
  expected="$1"
  input="$2"

  ./9cc "$input" > tmp.s
  cc -o tmp tmp.s
  ./tmp
  actual="$?"

  if [ "$actual" = "$expected" ]; then
    echo -e "\e[37;42;1m PASS \e[m $input => $actual"
  else
    echo "$input => $expected expected, but got $actual"
    exit 1
  fi
}

assert 0 0
assert 42 42
# 加減算
assert 21 "5+20-4"
# 空白文字を除去(tokenizer)
assert 41 " 12 + 34 - 5 "
# 四則演算(AST生成)
assert 47 '5+6*7'
assert 15 '5*(9-6)'
assert 4 '(3+5)/2'
# 単項プラスと単項マイナス
assert 9 '10+-1'
assert 8 '-10*2+30+-2'

echo OK
