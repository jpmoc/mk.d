_VMC_VKE_ACCOUNT_MK_VERSION= $(_VMC_VKE_MK_VERSION)

# VKE_ACCOUNT_ORGANIZATION_ID?= 82c51815-bced-4b00-a49a-XXXXXXXXXXX
# VKE_ACCOUNT_ORGANIZATION_NAME?= nsx_sm_01
# VKE_ACCOUNT_REFRESH_TOKEN?= 78473052-fd14-4147-96d1-XXXXXXXX

# Derived variables
VKE_ACCOUNT_ORGANIZATION_NAME?= $(VKE_ORGANIZATION_NAME)
VKE_ACCOUNT_ORGANIZATION_ID?= $(VKE_ORGANIZATION_ID)
VKE_ACCOUNT_REFRESH_TOKEN?= $(CSP_REFRESH_TOKEN)

# Option variables
__VKE_ORGANIZATION= $(if $(VKE_ACCOUNT_ORGANIZATION_ID),--organization $(VKE_ACCOUNT_ORGANIZATION_ID))
__VKE_REFRESH_TOKEN= $(if $(VKE_ACCOUNT_REFRESH_TOKEN),--refresh-token $(VKE_ACCOUNT_REFRESH_TOKEN))

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#


_vke_view_framework_macros ::
	@#echo 'VMC::VKE::Account ($(_VMC_VKE_ACCOUNT_MK_VERSION)) macros:'
	@#echo

_vke_view_framework_parameters ::
	@echo 'VMC::VKE::Account ($(_VMC_VKE_ACCOUNT_MK_VERSION)) parameters:'
	@echo '    VKE_ACCOUNT_ORGANIZATION_NAME=$(VKE_ACCOUNT_ORGANIZATION_NAME)'
	@echo '    VKE_ACCOUNT_ORGANIZATION_ID=$(VKE_ACCOUNT_ORGANIZATION_ID)'
	@echo '    VKE_ACCOUNT_REFRESH_TOKEN=$(VKE_ACCOUNT_REFRESH_TOKEN)'
	@echo

_vke_view_framework_targets ::
	@echo 'VMC::VKE::Account ($(_VMC_VKE_ACCOUNT_MK_VERSION)) targets:'
	@echo '    _vke_login_account                   - Log in an account'
	@echo '    _vke_logout_account                  - Log out of an account'
	@echo '    _vke_show_account                    - Show everything related to an account'
	@echo '    _vke_show_account_configuration      - Show configuration of an account'
	@echo '    _vke_show_account_description        - Show description of an account'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vke_login_account:
	@$(INFO) '$(VKE_UI_LABEL)Logging into account of organization "${VKE_ACCOUNT_ORGANIZATION_NAME}" ...'; $(NORMAL)
	$(VKE) account login $(__VKE_ORGANIZATION) $(__VKE_REFRESH_TOKEN)

_vke_logout_account:
	@$(INFO) '$(VKE_UI_LABEL)Logging out account of organization "${VKE_ACCOUNT_ORGANIZATION_NAME}" ...'; $(NORMAL)

_vke_show_account: _vke_show_account_configuration _vke_show_account_description

_vke_show_account_configuration:
	@$(INFO) '$(VKE_UI_LABEL)Showing configuration for account ...'; $(NORMAL)
	cat ~/.vke-cli/vke-config | jq '.'; echo

_vke_show_account_description:
	@$(INFO) '$(VKE_UI_LABEL)Showing description of account ...'; $(NORMAL)
	$(VKE) account show
