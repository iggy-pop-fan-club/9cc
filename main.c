#include "9cc.h"

int main(int argc, char **argv) {
  if (argc != 2) {
    error("引数の個数が正しくありません");
    return 1;
  }
  // ユーザーの入力を保存
  user_input = argv[1];

  // トークナイズする
  token = tokenize();
  // nodeにパースする
  Node *node = expr();

  // アセンブリの前半部分を出力
  printf(".intel_syntax noprefix\n");
  printf(".globl main\n");
  printf("main:\n");

  // ASTをトラバースしてアセンブリを生成する。
  gen(node);

  // 結果はスタックの最上位になければならないので、pop it
  // プログラムの終了コードにするために RAX にポップします。
  printf("  pop rax\n");
  printf("  ret\n");
  return 0;
}