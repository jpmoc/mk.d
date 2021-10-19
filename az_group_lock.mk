_AZ_GROUP_LOCK_MK_VERSION= $(_AZ_GROUP_MK_VERSION)

# GRP_LOCK_ID?= /subscriptions/<subscriptionid>/locks/my-lock
# GRP_LOCK_NAME?= my-lock
# GRP_LOCK_RESOURCEGROUP_NAME?= my-resource-group
# GRP_LOCK_SUBSCRIPTION_ID?=
# GRP_LOCK_TYPE?= CanNotDelete
# GRP_LOCKS_IDS?=
# GRP_LOCKS_RESOURCEGROUP_NAME?= my-resource-group
# GRP_LOCKS_SET_NAME?= my-lock-set

# Derived parameters
GRP_LOCK_ID?= /subscriptions/$(GRP_LOCK_SUBSCRIPTION_ID)/resourceGroups/$(GRP_LOCK_RESOURCEGROUP_NAME)/providers/Microsoft.Authorization/locks/$(GRP_LOCK_NAME)
GRP_LOCK_RESOURCEGROUP_NAME?= $(AZ_RESOURCEGROUP_NAME)
GRP_LOCK_SUBSCRIPTION_ID?= $(GRP_SUBSCRIPTION_ID)
GRP_LOCKS_RESOURCEGROUP_NAME?= $(GRP_LOCK_RESOURCEGROUP_NAME)

# Options parameters
__GRP_FILTER_STRING=
__GRP_IDS__LOCK= $(if $(GRP_LOCK_ID),--ids $(GRP_LOCK_ID))
__GRP_IDS__LOCKS= $(if $(GRP_LOCKS_IDS),--ids $(GRP_LOCKS_IDS))
__GRP_LOCK_TYPE= $(if $(GRP_LOCK_TYPE),--lock-type $(GRP_LOCK_TYPE))
__GRP_NAME__LOCK= $(if $(GRP_LOCK_NAME),--name $(GRP_LOCK_NAME))
__GRP_NOTE=
# __GRP_OUTPUT?=
__GRP_RESOURCE_GROUP__LOCK= $(if $(GRP_LOCK_RESOURCEGROUP_NAME),--resource-group $(GRP_LOCK_RESOURCEGROUP_NAME))
__GRP_RESOURCE_GROUP__LOCKS= $(if $(GRP_LOCKS_RESOURCEGROUP_NAME),--resource-group $(GRP_LOCKS_RESOURCEGROUP_NAME))

# UI parameters

#--- Utilities

#--- MACRO
_grp_get_lock_id= $(call _grp_get_lock_id_N, $(GRP_LOCK_NAME))
_grp_get_lock_id_N= $(call _grp_get_lock_id_NS, $(1), $(GRP_LOCK_SUBSCRIPTION_ID))
_grp_get_lock_id_NS= $(shell echo '/subscriptions/$(strip $(2))/locks/$(strip $(1))')

#----------------------------------------------------------------------
# USAGE
#

_grp_view_framework_macros ::
	@echo 'AZ::GRouP::Lock ($(_AZ_GROUP_LOCK_MK_VERSION)) macros:'
	@echo '    _grp_get_lock_id_{|N|NS}   - Get the id of a lock (Name,Subscription)'
	@echo

_grp_view_framework_parameters ::
	@echo 'AZ::Group::Lock ($(_AZ_GROUP_LOCK_MK_VERSION)) parameters:'
	@echo '    GRP_LOCK_ID=$(GRP_LOCK_ID)'
	@echo '    GRP_LOCK_NAME=$(GRP_LOCK_NAME)'
	@echo '    GRP_LOCK_RESOURCEGROUP_NAME=$(GRP_LOCK_RESOURCEGROUP_NAME)'
	@echo '    GRP_LOCK_TYPE=$(GRP_LOCK_TYPE)'
	@echo '    GRP_LOCK_SUBSCRIPTION_ID=$(GRP_LOCK_SUBSCRIPTION_ID)'
	@echo '    GRP_LOCKS_RESOURCEGROUP_NAME=$(GRP_LOCKS_RESOURCEGROUP_NAME)'
	@echo '    GRP_LOCKS_SET_NAME=$(GRP_LOCKS_SET_NAME)'
	@echo

