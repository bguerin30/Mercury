
export ALGO_SRCDIR		:= $(ALGO_DIR)/src
export ALGO_INCDIR		:= $(ALGO_DIR)/inc
export ALGO_TESTDIR		:= $(ALGO_DIR)/utests
export ALGO_EXMPLDIR	:= $(ALGO_DIR)/examples
export ALGO_BUILDDIR	:= $(CMODBUILD_DIR)/algorithms
export ALGO_LIBDIR		:= $(CMODLIB_DIR)/algorithms


export ALGO_BINDIR		:= $(ALGO_BUILDDIR)/bin
export ALGO_OBJDIR		:= $(ALGO_BUILDDIR)/obj
export ALGO_TESTOBJDIR	:= $(ALGO_OBJDIR)/tests
export ALGO_TESTALLOBJDIR		:= $(ALGO_TESTOBJDIR)/all
export ALGO_TESTSINGLEOBJDIR	:= $(ALGO_TESTOBJDIR)/single

export ALGO_LIBOUT	:= $(ALGO_LIBDIR)/libAlgorithms.a

_ALGO_SRCS	:= 
_ALGO_OBJS	:= $(_ALGO_SRCS:.c=.o)
_ALGO_LIBS	:= $(_ALGO_SRCS:.c=.a)

export ALGO_SRCS	:= $(patsubst %, $(ALGO_SRCDIR)/%,$(_ALGO_SRCS))
export ALGO_OBJS	:= $(patsubst %,$(ALGO_OBJDIR)/%,$(_ALGO_OBJS))
export ALGO_LIBS	:= $(patsubst %,$(ALGO_LIBDIR)/%,$(_ALGO_OBJS))

#Flags, Libraries and Includes
export ALGO_LIBFLAGS		:= $(LIBFLAGS) -lAlgorithms
export ALGO_INCFLAGS		:= $(INCFLAGS) -I$(ALGO_INCDIR) 
export ALGOTEST_INCFLAGS	:= $(ALGO_INCFLAGS) -I$(DS_TESTDIR)

export ALGO_MAKEFILE	:= $(ALGO_DIR)/Makefile