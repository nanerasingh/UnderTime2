ARCHS = arm64
TARGET = iphone:clang:latest

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = UnderTime
UnderTime_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += UnderTime
include $(THEOS_MAKE_PATH)/aggregate.mk
