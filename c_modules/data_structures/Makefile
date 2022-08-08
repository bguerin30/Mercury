
include $(CMODCONF_DIR)/ds_conf.mk
include $(DS_TESTDIR)/Makefile

.PHONY: ds_all ds_libs ds_clean ds_tests

ds_all: ds_clean ds_dirs ds_libs

ds_tests: ds_testall
	$(DSTESTALL_TARGET)
	
ds_dirs: out_dirs
	@mkdir -p $(DS_BUILDDIR)
	@mkdir -p $(DS_OBJDIR)
	@mkdir -p $(DS_BINDIR)
	@mkdir -p $(DS_LIBDIR)
	@mkdir -p $(DSTESTALL_OBJDIR)
	@mkdir -p $(DSTESTSING_OBJDIR)

ds_libs: $(DS_LIBOUT)


$(DS_OBJDIR)/%.o: $(DS_SRCDIR)/%.c
	@echo TESTALL DS_LIBOUT OBJS
	$(CC) $(CFLAGS) $(DS_INCFLAGS) -c $< -o $@

$(DS_LIBOUT): $(DS_OBJS)
	@echo TESTALL DS_LIBOUT
	ar rcs $@ $^

ds_clean:
	@$(RM) -rf $(DS_BUILDDIR)
	@$(RM) -rf $(DS_LIBDIR)