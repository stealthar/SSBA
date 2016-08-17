# ssba/ldl
# builds libldl.a
LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE	:= ldl
#LOCAL_CFLAGS	:= -fPIC -D_ANDROID_BUILD -D_ANDROID_DEBUG_BUILD -std=c++11 -fexceptions
LOCAL_CPPFLAGS 	+= 
LOCAL_SRC_FILES	:= \
	./Source/ldl.c \
	./Source/ldl_l.c

LOCAL_C_INCLUDES:= \
	$(LOCAL_PATH)/Include/ $(LOCAL_PATH)/../UFconfig/
	
ifeq ($(MY_LIBRARY_TYPE), STATIC)
	LOCAL_STATIC_LIBRARIES	:= 
	include $(BUILD_STATIC_LIBRARY)
else
	LOCAL_SHARED_LIBRARIES	:=
 	LOCAL_STATIC_LIBRARIES	:=  								
	include $(BUILD_SHARED_LIBRARY)
endif
