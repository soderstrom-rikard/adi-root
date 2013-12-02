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
BUILDROOT_DIR=${SOURCES_DIR}/buildroot
KERNEL_DIR=${BUILDROOT_DIR}/linux/linux-kernel
BuildToolChain=${TOOLCHAIN_DIR}/buildscript/BuildToolChain
BUILD_DIR?=${ROOT_DIR}/build
UBOOT_BUILDDIR?=${BUILD_DIR}/u-boot
BUILDROOT_BUILDDIR?=${BUILD_DIR}/buildroot

all: toolchain u-boot buildroot
	@echo ${BuildToolChain}

toolchain: toolchain_patches
	${BuildToolChain} -p
	mkdir -p ${BUILD_DIR}
	${BuildToolChain} \
		-b ${BUILD_DIR} \
		-k ${KERNEL_DIR} \
		-s ${TOOLCHAIN_DIR} \
		-u ${UBOOT_DIR} \
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

buildroot:
ifneq ($(BOARD),)
	@mkdir -p $(BUILDROOT_BUILDDIR)
	@cd ${BUILDROOT_DIR} && \
		make O=${BUILDROOT_BUILDDIR} distclean && \
		make O=${BUILDROOT_BUILDDIR} $(BOARD)_defconfig && \
		make O=${BUILDROOT_BUILDDIR} all
else
	@echo "Please use syntax \"make BOARD=<board> buildroot\""
endif

print_env:
	@echo ROOT_DIR=${ROOT_DIR}
	@echo PATCHES_DIR=${PATCHES_DIR}
	@echo SOURCES_DIR=${SOURCES_DIR}
	@echo TOOLCHAIN_DIR=${TOOLCHAIN_DIR}
	@echo UBOOT_DIR=${UBOOT_DIR}
	@echo BUILDROOT_DIR=${BUILDROOT_DIR}
	@echo KERNEL_DIR=${KERNEL_DIR}
	@echo BuildToolChain=${BuildToolChain}
	@echo BUILD_DIR=${BUILD_DIR}
	@echo UBOOT_BUILDDIR=${UBOOT_BUILDDIR}
	@echo BUILDROOT_BUILDDIR=${BUILDROOT_BUILDDIR}

