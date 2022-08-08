
#The Directories, Source, Includes, Objects, Binary and Resources
SRCDIR      := src 
TEST_SRCDIR	:= utests
INCDIR      := inc
BUILDDIR    := build/obj
TARGETDIR   := build/bin
LIBDIR		:= lib
RESDIR      := 
SRCEXT      := cpp
DEPEXT      := d
OBJEXT      := o

MODULES_BUILDDIR	:= $(BUILDDIR)/modules
TESTS_BUILDDIR		:= $(BUILDDIR)/utest
ATESTS_BUILDDIR 	:= $(BUILDDIR)/testall

LIB_OUT := ${LIBDIR}/aMercuryLib.a
TEST_ALL_OUT := ${TARGETDIR}/all_tests

#Compiler and Linker
CC         			:= gcc
#Flags, Libraries and Includes
CFLAGS      		:= -Wall -O3 -g
TEST_ALL_CFLAG		:= -DTEST_ALL
TEST_SINGLE_CFLAG	:= -DTEST_SINGLE
LIB_FLAGS      		:= -lm -l$(LIB_OUT)
INC         		:= -I$(INCDIR) -I/usr/local/include -I/usr/include
INCDEP      		:= -I$(INCDIR)

#---------------------------------------------------------------------------------
#DO NOT EDIT BELOW THIS LINE
#---------------------------------------------------------------------------------
SOURCES     := ringbug.c
_OBJS		:= ringbuf.o
OBJECTS     := $(patsubst %,$(MODULES_BUILDDIR)/%,$(_OBJS))

TSOURCES	:= ringbuf_test.c
_TOBJS		:= ringbuf_test.o
TOBJECTS    := $(patsubst %,$(TESTS_BUILDDIR)/%,$(_TOBJS))
ALLTOBJECTS := $(patsubst %, $(ATESTS_BUILDDIR)/%, $(_TOBJS))


#Defauilt Make
all: directories all_tests $(TEST_ALL_OUT)

all_tests: 
	@echo

$(MODULES_BUILDDIR)/%.o: $(SRCDIR)/%.c
	$(CC) -c $(INC) -o $@ $< $(CFLAGS)

$(LIB_OUT): $(OBJECTS)
	ar rvs $(LIB_OUT) $^

$(TESTS_BUILDDIR)/%.o: $(TEST_SRCDIR)/%.c $(LIB_OUT)
	$(CC) -c $(INC) -o $@ $< $(LIB_FLAGS) $(CFLAGS) $(TEST_SINGLE_CFLAG)

$(ATESTS_BUILDDIR)/%.o: $(TEST_SRCDIR)/%.c $(LIB_OUT)
	$(CC) -c $(INC) -o $@ $< $(LIB_FLAGS) $(CFLAGS) $(TEST_ALL_CFLAG)

$(TEST_ALL_OUT): $(ALLTOBJECTS) $(TEST_SRCDIR)/TestAll.c
	

#Remake
remake: cleaner all

#Make the Directories
directories:
	@mkdir -p $(TARGETDIR)
	@mkdir -p $(BUILDDIR)
	@mkdir -p $(MODULES_BUILDDIR)
	@mkdir -p $(TESTS_BUILDDIR)
	@mkdir -p $(ATESTS_BUILDDIR)
	@mkdir -p $(LIBDIR)
	

#Clean only Objecst
clean:
	@$(RM) -rf $(MODULES_BUILDDIR)
	@$(RM) -rf $(TESTS_BUILDDIR)
	@$(RM) -rf $(ATESTS_BUILDDIR)

#Full Clean, Objects and Binaries
cleaner: clean
	@$(RM) -rf $(TARGETDIR)
	@$(RM) -rf $(LIBDIR)

#Pull in dependency info for *existing* .o files
-include $(OBJECTS:.$(OBJEXT)=.$(DEPEXT))

#Non-File Targets
.PHONY: all remake clean cleaner