_AWS_COGNITO_MK_VERSION=0.99.0

#----------------------------------------------------------------------
# USAGE
#

_aws_view_makefile_macros :: _cto_view_makefile_macros
_cto_view_makefile_macros ::

_aws_view_makefile_targets :: _cto_view_makefile_targets
_cto_view_makefile_targets ::

_aws_view_makefile_variables :: _cto_view_makefile_variables
_cto_view_makefile_variables ::

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

-include $(MK_DIR)/aws_cognito_identity.mk
-include $(MK_DIR)/aws_cognito_idp.mk
-include $(MK_DIR)/aws_cognito_sync.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

