_GITLAB_GITLABCIYML_MK_VERSION= $(_GITLAB_MK_VERSION)

GLB_GITLABCIYML_NAME?= Bash

# Derived parameters

# Option parameters
__GLB_NAME__GITLABCIYML= $(if $(GLB_GITLABCIYML_NAME),--name $(GLB_GITLABCIYML_NAME))

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_glb_view_framework_macros ::
	@echo 'GitLaB::GitlabCiYml ($(_GITLAB_GITLABCIYML_MK_VERSION)) macros:'
	@echo

_glb_view_framework_parameters ::
	@echo 'GitLaB::GitlabCiYml ($(_GITLAB_GITLABCIYML_MK_VERSION)) parameters:'
	@echo '    GLB_GITLABCIYML_NAME=$(GLB_GITLABCIYML_NAME)'
	@echo

_glb_view_framework_targets ::
	@echo 'GitLaB::GitlabCiYml ($(_GITLAB_GITLABCIYML_MK_VERSION)) targets:'
	@echo '    _glb_show_gitlabciyml                         - show everything related to a gitlabciyml'
	@echo '    _glb_show_gitlabciyml_example                 - show example of a gitlabciyml'
	@echo '    _glb_view_gitlabciymls                        - view gitlabciymls'
	@echo


#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_glb_show_gitlabciyml: _glb_show_gitlabciyml_example

_glb_show_gitlabciyml_example:
	@$(INFO) '$(GLB_UI_LABEL)Showing example of gitlabciyml "$(GLB_GITLABCIYML_NAME)" ...'; $(NORMAL)
	echo; $(GITLAB) gitlabciyml get --name Bash | yq -r '.content' | xargs -0 echo

_glb_view_gitlabciyml:
	@$(INFO) '$(GLB_UI_LABEL)Viewing gitlabciyml ...'; $(NORMAL)
	$(GITLAB) gitlabciyml list
