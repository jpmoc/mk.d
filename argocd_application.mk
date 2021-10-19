_ARGOCD_APPLICATION_MK_VERSION= $(_ARGOCD_MK_VERSION)

# ACD_APPLICATION_APISERVER_URL?= https://kubernetes.default.svc
# ACD_APPLICATION_NAME?= my-application
# ACD_APPLICATION_NAMESPACE_NAME?= default
# ACD_APPLICATION_PROJECT_NAME?= my-project
# ACD_APPLICATION_REPO_URL?= https://github.com/argoproj/argocd-example-apps.git
# ACD_APPLICATION_REPO_PATH?= guestbook
# ACD_APPLICATION_TOKEN_JWT?= 
ACD_APPLICATIONS_REGEX?= *
# ACD_APPLICATIONS_SET_NAME?= my-applications-set

# Derived parameters
ACD_APPLICATION_PROJECT_NAME?= $(ACD_PROJECT_NAME)
ACD_APPLICATION_TOKEN_JWT?= $(ACD_ROLE_TOKEN_JWT)
ACD_APPLICATIONS_SET_NAME?= applications@@@$(ACD_APPLICATIONS_REGEX)

# Option parameters
__ACD_AUTH_TOKEN__APPLICATION= $(if $(ACD_APPLICATION_TOKEN_JWT),--auth-token $(ACD_APPLICATION_TOKEN_JWT))
__ACD_DEST_NAMESPACE= $(if $(ACD_APPLICATION_NAMESPACE_NAME),--dest-namespace $(ACD_APPLICATION_NAMESPACE_NAME))
__ACD_DEST_SERVER= $(if $(ACD_APPLICATION_APISERVER_URL),--dest-server $(ACD_APPLICATION_APISERVER_URL))
__ACD_PATH= $(if $(ACD_APPLICATION_REPO_PATH),--path $(ACD_APPLICATION_REPO_PATH))
__ACD_PROJECT__APPLICATION= $(if $(ACD_APPLICATION_PROJECT_NAME),--project $(ACD_APPLICATION_PROJECT_NAME))
__ACD_REPO= $(if $(ACD_APPLICATION_REPO_URL),--repo $(ACD_APPLICATION_REPO_URL))

# UI parameters
|_ACD_SHOW_APPLICATION_MANIFEST?= | head -20; echo '...'
|_ACD_VIEW_APPLICATIONS_SET?= | grep -E 'NAME|$(ACD_APPLICATIONS_REGEX)'

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_acd_view_framework_macros ::
	@echo 'ArgoCD::Application ($(_ARGOCD_APPLICATION_MK_VERSION)) macros:'
	@echo

_acd_view_framework_parameters ::
	@echo 'ArgoCD::Application ($(_ARGOCD_APPLICATION_MK_VERSION)) parameters:'
	@echo '    ACD_APPLICATION_APISERVER_URL=$(ACD_APPLICATION_APISERVER_URL)'
	@echo '    ACD_APPLICATION_HISTORY_ID=$(ACD_APPLICATION_HISTORY_ID)'
	@echo '    ACD_APPLICATION_NAME=$(ACD_APPLICATION_NAME)'
	@echo '    ACD_APPLICATION_NAMESPACE_NAME=$(ACD_APPLICATION_NAMESPACE_NAME)'
	@echo '    ACD_APPLICATION_NEWPROJECT_NAME=$(ACD_APPLICATION_NEWPROJECT_NAME)'
	@echo '    ACD_APPLICATION_OLDPROJECT_NAME=$(ACD_APPLICATION_OLDPROJECT_NAME)'
	@echo '    ACD_APPLICATION_PROJECT_NAME=$(ACD_APPLICATION_PROJECT_NAME)'
	@echo '    ACD_APPLICATION_REPO_URL=$(ACD_APPLICATION_REPO_URL)'
	@echo '    ACD_APPLICATION_REPO_PATH=$(ACD_APPLICATION_REPO_PATH)'
	@echo '    ACD_APPLICATION_TOKEN_JWT=$(ACD_APPLICATION_TOKEN_JWT)'
	@echo '    ACD_APPLICATIONS_REGEX=$(ACD_APPLICATIONS_REGEX)'
	@echo '    ACD_APPLICATIONS_SET_NAME=$(ACD_APPLICATIONS_SET_NAME)'
	@echo

