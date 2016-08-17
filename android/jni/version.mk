# this file is to be included in Android.mk
# Save existing LOCAL_PATH
USER_LOCAL_PATH:=$(LOCAL_PATH)

MY_LIBNAME		:=
MY_VERSION_MAJOR	:= 2
MY_VERSION_MINOR	:= 0
MY_VERSION_REVISION	:= 0


#restore the LOCAL_PATH
LOCAL_PATH:=$(USER_LOCAL_PATH)