_grp_view_framework_targets ::
	@echo 'AZ::Group::Lock ($(_AZ_GROUP_LOCK_MK_VERSION)) targets:'
	@echo '    _grp_create_lock             - Create a lock'
	@echo '    _grp_delete_lock             - Delete a lock'
	@echo '    _grp_show_lock               - Show everything related to a lock'
	@echo '    _grp_show_lock_description   - Show desription of a lock'
	@echo '    _grp_show_lock_object        - Show the object of a lock'
	@echo '    _grp_update_lock             - Update a lock'
	@echo '    _grp_view_locks              - View locks'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_grp_create_lock:
	@$(INFO) '$(GRP_UI_LABEL)Creating lock "$(GRP_LOCK_NAME)" ...'; $(NORMAL)
	$(AZ) group lock create $(__GRP_LOCK_TYPE) $(__GRP_NAME__LOCK) $(__GRP_NOTES) $(__GRP_OUTPUT) $(__GRP_RESOURCE_GROUP__LOCK) $(__GRP_SUBSCRIPTION)

_grp_delete_lock:
	@$(INFO) '$(GRP_UI_LABEL)Deleting lock "$(GRP_LOCK_NAME)" ...'; $(NORMAL)
	$(AZ) group lock delete $(__GRP_IDS__LOCK) $(__GRP_NAME__LOCK) $(__GRP_OUTPUT) $(__GRP_RESOURCE_GROUP__LOCK) $(__GRP_SUBSCRIPTION) $(__GRP_YES__LOCK)

_grp_show_lock :: _grp_show_lock_object _grp_show_lock_description

_grp_show_lock_description:
	@$(INFO) '$(GRP_UI_LABEL)Showing description of lock "$(GRP_LOCK_NAME)" ...'; $(NORMAL)
	$(AZ) group lock show $(__GRP_IDS__LOCK) $(__GRP_NAME__LOCK) $(__GRP_OUTPUT) $(__GRP_RESOURCE_GROUP__LOCK) $(__GRP_SUBSCRIPTION)

_grp_show_lock_object:
	@$(INFO) '$(GRP_UI_LABEL)Showing the object of lock "$(GRP_LOCK_NAME)" ...'; $(NORMAL)
	$(AZ) group lock show $(__GRP_IDS__LOCK) $(__GRP_NAME__LOCK) $(_X__GRP_OUTPUT) --output json $(__GRP_RESOURCE_GROUP__LOCK) $(__GRP_SUBSCRIPTION)

_grp_update_lock:
	@$(INFO) '$(GRP_UI_LABEL)Updating lock "$(GRP_LOCK_NAME)" ...'; $(NORMAL)
	$(AZ) group lock update $(__GRP_IDS__LOCK) $(__GRP_LOCK_TYPE) $(__GRP_NAME__LOCK) $(__GRP_NOTES) $(__GRP_OUTPUT) $(__GRP_RESOURCE_GROUP__LOCK) $(__GRP_SUBSCRIPTION)

_grp_view_locks:
	@$(INFO) '$(GRP_UI_LABEL)Viewing locks ...'; $(NORMAL)
	$(AZ) group lock list $(_X__GRP_FILTER_STRING) $(__GRP_OUTPUT) $(__GRP_RESOURCE_GROUP__LOCKS) $(__GRP_SUBSCRIPTION)

_grp_view_locks_set:
	@$(INFO) '$(GRP_UI_LABEL)Viewing locks-set "$(GRP_LOCKS_SET_NAME) ...'; $(NORMAL)
	$(AZ) group lock list $(__GRP_FILTER_STRING) $(__GRP_OUTPUT) $(__GRP_RESOURCE_GROUP__LOCKS) $(__GRP_SUBSCRIPTION)
