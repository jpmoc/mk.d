_KUBECTL_USER_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_USER_NAME?= 

# Derived parameters

# Option parameters

# UI parameters
|_KCL_SHOW_URSER_RBACRULES?=

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@echo 'KubeCtL::User ($(_KUBECTL_USER_MK_VERSION)) macros:'
	@echo

_kcl_list_parameters ::
	@echo 'KubeCtL::User ($(_KUBECTL_USER_MK_VERSION)) parameters:'
	@echo '    KCL_USER_NAME=$(KCL_USER_NAME)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::User ($(_KUBECTL_USER_MK_VERSION)) targets:'
	@echo '    _kcl_show_user                   - Show everything related to a user'
	@echo '    _kcl_show_user_description       - Show description of a user'
	@echo '    _kcl_show_user_rbacrules         - Show RBAC-rules attached to a user'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_create_user:

_kcl_delete_user:

_KCL_SHOW_USER_TARGETS: _kcl_show_user_rights _kcl_show_user_description
_kcl_show_user: $(_KCL_SHOW_USER_TARGETS)

_kcl_show_user_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of user "$(KCL_USER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'While Kubernetes uses usernames for access control decisions and in request logging, it does not have a User object nor does it store usernames or other information about users in its API.'; $(NORMAL)'

_kcl_show_user_rbacrules:
	@$(INFO) '$(KCL_UI_LABEL)Showing RBAC-rules of user "$(KCL_USER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) auth can-i $(_X_AS__USER) --list $(|_KCL_SHOW_USER_RBACRULES)