_acd_view_framework_targets ::
	@echo 'ArgoCD::Application ($(_ARGOCD_APPLICATION_MK_VERSION)) targets:'
	@echo '    _acd_create_application                 - Create an application'
	@echo '    _acd_delete_application                 - Delete an application'
	@echo '    _acd_disable_application_autoprune      - Disable auto-prune of an application'
	@echo '    _acd_disable_application_autosync       - Disable auto-sync of an application'
	@echo '    _acd_disable_application_selfhealing    - Disable self-healing of an application'
	@echo '    _acd_enable_application_autoprune       - Enable auto-prune of an application'
	@echo '    _acd_enable_application_autosync        - Enable auto-sync of an application'
	@echo '    _acd_enable_application_selfhealing     - Enable self-healing of an application'
	@echo '    _acd_diff_application                   - Diff an application'
	@echo '    _acd_rollback_application               - Rollback an application'
	@echo '    _acd_show_application                   - Show everything related to an application'
	@echo '    _acd_show_application_description       - Show description of an application'
	@echo '    _acd_show_application_diff              - Show diff of an application'
	@echo '    _acd_show_application_history           - Show history of an application'
	@echo '    _acd_show_application_manifest          - Show manifest of an application'
	@echo '    _acd_show_application_object            - Show object of an application'
	@echo '    _acd_show_application_state             - Show state of an application'
	@echo '    _acd_show_application_status            - Show state of an application'
	@echo '    _acd_sync_application                   - Sync an application'
	@echo '    _acd_update_application_project         - Update project of an application'
	@echo '    _acd_view_applications                  - View applications'
	@echo '    _acd_view_applications_set              - View set of applications'
	@echo '    _acd_waitfor_application                - Wait for an application'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_acd_create_application:
	@$(INFO) '$(ACD_UI_LABEL)Creating application "$(ACD_APPLICATION_NAME)" ...'; $(NORMAL)
	$(ARGOCD) app create $(__ACD_DEST_NAMESPACE) $(__ACD_DEST_SERVER) $(__ACD_PATH) $(__ACD_REPO) $(ACD_APPLICATION_NAME)

_acd_delete_application:
	@$(INFO) '$(ACD_UI_LABEL)Deleting application "$(ACD_APPLICATION_NAME)" ...'; $(NORMAL)
	$(ARGOCD) app delete $(ACD_APPLICATION_NAME)

_acd_diff_application:
	@$(INFO) '$(ACD_UI_LABEL)Diff-ing content of repo with live application "$(ACD_APPLICATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns an empty diff whenever the application is in sync'; $(NORMAL)
	$(ARGOCD) app diff $(ACD_APPLICATION_NAME)

_acd_disable_application_autoprune:
	@$(INFO) '$(ACD_UI_LABEL)Disable auto-sync of application "$(ACD_APPLICATION_NAME)" ...'; $(NORMAL)
	# $(ARGOCD) app set $(ACD_APPLICATION_NAME) --sync-policy automated

_acd_disable_application_autosync:
	@$(INFO) '$(ACD_UI_LABEL)Disable auto-sync of application "$(ACD_APPLICATION_NAME)" ...'; $(NORMAL)
	# $(ARGOCD) app set $(ACD_APPLICATION_NAME) --sync-policy automated

_acd_disable_application_selfhealing:
	@$(INFO) '$(ACD_UI_LABEL)Disable self-healing of application "$(ACD_APPLICATION_NAME)" ...'; $(NORMAL)
	# $(ARGOCD) app set $(ACD_APPLICATION_NAME) --sync-policy automated

