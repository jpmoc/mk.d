_AWS_XRAY_SAMPLINGRULE_MK_VERSION= $(_AWS_XRAY_MK_VERSION)

# XRY_SAMPLINGRULE_CONFIG?= RuleName=string,RuleARN=string,ResourceARN=string,Priority=integer,FixedRate=double,ReservoirSize=integer,ServiceName=string,ServiceType=string,Host=string,HTTPMethod=string,URLPath=string,Version=integer,Attributes={KeyName1=string,KeyName2=string}
# XRY_SAMPLINGRULE_NAME?=

# Derived parameters

# Option parameters

# UI parameters
XRY_UI_VIEW_SAMPLINGRULES_FIELDS?=
XRY_UI_VIEW_SAMPLINGRULES_SET_FIELDS?= $(XRY_UI_VIEW_SAMPLINGRULES_FIELDS)
XRY_UI_VIEW_SAMPLINGRULES_SET_SLICE?=

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_xry_view_framework_macros ::
	@echo 'AWS::XRaY::SamplingRule ($(_AWS_XRAY_SAMPLINGRULE_MK_VERSION)) macros:'
	@echo

_xry_view_framework_parameters ::
	@echo 'AWS::XRaY::SamplingRule ($(_AWS_XRAY_SAMPLINGRULE_MK_VERSION)) parameters:'
	@echo '    XRY_TRACES_START_TIME=$(XRY_TRACES_START_TIME)'
	@echo

_xry_view_framework_targets ::
	@echo 'AWS::XRaY::SamplingRule ($(_AWS_XRAY_SAMPLINGRULE_MK_VERSION)) targets:'A
	@echo '    _xry_create_samplingrule                           - Create a new trace'
	@echo '    _xry_delete_samplingrule                           - Delete an existing trace'
	@echo '    _xry_show_samplingrule                             - Show everything related to a sampling-rule'
	@echo '    _xry_show_samplingrule_description                 - Show description of a sampling-rule'
	@echo '    _xry_view_samplingrules                            - View sampling-rules'
	@echo '    _xry_view_samplingrules_set                        - View a set of sampling-rules'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_xry_create_samplingrule:
	@$(INFO) '$(AWS_UI_LABEL)Creating sampling-rule "$(XRY_SAMPLINGRULE_NAME)" ...'; $(NORMAL)

_xry_delete_samplingrule:
	@$(INFO) '$(AWS_UI_LABEL)Deleting sampling-rule "$(XRY_SAMPLINGRULE_NAME)" ...'; $(NORMAL)

_xry_show_samplingrule:: _xry_show_samplingrule_description

_xry_show_samplingrule_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of sampling-rule "$(XRY_SAMPLINGRULE_NAME)" ...'; $(NORMAL)


_xry_view_samplingrules:
	@$(INFO) '$(AWS_UI_LABEL)Viewing sampling-rules ...'; $(NORMAL)
	$(AWS) xray get-sampling-rules --query "SamplingRuleRecords[]$(XRY_UI_VIEW_SAMPLINGRULES_FIELDS)"

_xry_view_samplingrules_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing sampling-rules-set "$(XRY_SAMPLINGRULES_SET_NAME)" ...'; $(NORMAL)
