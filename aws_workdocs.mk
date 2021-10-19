_AWS_WORKDOCS_MK_VERSION= 0.99.6

# WDS_AUTH_TOKEN?=

# Derived parameters

# Option parameters

# UI parameters

#--- Utilities

#--- MACROS
_wds_get_authtoken_user_T= $(shell $(AWS) workdocs get-current-user --authentication-token $(1))

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _wds_view_framework_macros
_wds_view_framework_macros ::
	@echo 'AWS::WorkDocS ($(_AWS_WORKDOCS_MK_VERSION)) macros:'
	@echo '    _wds_get_authtoken_user                - Get the user embedded in the authentication token'
	@echo

_aws_view_framework_parameters :: _wds_view_framework_parameters
_wds_view_framework_parameters ::
	@echo 'AWS::WorkDocS ($(_AWS_WORKDOCS_MK_VERSION)) parameters:'
	@echo '    WDS_CURRENTUSER=$(WDS_CURRENTUSER)'
	@echo

_aws_view_framework_targets :: _wds_view_framework_targets
_wds_view_framework_targets ::
	@echo 'AWS::WorkDocS ($(_AWS_WORKDOCS_MK_VERSION)) targets:'
	@echo '    _wds_view_activities                   - View site acitvities'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_workdocs_comment.mk
-include $(MK_DIR)/aws_workdocs_document.mk
-include $(MK_DIR)/aws_workdocs_metadata.mk
-include $(MK_DIR)/aws_workdocs_folder.mk
-include $(MK_DIR)/aws_workdocs_labels.mk
-include $(MK_DIR)/aws_workdocs_notificationsubscription.mk
-include $(MK_DIR)/aws_workdocs_user.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#






_wds_view_activities:
	@$(INFO) '$(AWS_UI_LABEL)View activities ...'; $(NORMAL)
	$(AWS) workdocs describe-activities $(__WDS_AUTHENTICATION_TOKEN) $(__WDS_END_TIME) $(__WDS_LIMIT) $(__WDS_MARKER) $(__WDS_ORGANIZATION_ID) $(__WDS_START_TIME) $(__WDS_USER_ID)
