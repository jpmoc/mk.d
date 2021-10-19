_GITLAB_USER_MK_VERSION= $(_GITLAB_MK_VERSION)

# GLB_ARTIFACT_BUILD_TOKEN?=

# Derived parameters

# Option parameters
# __GLB_ARTIFACT_TYPE= $(if $(GLB_ARTIFACT_TYPE),--artifact-type $(GLB_ARTIFACT_TYPE))

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_glb_view_framework_macros ::
	@echo 'GitLaB::User ($(_GITLAB_ARTIFACT_MK_VERSION)) macros:'
	@echo

_glb_view_framework_parameters ::
	@echo 'GitLaB::User ($(_GITLAB_USER_MK_VERSION)) parameters:'
	@#echo '    GLB_ARTIFACT_BUILD_ID=$(GLB_ARTIFACT_BUILD_ID)'
	@echo

_glb_view_framework_targets ::
	@echo 'GitLaB::User ($(_GITLAB_USER_MK_VERSION)) targets:'
	@echo '    _glb_view_users            - view users'
	@echo


#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_glb_view_users:
	@$(INFO) '$(GLB_UI_LABEL)Viewing users ...'; $(NORMAL)
	$(GITLAB) user list
