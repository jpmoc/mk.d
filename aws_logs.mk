_AWS_LOGS_MK_VERSION=0.99.0

# LGS_DESTINATION_NAME_PREFIX?=
# LGS_UI_LABEL?= [logs] #

# Derived parameters
LGS_UI_LABEL?= $(AWS_UI_LABEL)

# Options
__LGS_DESTINATION_NAME_PREFIX?= $(if $(LGS_DESTINATION_NAME_PREFIX), --destination-name-prefix $(LGS_DESTINATION_NAME_PREFIX))

# Customizations

#--- Utilities

#--- MACRO

#----------------------------------------------------------------------
# USAGE
#

_aws_list_macros :: _lgs_list_macros
_lgs_list_macros ::
	@#echo 'AWS::LoGS ($(_AWS_LOGS_MK_VERSION)) macros:'
	@#echo

_aws_list_parameters :: _lgs_list_parameters
_lgs_list_parameters ::
	@echo 'AWS::LoGS ($(_AWS_LOGS_MK_VERSION)) parameters:'
	@echo '    LGS_DESTINATION_NAME_PREFIX=$(LGS_DESTINATION_NAME_PREFIX)'
	@echo '    LGS_UI_LABEL=$(LGS_UI_LABEL)'
	@echo

_aws_list_targets :: _lgs_list_targets
_lgs_list_targets ::
	@echo 'AWS::LoGS ($(_AWS_LOGS_MK_VERSION)) targets:'
	@echo '    _lgs_list_destinations               - Listing all destinations'
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

_lgs_list_destinations:
	@$(INFO) '$(AWS_UI_LABEL)Listing ALL destinations ...'; $(NORMAL)
	$(AWS) logs describe-destinations $(__LGS_DESTINATION_NAME_PREFIX) # --query "destinations[]$(_LGS_LIST_DESTINATIONS_FIELDS)"
