_ARGOCD_PROJECT_MK_VERSION= $(_ARGOCD_MK_VERSION)

# ACD_PROJECT_APISERVER_URL?= https://kubernetes.default.svc
# ACD_PROJECT_DESCRIPTION?=
# ACD_PROJECT_DESTINATION?= https://kubernetes.default.svc,default
ACD_PROJECT_NAME?= default
# ACD_PORJECT_NAMESPACE_NAME?= default
ACD_PROJECTS_REGEX?= *
# ACD_PROJECT_SOURCES_URLS?= https://github.com/argoproj/argocd-example-apps.git
# ACD_PROJECTS_SET_NAME?= my-projects-set

# Derived parameters
ACD_PROJECT_DESTINATION?= $(if $(ACD_PROJECT_NAMESPACE_NAME),"$(ACD_PROJECT_APISERVER_URL)$(COMMA)$(ACD_PROJECT_NAMESPACE_NAME)")
ACD_PROJECTS_SET_NAME?= projects@@@$(ACD_PROJECTS_REGEX)

# Option parameters
__ACD_DEST= $(if $(ACD_PROJECT_DESTINATION),--dest $(ACD_PROJECT_DESTINATION))
__ACD_SRC= $(if $(ACD_PROJECT_SOURCES_URLS),--src "$(subst $(SPACE),$(COMMA),$(ACD_PROJECT_SOURCES_URLS))")
__ACD_PROJECT__PROJECT= $(if $(ACD_PROJECT_NAME),--project $(ACD_PROJECT_NAME))
__ACD_UPSERT=

# Pipe parameters
|_ACD_VIEW_PROJECTS_SET?= | grep -E 'NAME|$(ACD_PROJECTS_REGEX)'

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_acd_view_framework_macros ::
	@echo 'ArgoCD::Project ($(_ARGOCD_PROJECT_MK_VERSION)) macros:'
	@echo

_acd_view_framework_parameters ::
	@echo 'ArgoCD::Project ($(_ARGOCD_PROJECT_MK_VERSION)) parameters:'
	@echo '    ACD_PROJECT_APISERVER_URL=$(ACD_PROJECT_APISERVER_URL)'
	@echo '    ACD_PROJECT_DESCRIPTION=$(ACD_PROJECT_DESCRIPTION)'
	@echo '    ACD_PROJECT_DESTINATION=$(ACD_PROJECT_DESTINATION)'
	@echo '    ACD_PROJECT_NAME=$(ACD_PROJECT_NAME)'
	@echo '    ACD_PROJECT_NAMESPACE_NAME=$(ACD_PROJECT_NAMESPACE_NAME)'
	@echo '    ACD_PROJECT_SOURCES_URLS=$(ACD_PROJECT_SOURCES_URLS)'
	@echo '    ACD_PROJECTS_REGEX=$(ACD_PROJECTS_REGEX)'
	@echo '    ACD_PROJECTS_SET_NAME=$(ACD_PROJECTS_SET_NAME)'
	@echo

_acd_view_framework_targets ::
	@echo 'ArgoCD::Project ($(_ARGOCD_PROJECT_MK_VERSION)) targets:'
	@echo '    _acd_create_project                 - Create a project'
	@echo '    _acd_delete_project                 - Delete a project'
	@echo '    _acd_show_project                   - Show everything related to a project'
	@echo '    _acd_show_project_applications      - Show applications of a project'
	@echo '    _acd_show_project_description       - Show description of a project'
	@echo '    _acd_show_project_roles             - Show roles of a project'
	@echo '    _acd_view_projects                  - View projects'
	@echo '    _acd_view_projects_set              - View set of projects'
	@echo '    _acd_waitfor_project                - Wait for a project'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_acd_create_project:
	@$(INFO) '$(ACD_UI_LABEL)Creating project "$(ACD_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the project already exists'; $(NORMAL)
	$(ARGOCD) proj create $(__ACD_DEST) $(__ACD_SRC) $(_X__ACD_UPSERT) $(ACD_PROJECT_NAME)

_acd_delete_project:
	@$(INFO) '$(ACD_UI_LABEL)Deleting project "$(ACD_PROJECT_NAME)" ...'; $(NORMAL)
	$(ARGOCD) proj delete $(ACD_PROJECT_NAME)

_acd_show_project :: _acd_show_project_applications _acd_show_project_roles _acd_show_project_description

_acd_show_project_applications:
	@$(INFO) '$(ACD_UI_LABEL)Showing applications in project "$(ACD_PROJECT_NAME)" ...'; $(NORMAL)
	$(ARGOCD) app list --project $(ACD_PROJECT_NAME)

_acd_show_project_description:
	@$(INFO) '$(ACD_UI_LABEL)Showing description project "$(ACD_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns whether the project is in or out-of-sync'; $(NORMAL)
	$(ARGOCD) proj get $(ACD_PROJECT_NAME)

_acd_show_project_roles:
	@$(INFO) '$(ACD_UI_LABEL)Showing roles of project "$(ACD_PROJECT_NAME)" ...'; $(NORMAL)
	$(ARGOCD) proj role list $(ACD_PROJECT_NAME)

_acd_update_project:
	@$(INFO) '$(ACD_UI_LABEL)Updating project "$(ACD_PROJECT_NAME)" ...'; $(NORMAL)
	$(ARGOCD) proj create $(__ACD_DEST) $(__ACD_SRC) --upsert $(ACD_PROJECT_NAME)

_acd_view_projects:
	@$(INFO) '$(ACD_UI_LABEL)View projects ...'; $(NORMAL)
	$(ARGOCD) proj list

_acd_view_projects_set:
	@$(INFO) '$(ACD_UI_LABEL)Viewing projects-set "$(ACD_PROJECTS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Projects are grouped based on provided regex'; $(NORMAL)
	$(ARGOCD) proj list $(|_ACD_VIEW_PROJECTS_SET)
