_AWS_DAX_SUBNETGROUP_MK_VERSION= $(_AWS_DAX_MK_VERSION)

# DAX_SUBNETGROUP_DESCRIPTION?= "This is my subnetgroup-description"
# DAX_SUBNETGROUP_NAME?= my-subnetgroup 
# DAX_SUBNETGROUP_SUBNET_IDS?=
# DAX_SUBNETGROUP_TAGS?= Key=string,Value=string ...
# DAX_SUBNETGROUPS_NAMES?= my-subnetgroup ...
# DAX_SUBNETGROUPS_SET_NAME?= my-subnetgroups-set 

# Derived parameters
DAX_SUBNETGROUP_SUBNET_IDS?=
DAX_SUBNETGROUPS_NAMES?= $(DAX_SUBNETGROUP_NAME)

# Option parameters
__DAX_SUBNET_GROUP_NAME= $(if $(DAX_SUBNETGROUP_NAME), --subnet-group-name $(DAX_SUBNETGROUP_NAME))
__DAX_SUBNET_GROUP_NAMES= $(if $(DAX_SUBNETGROUPS_NAMES), --subnet-group-names $(DAX_SUBNETGROUPS_NAMES))
__DAX_DESCRIPTION__SUBNETGROUP= $(if $(DAX_SUBNETGROUP_DESCRIPTION), --description $(DAX_SUBNETGROUP_DESCRIPTION))
__DAX_RESOURCE_NAME__SUBNETGROUP= $(if $(DAX_SUBNETGROUP_NAME), --resource-name $(DAX_SUBNETGROUP_NAME))
__DAX_TAG_KEYS__SUBNETGROUP= $(if $(DAX_SUBNETGROUP_TAG_KEYS), --tag-keys $(DAX_SUBNETGROUP_TAG_KEYS))
__DAX_TAGS__SUBNETGROUP= $(if $(DAX_SUBNETGROUP_TAGS), --tags $(DAX_SUBNETGROUP_TAGS))



# UI parameters
DAX_UI_VIEW_SUBNETGROUPS_FIELDS?=
DAX_UI_VIEW_SUBNETGROUPS_SET_FIELDS?= $(DAX_UI_VIEW_SUBNETGROUPS_FIELDS)
DAX_UI_VIEW_SUBNETGROUPS_SET_SLICE?=

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_dax_view_framework_macros ::
	@echo 'AWS::DAX::SubnetGroup ($(_AWS_DAX_SUBNETGROUP_MK_VERSION)) macros:'
	@echo

_dax_view_framework_parameters ::
	@echo 'AWS::DAX::SubnetGroup ($(_AWS_DAX_SUBNETGROUP_MK_VERSION)) parameters:'
	@echo '    DAX_SUBNETGROUP_DESCRIPTION=$(DAX_SUBNETGROUP_DESCRIPTION)'
	@echo '    DAX_SUBNETGROUP_NAME=$(DAX_SUBNETGROUP_NAME)'
	@echo '    DAX_SUBNETGROUP_SUBNET_IDS=$(DAX_SUBNETGROUP_SUBNET_IDS)'
	@echo '    DAX_SUBNETGROUPS_NAMES=$(DAX_SUBNETGROUPS_NAMES)'
	@echo '    DAX_SUBNETGROUPS_SET_NAME=$(DAX_SUBNETGROUPS_SET_NAME)'
	@echo

_dax_view_framework_targets ::
	@echo 'AWS::DAX::SubnetGroup ($(_AWS_DAX_SUBNETGROUP_MK_VERSION)) targets:'
	@echo '    _dax_create_subnetgroup                           - Create a new subnet-group'
	@echo '    _dax_delete_subnetgroup                           - Delete an existing subnet-group'
	@echo '    _dax_show_subnetgroup                             - Show everything related to a subnet-group'
	@echo '    _dax_show_subnetgroup_description                 - Show description of a subnet-group'
	@echo '    _dax_show_subnetgroup_tags                        - Show tags of a subnet-group'
	@echo '    _dax_view_subnetgroups                            - View parametergroups'
	@echo '    _dax_view_subnetgroups_set                        - View a set of subnet-groups'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_dax_create_subnetgroup:
	@$(INFO) '$(AWS_UI_LABEL)Creating subnet-group "$(DAX_SUBNETGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) dax create-subnet-group $(__DAX_DESCRIPTION__SUBNETGROUP) $(__DAX_SUBNET_GROUP_NAME)

_dax_delete_subnetgroup:
	@$(INFO) '$(AWS_UI_LABEL)Deleting subnet-group "$(DAX_SUBNETGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) dax delete-subnet-group $(__DAX_SUBNETGROUP_NAME)

_dax_show_subnetgroup: _dax_show_subnetgroup_tags _dax_show_subnetgroup_description

_dax_show_subnetgroup_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of subnet-group "$(DAX_SUBNETGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) dax describe-subnet-groups $(_X__DAX_SUBNETGROUP_NAMES) --subnet-group-names $(DAX_SUBNETGROUP_NAME) # --query "StreamDescriptionSummary"

_dax_show_subnetgroup_tags:
	@$(INFO) '$(AWS_UI_LABEL)Showing tags of subnet-group "$(DAX_SUBNETGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) dax list-tags $(__DAX_RESOURCE_NAME__SUBNETGROUP)

_dax_tag_subnetgroup:
	@$(INFO) '$(AWS_UI_LABEL)Tagging subnet-group "$(DAX_SUBNETGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) dax tag-resource $(__DAX_RESOURCE_NAME__SUBNETGROUP)

_dax_update_subnetgroup:
	@$(INFO) '$(AWS_UI_LABEL)Updating subnet-group "$(DAX_SUBNETGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) dax update-subnet-group $(__DAX_SUBNET_GROUP_NAME) $(__DAX_PARAMETER_NAME_VALUES)

_dax_untag_subnetgroup:
	@$(INFO) '$(AWS_UI_LABEL)Removing tags from subnet-group "$(DAX_SUBNETGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) dax untag-resource $(__DAX_SUBNET_GROUP_NAME) $(__DAX_TAG_KEYS__SUBNETGROUP)

_dax_view_subnetgroups:
	@$(INFO) '$(AWS_UI_LABEL)Viewing subnet-groups ...'; $(NORMAL)
	$(AWS) dax describe-subnet-groups $(_X__DAX_SUBNET_GROUP_NAMES) --query "ParameterGroups[]"

_dax_view_subnetgroups_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing subnet-groups-set "$(DAX_SUBNETGROUPS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Subnet-groups are grouped based on the provided names and/or slice'; $(NORMAL)
	$(AWS) dax describe-subnet-groups $(__DAX_SUBNET_GROUP_NAMES) --query "ParameterGroups[$(DAX_UI_VIEW_SUBNETGROUPS_SET_SLICE)]"
