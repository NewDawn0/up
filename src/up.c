#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

void up(int lim);
void init();
void help();

int main(int argc, char *argv[]) {
  int lim = 1;
  if (argc > 1) {
    if (strcmp(argv[1], "-i") == 0 || strcmp(argv[1], "--init") == 0) {
      init();
      return 0;
    }
    if (strcmp(argv[1], "-h") == 0 || strcmp(argv[1], "--help") == 0) {
      help();
      return 0;
    }
    lim = atoi(argv[1]);
  }
  up(lim);
  return 0;
}

void up(int lim) {
  if (lim <= 0)
    lim = 1;
  printf("cd ");
  for (int i = 0; i < lim; i++) {
    printf("../");
  }
  printf("\n");
}

void init() {
  const char *init_func[] = {
      "function up() {",
      " eval $(up-core \"$@\")",
      "}",
  };
  for (int i = 0; i < sizeof(init_func) / sizeof(init_func[0]); i++) {
    printf("%s\n", init_func[i]);
  }
}

void help() {
  printf("USAGE:\n");
  printf("  up <amount of directories to jump up>:\n\n");
  printf("OPTIONS:\n");
  printf("  up [-h|--help] -> Prints the usage:\n");
  printf("  up [-i|--init] -> Prints the shell hook function:\n");
}
