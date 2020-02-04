TARGET_PROVIDES_INIT_RC := true
CONFIG_ESD := no
HTTP := android

MAJOR_VERSION := $(word 1,$(subst ., ,$(PLATFORM_VERSION)))

PRODUCT_PACKAGES += \
	b2g.sh \
	b2g-info \
	b2g-prlimit \
	b2g-ps \
	bluetoothd \
	gonksched \
	init.bluetooth.rc \
	fakeappops \
	fs_config \
	init.rc \
	init.b2g.rc \
	killer \
	libttspico \
	rild \
	rilproxy \
	sensorsd \
	oom-msg-logger \
	node \
	gecko \
	gaia \
	$(NULL)

#gaia \
#	gecko \
#	gaia \


# List NPM packages below. Downloading these packages will require
# a network connection at build time.
#system_npm
 PRODUCT_PACKAGES += \
	socket.io \
	npm \
	ssh2 \
	xterm \
	express \
	$(NULL)



##privoxy
 PRODUCT_PACKAGES += \
	privoxy \
	config \
	match-all.action \
	user.action \
	user.filter \
	default.action \
	default.filter \
	trust \
	templates/blocked \
	templates/cgi-error-404 \
	templates/cgi-error-bad-param \
	templates/cgi-error-disabled \
	templates/cgi-error-file \
	templates/cgi-error-file-read-only \
	templates/cgi-error-modified \
	templates/cgi-error-parse \
	templates/cgi-style.css \
	templates/connect-failed \
	templates/connection-timeout \
	templates/default \
	templates/edit-actions-add-url-form \
	templates/edit-actions-for-url \
	templates/edit-actions-for-url-filter \
	templates/edit-actions-list \
	templates/edit-actions-list-button \
	templates/edit-actions-list-section \
	templates/edit-actions-list-url \
	templates/edit-actions-remove-url-form \
	templates/edit-actions-url-form \
	templates/forwarding-failed \
	templates/gen-templates-for-make.sh \
	templates/mod-local-help \
	templates/mod-support-and-service \
	templates/mod-title \
	templates/mod-unstable-warning \
	templates/no-server-data \
	templates/no-such-domain \
	templates/show-request \
	templates/show-status \
	templates/show-status-file \
	templates/show-url-info \
	templates/show-version \
	templates/toggle \
	templates/toggle-mini \
	templates/untrusted \
	templates/url-info-osd.xml \
	$(NULL)


##python
# PRODUCT_PACKAGES += \
#	python3.6 \
#	$(NULL)

##system_devicesvcd
 PRODUCT_PACKAGES += \
	devicesvcd \
	devicesvcd-data \
	init.devicesvc.rc \
	$(NULL)

##intd.sh
 PRODUCT_PACKAGES += \
	intd.sh \
	sshd-server.js \
	$(NULL)

##SSR
 PRODUCT_PACKAGES += \
	ss-local \
	SSR-server.js \
	SSR-test-client.js \
	$(NULL)



ifneq ($(filter-out 0 1 2 3 4,$(MAJOR_VERSION)),)
BOARD_SEPOLICY_DIRS += \
	gonk-misc/sepolicy

BOARD_SEPOLICY_UNION += \
	b2g.te \
	bluetoothd.te \
	fakeappops.te \
	gonksched.te \
	nfcd.te \
	plugin-container.te \
	rilproxy.te \
	sensorsd.te \
	file.te \
	file_contexts
endif

-include external/svox/pico/lang/all_pico_languages.mk
-include gaia/gaia.mk

ifeq ($(B2G_VALGRIND),1)
include external/valgrind/valgrind.mk
endif

ifeq ($(ENABLE_DEFAULT_BOOTANIMATION),true)
ifeq ($(BOOTANIMATION_ASSET_SIZE),)
	BOOTANIMATION_ASSET_SIZE := hvga
endif
ifeq ($(MOZILLA_OFFICIAL),1)
	BOOTANIMATION_PATH := bootanimations/official
else
	BOOTANIMATION_PATH := bootanimations/unofficial
endif
BOOTANIMATION_ASSET := $(BOOTANIMATION_PATH)/bootanimation_$(BOOTANIMATION_ASSET_SIZE).zip
PRODUCT_COPY_FILES += \
	gonk-misc/$(BOOTANIMATION_ASSET):system/media/bootanimation.zip
endif

ifeq ($(ENABLE_LIBRECOVERY),true)
PRODUCT_PACKAGES += \
  librecovery
endif

ifneq ($(DISABLE_SOURCES_XML),true)
PRODUCT_PACKAGES += \
	sources.xml
endif

ifeq ($(ENABLE_NGINX),true)
PRODUCT_PACKAGES +=           \
	nginx                 \
	nginx/nginx.conf      \
	nginx/mime.types      \
	nginx/html/index.html \
	nginx/html/50x.html

PRODUCT_PROPERTY_OVERRIDES += \
	ro.moz.httpd=1
endif # ENABLE_NGINX
