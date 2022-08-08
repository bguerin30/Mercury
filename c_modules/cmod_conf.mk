
CMODBUILD_DIR	:= $(BUILDDIR)/c_modules
CMODLIB_DIR		:= $(LIBDIR)/c_modules

CMODCONF_DIR	:= $(CMOD_DIR)/make_conf
DS_DIR	:= $(CMOD_DIR)/data_structures
ALGO_DIR	:= $(CMOD_DIR)/algorithms


MERC_LIBOUT	:= $(LIBDIR)/libMercury.a

#Compiler and Linker
CC			:= gcc
CFLAGS   	:= -Wall -O3 -g -Wno-unused 
#CFLAGS		+= -Wextra
CFLAGS		+= -Wpedantic

TESTALL_CFLAGS 		:= $(CFLAGS) -DTEST_ALL -Wno-uninitialized
TESTSINGLE_CFLAGS	:= $(CFLAGS) -DTEST_SINGLE

LIBFLAGS		:= 
INCFLAGS		:= 

CMOD_MAKEFILES := $(DS_DIR)/Makefile $(ALGO_DIR)/Makefile

include $(CMOD_MAKEFILES)

