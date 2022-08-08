
#DATA STRUCTURES (DS) Definitions

DS_TESTDIR	:= $(CMODTEST_DIR)/data_structures
DS_EXMPLDIR	:= $(CMODEXMPLE_DIR)/data_structures
DS_BUILDDIR	:= $(CMODBUILD_DIR)/data_structures
DS_LIBDIR	:= $(CMODLIB_DIR)/data_structures

DS_BINDIR			:= $(DS_BUILDDIR)/bin
DS_OBJDIR			:= $(DS_BUILDDIR)/obj
DS_TESTOBJDIR		:= $(DS_OBJDIR)/tests

DS_LIBOUT		:= libDataStruct.a

_DS_TINY_LIBOUT	:= libRingBuf.a
DS_TINY_LIBOUT	:= $(patsubst %,$(DS_LIBDIR)/%,$(_DS_TINY_LIBOUT))

_DS_SRCS		:= RingBuf.c
_DS_OBJS		:= $(_DS_SRCS:.c=.o)
_DS_LIBS		:= $(_DS_SRCS:.c=.a)

_DS_TEST_SRCS	:= ringbuf_test.c
_DS_TEST_OBJS	:= $(_DS_TEST_SRCS:.c=.o)

DS_SRCS			:= $(patsubst %,$(DS_SRCDIR)/%,$(_DS_SRCS))
DS_OBJS			:= $(patsubst %,$(DS_OBJDIR)/%,$(_DS_OBJS))
DS_LIBS			:= $(patsubst %,$(DS_LIBDIR)/%,$(_DS_LIBS))

DS_TEST_SRCS	:= $(patsubst %,$(DS_TESTDIR)/%,$(_DS_TEST_SRCS))
DS_TEST_OBJS 	:= $(patsubst %,$(DS_TESTOBJDIR)/%,$(_DS_TEST_OBJS))

#Flags, Libraries and Includes
DS_LIBFLAGS			:= $(DS_LIBOUT)
DS_INCFLAGS			:= $(INCFLAGS) -I$(DS_INCDIR)
DSTEST_INCFLAGS		:= $(DS_INCFLAGS) -I$(CMODTEST_DIR) -I$(DS_TESTDIR)
