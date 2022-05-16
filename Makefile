export ARCHS = armv7 arm64
export TARGET = iphone:clang:latest:9.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = DKFLEXLoader
DKFLEXLoader_FILES = Tweak.xm
DKFLEXLoader_FRAMEWORKS = Foundation UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

all::
	$(shell mkdir -p layout/Library/Application\ Support/DKFLEXLoader/)
	$(shell cp FLEX/build/Release-iphoneos/FLEX.framework/FLEX layout/Library/Application\ Support/DKFLEXLoader/libFLEX.dylib)
	$(shell ldid -S layout/Library/Application\ Support/DKFLEXLoader/libFLEX.dylib)


after-install::
	install.exec "killall -9 SpringBoard"
