_AWS_DEPLOY_DEPLOYMENTGROUP_MK_VERSION=$(_AWS_DEPLOY_MK_VERSION)

# DPY_DEPLOYMENTGROUP_NAME?= my-deployment-group

# Derived variables

# Options variables
__DPY_DEPLOYMENT_GROUP_NAME= $(if $(DPY_DEPLOYMENTGROUP_NAME), --deployment-group-name $(DPY_DEPLOYMENTGROUP_NAME))

# UI variables

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_dpy_view_makefile_macros ::
	@echo 'AWS::DePloY::DeploymentGroup ($(_AWS_DEPLOY_DEPLOYMENTGROUP_MK_VERSION)) macros:'
	@echo

_dpy_view_makefile_targets ::
	@echo 'AWS::DePloY::DeploymentGroup ($(_AWS_DEPLOY_DEPLOYMENTGROUP_MK_VERSION)) targets:'
	@echo '    _dpy_view_deploymentgroups                  - View existing deployment-groups'
	@echo 

_dpy_view_makefile_variables ::
	@echo 'AWS::DePloY::DeploymentGroup ($(_AWS_DEPLOY_DEPLOYMENTGROUP_MK_VERSION)) variables:'
	@echo '    DPY_DEPLOYMENTGROUP_NAME=$(DPY_DEPLOYMENTGROUP_NAME)'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_dpy_show_deploymentgroup:
	@$(INFO) '$(AWS_UI_LABEL)Showing summary of deployment-group "$(DPY_DEPLOYMENTGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) deploy get-deployment-group $(__DPY_APPLICATION_NAME) $(__DPY_DEPLOYMENT_GROUP_NAME)

_dpy_view_deploymentgroups:
	@$(INFO) '$(AWS_UI_LABEL)Viewing deployment-groups ...'; $(NORMAL)
	$(AWS) deploy list-deployment-groups $(__DPY_APPLICATION_NAME) --query "deploymentGroups[]"
