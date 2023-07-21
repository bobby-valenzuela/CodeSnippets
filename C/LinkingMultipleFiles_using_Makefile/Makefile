# define which compiler to use
CC        = gcc
# define compiler flags
CFLAGS    = -std=c11 -Wall -Wextra -fmax-errors=10
# define library paths in addition to /usr/lib
LFLAGS    =
# define the object files that this project needs
OBJFILES  = program.o numchoose.o
# define name of executable file
MAIN      = program

#############################################################################
# ----- all below is generic - one would typically only adjust the above ----
# $(VAR) - anyhting like this $(VAR) is a variable defined above


all: $(MAIN)

$(MAIN): $(OBJFILES)
	# echo "Creating " $(MAIN)
	$(CC) $(CFLAGS) -o $(MAIN) $(OBJFILES)

%.o: %.c
	echo "Creating Object files..."
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	echo "Cleaning Object files..."
	rm -f $(OBJFILES) $(MAIN)
