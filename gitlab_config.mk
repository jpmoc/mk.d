_GITLAB_CONFIG_MK_VERSION= $(_GITLAB_MK_VERSION)

GLB_CONFIG_FILEPATH?= $(HOME)/.python-gitlab.cfg
GLB_CONFIG_NAME?= user-config

# Derived parameters

# Option parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_glb_view_framework_macros ::
	@echo 'GitLaB::Config ($(_GITLAB_CONFIG_MK_VERSION)) macros:'
	@echo

_glb_view_framework_parameters ::
	@echo 'GitLaB::Config ($(_GITLAB_CONFIG_MK_VERSION)) parameters:'
	@echo '    GLB_CONFIG_FILEPATH=$(GLB_CONFIG_FILEPATH)'
	@echo '    GLB_CONFIG_NAME=$(GLB_CONFIG_NAME)'
	@echo

_glb_view_framework_targets ::
	@echo 'GitLaB::Config ($(_GITLAB_CONFIG_MK_VERSION)) targets:'
	@echo '    _glb_show_config                   - show everything related to the config'
	@echo '    _glb_show_config_content           - show content of a config'
	@echo '    _glb_show_config_description       - show description of a config'
	@echo


#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_glb_show_config: _glb_show_config_content _glb_show_config_description

_glb_show_config_content:
	@$(INFO) '$(GLB_UI_LABEL)Showing content of configuration "$(GLB_CONFIG_NAME)" ...'; $(NORMAL)
	cat $(GLB_CONFIG_FILEPATH)

_glb_show_config_description:
	@$(INFO) '$(GLB_UI_LABEL)showing description of configuration "$(GLB_CONFIG_NAME)" ...'; $(NORMAL)
	ls -la $(GLB_CONFIG_FILEPATH)
