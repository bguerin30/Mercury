
BUILDDIR	:= build
LIBDIR		:= lib

CMOD_DIR	:= c_modules



.PHONY: all dirs clean remake tests libs

all: cleaner dirs libs

clean: cmod_clean	#pymod_clean
tests: cmod_tests  #pymod_tests
libs: cmod_libs	#pymod_libs
	@echo MAIN MakeFile cleaner


dirs: out_dirs cmod_dirs #pymod_dirs
	@echo MAIN MakeFile dirs

remake: cleaner cmod_all #pymod_all

$(info LIBDIR = $(LIBDIR))
$(info LIBDIR = $(BUILDDIR))

cleaner:
	@echo MAIN MakeFile cleaner
	@$(RM) -rf $(BUILDDIR)
	@$(RM) -rf $(LIBDIR)

out_dirs: 
	@echo MAIN MakeFile out_dirs
	@mkdir -p $(LIBDIR)
	@mkdir -p $(BUILDDIR)


-include $(CMOD_DIR)/cmod_makefile.mk
-include $(PYMOD_DIR)/pymod_makefile.mk
	



