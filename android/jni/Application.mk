#APP_STL	:= gnustl_shared
#APP_ABI	:= armeabi-v7a

APP_STL := gnustl_static
APP_CPPFLAGS := -frtti -fexceptions
APP_CFLAGS	+= -Wno-error=format-security
APP_ABI := armeabi-v7a 
APP_PLATFORM	:= android-16
APP_OPTIM := release
