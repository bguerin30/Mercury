
BUILDDIR	:= build
LIBDIR		:= lib

CMOD_DIR	:= c_modules



.PHONY: all dirs clean cleaner remake 

all: cleaner dirs libs tests
	@echo -----------  MAIN MakeFile all

clean: cmod_clean	#pymod_clean
	@echo -----------  MAIN MakeFile clean

tests: cmod_tests  #pymod_tests
	@echo -----------  MAIN MakeFile tests

libs: cmod_libs	#pymod_libs
	@echo -----------  MAIN MakeFile cleaner

dirs: out_dirs cmod_dirs #pymod_dirs
	@echo -----------  MAIN MakeFile dirs

out_dirs: 
	@echo -----------  MAIN MakeFile out_dirs
	@mkdir -p $(LIBDIR)
	@mkdir -p $(BUILDDIR)

remake: clean libs tests
	@echo -----------  MAIN MakeFile dirs

cleaner: cmod_cleaner
	@echo -----------  MAIN MakeFile cleaner
	@$(RM) -rf $(BUILDDIR)
	@$(RM) -rf $(LIBDIR)

-include $(CMOD_DIR)/cmod_makefile.mk
-include $(PYMOD_DIR)/pymod_makefile.mk
	



