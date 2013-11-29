### VARIABLE = value
### Normal setting of a variable - values within it are recursively expanded when the variable is used, not when it's declared
### 
### VARIABLE := value
### Setting of a variable with simple expansion of the values inside - values within it are expanded at declaration time.
### 
### VARIABLE ?= value
### Setting of a variable only if it doesn't have a value
### 
### VARIABLE += value
### Appending the supplied value to the existing value
### 
ROOT_DIR?=${PWD}
PATCHES_DIR=${ROOT_DIR}/patches
SOURCES_DIR=${ROOT_DIR}/sources
TOOLCHAIN_DIR=${SOURCES_DIR}/toolchain
UBOOT_DIR=${SOURCES_DIR}/u-boot
BuildToolChain="${TOOLCHAIN_DIR}/buildscript/BuildToolChain"
BUILD_DIR?=${ROOT_DIR}/build
UBOOT_BUILDDIR?=${BUILD_DIR}/u-boot

all: toolchain
	@echo ${BuildToolChain}

toolchain: toolchain_patches
	${BuildToolChain} -p
	mkdir -p ${BUILD_DIR}
	${BuildToolChain} \
		-b ${BUILD_DIR} \
		-k ${SOURCES_DIR}/uclinux \
		-s ${SOURCES_DIR}/toolchain \
		-u ${SOURCES_DIR}/u-boot \
		-j 1


toolchain_patches: .patch.BuildToolChain.applied

.patch.BuildToolChain.applied:
	patch --directory ${TOOLCHAIN_DIR} ${BuildToolChain} ${PATCHES_DIR}/BuildToolChain.patch -t
	touch $@

u-boot:
ifneq ($(BOARD),)
	@mkdir -p $(UBOOT_BUILDDIR)
	@cd ${UBOOT_DIR} && \
		make O=${UBOOT_BUILDDIR} distclean && \
		make O=${UBOOT_BUILDDIR} $(BOARD)_config && \
		make O=${UBOOT_BUILDDIR} all
else
	@echo "Please use syntax \"make BOARD=<board> u-boot\""
endif

print_env:
	@echo ROOT_DIR=${ROOT_DIR}
	@echo PATCHES_DIR=${ROOT_DIR}
	@echo SOURCES_DIR=${ROOT_DIR}
	@echo TOOLCHAIN_DIR=${SOURCES_DIR}
	@echo UBOOT_DIR=${UBOOT_DIR}
	@echo BuildToolChain=${BuildToolChain}
	@echo BUILD_DIR?=${BUILD_DIR}
	@echo UBOOT_BUILDDIR?=${UBOOT_BUILDDIR}
	@

