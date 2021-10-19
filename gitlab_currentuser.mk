_GITLAB_CURRENTUSER_MK_VERSION= $(_GITLAB_MK_VERSION)

# GLB_CURRENTUSER_EMAIL?= emayssat@domain.com
# GLB_CURRENTUSER_ID?= 123456 
# GLB_CURRENTUSER_NAME?= my-current-user 
# GLB_CURRENTUSER_USERNAME?= my-username
# GLB_CURRENTUSER_URL?= https://gitlab.com/emayssat
GLB_CURRENTUSER_PAGE_NUMBER?= 1
GLB_CURRENTUSER_PAGE_DENSITY?= 10

# Derived parameters

# Option parameters
__GLB_PAGE__CURRENTUSER= $(if $(GLB_CURRENTUSER_PAGE_NUMBER),--page $(GLB_CURRENTUSER_PAGE_NUMBER))
__GLB_PER_PAGE__CURRENTUSER= $(if $(GLB_CURRENTUSER_PAGE_DENSITY),--per-page $(GLB_CURRENTUSER_PAGE_DENSITY))

# UI parameters

#--- Utilities

#--- MACROS

_glb_get_currentuser_email= $(shell $(GITLAB) --output json  current-user get | jq -r '.email')
_glb_get_currentuser_name= $(shell $(GITLAB) --output json  current-user get | jq -r '.name')
_glb_get_currentuser_username= $(shell $(GITLAB) --output json  current-user get | jq -r '.username')
_glb_get_currentuser_url= $(shell $(GITLAB) --output json  current-user get | jq -r '.web_url')

#----------------------------------------------------------------------
# USAGE
#

_glb_view_framework_macros ::
	@echo 'GitLaB::CurrentUser ($(_GITLAB_CURRENTUSER_MK_VERSION)) macros:'
	@echo '    _glb_get_currentuser_email          - get the email of the current user'
	@echo '    _glb_get_currentuser_name           - get the name of the current user'
	@echo '    _glb_get_currentuser_url            - get the URL of the current user'
	@echo '    _glb_get_currentuser_username       - get the username of the current user'
	@echo

_glb_view_framework_parameters ::
	@echo 'GitLaB::CurrentUser ($(_GITLAB_CURRENTUSER_MK_VERSION)) parameters:'
	@echo '    GLB_CURRENTUSER_EMAIL=$(GLB_CURRENTUSER_EMAIL)'
	@echo '    GLB_CURRENTUSER_ID=$(GLB_CURRENTUSER_ID)'
	@echo '    GLB_CURRENTUSER_NAME=$(GLB_CURRENTUSER_NAME)'
	@echo '    GLB_CURRENTUSER_URL=$(GLB_CURRENTUSER_URL)'
	@echo '    GLB_CURRENTUSER_USERNAME=$(GLB_CURRENTUSER_USERNAME)'
	@echo

_glb_view_framework_targets ::
	@echo 'GitLaB::CurrentUser ($(_GITLAB_CURRENTUSER_MK_VERSION)) targets:'
	@echo '    _glb_show_currentuser                - show everything related to the current-user'
	@echo '    _glb_show_currentuser_description    - show description of the current'
	@echo '    _glb_show_currentuser_emails         - show emails of the current'
	@echo '    _glb_show_currentuser_sshpublickeys  - show ssh-public-keys of the current'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_glb_show_currentuser: _glb_show_currentuser_emails _glb_show_currentuser_sshpublickeys _glb_show_currentuser_description

_glb_show_currentuser_description:
	@$(INFO) '$(GLB_UI_LABEL)Showing description of current-user "$(GLB_CURRENTUSER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The operation identifies the current-user based on the used API key'; $(NORMAL)
	$(GITLAB) current-user get

_glb_show_currentuser_emails:
	@$(INFO) '$(GLB_UI_LABEL)Showing emails of current-user "$(GLB_CURRENTUSER_NAME)" ...'; $(NORMAL)
	$(GITLAB) current-user-email list

_glb_show_currentuser_sshpublickeys:
	@$(INFO) '$(GLB_UI_LABEL)Showing SSH public-keys of current-user "$(GLB_CURRENTUSER_NAME)" ...'; $(NORMAL)
	$(GITLAB) current-user-key list
