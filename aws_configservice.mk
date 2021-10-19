_AWS_CONFIGSERVICE_MK_VERSION=0.99.0

# CSE_RECORDER_RECORDING_GROUP?= allSupported=true,includeGlobalResourceTypes=true
# CSE_RECORDER_RECORDING_GROUP_FILEPATH?= ./my-recording-group.json
CSE_RECORDER_NAME?= default
# CSE_RECORDER_ROLE_ARN?= arn:aws:iam::123456789012:role/config-role

# Derived variables
CSE_RECORDER_RECORDING_GROUP?= $(if $(CSE_RECORDER_RECORDING_GROUP_FILEPATH), file://$(CSE_RECORDER_RECORDING_GROUP_FILEPATH))
CSE_RECORDER_NAMES?= $(CSE_RECORD_NAME)
CSE_RECORDER_ROLE_ARN?= arn:aws:iam::$(AWS_ACCOUNT_ID):role/config-role

# Options variables
__CSE_CONFIGURATION_RECORDER?= $(if $(CSE_RECORDER_NAME), --configuration-recorder name=$(CSE_RECORDER_NAME)$(COMMA)roleARN=$(CSE_RECORDER_ROLE_ARN))
__CSE_CONFIGURATION_RECORDER_NAME?= $(if $(CSE_RECORDER_NAME), --configuration-recorder-name $(CSE_RECORDER_NAME))
__CSE_CONFIGURATION_RECORDER_NAMES?= $(if $(CSE_RECORDER_NAMES), --configuration-recorder-names $(CSE_RECORDER_NAMES))
__CSE_RECORDING_GROUP?= $(if $(CSE_RECORDER_RECORDING_GROUP), --recording-group $(CSE_RECORDER_RECORDING_GROUP))

# UI variables

#--- Utilities

#--- MACRO

#----------------------------------------------------------------------
# USAGE
#

_aws_view_makefile_macros :: _cse_view_makefile_macros
_cse_view_makefile_macros :: ;
	@echo "AWS::ConfigServicE ($(_AWS_CONFIGSERVICE_MK_VERSION)) macros:"
	@echo

_aws_view_makefile_targets :: _cse_view_makefile_targets
_cse_view_makefile_targets ::
	@echo "AWS::ConfigService ($(_AWS_CONFIGSERVICE_MK_VERSION)) targets:"
	@echo "    _cse_show_recorder_status      - Show the status of a configuration recorder"
	@echo "    _cse_show_recorderset          - Show details of configuration recorder set"
	@echo "    _cse_show_recorderset_status   - Show status of configuration recorder set"
	@echo "    _cse_start_recorder            - Start a configuration recorder"
	@echo

_aws_view_makefile_variables :: _cse_view_makefile_variables
_cse_view_makefile_variables ::
	@echo "AWS::ConfigServicE ($(_AWS_CONFIGSERVICE_MK_VERSION)) variables:"
	@echo "    CSE_RECORDER_NAME=$(CSE_RECORDER_NAME)"
	@echo "    CSE_RECORDER_NAMES=$(CSE_RECORDER_NAMES)"
	@echo "    CSE_RECORDER_RECORDING_GROUP=$(CSE_RECORDER_RECORDING_GROUP)"
	@echo "    CSE_RECORDER_RECORDING_GROUP_FILEPATH=$(CSE_RECORDER_RECORDING_GROUP_FILEPATH)"
	@echo "    CSE_RECORDER_ROLE_ARN=$(CSE_RECORDER_ROLE_ARN)"
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#


_cse_create_recorder:
	@$(INFO) "$(AWS_LABEL)Creating a new configuration-recorder '$(CSE_RECORDER_NAME)' ..."; $(NORMAL)
	$(AWS) configservice put-configuration-recorder $(__CSE_CONFIGURATION_RECORDER) $(__CSE_RECORDING_GROUP)

_cse_delete_recorder:
	@$(INFO) "$(AWS_LABEL)Deleting the configuration-recorder '$(CSE_RECORDER_NAME)' ..."; $(NORMAL)
	$(AWS) configservice delete-configuration-recorder $(__CSE_CONFIGURATION_RECORDER_NAME)

_cse_show_recorderset:
	@$(INFO) "$(AWS_LABEL)Showing the configuration recorders ..."; $(NORMAL)
	$(AWS) configservice describe-configuration-recorders $(__CSE_CONFIGURATION_RECORDER_NAMES)

_cse_show_recorderset_status:
	@$(INFO) "$(AWS_LABEL)Fetching the status of the configuration-recorder-set ..."; $(NORMAL)
	$(AWS) configservice describe-configuration-recorder-status $(__CSE_CONFIGURATION_RECORDER_NAMES)

_cse_show_service_status:
	@$(INFO) "$(AWS_LABEL)Fetching the status of the config service ..."; $(NORMAL)
	$(AWS) configservice get-status

_cse_start_recorder:
	@$(INFO) "$(AWS_LABEL)Starting configuration-recorder '$(CSE_RECORDER_NAME)' ..."; $(NORMAL)
	@$(WARN) "This command returns no output. To validate the operation check the recorder status!"; $(NORMAL)
	$(AWS) configservice start-configuration-recorder $(__CSE_CONFIGURATION_RECORDER_NAME)

_cse_stop_recorder:
	@$(INFO) "$(AWS_LABEL)Stopping configuration-recorder '$(CSE_RECORDER_NAME)' ..."; $(NORMAL)
	@$(WARN) "This command returns no output. To validate the operation check the service status!"; $(NORMAL)
	$(AWS) configservice stop-configuration-recorder $(__CSE_CONFIGURATION_RECORDER_NAME)

_cse_view_recorders:
	@$(INFO) "$(AWS_LABEL)Viewing all configuration-recorders ..."; $(NORMAL)
	$(AWS) configservice describe-configuration-recorder-status $(_X__CSE_CONFIGURATION_RECORDER_NAMES)

