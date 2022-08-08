
BUILDDIR	:= build
LIBDIR		:= lib

CMOD_DIR	:= c_modules

include $(CMOD_DIR)/Makefile


.PHONY: all dirs clean remake tests libs

tests: cmod_libs cmod_tests 

libs: cmod_libs
clean: cmod_clean
dirs: out_dirs cmod_dirs
remake: cmod_remake


all: cleaner dirs tests 
	$(CMODTEST_OUT)


cleaner:
	@$(RM) -rf $(BUILDDIR)
	@$(RM) -rf $(LIBDIR)


out_dirs: 
	@mkdir -p $(LIBDIR)
	@mkdir -p $(BUILDDIR)
	@mkdir -p $(CMODBUILD_DIR)
	@mkdir -p $(CMODLIB_DIR)

	



