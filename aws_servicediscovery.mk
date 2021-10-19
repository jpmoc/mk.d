_AWS_SERVICEDISCOVERY_MK_VERSION= 0.99.0

# SDY_PARAMETER?= value

# Derived parameters

# Option parameters

# UI parameters

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _sdy_view_framework_macros
_sdy_view_framework_macros ::

_view_framework_parameters :: _sdy_view_framework_parameters
_sdy_view_framework_parameters ::

_view_framework_targets :: _sdy_view_framework_targets
_sdy_view_framework_targets ::

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?=.
-include $(MK_DIR)/aws_servicediscovery_instance.mk
-include $(MK_DIR)/aws_servicediscovery_namespace.mk
-include $(MK_DIR)/aws_servicediscovery_operation.mk
-include $(MK_DIR)/aws_servicediscovery_service.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

