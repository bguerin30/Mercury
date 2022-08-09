






.PHONY: ds_all ds_clean ds_tests

ds_all: ds_clean ds_libs
	@echo DataStruct MakeFile ds_all

ds_libs: $(DS_OBJS) $(DS_TINY_LIBOUT) $(DS_LIBOUT)
	@echo DS MakeFile ds_libs

ds_tests: ds_libs $(DS_TEST_OBJS)
	@echo DataStruct MakeFile ds_libs

$(DS_OBJDIR)/%.o: $(CMODSRC_DIR)/$(DS_FOLDER)/%.c
	@echo DataStruct MakeFile OBJS
	$(CC) $(CFLAGS) $(CMOD_INCFLAGS) -c $< -o $@
	
$(DS_OBJDIR)/%.o: $(CMODSRC_DIR)/$(DS_FOLDER)/%.c
	@echo DataStruct MakeFile OBJS
	$(CC) $(CFLAGS) $(CMOD_INCFLAGS) -c $< -o $@

$(DS_LIBDIR)/lib%.a: $(CMODOBJ_DIR)/%.o
	@echo DS MakeFile $@
	ar rcs $@ $^


ds_clean:
	@$(RM) -rf $(DS_BUILDDIR)
	@$(RM) -rf $(DS_LIBDIR)