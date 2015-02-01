#!/bin/sh -e

DIR=$PWD

config_enable () {
	ret=$(./scripts/config --state ${config})
	if [ ! "x${ret}" = "xy" ] ; then
		echo "Setting: ${config}=y"
		./scripts/config --enable ${config}
	fi
}

config_disable () {
	ret=$(./scripts/config --state ${config})
	if [ ! "x${ret}" = "xn" ] ; then
		echo "Setting: ${config}=n"
		./scripts/config --disable ${config}
	fi
}

config_module () {
	ret=$(./scripts/config --state ${config})
	if [ ! "x${ret}" = "xm" ] ; then
		echo "Setting: ${config}=m"
		./scripts/config --module ${config}
	fi
}

config_string () {
	ret=$(./scripts/config --state ${config})
	if [ ! "x${ret}" = "x${option}" ] ; then
		echo "Setting: ${config}=${option}"
		./scripts/config --set-str ${config} ${option}
	fi
}

config_value () {
	ret=$(./scripts/config --state ${config})
	if [ ! "x${ret}" = "x${option}" ] ; then
		echo "Setting: ${config}=${option}"
		./scripts/config --set-val ${config} ${option}
	fi
}

cd ${DIR}/KERNEL/

#http://anonscm.debian.org/viewvc/kernel/dists/trunk/linux/debian/config/armhf/config.lpae?view=markup

##
## file: arch/arm/Kconfig
##
CONFIG_ARM_DMA_IOMMU_ALIGNMENT=8

##
## file: arch/arm/kvm/Kconfig
##
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=y

##
## file: arch/arm/mm/Kconfig
##
CONFIG_ARM_LPAE=y

##
## file: drivers/iommu/Kconfig
##
CONFIG_ARM_SMMU=y

config="CONFIG_ARM_DMA_IOMMU_ALIGNMENT" ; option="8" ; config_value
config="CONFIG_VIRTUALIZATION" ; config_enable
config="CONFIG_KVM" ; config_enable
config="CONFIG_ARM_LPAE" ; config_enable
config="CONFIG_ARM_SMMU" ; config_enable

###############

#
# CPU Core family selection
#
config="CONFIG_ARCH_MXC" ; config_disable

#
# OMAP Feature Selections
#
config="CONFIG_ARCH_OMAP3" ; config_disable
config="CONFIG_ARCH_OMAP4" ; config_disable
config="CONFIG_SOC_AM33XX" ; config_disable
config="CONFIG_SOC_AM43XX" ; config_disable

#
# OMAP Legacy Platform Data Board Type
#
config="CONFIG_MACH_SUN4I" ; config_disable
config="CONFIG_MACH_SUN5I" ; config_disable

#
# Processor Features
#
config="CONFIG_ARM_ERRATA_430973" ; config_disable

#
# Argus cape driver for beaglebone black
#
config="CONFIG_CAPE_BONE_ARGUS" ; config_disable
config="CONFIG_BEAGLEBONE_PINMUX_HELPER" ; config_disable

#
# Graphics support
#
config="CONFIG_IMX_IPUV3_CORE" ; config_disable

config="CONFIG_DRM_TILCDC" ; config_disable
config="CONFIG_DRM_IMX" ; config_disable
config="CONFIG_DRM_ETNAVIV" ; config_disable

#
