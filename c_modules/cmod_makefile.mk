
#=============================================================
#Compiler and Linker
#=============================================================
CC		:= gcc
CFLAGS  := -Wall -O3 -g -Wno-unused 
#CFLAGS	+= -Wextra
CFLAGS	+= -Wpedantic
CFLAGS	+= -Wno-uninitialized

TEST_CFLAGS := $(CFLAGS) -DTEST_ALL 

#=============================================================
# C MODULE FOLDER STRUCT
#=============================================================
CMODLIB_DIR		:= $(LIBDIR)/c_modules
CMODSRC_DIR		:= $(CMOD_DIR)/src
CMODINC_DIR		:= $(CMOD_DIR)/include
CMODEXMPLE_DIR	:= $(CMOD_DIR)/examples
CMODTEST_DIR	:= $(CMOD_DIR)/utests
CMODMAKE_DIR	:= $(CMOD_DIR)/makefiles
CMODBUILD_DIR	:= $(BUILDDIR)/c_modules
CMODBIN_DIR		:= $(CMODBUILD_DIR)/bin
CMODOBJ_DIR		:= $(CMODBUILD_DIR)/obj

# Create defatult CMOD Vars
CMOD_MKDIRS		:= $(CMODBUILD_DIR) $(CMODBIN_DIR) $(CMODOBJ_DIR) $(CMODLIB_DIR)
CMOD_INCDIRS	:= $(CMODINC_DIR) $(CMODLIB_DIR)
CMOD_INCFLAGS	:=	
CMOD_OUTLIBS	:= $(CMODLIB_DIR)/libmercury.a
CMOD_LIBFLAGS	:= -lmercury

#=============================================================
# These must be added for every directory in c_modules/
#=============================================================
CMOD_FOLDERS	:=
CMOD_LIBS		:=
_CMOD_SRCS		:=
_CMOD_TESTSRCS	:= TestAll.c
_CMOD_BINS		:= TestAll
_CMOD_MAKEFILES	:=

#=============================================================
# ALGO FOLDER
#=============================================================
ALGO_FOLDER		:= algorithms
CMOD_FOLDERS	+= $(ALGO_FOLDER)
_CMOD_SRCS		+=
_CMOD_TESTSRCS	+=
_CMOD_BINS		+=
_CMOD_MAKEFILES	+=

#=============================================================
# DATA STRUCTURES FOLDER
#=============================================================
DS_FOLDER		:= datastructs
DS_SRCS			:= RingBuf.c 
DS_LIBS			:= $(DS_SRCS:.c=.a)
DS_TESTSRCS		:= test_RingBuf.c	
DS_BINS			:= test_RingBuf
DS_MAKEFILES	:= $(DS_FOLDER).mk		
DS_OBJDIR		:= $(CMODOBJ_DIR)/$(DS_FOLDER)
DS_LIBDIR		:= $(CMODLIB_DIR)/$(DS_FOLDER)

CMOD_FOLDERS	+= $(DS_FOLDER)
CMOD_LIBS		+= $(patsubst %, $(DS_FOLDER)/%, $(DS_LIBS))
_CMOD_SRCS		+= $(patsubst %, $(DS_FOLDER)/%, $(DS_SRCS))
_CMOD_TESTSRCS	+= $(patsubst %, $(CMODTEST_DIR)/$(DS_FOLDER)/%, $(DS_TESTSRCS))
_CMOD_BINS		+= $(patsubst %, $(DS_FOLDER)/%, $(DS_BINS))
_CMOD_MAKEFILES	+= $(DS_MAKEFILES)

#=============================================================
# Automatically add to variables by using CMOD_FOLDERS, _CMOD_SRCS, _CMOD_TESTSRCS, _CMOD_BINS
#=============================================================
CMOD_MKDIRS		+= $(patsubst %, $(CMODLIB_DIR)/%, $(CMOD_FOLDERS))
CMOD_MKDIRS		+= $(patsubst %, $(CMODOBJ_DIR)/%, $(CMOD_FOLDERS))
CMOD_INCDIRS	+= $(patsubst %, $(CMODINC_DIR)/%, $(CMOD_FOLDERS))
CMOD_INCFLAGS	+= $(patsubst %, -I%, $(CMOD_INCDIRS))
CMOD_OUTLIBS	+= $(addsuffix .a, $(patsubst %, $(CMODLIB_DIR)/lib%, $(CMOD_FOLDERS)))
CMOD_OUTLIBS	+= $(patsubst %, $(CMODLIB_DIR)/%, $(CMOD_LIBS))
CMOD_LIBFLAGS	+= $(patsubst %, -I%, $(CMOD_INCDIRS)) $(patsubst %, -l%,$(CMOD_FOLDERS))

