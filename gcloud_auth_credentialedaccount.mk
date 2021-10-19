_GCLOUD_AUTH_CREDENTIALEDACCOUNT_MK_VERSION= $(_GCLOUD_AUTH_MK_VERSION)

GAH_CREDENTIALEDACCOUNT_ACTIVATE_ENABLE?= true
# GAH_CREDENTIALEDACCOUNT_GDRIVEACCESS_ENABLE?= true
GAH_CREDENTIALEDACCOUNT_LAUNCHBROWSER_ENABLE?= true
# GAH_CREDENTIALEDACCOUNT_LOGIN_FORCE?= false
# GAH_CREDENTIALEDACCOUNT_USERACCOUNT_EMAIL?= emayssat@vmware.com

# Derived parameters
GAH_CREDENTIALEDACCOUNT_NAME?= $(GCD_ACTIVECREDENTIALEDACCOUNT_NAME)
GAH_CREDENTIALEDACCOUNT_USERACCOUNT_EMAIL?= $(GAH_CREDENTIALEDACCOUNT_NAME)

# Options parameters
__GAH_ACTIVATE= $(if $(filter false, $(GAH_CREDENTIALEDACCOUNT_ACTIVATE_ENABLE)),--no-activate,--activate)
__GAH_ALL=
__GAH_BRIEF=
__GAH_ENABLE_GDRIVE_ACCESS= $(if $(filter true, $(GAH_CREDENTIALEDACCOUNT_GDRIVEACCESS_ENABLE)),--enable-gdrive-access)
__GAH_FILTER=
__GAH_FILTER_ACCOUNT=
__GAH_FORCE= $(if $(filter true,$(GAH_CREDENTIALEDACCOUNT_LOGIN_FORCE)),--force)
__GAH_LAUNCH_BROWSER= $(if $(filter false, $(GAH_CREDENTIALEDACCOUNT_LAUNCHBROWSER_ENBLE)), --no-launch-browser, --launch-browser)
__GAH_LIMIT=
__GAH_PAGE_SIZE=
__GAH_SORT_BY=

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_gah_view_framework_macros ::
	@echo 'Gcloud::AutH::CredentialedAccount ($(_GCLOUD_AUTH_CREDENTIALEDACCOUNT_MK_VERSION)) macros:'
	@echo


_gah_view_framework_parameters ::
	@echo 'Gcloud::AutH::CredentialedAccount ($(_GCLOUD_AUTH_CREDENTIALEDACCOUNT_MK_VERSION)) parameters:'
	@echo '    GAH_CREDENTIALEDACCOUNT_ACTIVATE_ENABLE=$(GAH_CREDENTIALEDACCOUNT_ACTIVATE_ENABLE)'
	@echo '    GAH_CREDENTIALEDACCOUNT_GDRIVEACCESS_ENABLE=$(GAH_CREDENTIALEDACCOUNT_GDRIVEACCESS_ENABLE)'
	@echo '    GAH_CREDENTIALEDACCOUNT_LAUNCHBROWSER_ENABLE=$(GAH_CREDENTIALEDACCOUNT_LAUNCHBROWSER_ENABLE)'
	@echo '    GAH_CREDENTIALEDACCOUNT_USERACCOUNT_EMAIL=$(GAH_CREDENTIALEDACCOUNT_USERACCOUNT_EMAIL)'
	@echo

_gah_view_framework_targets ::
	@echo 'Gcloud::AutH::CredentialedAccount ($(_GCLOUD_AUTH_CREDENTIALEDACCOUNT_MK_VERSION)) targets:'
	@echo '    _gcq_login_useraccount                 - Login as user-account'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_gah_create_credentialedaccount:
	@$(INFO) '$(GCD_UI_LABEL)Creating credentialed account "$(GAH_CREDENTIALEDACCOUNT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the provided user-account email does NOT match the selected Google account'; $(NORMAL)
	@$(WARN) 'If no GUI is availabe, prints a URL to standard output to be copied'; $(NORMAL)
	$(GCLOUD) auth login $(__GAH_ACTIVATE) $(__GAH_BRIEF) $(__GAH_ENABLE_GDRIVE_ACCESS) $(__GAH_FORCE) $(__GAH_LAUNCH_BROWSER) $(GAH_CREDENTIALEDACCOUNT_USERACCOUNT_EMAIL)

_gah_delete_credentialedaccount:
	@$(INFO) '$(GCD_UI_LABEL)Delete credentialed account "$(GAH_CREDENTIALEDACCOUNT_NAME)" ...'; $(NORMAL)
	$(GCLOUD) auth revoke $(_X__GAH_ALL) $(GCG_CREDENTIALEDACCOUNT_NAME)

_gah_show_credentialedaccount:
	@$(INFO) '$(GCD_UI_LABEL)Showing credentialed account "$(GAH_CREDENTIALEDACCOUNT_NAME)" ...'; $(NORMAL)
	$(GCLOUD) auth list $(__GAH_FILTER) $(__GAH_FILTER_ACCOUNT) $(__GAH_LIMIT) $(__GAH_PAGE_SIZE) $(__GAH_SORT_BY)

_gah_view_credentialedaccounts:
	@$(INFO) '$(GCD_UI_LABEL)View credentialed accounts ...'; $(NORMAL)
	$(GCLOUD) auth list $(__GAH_FILTER) $(__GAH_FILTER_ACCOUNT) $(__GAH_LIMIT) $(__GAH_PAGE_SIZE) $(__GAH_SORT_BY)
