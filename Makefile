export THEOS_DEVICE_IP=127.0.0.1
export THEOS_DEVICE_PORT=2222
export GO_EASY_ON_ME = 1
export ARCHS = armv7 arm64
export DEBUG = 1
TARGET := iphone:7.0:7.0

include theos/makefiles/common.mk

THEOS_BUILD_DIR = build

SUBPROJECTS = preferences
SUBPROJECTS += tweak
include $(THEOS_MAKE_PATH)/aggregate.mk

after-stage::
	$(ECHO_NOTHING)find $(THEOS_STAGING_DIR) -iname '*.plist' -exec plutil -convert binary1 {} \;$(ECHO_END)
	$(ECHO_NOTHING)find $(THEOS_STAGING_DIR) -iname '*.png' -exec pincrush -i {} \;$(ECHO_END)
	$(ECHO_NOTHING)find $(THEOS_STAGING_DIR) -name '*.DS_Store' -type f -exec rm {} \;$(ECHO_END)
after-install::
	@install.exec "killall -9 SpringBoard"