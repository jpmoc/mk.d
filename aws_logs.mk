_AWS_LOGS_MK_VERSION=0.99.0

# LGS_DESTINATION_NAME_PREFIX?=

# Derived parameters

# Options parameters
__LGS_DESTINATION_NAME_PREFIX?= $(if $(LGS_DESTINATION_NAME_PREFIX), --destination-name-prefix $(LGS_DESTINATION_NAME_PREFIX))

# UI parameters

#--- Utilities

#--- MACRO

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _lgs_view_framework_macros
_lgs_view_framework_macros ::
	@#echo 'AWS::LoGS ($(_AWS_LOGS_MK_VERSION)) macros:'
	@#echo

_aws_view_framework_parameters :: _lgs_view_framework_parameters
_lgs_view_framework_parameters ::
	@echo 'AWS::LoGS ($(_AWS_LOGS_MK_VERSION)) parameters:'
	@echo '    LGS_DESTINATION_NAME_PREFIX=$(LGS_DESTINATION_NAME_PREFIX)'
	@echo

_aws_view_framework_targets :: _lgs_view_framework_targets
_lgs_view_framework_targets ::
	@echo 'AWS::LoGS ($(_AWS_LOGS_MK_VERSION)) targets:'
	@echo '    _lgs_view_destinations               - View existing destinations'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_logs_event.mk
-include $(MK_DIR)/aws_logs_loggroup.mk
-include $(MK_DIR)/aws_logs_stream.mk
-include $(MK_DIR)/aws_logs_subscriptionfilter.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_lgs_view_destinations:
	@$(INFO) '$(AWS_UI_LABEL)Viewing existing destinations ...'; $(NORMAL)
	$(AWS) logs describe-destinations $(__LGS_DESTINATION_NAME_PREFIX) # --query "destinations[]$(LGS_UI_VIEW_DESTINATIONS_FIELDS)"
