_ASK_PROJECT_MK_VERSION= $(_ASK_MK_VERSION)

# ASK_PROJECT_DIRPATH?= ./projects/ask-app/
# ASK_PROJECT_NAME?= hello-ask
# ASK_PROJECT_PROFILE_NAME?= default
# ASK_PROJECT_SKILL_NAME?= hello-ask
# ASK_PROJECT_TEMPLATE_NAME?= Fact
# ASK_PROJECT_TEMPLATE_URL?= https://s3.amazonaws.com/ask-cli/templates/python3-templates.json
# ASK_PROJECTS_DIRPATH?= ./projects/
ASK_PROJECTS_NAME_REGEX?= */
ASK_PROJECTS_SET_NAME?= all-projects

# Derived parameters
ASK_PROJECT_DIRPATH?= $(ASK_PROJECTS_DIRPATH)$(ASK_PROJECT_NAME)/
ASK_PROJECT_PROFILE_NAME?= $(ASK_PROFILE_NAME)
ASK_PROJECT_SKILL_NAME?= $(ASK_SKILL_NAME)

# Options parameters
__ASK_PROFILE__PROJECT= $(if $(ASK_PROJECT_PROFILE_NAME),--profile $(ASK_PROJECT_PROFILE_NAME))
__ASK_SKILL_NAME= $(if $(ASK_PROJECT_SKILL_NAME),--skill-name $(ASK_PROJECT_SKILL_NAME))
__ASK_TEMPLATE= $(if $(ASK_PROJECT_TEMPLATE_NAME),--template $(ASK_PROJECT_TEMPLATE_NAME))
__ASK_URL= $(if $(ASK_PROJECT_TEMPLATE_URL),--url $(ASK_PROJECT_TEMPLATE_URL))

# Pipe parameters
_ASK_CREATE_PROJECT_|?= cd $(ASK_PROJECTS_DIRPATH) && 
_ASK_VIEW_PROJECTS_|?= cd $(ASK_PROJECTS_DIRPATH) && 
_ASK_VIEW_PROJECTS_SET_|?= cd $(ASK_PROJECTS_DIRPATH) && 

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_ask_view_framework_macros ::
	@echo 'ASK::Project ($(_ASK_PROJECT_MK_VERSION)) macros:'
	@echo

_ask_view_framework_parameters ::
	@echo 'ASK::Project ($(_ASK_PROJECT_MK_VERSION)) parameters:'
	@echo '    ASK_PROJECT_PROFILE_NAME=$(ASK_PROJECT_PROFILE_NAME)'
	@echo '    ASK_PROJECT_DIRPATH=$(ASK_PROJECT_DIRPATH)'
	@echo '    ASK_PROJECT_NAME=$(ASK_PROJECT_NAME)'
	@echo '    ASK_PROJECT_SKILL_NAME=$(ASK_PROJECT_SKILL_NAME)'
	@echo '    ASK_PROJECT_TEMPLATE_NAME=$(AWSK_PROJECT_TEMPLATE_NAME)'
	@echo '    ASK_PROJECT_TEMPLATE_URL=$(AWSK_PROJECT_TEMPLATE_URL)'
	@echo '    ASK_PROJECTS_DIRPATH=$(ASK_PROJECTS_DIRPATH)'
	@echo '    ASK_PROJECTS_NAME_REGEX=$(ASK_PROJECTS_NAME_REGEX)'
	@echo '    ASK_PROJECTS_SET_NAME=$(ASK_PROJECTS_SET_NAME)'
	@echo

_ask_view_framework_targets ::
	@echo 'ASK::Project ($(_ASK_PROJECT_MK_VERSION)) targets:'
	@echo '    _ask_create_project                  - Create a new project'
	@echo '    _ask_delete_project                  - Delete a project'
	@echo '    _ask_show_project                    - Show everything related to a project'
	@echo '    _ask_show_project_description        - Show the description of a project'
	@echo '    _ask_show_project_files              - Show files of a project'
	@echo '    _ask_view_projects                   - View projects'
	@echo '    _ask_view_projects_set               - View a set of projects'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ask_create_project:
	@$(INFO) '$(ASK_UI_LABEL)Creating project "$(ASK_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the project already exists!'; $(NORMAL)
	-$(_ASK_CREATE_PROJECT_|) $(ASK) new $(__ASK_PROFILE__PROJECT) $(__ASK_SKILL_NAME) $(__ASK_TEMPLATE) $(__ASK_URL)

_ask_delete_project:
	@$(INFO) '$(ASK_UI_LABEL)Deleting project "$(ASK_PROJECT_NAME)" ...'; $(NORMAL)
	@read -p 'You are about to delete the project directory "$(ASK_PROJECT_DIRPATH)". Are you sure? (Ctrl-C to cancel)' yesNo
	[ -d $(ASK_PROJECT_DIRPATH) ] && rm -rf $(ASK_PROJECT_DIRPATH)

_ask_show_project :: _ask_show_project_files _ask_show_project_description

_ask_show_project_description: 
	@$(INFO) '$(ASK_UI_LABEL)Showing description of project "$(ASK_PROJECT_NAME)" ...'; $(NORMAL)

_ask_show_project_files: 
	@$(INFO) '$(ASK_UI_LABEL)Showing files of project "$(ASK_PROJECT_NAME)" ...'; $(NORMAL)
	tree $(ASK_PROJECT_DIRPATH)

_ask_view_projects:
	@$(INFO) '$(ASK_UI_LABEL)Viewing projects ...'; $(NORMAL)
	@$(WARN) 'This operation fails if no projects are found!'; $(NORMAL)
	-$(_ASK_VIEW_PROJECTS_|) ls -dl */

_ask_view_projects_set:
	@$(INFO) '$(ASK_UI_LABEL)Viewing projects-set "$(ASK_PROJECTS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if no matching projects are found!'; $(NORMAL)
	-$(_ASK_VIEW_PROJECTS_SET_|) ls -dl $(ASK_XS_NAME_REGEX)
