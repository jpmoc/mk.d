_VIRTUALENV_ENVIRONMENT_MK_VERSION= $(_VIRTUALENV_MK_VERSION)

# VEV_ENVIRONMENT_DIRPATH?= ./top-directory/.env/
# VEV_ENVIRONMENT_NAME?= .env
VEV_ENVIRONMENT_REQUIREMENTS_FILENAME?= requirements.txt
# VEV_ENVIRONMENT_REQUIREMENTS_FILEPATH?= ./top-directory/requirements.txt
# VEV_ENVIRONMENTS_DIRPATH?= ./top-directory/
VEV_ENVIRONMENTS_NAME_REGEX?= .??*/
# VEV_ENVIRONMENTS_SET_NAME?= my-environments-set

# Derived parameters
VEV_ENVIRONMENT_DIRPATH?= $(VEV_ENVIRONMENTS_DIRPATH)$(VEV_ENVIRONMENT_NAME)
VEV_ENVIRONMENT_REQUIREMENTS_FILEPATH?= $(VEV_ENVIRONMENTS_DIRPATH)$(VEV_ENVIRONMENT_REQUIREMENTS_FILENAME)
VEV_ENVIRONMENTS_SET_NAME?= $(VEV_ENVIRONMENTS_NAME_REGEX)

# Options parameters

# UI parameters

# Pipe parameters
_VEV_CREATE_ENVIRONMENT_|?= cd $(VEV_ENVIRONMENTS_DIRPATH) &&
_VEV_POPULATE_ENVIRONMENT_|?= cd $(VEV_ENVIRONMENTS_DIRPATH) && $(SOURCE) $(VEV_ENVIRONMENT_NAME)/bin/activate &&
_VEV_SHOW_ENVIRONMENT_MODULES_|?= $(SOURCE) $(VEV_ENVIRONMENT_DIRPATH)/bin/activate &&
_VEV_SHOW_ENVIRONMENT_PYTHON_|?= $(SOURCE) $(VEV_ENVIRONMENT_DIRPATH)/bin/activate &&
_VEV_VIEW_ENVIRONMENTS_|?= cd $(VEV_ENVIRONMENTS_DIRPATH) &&
_VEV_VIEW_ENVIRONMENTS_SET_|?= cd $(VEV_ENVIRONMENTS_DIRPATH) &&

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_vev_view_framework_macros ::
	@echo 'VirtualEnV::Environment ($(_VIRTUALENV_ENVIRONMENT_MK_VERSION)) targets:'
	@echo

_vev_view_framework_parameters ::
	@echo 'VirtualEnV::Environment ($(_VIRTUALENV_ENVIRONMENT_MK_VERSION)) parameters:'
	@echo '    VEV_ENVIRONMENT_DIRPATH=$(VEV_ENVIRONMENT_DIRPATH)'
	@echo '    VEV_ENVIRONMENT_NAME=$(VEV_ENVIRONMENT_NAME)'
	@echo '    VEV_ENVIRONMENT_REQUIREMENTS_FILENAME=$(VEV_ENVIRONMENT_REQUIREMENTS_FILENAME)'
	@echo '    VEV_ENVIRONMENT_REQUIREMENTS_FILEPATH=$(VEV_ENVIRONMENT_REQUIREMENTS_FILEPATH)'
	@echo '    VEV_ENVIRONMENTS_DIRPATH=$(VEV_ENVIRONMENTS_DIRPATH)'
	@echo '    VEV_ENVIRONMENTS_NAME_REGEX=$(VEV_ENVIRONMENTS_NAME_REGEX)'
	@echo

