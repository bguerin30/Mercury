
#DATA STRUCTURES (DS) Definitions
export DS_SRCDIR	:= $(DS_DIR)/src
export DS_INCDIR	:= $(DS_DIR)/inc
export DS_TESTDIR	:= $(DS_DIR)/utests
export DS_EXMPLDIR	:= $(DS_DIR)/examples
export DS_BUILDDIR	:= $(CMODBUILD_DIR)/data_structures
export DS_LIBDIR	:= $(CMODLIB_DIR)/data_structures

export DS_BINDIR			:= $(DS_BUILDDIR)/bin
export DS_OBJDIR			:= $(DS_BUILDDIR)/obj
export DS_TESTOBJDIR		:= $(DS_OBJDIR)/tests
export DSTESTALL_OBJDIR 	:= $(DS_TESTOBJDIR)/all
export DSTESTSING_OBJDIR	:= $(DS_TESTOBJDIR)/single

export DS_LIBOUT		:= ${DS_LIBDIR}/libDataStruct.a

_DS_SRCS	:= RingBuf.c
_DS_OBJS	:= $(_DS_SRCS:.c=.o)
_DS_LIBS	:= $(_DS_SRCS:.c=.a)

export DS_SRCS	:= $(patsubst %,$(DS_SRCDIR)/%,$(_DS_SRCS))
export DS_OBJS	:= $(patsubst %,$(DS_OBJDIR)/%,$(_DS_OBJS))
export DS_LIBS	:= $(patsubst %,$(DS_LIBDIR)/%,$(_DS_OBJS))

#Flags, Libraries and Includes
export DS_LIBFLAGS			:= $(DS_LIBOUT)
export DS_INCFLAGS			:= $(INCFLAGS) -I$(DS_INCDIR)
export DSTEST_INCFLAGS		:= $(DS_INCFLAGS) -I$(DS_TESTDIR)

export DS_MAKEFILE	:= $(DS_DIR)/Makefile