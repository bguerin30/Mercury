
include $(CMODCONF_DIR)/ds_conf.mk

.PHONY: ds_all ds_libs ds_clean ds_tests

ds_all: ds_clean ds_dirs ds_libs
ds_libs: $(DS_OBJS) $(DS_TINY_LIBOUT) $(DS_LIBOUT)
ds_tests: ds_libs $(DS_TEST_OBJS)

ds_dirs: out_dirs
	@mkdir -p $(DS_BUILDDIR)
	@mkdir -p $(DS_OBJDIR)
	@mkdir -p $(DS_BINDIR)
	@mkdir -p $(DS_LIBDIR)
	@mkdir -p $(DS_TESTOBJDIR)

$(info DS_SRCS = $(DS_SRCS))
$(info DS_OBJS = $(DS_OBJS))
$(info DS_LIBS = $(DS_LIBS))
$(info DS_TEST_SRCS = $(DS_TEST_SRCS))
$(info DS_LIBDIR = $(DS_LIBDIR))
$(info DS_SRCS = $(DS_SRCS))
$(DS_TESTOBJDIR)/%.o: $(DS_TESTDIR)/%.c
	@echo DataStruct TEST OBJS
	$(CC) $(TEST_CFLAGS) $(DSTEST_INCFLAGS) -c $< -o $@

$(DS_OBJDIR)/%.o: $(DS_SRCDIR)/%.c
	@echo DataStruct OBJS
	$(CC) $(CFLAGS) $(DS_INCFLAGS) -c $< -o $@

$(DS_LIBDIR)/lib%.a: $(DS_OBJDIR)/%.o
	@echo Tiny DataStruct Libs
	ar rcs $@ $^

$(DS_LIBOUT): $(DS_OBJS)
	@echo DataStruct Lib
	ar rcs $@ $^

ds_clean:
	@$(RM) -rf $(DS_BUILDDIR)
	@$(RM) -rf $(DS_LIBDIR)