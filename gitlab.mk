_GITLAB_MK_VERSION= 0.99.0

# GLB_MODE_DEBUG?= false
# GLB_MODE_INTERACTIVE?= true
GLB_MODE_SERVICE?= true
GLB_OUTPUT?= yaml
# GLB_PROFILE_NAME?= vmware
# GLB_PROFILE_API_URL?= https://gitlab.eng.vmware.com/api/v4
GLB_PROFILE_API_VERSION?= 4#
# GLB_PROFILE_PRIVATE_TOKEN?= BtE9prxP8HAnmJNBcaKd
# GLB_PROFILE_URL?= https://gitlab.eng.vmware.com/

# Derived parameter
GLB_MODE_DEBUG?= $(CMN_MODE_DEBUG)
GLB_MODE_INTERACTIVE?= $(CMN_MODE_INTERACTIVE)
GLB_PROFILE_API_URL?= $(GLB_PROFILE_URL)/api/v$(GLB_PROFILE_API_VERSION)

# Option parameters

# UI parameters
GLB_UI_LABEL?= [gitlab] #

#--- Utilities

__GITLAB_OPTIONS+= $(if $(filter true,$(GLB_MODE_DEBUG)),--debug)
__GITLAB_OPTIONS+= $(if $(GLB_PROFILE_NAME),--gitlab $(GLB_PROFILE_NAME))
__GITLAB_OPTIONS+= $(if $(GLB_OUTPUT),--output $(GLB_OUTPUT))
__GITLAB_OPTIONS+= --verbose
GITLAB_BIN?= gitlab
GITLAB?= $(strip $(__GITLAB_ENVIRONMENT) $(GITLAB_ENVIRONMENT) $(GITLAB_BIN) $(__GITLAB_OPTIONS) $(GITLAB_OPTIONS))

__GITLABRUNNER_OPTIONS+= $(if $(filter true,$(GLB_MODE_DEBUG)),--debug)
GITLABRUNNER_BIN?= $(if $(filter true,$(GLB_MODE_SERVICE)),sudo) gitlab-runner
GITLABRUNNER?= $(strip $(__GITLABRUNNER_ENVIRONMENT) $(GITLABRUNNER_ENVIRONMENT) $(GITLABRUNNER_BIN) $(__GITLABRUNNER_OPTIONS) $(GITLABRUNNER_OPTIONS) )

__GITLABSERVICE_OPTIONS+= $(if $(filter true,$(GLB_MODE_DEBUG)),--debug)
GITLABSERVICE_BIN?= sudo gitlab-ci-multi-runner
GITLABSERVICE?= $(strip $(__GITLABSERVICE_ENVIRONMENT) $(GITLABSERVICE_ENVIRONMENT) $(GITLABSERVICE_BIN) $(__GITLABSERVICE_OPTIONS) $(GITLABSERVICE_OPTIONS))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _glb_view_framework_macros
_glb_view_framework_macros ::
	@echo 'GitLab::: ($(_GITLAB_MK_VERSION)) macros:'
	@echo

_view_framework_parameters :: _glb_view_framework_parameters
_glb_view_framework_parameters ::
	@echo 'GitLaB:: ($(_GITLAB_MK_VERSION)) parameters:'
	@echo '    GLB_MODE_DEBUG=$(GLB_MODE_DEBUG)'
	@echo '    GLB_MODE_INTERACTIVE=$(GLB_MODE_INTERACTIVE)'
	@echo '    GLB_MODE_SERVICE=$(GLB_MODE_SERVICE)'
	@echo '    GLB_PROFILE_NAME=$(GLB_PROFILE_NAME)'
	@echo '    GLB_PROFILE_API_URL=$(GLB_PROFILE_API_URL)'
	@echo '    GLB_PROFILE_API_VERSION=$(GLB_PROFILE_API_VERSION)'
	@echo '    GLB_PROFILE_PRIVATE_TOKEN=$(GLB_PROFILE_PRIVATE_TOKEN)'
	@echo '    GLB_PROFILE_URL=$(GLB_PROFILE_URL)'
	@echo

_view_framework_targets :: _glb_view_framework_targets
_glb_view_framework_targets ::
	@echo 'GitLaB:: ($(_GITLAB_MK_VERSION)) targets:'
	@echo '    _glb_install_dependencies         - Install dependencies'
	@echo '    _glb_show_version                 - Show version of the utility'
	@echo '    _glb_show_version_gitlabrunner    - Show version of the gitlab-runner'
	@echo '    _glb_show_version_gitlabservice   - Show version of the giltab-service'
	@echo


#-----------------------------------------------------------------------
# PRIVATE TARGETS
#


MK_DIR?= .
-include $(MK_DIR)/gitlab_artifact.mk
-include $(MK_DIR)/gitlab_config.mk
-include $(MK_DIR)/gitlab_currentuser.mk
-include $(MK_DIR)/gitlab_gitlabciyml.mk
-include $(MK_DIR)/gitlab_project.mk
-include $(MK_DIR)/gitlab_projectpipeline.mk
-include $(MK_DIR)/gitlab_projectpipelineschedule.mk
-include $(MK_DIR)/gitlab_projectpipelineschedulevariable.mk
-include $(MK_DIR)/gitlab_projecttrigger.mk
-include $(MK_DIR)/gitlab_runner.mk
-include $(MK_DIR)/gitlab_service.mk
-include $(MK_DIR)/gitlab_user.mk

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _glb_install_dependencies
_glb_install_dependencies ::
	@$(INFO) '$(GLB_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	@$(WARN) 'Install docs @ https://docs.gitlab.com/runner/install/linux-repository.html'; $(NORMAL)
	curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash
	sudo apt-get install gitlab-runner
	dpkg --listfiles gitlab-runner
	@$(WARN) 'Install docs @ https://docs.gitlab.com/runner/install/linux-repository.html'; $(NORMAL)
	sudo pip install --upgrade python-gitlab


_glb_show_version: _glb_show_version_gitlabrunner _glb_show_version_gitlabservice

_glb_show_version_gitlabrunner:
	@$(INFO) '$(GLB_UI_LABEL)Showing version of gitlab-runner ...'; $(NORMAL)
	$(GITLABRUNNER) --version

_glb_show_version_gitlabservice:
	@$(INFO) '$(GLB_UI_LABEL)Showing version of gitlab-service ...'; $(NORMAL)
	$(GITLABSERVICE) --version
