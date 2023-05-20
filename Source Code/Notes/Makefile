export ARCHS = arm64 arm64e
export TARGET = iphone:clang:15.0:15.0

THEOS_PACKAGE_SCHEME = rootless
FINALPACKAGE = 1
DEBUG = 0


INSTALL_TARGET_PROCESSES = SpringBoard
SUBPROJECTS += Tweak Prefs

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/aggregate.mk

after-stage::
	find . -name ".DS_STORE" -delete
after-install::
	install.exec "killall -9 SpringBoard"