_vev_view_framework_targets ::
	@echo 'VirtualEnV::Environment ($(_VIRTUALENV_ENVIRONMENT_MK_VERSION)) targets:'
	@echo '    _vev_activate_environment            - Activate an environment'
	@echo '    _vev_create_environment              - Create an environment'
	@echo '    _vev_deactivate_environment          - Deactivate an environment'
	@echo '    _vev_delete_environment              - Delete an environment'
	@echo '    _vev_populate_environment            - Populate an environment'
	@echo '    _vev_show_environment                - Show everything related to an environment'
	@echo '    _vev_show_environment_description    - Show description of an environment'
	@echo '    _vev_show_environment_modules        - Show modules an environment'
	@echo '    _vev_view_environemts                - View environments'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vev_activate_environment:
	@$(INFO) '$(VEV_UI_LABEL)Activating environment "$(VEV_ENVIRONMENT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Current shell is $(SHELL)'; $(NORMAL)
	$(SOURCE) $(VEV_ENVIRONMENT_DIRPATH)/bin/activate
	@$(WARN) 'This command is executed in a subshell, not the one where make is run!'; $(NORMAL)

_vev_create_environment:
	@$(INFO) '$(VEV_UI_LABEL)Creating environment "$(VEV_ENVIRONMENT_NAME)" ...'; $(NORMAL)
	$(PYTHON) --version
	$(_VEV_CREATE_ENVIRONMENT_|) $(VIRTUALENV) $(VEV_ENVIRONMENT_NAME)

_vev_deactivate_environment:
	@$(INFO) '$(VEV_UI_LABEL)Deactivate environment "$(VEV_ENVIRONMENT_NAME)" ...'; $(NORMAL)
	deactivate

_vev_delete_environment:
	@$(INFO) '$(VEV_UI_LABEL)Deleting environment "$(VEV_ENVIRONMENT_NAME)" ...'; $(NORMAL)
	@read -p "You are about to delete the directory "$(VEV_ENVIRONMENT_DIRPATH)". Are you sure? (Ctrl-C to exit)" yesNo
	rm -r $(VEV_ENVIRONMENT_DIRPATH)

_vev_populate_environment::
	@$(INFO) '$(VEV_UI_LABEL)Populating environment "$(VEV_ENVIRONMENT_NAME)" ...'; $(NORMAL)
	cat $(VEV_ENVIRONMENT_REQUIREMENTS_FILEPATH)
	$(_VEV_POPULATE_ENVIRONMENT_|) pip install -r requirements.txt

_vev_show_environment :: _vev_show_environment_files _vev_show_environment_modules _vev_show_environment_python _vev_show_environment_description

_vev_show_environment_description:
	@$(INFO) '$(VEV_UI_LABEL)Showing description in environment "$(VEV_ENVIRONMENT_NAME)" ...'; $(NORMAL)
	ls -lad $(VEV_ENVIRONMENT_DIRPATH)

_vev_show_environment_files:
	@$(INFO) '$(VEV_UI_LABEL)Showing files in environment "$(VEV_ENVIRONMENT_NAME)" ...'; $(NORMAL)
	-tree $(VEV_ENVIRONMENT_DIRPATH)

_vev_show_environment_modules:
	@$(INFO) '$(VEV_UI_LABEL)Showing modules in environment "$(VEV_ENVIRONMENT_NAME)" ...'; $(NORMAL)
	-$(_VEV_SHOW_ENVIRONMENT_MODULES_|) $(PIP) list

_vev_show_environment_python:
	@$(INFO) '$(VEV_UI_LABEL)Showing python of environment "$(VEV_ENVIRONMENT_NAME)" ...'; $(NORMAL)
	$(_VEV_SHOW_ENVIRONMENT_PYTHON_|) which python
	$(_VEV_SHOW_ENVIRONMENT_PYTHON_|) python --version

_vev_view_environments:
	@$(INFO) '$(VEV_UI_LABEL)Viewing environments ...'; $(NORMAL)
	-$(_VEV_VIEW_ENVIRONMENTS_|) ls -ald .??*/

_vev_view_environments_set:
	@$(INFO) '$(VEV_UI_LABEL)Viewing environments-set "$(VEV_ENVIRONMENTS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Environments are grouped based on directory and name-regex'; $(NORMAL)
	-$(_VEV_VIEW_ENVIRONMENTS_SET_|) ls -ald $(VEV_ENVIRONMENTS_NAME_REGEX)
