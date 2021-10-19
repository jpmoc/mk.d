_AWS_ELASTICACHE_SUBNETGROUP_MK_VERSION= $(_AWS_ELASTICACHE_MK_VERSION)

# ECE_SUBNETGROUP_DESCRIPTION?= "This is my subnetgroup-description"
# ECE_SUBNETGROUP_NAME?= my-subnetgroup 
# ECE_SUBNETGROUP_SUBNET_IDS?=
# ECE_SUBNETGROUP_TAGS?= Key=string,Value=string ...
# ECE_SUBNETGROUPS_NAMES?= my-subnetgroup ...
# ECE_SUBNETGROUPS_SET_NAME?= my-subnetgroups-set 

# Derived parameters
ECE_SUBNETGROUP_SUBNET_IDS?=
ECE_SUBNETGROUPS_NAMES?= $(ECE_SUBNETGROUP_NAME)

# Option parameters
__ECE_CACHE_SUBNET_GROUP_DESCRIPTION= $(if $(ECE_SUBNETGROUP_DESCRIPTION), --cache-subnet-group-description $(ECE_SUBNETGROUP_DESCRIPTION))
__ECE_CACHE_SUBNET_GROUP_NAME= $(if $(ECE_SUBNETGROUP_NAME), --subnet-group-name $(ECE_SUBNETGROUP_NAME))
__ECE_SUBNET_GROUP_NAMES= $(if $(ECE_SUBNETGROUPS_NAMES), --subnet-group-names $(ECE_SUBNETGROUPS_NAMES))
__ECE_RESOURCE_NAME__SUBNETGROUP= $(if $(ECE_SUBNETGROUP_NAME), --resource-name $(ECE_SUBNETGROUP_NAME))
__ECE_SUBNET_IDS= $(if $(ECE_SUBNETGROUP_SUBNET_IDS), --subnet-ids $(ECE_SUBNETGROUP_SUBNET_IDS))
__ECE_TAG_KEYS__SUBNETGROUP= $(if $(ECE_SUBNETGROUP_TAG_KEYS), --tag-keys $(ECE_SUBNETGROUP_TAG_KEYS))
__ECE_TAGS__SUBNETGROUP= $(if $(ECE_SUBNETGROUP_TAGS), --tags $(ECE_SUBNETGROUP_TAGS))



# UI parameters
ECE_UI_VIEW_SUBNETGROUPS_FIELDS?=
ECE_UI_VIEW_SUBNETGROUPS_SET_FIELDS?= $(ECE_UI_VIEW_SUBNETGROUPS_FIELDS)
ECE_UI_VIEW_SUBNETGROUPS_SET_SLICE?=

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_ece_view_framework_macros ::
	@echo 'AWS::ElastiCache::SubnetGroup ($(_AWS_ELASTICACHE_SUBNETGROUP_MK_VERSION)) macros:'
	@echo

_ece_view_framework_parameters ::
	@echo 'AWS::ElastiCache::SubnetGroup ($(_AWS_ELASTICACHE_SUBNETGROUP_MK_VERSION)) parameters:'
	@echo '    ECE_SUBNETGROUP_DESCRIPTION=$(ECE_SUBNETGROUP_DESCRIPTION)'
	@echo '    ECE_SUBNETGROUP_NAME=$(ECE_SUBNETGROUP_NAME)'
	@echo '    ECE_SUBNETGROUP_SUBNET_IDS=$(ECE_SUBNETGROUP_SUBNET_IDS)'
	@echo '    ECE_SUBNETGROUPS_NAMES=$(ECE_SUBNETGROUPS_NAMES)'
	@echo '    ECE_SUBNETGROUPS_SET_NAME=$(ECE_SUBNETGROUPS_SET_NAME)'
	@echo

_ece_view_framework_targets ::
	@echo 'AWS::ElastiCache::SubnetGroup ($(_AWS_ELASTICACHE_SUBNETGROUP_MK_VERSION)) targets:'
	@echo '    _ece_create_subnetgroup                           - Create a new subnet-group'
	@echo '    _ece_delete_subnetgroup                           - Delete an existing subnet-group'
	@echo '    _ece_show_subnetgroup                             - Show everything related to a subnet-group'
	@echo '    _ece_show_subnetgroup_description                 - Show description of a subnet-group'
	@echo '    _ece_show_subnetgroup_tags                        - Show tags of a subnet-group'
	@echo '    _ece_view_subnetgroups                            - View parametergroups'
	@echo '    _ece_view_subnetgroups_set                        - View a set of subnet-groups'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ece_create_subnetgroup:
	@$(INFO) '$(AWS_UI_LABEL)Creating subnet-group "$(ECE_SUBNETGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) elasticache create-subnet-group $(__ECE_CACHE_SUBNET_GROUP_DESCRIPTION) $(__ECE_CACHE_SUBNET_GROUP_NAME) $(__ECE_SUBNET_IDS)

_ece_delete_subnetgroup:
	@$(INFO) '$(AWS_UI_LABEL)Deleting subnet-group "$(ECE_SUBNETGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) elasticache delete-cache-subnet-group $(__ECE_CACHE_SUBNET_GROUP_NAME)

_ece_show_subnetgroup: _ece_show_subnetgroup_tags _ece_show_subnetgroup_description

_ece_show_subnetgroup_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of subnet-group "$(ECE_SUBNETGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) elasticache describe-cache-subnet-groups $(__ECE_CACHE_SUBNET_GROUP_NAME) # --query "StreamDescriptionSummary"

_ece_show_subnetgroup_tags:
	@$(INFO) '$(AWS_UI_LABEL)Showing tags of subnet-group "$(ECE_SUBNETGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) elasticache list-tags-for-resource $(__ECE_RESOURCE_NAME__SUBNETGROUP)

_ece_tag_subnetgroup:
	@$(INFO) '$(AWS_UI_LABEL)Tagging subnet-group "$(ECE_SUBNETGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) elasticache add-tags-to-resource $(__ECE_RESOURCE_NAME__SUBNETGROUP) $(__ECE_TAGS__SUBNETGROUP)

_ece_update_subnetgroup:
	@$(INFO) '$(AWS_UI_LABEL)Updating subnet-group "$(ECE_SUBNETGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) elasticache modify-cache-subnet-group $(__ECE_CACHE_SUBNET_GROUP_NAME) $(__ECE_PARAMETER_NAME_VALUES)

_ece_untag_subnetgroup:
	@$(INFO) '$(AWS_UI_LABEL)Removing tags from subnet-group "$(ECE_SUBNETGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) elasticache remove-tags-from-resource $(__ECE_CACHE_SUBNET_GROUP_NAME) $(__ECE_TAG_KEYS__SUBNETGROUP)

_ece_view_subnetgroups:
	@$(INFO) '$(AWS_UI_LABEL)Viewing subnet-groups ...'; $(NORMAL)
	$(AWS) elasticache describe-cache-subnet-groups $(_X__ECE_CACHE_SUBNET_GROUP_NAME) # --query "ParameterGroups[]"

_ece_view_subnetgroups_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing subnet-groups-set "$(ECE_SUBNETGROUPS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Subnet-groups are grouped based on the provided slice'; $(NORMAL)
	$(AWS) elasticache describe-cache-subnet-groups $(_X__ECE_CACHE_SUBNET_GROUP_NAME) # --query "ParameterGroups[$(ECE_UI_VIEW_SUBNETGROUPS_SET_SLICE)]"
