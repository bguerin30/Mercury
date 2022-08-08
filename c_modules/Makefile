
CMODBUILD_DIR	:= $(BUILDDIR)/c_modules
CMODLIB_DIR		:= $(LIBDIR)/c_modules
CMODMAKE_DIR	:= $(CMOD_DIR)/makefiles
CMODCONF_DIR	:= $(CMOD_DIR)/make_conf
CMODSRC_DIR		:= $(CMOD_DIR)/src
CMODINC_DIR		:= $(CMOD_DIR)/include
CMODEXMPLE_DIR	:= $(CMOD_DIR)/examples
CMODTEST_DIR	:= $(CMOD_DIR)/utests

DS_SRCDIR	:= $(CMODSRC_DIR)/data_structures
DS_INCDIR	:= $(CMODINC_DIR)/data_structures

ALGO_SRCDIR	:= $(CMODSRC_DIR)/algorithms
ALGO_INCDIR	:= $(CMODINC_DIR)/algorithms

_CMODTEST_SRC := TestAll.c
_CMODTEST_OBJ := TestAll.o

CMODTEST_SRC := $(patsubst %, $(CMODTEST_DIR)/%,$(_CMODTEST_SRC))
CMODTEST_OBJ := $(patsubst %, $(CMODBUILD_DIR)/%,$(_CMODTEST_OBJ))

CMODTEST_OUT	:= $(CMODBUILD_DIR)/TestAll
MERC_LIBOUT		:= $(CMODLIB_DIR)/libMercury.a

#Compiler and Linker
CC		:= gcc
CFLAGS  := -Wall -O3 -g -Wno-unused 
#CFLAGS	+= -Wextra
CFLAGS	+= -Wpedantic

TEST_CFLAGS 	:= $(CFLAGS) -DTEST_ALL -Wno-uninitialized
LIBFLAGS	:= 
INCFLAGS	:= -I$(CMODINC_DIR)

_CMOD_MAKEFILES := algo_Makefile.mk ds_Makefile.mk
CMOD_MAKEFILES	:= $(patsubst %, $(CMODMAKE_DIR)/%,$(_CMOD_MAKEFILES))

include $(CMOD_MAKEFILES)


.PHONY: cmod_dirs cmod_all cmod_clean cmod_cleaner cmod_remake

cmod_all: cmod_cleaner cmod_dirs cmod_tests cmod_libs

cmod_dirs: out_dirs ds_dirs algo_dirs

cmod_tests: $(DS_LIBOUT) $(DS_TEST_OBJS) $(CMODTEST_OUT) #algo_tests
	

cmod_libs: ds_libs $(MERC_LIBOUT) #algo_libs

$(CMODTEST_OBJ): $(CMODTEST_SRC)
	$(CC) $(TEST_CFLAGS) $(DSTEST_INCFLAGS) -c $^ -o $@ 	

$(CMODTEST_OUT): $(CMODTEST_OBJ)
	$(CC) $(DSTEST_INCFLAGS) $< $(DS_TEST_OBJS) -o $@ $(DS_LIBFLAGS)

$(MERC_LIBOUT): $(DS_OBJS)
	ar rcs $@ $^

#Remake
cmod_remake: cmod_cleaner all
	
#Clean only Objecst
cmod_clean: ds_clean algo_clean
	
#Full Clean, Objects and Binaries
cmod_cleaner: 
	@$(RM) -rf $(CMODBUILD_DIR)
	@$(RM) -rf $(CMODLIB_DIR)

