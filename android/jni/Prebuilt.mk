# feature_association/android/jni/Prebuilt.mk
# Pre-built libraries; must list one a time        

# vtlapack
include $(CLEAR_VARS)
LOCAL_MODULE := libclapack 
LOCAL_SRC_FILES := ../../../vtlapack/android/lib/$(TARGET_ARCH_ABI)/libclapack.a 
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libf2c 
LOCAL_SRC_FILES := ../../../vtlapack/android/lib/$(TARGET_ARCH_ABI)/libf2c.a 
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libblas 
LOCAL_SRC_FILES := ../../../vtlapack/android/lib/$(TARGET_ARCH_ABI)/libblas.a 
include $(PREBUILT_STATIC_LIBRARY)

# FeautreDescritorLib
include $(CLEAR_VARS)
LOCAL_MODULE := libFeatureDescriptorLib
LOCAL_SRC_FILES := ../../../FeatureDescriptorLib/android/lib/$(TARGET_ARCH_ABI)/libFeatureDescriptorLib.a 
include $(PREBUILT_STATIC_LIBRARY)

# rknave
include $(CLEAR_VARS)
LOCAL_MODULE := librknave 
LOCAL_SRC_FILES := ../../../rknave/android/lib/$(TARGET_ARCH_ABI)/librknave.a 
include $(PREBUILT_STATIC_LIBRARY)

# db
include $(CLEAR_VARS)
LOCAL_MODULE := libdb 
LOCAL_SRC_FILES := ../../../db/android/lib/$(TARGET_ARCH_ABI)/libdb.a 
include $(PREBUILT_STATIC_LIBRARY)

# ARComms
include $(CLEAR_VARS)
LOCAL_MODULE := libARComms 
LOCAL_SRC_FILES := ../../../ARComms/android/lib/$(TARGET_ARCH_ABI)/libARComms.a 
include $(PREBUILT_STATIC_LIBRARY)

# boost
include $(CLEAR_VARS)
LOCAL_MODULE := libboost_thread 
LOCAL_SRC_FILES := ../../../../opensw/android-boost/lib/$(TARGET_ARCH_ABI)/libboost_thread.a 
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libboost_filesystem
LOCAL_SRC_FILES := ../../../../opensw/android-boost/lib/$(TARGET_ARCH_ABI)/libboost_filesystem.a 
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libboost_system
LOCAL_SRC_FILES := ../../../../opensw/android-boost/lib/$(TARGET_ARCH_ABI)/libboost_system.a 
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libboost_timer
LOCAL_SRC_FILES := ../../../../opensw/android-boost/lib/$(TARGET_ARCH_ABI)/libboost_timer.a 
include $(PREBUILT_STATIC_LIBRARY)
		
include $(CLEAR_VARS)
LOCAL_MODULE := libboost_chrono
LOCAL_SRC_FILES := ../../../../opensw/android-boost/lib/$(TARGET_ARCH_ABI)/libboost_chrono.a 
include $(PREBUILT_STATIC_LIBRARY)
		
include $(CLEAR_VARS)
LOCAL_MODULE := libboost_date_time
LOCAL_SRC_FILES := ../../../../opensw/android-boost/lib/$(TARGET_ARCH_ABI)/libboost_date_time.a 
include $(PREBUILT_STATIC_LIBRARY)
	