# current dir; where Android.mk is
LOCAL_PATH	:= $(call my-dir)
MY_ABS_PATH	:= $(abspath $(LOCAL_PATH)/../..)

# This file include sub-mk files. LOCAL_PATH becomes where the last 
# included mk file is located.
# the following variables are expanded immediately and used by all makefiles
MY_TOPDIR 			:= $(LOCAL_PATH)/../../..
MY_PARENTDIR		:= $(LOCAL_PATH)/../..
MY_EXPORTLIBDIR		:= $(LOCAL_PATH)/../lib/$(TARGET_ARCH_ABI)
MY_OBJDIR			:= $(LOCAL_PATH)/../obj/local/$(TARGET_ARCH_ABI)
MY_LOCALLIBS		:= V3D ldl colamd 
MY_EXPORTLIBS		:= $(addprefix $(MY_OBJDIR)/lib, $(addsuffix .a, $(MY_LOCALLIBS)))
MY_LIBRARY_TYPE		:= STATIC

# identify prebuilt libraries
include $(LOCAL_PATH)/Prebuilt.mk

#--- Build all libraries and executables ---
# sub-makefiles specifies buildable targets.
submks := $(addprefix $(LOCAL_PATH)/../../, \
				$(addsuffix /Android.mk, \
					V3D SuiteSparse/LDL SuiteSparse/COLAMD \
				) \
			)
include $(submks)

# defines default targets
mylib: $(MY_LOCALLIBS)						
ifeq ($(OS),Windows_NT)
	@if not exist $(MY_EXPORTLIBDIR) mkdir $(subst /,\\,$(MY_EXPORTLIBDIR))
else
	@mkdir -p $(MY_EXPORTLIBDIR)
endif
	@echo "cp $(MY_EXPORTLIBS) $(MY_EXPORTLIBDIR)"
	@cp	$(MY_EXPORTLIBS) $(MY_EXPORTLIBDIR)
   
app: mylib $(MY_LOCALAPPS)
	
all: app

# post-build
.PHONY:	debug
debug:
	@echo "MY_EXPORTLIBDIR    : $(MY_EXPORTLIBDIR)"
	@echo "MY_EXPORTLIBS      : $(MY_EXPORTLIBS)"
	@echo "MY_OBJDIR          : $(MY_OBJDIR)"
