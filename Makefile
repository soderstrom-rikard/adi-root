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
BuildToolChain="${TOOLCHAIN_DIR}/buildscript/BuildToolChain"

all: toolchain
	@echo ${BuildToolChain}

toolchain: toolchain_patches
	${BuildToolChain} -p
	mkdir -p ${ROOT_DIR}/build
	${BuildToolChain} \
		-b ${ROOT_DIR}/build \
		-k ${ROOT_DIR}/sources/uclinux \
		-s ${ROOT_DIR}/sources/toolchain \
		-u ${ROOT_DIR}/sources/u-boot \
		-j 1


toolchain_patches: .patch.BuildToolChain.applied

.patch.BuildToolChain.applied:
	patch --directory ${TOOLCHAIN_DIR} ${BuildToolChain} ${PATCHES_DIR}/BuildToolChain.patch -t
	touch $@

print_env:
	@echo ROOT_DIR=${ROOT_DIR}
	@echo PATCHES_DIR=${ROOT_DIR}
	@echo SOURCES_DIR=${ROOT_DIR}
	@echo TOOLCHAIN_DIR=${SOURCES_DIR}
	@echo BuildToolChain=${BuildToolChain}
	@

