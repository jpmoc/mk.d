_AZ_GROUP_DEPLOYMENT_MK_VERSION= $(_AZ_GROUP_MK_VERSION)

## GRP_DEPLOYMENT_ID?= /subscriptions/<subscriptionid>/deployments/my-deployment
## GRP_DEPLOYMENT_LOCATION_ID?= westus2
## GRP_DEPLOYMENT_MODE_NOWAIT?= false
## GRP_DEPLOYMENT_MODE_YES?=
# GRP_DEPLOYMENT_NAME?= my-deployment
# GRP_DEPLOYMENT_RESOURCEGROUP_NAME?= my-resource-group
# GRP_DEPLOYMENT_SUBSCRIPTION_ID?=
## GRP_DEPLOYMENT_TAGS_KEYVALUES?=
# GRP_DEPLOYMENT_TEMPLATE_DIRPATH?=
# GRP_DEPLOYMENT_TEMPLATE_FILENAME?=
# GRP_DEPLOYMENT_TEMPLATE_FILEPATH?=
## GRP_DEPLOYMENT_WAIT_EVENT?= created
# GRP_DEPLOYMENTS_FILTER?=
# GRP_DEPLOYMENTS_RESOURCEGROUP_NAME?= my-resource-group
# GRP_DEPLOYMENTS_SET_NAME?= my-deployment-set

# Derived parameters
## #GRP_DEPLOYMENT_ID?= /subscriptions/$(GRP_DEPLOYMENT_SUBSCRIPTION_ID)/deployments/$(GRP_DEPLOYMENT_NAME)
## GRP_DEPLOYMENT_LOCATION_ID?= $(GRP_LOCATION_ID)
## GRP_DEPLOYMENT_MODE_NOWAIT?= $(GRP_MODE_NOWAIT)
## GRP_DEPLOYMENT_MODE_YES?= $(GRP_MODE_YES)
GRP_DEPLOYMENT_NAME?= $(AZ_DEPLOYMENT_NAME)
GRP_DEPLOYMENT_RESOURCEGROUP_NAME?= $(AZ_RESOURCEGROUP_NAME)
GRP_DEPLOYMENT_SUBSCRIPTION_ID?= $(GRP_SUBSCRIPTION_ID)
GRP_DEPLOYMENT_TEMPLATE_DIRPATH?= $(GRP_OUTPUTS_DIRPATH)
GRP_DEPLOYMENT_TEMPLATE_FILENAME?= $(GRP_DEPLOYMENT_NAME).json
GRP_DEPLOYMENT_TEMPLATE_FILEPATH?= $(GRP_DEPLOYMENT_TEMPLATE_DIRPATH)$(GRP_DEPLOYMENT_TEMPLATE_FILENAME)
GRP_DEPLOYMENTS_RESOURCEGROUP_NAME?= $(GRP_DEPLOYMENT_RESOURCEGROUP_NAME)

# Options parameters
## __GRP_CREATED= $(if $(filter created, $(GRP_DEPLOYMENT_WAIT_EVENT)),--created)
## __GRP_DELETED= $(if $(filter deleted, $(GRP_DEPLOYMENT_WAIT_EVENT)),--deleted)
## __GRP_EXISTS= $(if $(filter deleted, $(GRP_DEPLOYMENT_WAIT_EVENT)),--deleted)
__GRP_FILTER= $(if $(GRP_DEPLOYMENTS_FILTER),--filter $(GRP_DEPLOYMENTS_FILTER))
## __GRP_INCLUDE_COMMENTS=
## __GRP_INCLUDE_PARAMETER_DEFAULT_VALUE=
## __GRP_LOCATION= $(if $(GRP_DEPLOYMENT_LOCATION_ID),--location $(GRP_DEPLOYMENT_LOCATION_ID))
__GRP_NAME__DEPLOYMENT= $(if $(GRP_DEPLOYMENT_NAME),--name $(GRP_DEPLOYMENT_NAME))
## __GRP_NO_WAIT__DEPLOYMENT= $(if $(filter true, $(GRP_DEPLOYMENT_MODE_NOWAIT)),--no-wait)
# __GRP_OUTPUT?=
__GRP_RESOURCE_GROUP__DEPLOYMENT= $(if $(GRP_DEPLOYMENT_RESOURCEGROUP_NAME),--resource-group $(GRP_DEPLOYMENT_RESOURCEGROUP_NAME))
__GRP_RESOURCE_GROUP__DEPLOYMENTS= $(if $(GRP_DEPLOYMENTS_RESOURCEGROUP_NAME),--resource-group $(GRP_DEPLOYMENTS_RESOURCEGROUP_NAME))
## __GRP_TAGS= $(if $(GRP_DEPLOYMENT_TAGS_KEYVALUES),--tags $(GRP_DEPLOYMENT_TAGS_KEYVALUES))
__GRP_TOP=
## __GRP_UPDATED= $(if $(filter updated, $(GRP_DEPLOYMENT_WAIT_EVENT)),--updated)
## __GRP_YES__DEPLOYMENT= $(if $(filter false, $(GRP_DEPLOYMENT_MODE_YES)),--yes)