_acd_enable_application_autoprune:
	@$(INFO) '$(ACD_UI_LABEL)Enable auto-prune of application "$(ACD_APPLICATION_NAME)" ...'; $(NORMAL)
	$(ARGOCD) app set $(ACD_APPLICATION_NAME) --auto-prune

_acd_enable_application_autosync:
	@$(INFO) '$(ACD_UI_LABEL)Enable auto-sync of application "$(ACD_APPLICATION_NAME)" ...'; $(NORMAL)
	$(ARGOCD) app set $(ACD_APPLICATION_NAME) --sync-policy automated

_acd_enable_application_selfhealing:
	@$(INFO) '$(ACD_UI_LABEL)Enable self-healing of application "$(ACD_APPLICATION_NAME)" ...'; $(NORMAL)
	$(ARGOCD) app set $(ACD_APPLICATION_NAME) --self-heal

_acd_rollback_application:
	@$(INFO) '$(ACD_UI_LABEL)Rolling back application "$(ACD_APPLICATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the automatic-sync is enabled'; $(NORMAL)
	$(ARGOCD) app rollback $(ACD_APPLICATION_NAME) $(ACD_APPLICATION_HISTORY_ID)

_acd_show_application :: _acd_show_application_diff _acd_show_application_history _acd_show_application_manifest _acd_show_application_description

_acd_show_application_description:
	@$(INFO) '$(ACD_UI_LABEL)Showing description application "$(ACD_APPLICATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns whether the application is in or out-of-sync'; $(NORMAL)
	$(ARGOCD) app get $(__ACD_AUTH_TOKEN__APPLICATION) $(ACD_APPLICATION_NAME)

_acd_show_application_diff:
	@$(INFO) '$(ACD_UI_LABEL)Showing diff of application "$(ACD_APPLICATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns an empty diff whenever the application is in sync'; $(NORMAL)
	@$(WARN) 'This operation fails if the diff is not empty'; $(NORMAL)
	-$(ARGOCD) app diff $(ACD_APPLICATION_NAME)

_acd_show_application_history:
	@$(INFO) '$(ACD_UI_LABEL)Showing history of application "$(ACD_APPLICATION_NAME)" ...'; $(NORMAL)
	$(ARGOCD) app history $(ACD_APPLICATION_NAME)

_acd_show_application_manifest:
	@$(INFO) '$(ACD_UI_LABEL)Showing manifest of application "$(ACD_APPLICATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the application manifest based on the content of the repository'; $(NORMAL)
	$(ARGOCD) app manifests $(ACD_APPLICATION_NAME) $(|_ACD_SHOW_APPLICATION_MANIFEST)

_acd_sync_application:
	@$(INFO) '$(ACD_UI_LABEL)Sync-ing application "$(ACD_APPLICATION_NAME)" ...'; $(NORMAL)
	$(ARGOCD) app sync $(ACD_APPLICATION_NAME)

_acd_update_application_project:
	@$(INFO) '$(ACD_UI_LABEL)Updating project for application "$(ACD_APPLICATION_NAME)" ...'; $(NORMAL)
	$(ARGOCD) app set $(__ACD_PROJECT__APPLICATION) $(ACD_APPLICATION_NAME)

_acd_view_applications:
	@$(INFO) '$(ACD_UI_LABEL)View applications ...'; $(NORMAL)
	$(ARGOCD) app list $(__ACD_PROJECT__APPLICATION)

_acd_view_applications_set:
	@$(INFO) '$(ACD_UI_LABEL)Viewing applications-set "$(ACD_APPLICATIONS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Applications are grouped based on provided project and regex'; $(NORMAL)
	$(ARGGOCD) app list $(__ACD_PROJECT__APPLICATION) $(|_ACD_VIEW_APPLICATIONS_SET)

_acd_waitfor_application:
	@$(INFO) '$(ACD_UI_LABEL)Waiting for applications-set "$(ACD_APPLICATIONS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation completes once the application has reached a steady state'; $(NORMAL)
	$(ARGOCD) app wait $(ACD_APPLICATION_NAME)
