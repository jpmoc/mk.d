_AZ_GROUP_MK_VERSION= 0.99.1

# GRP_INPUTS_DIRPATH?=
# GRP_LOCATION_ID?=
# GRP_MODE_NOWAIT?= false
# GRP_MODE_YES?= false
# GRP_OUTPUT_FORMAT?= table
# GRP_OUTPUTS_DIRPATH?=
# GRP_SUBSCRIPTION_ID_OR_NAME?=

# Derived parameters
GRP_INPUTS_DIRPATH?= $(AZ_INPUTS_DIRPATH)
GRP_LOCATION_ID?= $(AZ_LOCATION_ID)
GRP_MODE_NOWAIT?= $(AZ_MODE_NOWAIT)
GRP_MODE_YES?= $(AZ_MODE_YES)
GRP_OUTPUT_FORMAT?= $(AZ_OUTPUT_FORMAT)
GRP_OUTPUTS_DIRPATH?= $(AZ_OUTPUTS_DIRPATH)
GRP_SUBSCRIPTION_ID?= $(AZ_SUBSCRIPTION_ID)
GRP_SUBSCRIPTION_ID_OR_NAME?= $(AZ_SUBSCRIPTION_ID_OR_NAME)

# Options parameters
__GRP_OUTPUT?= $(if $(GRP_OUTPUT_FORMAT),--output $(GRP_OUTPUT_FORMAT))
__GRP_SUBSCRIPTION?= $(if $(GRP_SUBSCRIPTION_ID_OR_NAME),--subscription $(GRP_SUBSCRIPTION_ID_OR_NAME))

___GRP_GLOBALS?= $(__GRP_OUTPUT) $(__GRP_SUBSCRIPTION)

# UI parameters
GRP_UI_LABEL?= $(AZ_UI_LABEL)

#--- Utilities

#--- MACRO

#----------------------------------------------------------------------
# USAGE
#

_az_view_framework_macros :: _grp_view_framework_macros
_grp_view_framework_macros ::
	@#echo 'AZ::GRouP ($(_AZ_GROUP_MK_VERSION)) macros:'
	@#echo

_az_view_framework_parameters :: _grp_view_framework_parameters
_grp_view_framework_parameters ::
	@echo 'AZ::GRouP ($(_AZ_GROUP_MK_VERSION)) parameters:'
	@echo '    GRP_INPUTS_DIRPATH=$(GRP_INPUTS_DIRPATH)'
	@echo '    GRP_LOCATION_ID=$(GRP_LOCATION_ID)'
	@echo '    GRP_MODE_NOWAIT=$(GRP_MODE_NOWAIT)'
	@echo '    GRP_MODE_YES=$(GRP_MODE_YES)'
	@echo '    GRP_OUTPUT_FORMAT=$(GRP_OUTPUT_FORMAT)'
	@echo '    GRP_OUTPUTS_DIRPATH=$(GRP_OUTPUTS_DIRPATH)'
	@echo '    GRP_SUBSCRIPTION_ID=$(GRP_SUBSCRIPTION_ID)'
	@echo '    GRP_SUBSCRIPTION_ID_OR_NAME=$(GRP_SUBSCRIPTION_ID_OR_NAME)'
	@echo

_az_view_framework_targets :: _grp_view_framework_targets
_grp_view_framework_targets ::
	@echo 'AZ::GRouP ($(_AZ_GROUP_MK_VERSION)) targets:'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/az_group_deployment.mk
-include $(MK_DIR)/az_group_lock.mk
-include $(MK_DIR)/az_group_resourcegroup.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
