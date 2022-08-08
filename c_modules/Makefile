
include $(CMOD_DIR)/cmod_conf.mk

.PHONY: cmod_dirs cmod_all cmod_clean cmod_cleaner cmod_remake

cmod_all: cmod_cleaner cmod_dirs cmod_tests cmod_libs

cmod_dirs: out_dirs ds_dirs algo_dirs

cmod_tests: ds_tests #algo_tests
	

cmod_libs: ds_libs #algo_libs
	

#Remake
cmod_remake: cmod_cleaner all
	
#Clean only Objecst
cmod_clean: ds_clean algo_clean
	
#Full Clean, Objects and Binaries
cmod_cleaner: 
	@$(RM) -rf $(CMODBUILD_DIR)
	@$(RM) -rf $(CMODLIB_DIR)

