export ARCHS = armv7 arm64
export TARGET = iphone:clang:latest:7.0

include theos/makefiles/common.mk

TWEAK_NAME = DKFLEXLoader
DKFLEXLoader_FILES = Tweak.xm
DKFLEXLoader_FRAMEWORKS = Foundation UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

all::
	$(shell mkdir -p layout/Library/Application\ Support/DKFLEXLoader/)
	$(shell cp bin/universal/libFLEX.dylib layout/Library/Application\ Support/DKFLEXLoader/)

after-install::
	install.exec "killall -9 SpringBoard"
