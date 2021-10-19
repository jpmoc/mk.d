_VMC_VDP_ROLE_MK_VERSION= $(_VMC_VDP_MK_VERSION)

# VDP_ROLE_NAME?= vdp:guru
# VDP_ROLE_ORGANIZATION_NAME?=
# VDP_ROLE_PROJECT_NAME?=
# VDP_ROLE_USER_NAME?= 

# Derived variables
VDP_ROLE_ORGANIZATION_NAME?= $(VDP_ORGANIZATION_NAME)
VDP_ROLE_PROJECT_NAME?= $(VDP_PROJECT_NAME)

# Option variables
__VDP_ORG__ROLE= $(if $(VDP_ROLE_ORGANIZATION_NAME),--org $(VDP_ROLE_ORGANIZATION_NAME))
__VDP_PROJECT__ROLE= $(if $(VDP_ROLE_PROJECT_NAME),--project $(VDP_ROLE_PROJECT_NAME))

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_vdp_view_framework_macros ::
	@#echo 'VmwareClouD::VDP::Namespace ($(_VMC_VDP_ROLE_MK_VERSION)) macros:'
	@#echo

_vdp_view_framework_parameters ::
	@echo 'VmwareClouD::VDP::Namespace ($(_VMC_VDP_ROLE_MK_VERSION)) parameters:'
	@echo '    VDP_ROLE_NAME=$(VDP_ROLE_NAME)             # Must start with vdp:'
	@echo '    VDP_ROLE_ORGANIZATION_NAME=$(VDP_ROLE_ORGANIZATION_NAME)'
	@echo '    VDP_ROLE_PROJECT_NAME=$(VDP_ROLE_PROJECT_NAME)'
	@echo '    VDP_ROLE_USER_NAME=$(VDP_ROLE_USER_NAME)'
	@echo

_vdp_view_framework_targets ::
	@echo 'VmwareClouD::VDP::Namespace ($(_VMC_VDP_ROLE_MK_VERSION)) targets:'
	@echo '    _vdp_append_role                  - Append a new role to a user'
	@echo '    _vdp_attach_role                  - Attach a specific role to a user'
	@echo '    _vdp_create_role                  - Create a new role'
	@echo '    _vdp_delete_role                  - Delete an existing role'
	@echo '    _vdp_show_role                    - Show everything related to a role'
	@echo '    _vdp_view_roles                   - View roles'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vdp_append_role:
	@$(INFO) '$(VDP_UI_LABEL)Appending role "$(VDP_ROLE_NAME)" to user "$(VDP_ROLE_USER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'VDP roles are K8s role objects'; $(NORMAL)
	$(VDP) roles set $(VDP_ROLE_USER_NAME)+=$(VDP_ROLE_NAME) $(__VDP_ORG__ROLE) $(__VDP_PROJECT__ROLE)

_vdp_attach_role:
	@$(INFO) '$(VDP_UI_LABEL)Attaching role "$(VDP_ROLE_NAME)" to user "$(VDP_ROLE_USER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'VDP roles are K8s role objects'; $(NORMAL)
	$(VDP) roles set $(VDP_ROLE_USER_NAME)=$(VDP_ROLE_NAME) $(__VDP_ORG__ROLE) $(__VDP_PROJECT__ROLE)

_vdp_create_role:
	@$(INFO) '$(VDP_UI_LABEL)Creating role "$(VDP_ROLE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'VDP roles are K8s role objects. They are created with the kubectl command.'; $(NORMAL)

_vdp_delete_role:
	@$(INFO) '$(VDP_UI_LABEL)Deleting role "$(VDP_ROLE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'VDP roles are K8s role objects and can only be deleted with the kubectl command'; $(NORMAL)

_vdp_remove_role:
	@$(INFO) '$(VDP_UI_LABEL)Remove role "$(VDP_ROLE_NAME)" from user "$(VDP_ROLE_USER_NAME)" ...'; $(NORMAL)
	$(VDP) roles set $(VDP_ROLE_USER_NAME)-=$(VDP_ROLE_NAME)

_vdp_show_role:
	@$(INFO) '$(VDP_UI_LABEL)Showing role "$(VDP_ROLE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'VDP roles are K8s role objects and can only be described with the kubectl command'; $(NORMAL)

_vdp_view_roles:
	@$(INFO) '$(VDP_UI_LABEL)Viewing roles ...'; $(NORMAL)
	@$(WARN) 'VDP roles are K8s role objects and can only be described with the kubectl command'; $(NORMAL)
