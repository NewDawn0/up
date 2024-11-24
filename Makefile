CC := gcc
CFLAGS := -O3 -Wall -Wpedantic

build:
	$(CC) $(CFLAGS) ./src/up.c -o up-core

install: build
	sudo cp ./up-core /usr/local/bin/
