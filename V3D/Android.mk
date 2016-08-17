# ssba/V3D
# builds libV3D.a
LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE	:= V3D
#LOCAL_CFLAGS	:= -fPIC -D_ANDROID_BUILD -D_ANDROID_DEBUG_BUILD -std=c++11 -fexceptions
LOCAL_CPPFLAGS 	+= 
LOCAL_SRC_FILES	:= \
	../Math/v3d_nonlinlsq.cpp \
    ../Math/v3d_optimization.cpp \
    ../Math/v3d_optimization_lm.cpp \
	../Geometry/v3d_metricbundle.cpp \
    ../Geometry/v3d_stereobundle.cpp

LOCAL_C_INCLUDES:= \
	$(LOCAL_PATH)/../ $(LOCAL_PATH)/../Base/ $(LOCAL_PATH)/../Math/ $(LOCAL_PATH)/../Geometry/

ifeq ($(MY_LIBRARY_TYPE), STATIC)
	LOCAL_STATIC_LIBRARIES	:= 
	include $(BUILD_STATIC_LIBRARY)
else
	LOCAL_SHARED_LIBRARIES	:=
 	LOCAL_STATIC_LIBRARIES	:=  								
	include $(BUILD_SHARED_LIBRARY)
endif
