_AWSLOGS_MK_VERSION= 0.99.4

# ALS_ACCESS_KEY_ID?=
ALS_MODE_COLOR?= auto
# ALS_PROFILE?= <aws-profile>
# ALS_SECRET_ACCESS_KEY?=

# Derived parameters
ALS_PROFILE?= $(AWS_PROFILE)
ALS_REGION?= $(AWS_REGION)

# Option parameters

# UI parameters
ALS_UI_LABEL?= [awslog] #

#--- Utilities
__AWSLOGS_OPTIONS+= $(if $(ALS_ACCESS_KEY_ID),--aws-access-key-id $(ALS_ACCESS_KEY_ID))
__AWSLOGS_OPTIONS+= $(if $(ALS_MODE_COLOR),--color=$(ALS_MODE_COLOR))
__AWSLOGS_OPTIONS+= $(if $(ALS_PROFILE),--profile=$(ALS_PROFILE))
__AWSLOGS_OPTIONS+= $(if $(ALS_REGION),--region=$(ALS_PROFILE))
__AWSLOGS_OPTIONS+= $(if $(ALS_SECRET_ACCESS_KEY),--aws-secret-access-key $(ALS_SECRET_ACCESS_KEY))

AWSLOGS_BIN?= awslogs
AWSLOGS?= $(strip $(__AWSLOGS_ENVIRONMENT) $(AWSLOGS_ENVIRONMENT) $(AWSLOGS_BIN) $(__AWSLOGS_OPTIONS) $(AWSLOGS_OPTIONS))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_install_framework_dependencies :: _als_install_framework_dependencies
_als_install_framework_dependencies ::
	# Install docs at https://github.com/jorgebastida/awslogs
	sudo pip install awslogs
	which awslogs
	# /usr/local/bin/awslogs

_view_framework_macros :: _als_view_framework_macros
_als_view_framework_macros ::
	@#echo 'AwsLogS ($(_AWSLOGS_MK_VERSION)) macros:'
	@#echo

_view_framework_parameters :: _als_view_framework_parameters
_als_view_framework_parameters ::
	@echo 'AwsLogS ($(_AWSLOGS_MK_VERSION)) parameters:'
	@echo '    ALS_ACCESS_KEY_ID=$(ALS_ACCESS_KEY_ID)'
	@echo '    ALS_PROFILE=$(ALS_PROFILE)'
	@echo '    ALS_REGION=$(ALS_REGION)'
	@echo '    ALS_SECRET_ACCESS_KEY=$(ALS_SECRET_ACCESS_KEY)'
	@echo '    AWSLOGS=$(AWSLOGS)'
	@echo

_view_framework_targets :: _als_view_framework_targets
_als_view_framework_targets ::
	@echo 'AwsLogS ($(_AWSLOGS_MK_VERSION)) targets:'
	@echo '    _als_show_version               - Show the current version of awslogs'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/awslogs_loggroup.mk
-include $(MK_DIR)/awslogs_stream.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_als_show_version:
	@$(INFO) '$(ALS_UI_LABEL)Show installed version of awslog ...'; $(NORMAL)
	# The latest version at the time of this writing was 0.11.0
	awslogs --version
