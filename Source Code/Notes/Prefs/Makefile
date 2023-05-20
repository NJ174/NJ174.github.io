include $(THEOS)/makefiles/common.mk
ARCHS = arm64 arm64e
export TARGET = iphone:clang:15.0:15.0
BUNDLE_NAME = NotesPrefs

SOURCES  = $(shell find . -name '*.m')

NotesPrefs_FILES = $(SOURCES)
NotesPrefs_FRAMEWORKS = UIKit
NotesPrefs_PRIVATE_FRAMEWORKS = Preferences
NotesPrefs_INSTALL_PATH = /Library/PreferenceBundles
NotesPrefs_CFLAGS = -fobjc-arc -Wno-deprecated-declarations

include $(THEOS_MAKE_PATH)/bundle.mk
