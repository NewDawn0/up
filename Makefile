CFLAGS := -O3 -Wall -Wpedantic

build:
	cc $(CFLAGS) ./src/up.c -o up-core

install: build
	sudo cp ./up-core /usr/local/bin/