# Pipe
|_GRP_EXPORT_DEPLOYMENT?= | tee $(GRP_DEPLOYMENT_TEMPLATE_FILEPATH)

# UI parameters

#--- Utilities

#--- MACRO
## _grp_get_deployment_id= $(call _grp_get_deployment_id_N, $(GRP_DEPLOYMENT_NAME))
## _grp_get_deployment_id_N= $(call _grp_get_deployment_id_NS, $(1), $(GRP_DEPLOYMENT_SUBSCRIPTION_ID))
## _grp_get_deployment_id_NS= $(shell echo '/subscriptions/$(strip $(2))/deployments/$(strip $(1))')

#----------------------------------------------------------------------
# USAGE
#

_grp_view_framework_macros ::
	@echo 'AZ::GRouP::Deployment ($(_AZ_GROUP_DEPLOYMENT_MK_VERSION)) macros:'
	@## echo '    _grp_get_deployment_id_{|N|NS}   - Get the id of a deployment (Name,Subscription)'
	@echo

_grp_view_framework_parameters ::
	@echo 'AZ::Group::Deployment ($(_AZ_GROUP_DEPLOYMENT_MK_VERSION)) parameters:'
	@#echo '    GRP_DEPLOYMENT_ID=$(GRP_DEPLOYMENT_ID)'
	@#echo '    GRP_DEPLOYMENT_LOCATION_ID=$(GRP_DEPLOYMENT_LOCATION_ID)'
	@#echo '    GRP_DEPLOYMENT_MODE_NOWAIT=$(GRP_DEPLOYMENT_MODE_NOWAIT)'
	@#echo '    GRP_DEPLOYMENT_MODE_YES=$(GRP_DEPLOYMENT_MODE_YES)'
	@echo '    GRP_DEPLOYMENT_NAME=$(GRP_DEPLOYMENT_NAME)'
	@echo '    GRP_DEPLOYMENT_RESOURCEGROUP_NAME=$(GRP_DEPLOYMENT_RESOURCEGROUP_NAME)'
	@echo '    GRP_DEPLOYMENT_SUBSCRIPTION_ID=$(GRP_DEPLOYMENT_SUBSCRIPTION_ID)'
	@#echo '    GRP_DEPLOYMENT_TAGS_KEYVALUES=$(GRP_DEPLOYMENT_TAGS_KEYVALUES)'
	@echo '    GRP_DEPLOYMENT_TEMPLATE_DIRPATH=$(GRP_DEPLOYMENT_TEMPLATE_DIRPATH)'
	@echo '    GRP_DEPLOYMENT_TEMPLATE_FILENAME=$(GRP_DEPLOYMENT_TEMPLATE_FILENAME)'
	@echo '    GRP_DEPLOYMENT_TEMPLATE_FILEPATH=$(GRP_DEPLOYMENT_TEMPLATE_FILEPATH)'
	@#echo '    GRP_DEPLOYMENT_WAIT_EVENT=$(GRP_DEPLOYMENT_WAIT_EVENT)'
	@echo '    GRP_DEPLOYMENTS_FILTER=$(GRP_DEPLOYMENTS_FILTER)'
	@echo '    GRP_DEPLOYMENTS_RESOURCEGROUP_NAME=$(GRP_DEPLOYMENTS_RESOURCEGROUP_NAME)'
	@echo '    GRP_DEPLOYMENTS_SET_NAME=$(GRP_DEPLOYMENTS_SET_NAME)'
	@echo

