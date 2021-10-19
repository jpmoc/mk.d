_AWS_DAX_PARAMETERGROUP_MK_VERSION= $(_AWS_DAX_MK_VERSION)

# DAX_PARAMETERGROUP_CONFIG?= ParameterName=string,ParameterValue=string ...
# DAX_PARAMETERGROUP_CONFIG_FILEPATH?= ./parametergroup-config.json
# DAX_PARAMETERGROUP_DESCRIPTION?= "This is my parametergroup-description"
# DAX_PARAMETERGROUP_NAME?= my-parametergroup 
# DAX_PARAMETERGROUP_TAGS?= Key=string,Value=string ...
# DAX_PARAMETERGROUPS_NAMES?= my-parametergroup ...
# DAX_PARAMETERGROUPS_SET_NAME?= my-parametergroups-set 

# Derived parameters
DAX_PARAMETERGROUP_CONFIG?= $(if $(DAX_PARAMETERGROUP_CONFIG_FILEPATH),file://$(DAX_PARAMETERGROUP_CONFIG_FILEPATH))
DAX_PARAMETERGROUPS_NAMES?= $(DAX_PARAMETERGROUP_NAME)

# Option parameters
__DAX_PARAMETER_NAME_VALUES= $(if $(DAXA_PARAMETERGROUP_CONFIG), --parameter-name-values $(DAX_PARAMETERGROUP_CONFIG))
__DAX_PARAMETER_GROUP_NAME= $(if $(DAX_PARAMETERGROUP_NAME), --parameter-group-name $(DAX_PARAMETERGROUP_NAME))
__DAX_PARAMETER_GROUP_NAMES= $(if $(DAX_PARAMETERGROUPS_NAMES), --parameter-group-names $(DAX_PARAMETERGROUPS_NAMES))
__DAX_DESCRIPTION__PARAMETERGROUP= $(if $(DAX_PARAMETERGROUP_DESCRIPTION), --description $(DAX_PARAMETERGROUP_DESCRIPTION))
__DAX_RESOURCE_NAME__PARAMETERGROUP= $(if $(DAX_PARAMETERGROUP_NAME), --resource-name $(DAX_PARAMETERGROUP_NAME))
__DAX_TAG_KEYS__PARAMETERGROUP= $(if $(DAX_PARAMETERGROUP_TAG_KEYS), --tag-keys $(DAX_PARAMETERGROUP_TAG_KEYS))
__DAX_TAGS__PARAMETERGROUP= $(if $(DAX_PARAMETERGROUP_TAGS), --tags $(DAX_PARAMETERGROUP_TAGS))



# UI parameters
DAX_UI_VIEW_PARAMETERGROUPS_FIELDS?=
DAX_UI_VIEW_PARAMETERGROUPS_SET_FIELDS?= $(DAX_UI_VIEW_PARAMETERGROUPS_FIELDS)
DAX_UI_VIEW_PARAMETERGROUPS_SET_SLICE?=

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_dax_view_framework_macros ::
	@echo 'AWS::DAX::ParameterGroup ($(_AWS_DAX_PARAMETERGROUP_MK_VERSION)) macros:'
	@echo

_dax_view_framework_parameters ::
	@echo 'AWS::DAX::ParameterGroup ($(_AWS_DAX_PARAMETERGROUP_MK_VERSION)) parameters:'
	@echo '    DAX_PARAMETERGROUP_CONFIG=$(DAX_PARAMETERGROUP_CONFIG)'
	@echo '    DAX_PARAMETERGROUP_CONFIG_FILEPATH=$(DAX_PARAMETERGROUP_CONFIG_FILEPATH)'
	@echo '    DAX_PARAMETERGROUP_DESCRIPTION=$(DAX_PARAMETERGROUP_DESCRIPTION)'
	@echo '    DAX_PARAMETERGROUP_NAME=$(DAX_PARAMETERGROUP_NAME)'
	@echo '    DAX_PARAMETERGROUPS_NAMES=$(DAX_PARAMETERGROUPS_NAMES)'
	@echo '    DAX_PARAMETERGROUPS_SET_NAME=$(DAX_PARAMETERGROUPS_SET_NAME)'
	@echo

_dax_view_framework_targets ::
	@echo 'AWS::DAX::ParameterGroup ($(_AWS_DAX_PARAMETERGROUP_MK_VERSION)) targets:'
	@echo '    _dax_create_parametergroup                           - Create a new parameter-group'
	@echo '    _dax_delete_parametergroup                           - Delete an existing parameter-group'
	@echo '    _dax_show_parametergroup                             - Show everything related to a parameter-group'
	@echo '    _dax_show_parametergroup_description                 - Show description of a parameter-group'
	@echo '    _dax_show_parametergroup_tags                        - Show tags of a parameter-group'
	@echo '    _dax_view_parametergroups                            - View parametergroups'
	@echo '    _dax_view_parametergroups_set                        - View a set of parameter-groups'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_dax_create_parametergroup:
	@$(INFO) '$(AWS_UI_LABEL)Creating parameter-group "$(DAX_PARAMETERGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) dax create-parametergroup $(__DAX_PARAMETER_GROUP_NAME) $(__DAX_DESCRIPTION__PARAMETERGROUP)

_dax_delete_parametergroup:
	@$(INFO) '$(AWS_UI_LABEL)Deleting parameter-group "$(DAX_PARAMETERGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) dax delete-parametergroup $(__DAX_PARAMETER_GROUP_NAME)

_dax_show_parametergroup: _dax_show_parametergroup_tags _dax_show_parametergroup_description

_dax_show_parametergroup_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of parameter-group "$(DAX_PARAMETERGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) dax describe-parameter-groups $(_X__DAX_PARAMETER_GROUP_NAMES) --parameter-group-names $(DAX_PARAMETERGROUP_NAME) # --query "StreamDescriptionSummary"

_dax_show_parametergroup_tags:
	@$(INFO) '$(AWS_UI_LABEL)Showing tags of parameter-group "$(DAX_PARAMETERGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) dax list-tags $(__DAX_RESOURCE_NAME__PARAMETERGROUP)

_dax_tag_parametergroup:
	@$(INFO) '$(AWS_UI_LABEL)Tagging parameter-group "$(DAX_PARAMETERGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) dax tag-resource $(__DAX_RESOURCE_NAME__PARAMETERGROUP)

_dax_update_parametergroup:
	@$(INFO) '$(AWS_UI_LABEL)Updating parameter-group "$(DAX_PARAMETERGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) dax update-parameter-group $(__DAX_PARAMETER_GROUP_NAME) $(__DAX_PARAMETER_NAME_VALUES)

_dax_untag_parametergroup:
	@$(INFO) '$(AWS_UI_LABEL)Removing tags from parameter-group "$(DAX_PARAMETERGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) dax untag-resource $(__DAX_PARAMETER_GROUP_NAME) $(__DAX_TAG_KEYS__PARAMETERGROUP)

_dax_view_parametergroups:
	@$(INFO) '$(AWS_UI_LABEL)Viewing parameter-groups ...'; $(NORMAL)
	$(AWS) dax describe-parameter-groups $(_X__DAX_PARAMETER_GROUP_NAMES) --query "ParameterGroups[]"

_dax_view_parametergroups_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing parameter-groups-set "$(DAX_PARAMETERGROUPS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Parameter-groups are grouped based on the provided names and/or slice'; $(NORMAL)
	$(AWS) dax describe-parameter-groups $(__DAX_PARAMETER_GROUP_NAMES) --query "ParameterGroups[$(DAX_UI_VIEW_PARAMETERGROUPS_SET_SLICE)]"