# Create the final vars by using, _CMOD_SRCS, _CMOD_TESTSRCS, _CMOD_BINS, _CMOD_MAKEFILES
CMOD_SRCS		:= $(patsubst %, $(CMODSRC_DIR)/%, $(_CMOD_SRCS))
CMOD_OBJS		:= $(patsubst %, $(CMODOBJ_DIR)/%, $(_CMOD_SRCS:.c=.o))
CMOD_TESTSRCS	:= $(patsubst %, $(CMODSRC_DIR)/%, $(_CMOD_TESTSRCS))
CMOD_TESTOBJS	:= $(patsubst %, $(CMODOBJ_DIR)/%, $(_CMOD_TESTSRCS:.c=.o))
CMOD_BINS		:= $(patsubst %, $(CMODOBJ_DIR)/%, $(_CMOD_BINS))
CMOD_MAKEFILES	:= $(patsubst %, $(CMODMAKE_DIR)/%,$(_CMOD_MAKEFILES))

$(info CMOD_MAKEFILES = $(CMOD_MAKEFILES))
$(info CMOD_INCDIRS = $(CMOD_INCDIRS))
$(info CMOD_INCFLAGS = $(CMOD_INCFLAGS))

#TODO: Target to Copy over each libraries header file
#TODO: Write header file for each library
.PHONY: cmod_all cmod_dirs cmod_libs cmod_tests cmod_clean cmod_cleaner cmod_remake

cmod_all: cmod_cleaner cmod_dirs
	@echo CMOD cmod_all

$(CMODOBJ_DIR)/%.o: $(DS_TESTDIR)/%.c
	@echo CMOD $@
	$(CC) $(TEST_CFLAGS) $(DSTEST_INCFLAGS) -c $< -o $@

$(CMODTEST_OBJ): $(CMODTEST_SRC)
	@echo CMOD S(CMODTEST_OBJ)
	$(CC) $(TEST_CFLAGS) $(DSTEST_INCFLAGS) -c $^ -o $@ 	

$(CMODTEST_OUT): $(CMODTEST_OBJ)
	@echo CMOD S(CMODTEST_OUT)
	$(CC) $(DSTEST_INCFLAGS) $< $(ALGO_TEST_OBJS) -o $@ $(ALGO_LIBFLAGS)

$(CMOD_OUTLIBS): $(CMOD_OBJS)
	@echo CMOD S(CMOD_OUTLIBS)
	ar rcs $@ $^

#Make output dirs
cmod_dirs: 
	@echo CMOD cmod_dirs 
	$(foreach dir, $(CMOD_MKDIRS), mkdir -p $(dir); )

#Run test binarys that were generated
cmod_tests: $(ALGO_LIBOUT) $(ALGO_TEST_OBJS) $(CMODTEST_OUT) #algo_tests
	@echo CMOD cmod_tests
	$(foreach bin, $(CMOD_BINS), $(bin) ;)
	
cmod_libs: $(CMOD_OBJS) $(CMOD_OUTLIBS) #algo_libs
	@echo CMOD MakeFile cmod_libs

#Remake
cmod_remake: cmod_cleaner all
	@echo CMOD MakeFile cmod_remake

#Clean only Objecst
cmod_clean: ds_clean algo_clean
	@echo CMOD MakeFile cmod_clean

#Full Clean, Objects and Binaries
cmod_cleaner: 
	@echo CMOD MakeFile cmod_cleaner
	@$(RM) -rf $(CMODBUILD_DIR)
	@$(RM) -rf $(CMODLIB_DIR)


include $(CMOD_MAKEFILES)
