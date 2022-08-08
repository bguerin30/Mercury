
include $(CMODCONF_DIR)/algo_conf.mk

.PHONY: algo_all algo_libs algo_clean

algo_all: algo_clean algo_dirs algo_tests algo_libs

algo_tests:
	$(MAKE) -C utests all

algo_dirs: out_dirs
	@mkdir -p $(ALGO_BUILDDIR)
	@mkdir -p $(ALGO_OBJDIR)
	@mkdir -p $(ALGO_BINDIR)
	@mkdir -p $(ALGO_LIBDIR)
	@mkdir -p $(ALGO_TESTALLOBJDIR)
	@mkdir -p $(ALGO_TESTSINGLEOBJDIR)

algo_libs: $(ALGO_LIBOUT)


$(ALGO_OBJDIR)/%.o: $(ALGO_SRCDIR)/%.c
	$(CC) $(ALGO_CFLAGS) $(ALGO_INCFLAGS) -c $< -o $@ $(ALGO_LIBFLAGS)

$(ALGO_LIBOUT): $(ALGO_OBJS)
	ar rvs $@ $^

algo_clean:
	@$(RM) -rf $(ALGO_BUILDDIR)
	@$(RM) -rf $(ALGO_LIBDIR)