_AWS_ELASTICACHE_PARAMETERGROUP_MK_VERSION= $(_AWS_ELASTICACHE_MK_VERSION)

# ECE_PARAMETERGROUP_CONFIG?= ParameterName=string,ParameterValue=string ...
# ECE_PARAMETERGROUP_CONFIG_FILEPATH?= ./parametergroup-config.json
# ECE_PARAMETERGROUP_DESCRIPTION?= "This is my parametergroup-description"
# ECE_PARAMETERGROUP_FAMILY?= redis-4.0
# ECE_PARAMETERGROUP_NAME?= my-parameter-group 
# ECE_PARAMETERGROUP_PARAMETER_SOURCE?= user
# ECE_PARAMETERGROUP_TAGS?= Key=string,Value=string ...
# ECE_PARAMETERGROUPS_NAMES?= my-parametergroup ...
# ECE_PARAMETERGROUPS_SET_NAME?= my-parametergroups-set 

# Derived parameters
ECE_PARAMETERGROUP_CONFIG?= $(if $(ECE_PARAMETERGROUP_CONFIG_FILEPATH),file://$(ECE_PARAMETERGROUP_CONFIG_FILEPATH))
ECE_PARAMETERGROUPS_NAMES?= $(ECE_PARAMETERGROUP_NAME)

# Option parameters
__ECE_CACHE_PARAMETER_GROUP_FAMILY= $(if $(ECE_PARAMETERGROUP_FAMILY), --cache-parameter-group-family $(ECE_PARAMETERGROUP_FAMILY))
__ECE_CACHE_PARAMETER_GROUP_NAME= $(if $(ECE_PARAMETERGROUP_NAME), --cache-parameter-group-name $(ECE_PARAMETERGROUP_NAME))
__ECE_DESCRIPTION__PARAMETERGROUP= $(if $(ECE_PARAMETERGROUP_DESCRIPTION), --description $(ECE_PARAMETERGROUP_DESCRIPTION))
__ECE_PARAMETER_NAME_VALUES= $(if $(ECEA_PARAMETERGROUP_CONFIG), --cache-parameter-name-values $(ECE_PARAMETERGROUP_CONFIG))
__ECE_SOURCE= $(if $(ECE_PARAMETERGROUP_PARAMETER_SOURCE), --source $(ECE_PARAMETERGROUP_PARAMETER_SOURCE))



# UI parameters
ECE_UI_SHOW_PARAMETERGROUP_PARAMETERS_DESCRIPTIONS?= .{description:Description,ParameterName:ParameterName}
ECE_UI_SHOW_PARAMETERGROUP_PARAMETERS_VALUES?= .{dataType:DataType,changeType:ChangeType,isModifiable:IsModifiable,allowedValues:AllowedValues,source:Source,parameterValue:ParameterValue,ParameterName:ParameterName,minimumEngineVersion:MinimumEngineVersion}

ECE_UI_VIEW_PARAMETERGROUPS_FIELDS?=
ECE_UI_VIEW_PARAMETERGROUPS_SET_FIELDS?= $(ECE_UI_VIEW_PARAMETERGROUPS_FIELDS)
ECE_UI_VIEW_PARAMETERGROUPS_SET_SLICE?=

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_ece_view_framework_macros ::
	@echo 'AWS::Elasticache::ParameterGroup ($(_AWS_ELASTICACHE_PARAMETERGROUP_MK_VERSION)) macros:'
	@echo

_ece_view_framework_parameters ::
	@echo 'AWS::Elasticache::ParameterGroup ($(_AWS_ELASTICACHE_PARAMETERGROUP_MK_VERSION)) parameters:'
	@echo '    ECE_PARAMETERGROUP_CONFIG=$(ECE_PARAMETERGROUP_CONFIG)'
	@echo '    ECE_PARAMETERGROUP_CONFIG_FILEPATH=$(ECE_PARAMETERGROUP_CONFIG_FILEPATH)'
	@echo '    ECE_PARAMETERGROUP_DESCRIPTION=$(ECE_PARAMETERGROUP_DESCRIPTION)'
	@echo '    ECE_PARAMETERGROUP_FAMILY=$(ECE_PARAMETERGROUP_FAMILY)'
	@echo '    ECE_PARAMETERGROUP_NAME=$(ECE_PARAMETERGROUP_NAME)'
	@echo '    ECE_PARAMETERGROUPS_NAMES=$(ECE_PARAMETERGROUPS_NAMES)'
	@echo '    ECE_PARAMETERGROUPS_SET_NAME=$(ECE_PARAMETERGROUPS_SET_NAME)'
	@echo

_ece_view_framework_targets ::
	@echo 'AWS::Elasticache::ParameterGroup ($(_AWS_ELASTICACHE_PARAMETERGROUP_MK_VERSION)) targets:'
	@echo '    _ece_create_parametergroup                           - Create a new parameter-group'
	@echo '    _ece_delete_parametergroup                           - Delete an existing parameter-group'
	@echo '    _ece_show_parametergroup                             - Show everything related to a parameter-group'
	@echo '    _ece_show_parametergroup_description                 - Show description of a parameter-group'
	@echo '    _ece_show_parametergroup_parameters                  - Show parameters of a parameter-group'
	@echo '    _ece_view_parametergroups                            - View parametergroups'
	@echo '    _ece_view_parametergroups_set                        - View a set of parameter-groups'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ece_create_parametergroup:
	@$(INFO) '$(AWS_UI_LABEL)Creating cache-parameter-group "$(ECE_PARAMETERGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) elasticache create-cache-parameter-group $(__ECE_CACHE_PARAMETER_GROUP_FAMILY) $(__ECE_CACHE_PARAMETER_GROUP_NAME) $(__ECE_DESCRIPTION__PARAMETERGROUP)

_ece_delete_parametergroup:
	@$(INFO) '$(AWS_UI_LABEL)Deleting cache-parameter-group "$(ECE_PARAMETERGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) elasticache delete-cache-parameter-group $(__ECE_CACHE_PARAMETER_GROUP_NAME)

_ece_show_parametergroup: _ece_show_parametergroup_parameters _ece_show_parametergroup_description

_ece_show_parametergroup_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of cache-parameter-group "$(ECE_PARAMETERGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) elasticache describe-cache-parameter-groups $(__ECE_CACHE_PARAMETER_GROUP_NAME) --query "CacheParameterGroups[]"

_ece_show_parametergroup_parameters: _ece_show_parametergroup_parameters_description _ece_show_parametergroup_parameters_values

_ece_show_parametergroup_parameters_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing parameters of cache-parameter-group "$(ECE_PARAMETERGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) elasticache describe-cache-parameters $(__ECE_CACHE_PARAMETER_GROUP_NAME) $(__ECE_SOURCE) --query "Parameters[]$(ECE_UI_SHOW_PARAMETERGROUP_PARAMETERS_DESCRIPTIONS)"

_ece_show_parametergroup_parameters_values:
	@$(INFO) '$(AWS_UI_LABEL)Showing parameters of cache-parameter-group "$(ECE_PARAMETERGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) elasticache describe-cache-parameters $(__ECE_CACHE_PARAMETER_GROUP_NAME) $(__ECE_SOURCE) --query "Parameters[]$(ECE_UI_SHOW_PARAMETERGROUP_PARAMETERS_VALUES)"

_ece_update_parametergroup:
	@$(INFO) '$(AWS_UI_LABEL)Updating cache-parameter-group "$(ECE_PARAMETERGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) elasticache modify-cache-parameter-group $(__ECE_CACHE_PARAMETER_GROUP_NAME) $(__ECE_PARAMETER_NAME_VALUES)

_ece_view_parametergroups:
	@$(INFO) '$(AWS_UI_LABEL)Viewing cache-parameter-groups ...'; $(NORMAL)
	$(AWS) elasticache describe-cache-parameter-groups $(_X__ECE_CACHE_PARAMETER_GROUP_NAME) --query "CacheParameterGroups[]"

_ece_view_parametergroups_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing cache-parameter-groups-set "$(ECE_PARAMETERGROUPS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Parameter-groups are grouped based on the provided names and/or slice'; $(NORMAL)
	$(AWS) elasticache describe-cache-parameter-groups $(_X__ECE_CACHE_PARAMETER_GROUP_NAME) --query "CacheParameterGroups[$(ECE_UI_VIEW_PARAMETERGROUPS_SET_SLICE)]"
