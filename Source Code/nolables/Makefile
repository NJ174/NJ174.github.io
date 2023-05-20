TARGET := iphone:clang:15.0
INSTALL_TARGET_PROCESSES = SpringBoard

THEOS_PACKAGE_SCHEME = rootless
DEBUG = 0
FINALPACKAGE = 1


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = nolabels

nolabels_FILES = Tweak.x
nolabels_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
before-stage::
		find . -name ".DS_Store" -delete
after-install::
	install.exec "killall -9 SpringBoard"