_grp_view_framework_targets ::
	@echo 'AZ::Group::Deployment ($(_AZ_GROUP_DEPLOYMENT_MK_VERSION)) targets:'
	@echo '    _grp_create_deployment             - Create a deployment'
	@echo '    _grp_delete_deployment             - Delete a deployment'
	@echo '    _grp_export_deployment             - Export deployment'
	@echo '    _grp_show_deployment               - Show everything related to a deployment'
	@echo '    _grp_show_deployment_description   - Show desription of a deployment'
	@echo '    _grp_show_deployment_object        - Show the object of a deployment'
	@echo '    _grp_show_deployment_resources     - Show the resources in a deployment'
	@echo '    _grp_view_deployments              - View deployments'
	@echo '    _grp_view_deployments_set          - View a set of deployments'
	@echo '    _grp_wait_deployment               - Wait for deployment ot complete'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_grp_create_deployment:
	@$(INFO) '$(GRP_UI_LABEL)Creating deployment "$(GRP_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	#$(AZ) group deployment create $(__GRP_LOCATION) $(__GRP_NAME__DEPLOYMENT) $(__GRP_OUTPUT) $(__GRP_SUBSCRIPTION) $(__GRP_TAGS)

_grp_delete_deployment:
	@$(INFO) '$(GRP_UI_LABEL)Deleting deployment "$(GRP_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	#$(AZ) group deployment delete $(__GRP_NAME__DEPLOYMENT) $(__GRP_NO_WAIT__DEPLOYMENT) $(__GRP_OUTPUT) $(__GRP_SUBSCRIPTION) $(__GRP_YES__DEPLOYMENT)

_grp_export_deployment:
	@$(INFO) '$(GRP_UI_LABEL)Export deployment "$(GRP_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	#$(AZ) group deployment export $(__GRP_NAME__DEPLOYMENT) $(__GRP_INCLUDE_COMMENTS) $(__GRP_INCLUDE_PARAMETER_DEFAULT_VALUE) $(_X__GRP_OUTPUT) --output json $(__GRP_SUBSCRIPTION) $(|_GRP_EXPORT_DEPLOYMENT)

_grp_show_deployment :: _grp_show_deployment_object _grp_show_deployment_resources _grp_show_deployment_description

_grp_show_deployment_description:
	@$(INFO) '$(GRP_UI_LABEL)Showing description of deployment "$(GRP_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	$(AZ) group deployment show $(__GRP_NAME__DEPLOYMENT) $(__GRP_OUTPUT) $(__GRP_RESOURCE_GROUP__DEPLOYMENT) $(__GRP_SUBSCRIPTION)

_grp_show_deployment_object:
	@$(INFO) '$(GRP_UI_LABEL)Showing the object of deployment "$(GRP_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	$(AZ) group deployment show $(__GRP_NAME__DEPLOYMENT) $(_X__GRP_OUTPUT) --output json $(__GRP_RESOURCE_GROUP__DEPLOYMENT) $(__GRP_SUBSCRIPTION)

_grp_show_deployment_resources ::
	@$(INFO) '$(GRP_UI_LABEL)Showing resources in deployment "$(GRP_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	$(AZ) group deployment show $(__GRP_NAME__DEPLOYMENT) $(__GRP_OUTPUT) $(__GRP_RESOURCE_GROUP__DEPLOYMENT) $(__GRP_SUBSCRIPTION)  --query 'properties.outputResources[].id'
	@# To be implemented!

_grp_validate_deployment:
	@$(INFO) '$(GRP_UI_LABEL)Validating deployment "$(GRP_DEPLOYMENT_NAME)" ...'; $(NORMAL)

_grp_view_deployments:
	@$(INFO) '$(GRP_UI_LABEL)Viewing deployments ...'; $(NORMAL)
	$(AZ) group deployment list $(_X__GRP_FILTER) $(__GRP_OUTPUT) $(__GRP_RESOURCE_GROUP__DEPLOYMENTS) $(__GRP_SUBSCRIPTION) $(_X__GRP_TOP)

_grp_view_deployments_set:
	@$(INFO) '$(GRP_UI_LABEL)Viewing deployments-set "$(GRP_DEPLOYMENTS_SET_NAME) ...'; $(NORMAL)
	@$(WARN) 'Deployments are grouped based on the provided filter, resource-group, top, and query-filter'; $(NORMAL)
	$(AZ) group deployment list $(__GRP_FILTER) $(__GRP_OUTPUT) $(__GRP_RESOURCE_GROUP__DEPLOYMENTS) $(__GRP_SUBSCRIPTION) $(__GRP_TOP)

_grp_wait_deployment:
	@$(INFO) '$(GRP_UI_LABEL)Waiting for deployment "$(GRP_DEPLOYMENT_NAME)" ...'; $(NORMAL)
	$(AZ) wait $(__GRP_CREATED) $(__GRP_CUSTOM) $(__GRP_DELETED) $(__GRP_EXISTS) $(__GRP_INTERVAL) $(__GRP_NAME__DEPLOYMENT) $(__GRP_SUBSCRIPTION) $(__GRP_TIMEOUT) $(__GRP_UPDATED)
