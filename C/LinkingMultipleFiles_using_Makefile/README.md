- program.c - this is our main program which contains the main() function.
- func_prototypes.h: This is a header file which contains the function prototypes of our external code (code not in program.c).
- num_choose.c this is separate code (not a standalone program) which is used in program.c

Running `make` will execute our Makefile, which in turn...
- Fills in all headers (including func_prototypes.h)
- Creates object files for program.o and numchoose.o
- Links program.o and numchoose.o and create an executable.
