- program.c - this is our main program which contains the main() function.
- func_prototypes.h: This is a header file which contains the function prototypes of our external code (code not in program.c).
- num_choose.c this is separate code (not a standalone program) which is used in program.c

<br />

```bash
make
```  
Running `make` will execute our Makefile, which in turn...
- Fills in all headers (including func_prototypes.h)
- Creates object files for program.o and numchoose.o
- Links program.o and numchoose.o and create an executable.

<br />

```bash
make clean
```  
Running `make clean` will clean up all object files.

<br/>

```bash
make launch
```

This will re-compile the program, but only re-compiling the bits that need updating (if source code was modified) and will subsequently execute the program.
This can be used instead of make if you want to compile and execute the program on the first run.
