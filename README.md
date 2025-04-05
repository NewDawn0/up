# Up

Up is a command-line tool designed to simplify the process of navigating directories by providing a convenient alternative to using `cd` with relative path specifications. Instead of typing lengthy commands like `cd ../../../` to move up multiple directories, users can simply enter `up <amount>` to ascend the specified number of directories. For instance, typing `up 3` would navigate up three directories from the current location.

If the input to Up is not a number, it will default to navigating to the user's home directory. Additionally, if the specified number exceeds the available directories to ascend, Up will navigate to the topmost directory, if no amount is provided up will simply ascend 1 directory.

## Dependencies

- GCC (Or any other C compiler)
- GnuMake
- A Posix compliant shell

## Installation:

### Manually

1. Install the dependencies
2. Install the program

```bash
git clone https://github.com/NewDawn0/up
make install

```

- Next run the post install shell hook

### Using Nix

1. Add it to your packages

```nix
environment.systemPackages = [ pkgs.up ];
# Or
home.packages = [ pkgs.up ];

```

- Next run the post install shell hook

## Postinstall

If you built the package using NIX you can just source the generated file `./result/share/SOURCE_ME.sh` otherwise
append the output of `up-core --init` to your shell configuration file (e.g., `.bashrc`, `.zshrc`).
By loading this function it enables the up command.
