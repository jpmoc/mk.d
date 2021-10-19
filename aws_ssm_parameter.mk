_AWS_SSM_PARAMETER_MK_VERSION = 0.99.0

# SSM_PARAMETER_DECRYPT?= false
SSM_PARAMETER_KMSKEY_ID?= alias/aws/ssm 
# SSM_PARAMETER_NAME?= my-parameter-name
SSM_PARAMETER_OVERWRITE?= false
# SSM_PARAMETER_TYPE?= SecureString
# SSM_PARAMETER_VALUE?= "a value"
# SSM_PARAMETER_VALUE_FILEPATH?= ./parameter-value.json
# SSM_PARAMETERS_SET_PATH?= /path/to/parameters/
# SSM_PARAMETERS_SET_NAME?= my-parameter-set
SSM_PARAMETERS_SET_RECURSIVE?= false

# Derived variables
SSM_PARAMETER_VALUE?= $(if $(SSM_PARAMETER_VALUE_FILEPATH), file://$(SSM_PARAMETER_VALUE_FILEPATH))
SSM_PARAMETERS_SET_NAME?= $(SSM_PARAMETERS_SET_PATH)

# Option variables
__SSM_FILTERS_PARAMETER=
__SSM_KEY_ID?= $(if $(SSM_PARAMETER_KMSKEY_ID), --key-id $(SSM_PARAMETER_KMSKEY_ID))
__SSM_NAME?= $(if $(SSM_PARAMETER_NAME), --name $(SSM_PARAMETER_NAME))
__SSM_OVERWRITE?= $(if $(filter true, $(SSM_PARAMETER_OVERWRITE)), --overwrite, --no-overwrite)
__SSM_PARAMETER_FILTERS=
__SSM_PATH= $(if $(SSM_PARAMETERS_SET_PATH), --path $(SSM_PARAMETERS_SET_PATH))
__SSM_RECURSIVE= $(if $(filter true, $(SSM_PARAMETER_SET)), --recursive, --no-recursive)
__SSM_TYPE?= $(if $(SSM_PARAMETER_TYPE), --type $(SSM_PARAMETER_TYPE))
__SSM_VALUE?= $(if $(SSM_PARAMETER_VALUE), --value $(SSM_PARAMETER_VALUE))
__SSM_WITH_DECRYPTION?= $(if $(filter true, $(SSM_PARAMETER_DECRYPT)), --with-decryption, --no-with-decryption)

# UI variables
SSM_UI_VIEW_PARAMETERS_FIELDS?=
SSM_UI_VIEW_PARAMETERS_SET_FIELDS?= $(SSM_UI_VIEW_PARAMETERS_FIELDS)

#--- Utilities

#--- MACRO
_ssm_get_parameter_value= $(call _ssm_get_parameter_value_N, $(SSM_PARAMETER_NAME))
_ssm_get_parameter_value_N= $(shell $(AWS) ssm get-parameter --name $(1) --with-decription --output text)

_ssm_put_parameter_value_DNTV= $(call $(AWS) ssm put-parameter --description $(1) --name $(2) --type $(3) --value $(4) --no-overwrite --output text)

_ssm_update_parameter_DNTV= $(call $(AWS) ssm put-parameter --description $(1) --name $(2) --type $(3) --value $(4) --overwrite --output text)

#----------------------------------------------------------------------
# USAGE
#

_ssm_view_makefile_macros ::
	@echo 'AWS::SSM::Parameter ($(_AWS_SSM_PARAMETER_MK_VERSION)) macros:'
	@echo '    _ssm_get_parameter_value_{|N}            - Get parameter value'
	@echo '    _ssm_put_parameter_value_DNTV            - Put in store a new parameter/value'
	@echo '    _ssm_update_parameter_DNTV               - Upate store with a new parameter/value'
	@echo

_ssm_view_makefile_targets ::
	@echo 'AWS::SSM::Parameter ($(_AWS_SSM_PARAMETER_MK_VERSION)) targets:'
	@echo '    _ssm_delete_parameter         - Delete parameter'
	@echo '    _ssm_create_parameter	 - Create a parameter and set its value'
	@echo '    _ssm_show_parameter_value     - Fetch the value of a given parameter from the store'
	@echo '    _ssm_view_parameters          - View all parameters'
	@echo '    _ssm_view_parameters_set      - View a set of parameters'
	@echo

_ssm_view_makefile_variables ::
	@echo 'AWS::SSM::Parameter ($(_AWS_SSM_PARAMETER_MK_VERSION)) variables:'
	@echo '    SSM_PARAMETER_DECRYPT=$(SSM_PARAMETER_DECRYPT)'
	@echo '    SSM_PARAMETER_KMSKEY_ID=$(SSM_PARAMETER_KMSKEY_ID)'
	@echo '    SSM_PARAMETER_NAME=$(SSM_PARAMETER_NAME)'
	@echo '    SSM_PARAMETER_TYPE=$(SSM_PARAMETER_TYPE)'
	@echo '    SSM_PARAMETER_VALUE=$(SSM_PARAMETER_VALUE)'
	@echo '    SSM_PARAMETER_VALUE_FILEPATH=$(SSM_PARAMETER_VALUE_FILEPATH)'
	@echo '    SSM_PARAMETERS_PATH=$(SSM_PARAMETERS_PATH)'
	@echo '    SSM_PARAMETERS_SET_NAME=$(SSM_PARAMETERS_SET_NAME)'
	@echo '    SSM_PARAMETERS_SET_RECURSIVE=$(SSM_PARAMETERS_SET_RECURSIVE)'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ssm_create_parameter:
	@$(INFO) '$(AWS_UI_LABEL)Storing new value in parameter "$(SSM_PARAMETER_NAME)" ...'; $(NORMAL)
	$(if $(SSM_PARAMETER_VALUE_FILEPATH), cat $(SSM_PARAMETER_VALUE_FILEPATH))
	$(AWS) ssm put-parameter $(__SSM_KEY_ID) $(__SSM_NAME) $(__SSM_OVERWRITE) $(__SSM_TYPE) $(__SSM_VALUE)

_ssm_delete_parameter:
	@$(INFO) '$(AWS_UI_LABEL)Deleting parameter "$(SSM_PARAMETER_NAME)" ...'; $(NORMAL)
	$(AWS) ssm delete-parameter $(__SSM_NAME)

_ssm_show_parameter: _ssm_show_parameter_history _ssm_show_parameter_value _ssm_show_parameter_overview

_ssm_show_parameter_history:
	@$(INFO) '$(AWS_UI_LABEL)Showing history of parameter "$(SSM_PARAMETER_NAME)" ...'; $(NORMAL)
	$(AWS) ssm get-parameter-history $(__SSM_NAME) $(__SSM_WITH_DECRYPTION)

_ssm_show_parameter_overview:
	@$(INFO) '$(AWS_UI_LABEL)Showing overview of parameter "$(SSM_PARAMETER_NAME)" ...'; $(NORMAL)
	$(AWS) ssm describe-parameters --filters "Key=Name,Values=$(SSM_PARAMETER_NAME)" --query "Parameters[]"

_ssm_show_parameter_value:
	@$(INFO) '$(AWS_UI_LABEL)Showing value of parameter "$(SSM_PARAMETER_NAME)" ...'; $(NORMAL)
	$(CYAN); $(AWS) ssm get-parameter $(__SSM_NAME) $(__SSM_WITH_DECRYPTION) --query "Parameter.Value" --output text; $(WHITE)

_ssm_update_parameter: _ssm_create_parameter

_ssm_view_parameters:
	@$(INFO) '$(AWS_UI_LABEL)Viewing parameters ...'; $(NORMAL)
	$(AWS) ssm describe-parameters $(__SSM_FILTERS_PARAMETER) $(__SSM_PARAMETER_FILTERS) --query "Parameters[]$(SSM_UI_VIEW_PARAMETERS_FIELDS)"

_ssm_view_parameters_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing a parameters-set "$(SSM_PARAMETERS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Parameters are grouped based on their path'; $(NORMAL)
	$(AWS) ssm get-parameters-by-path $(__SSM_PATH) $(__SSM_PARAMETER_FILTERS) $(__SSM_RECURSIVE) $(__SSM_WITH_DECRYPTION) --query "Parameters[]$(SSM_UI_VIEW_PARAMETERS_SET_FIELDS)"
