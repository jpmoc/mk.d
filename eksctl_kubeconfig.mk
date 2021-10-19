_EKSCTL_KUBECONFIG_MK_VERSION= $(_EKSCTL_MK_VERSION)

# ECL_KUBECONFIG_AUTO_ENABLE?= false
# ECL_KUBECONFIG_AWS_PROFILE?=
# ECL_KUBECONFIG_AWS_REGION?= us-west-2
# ECL_KUBECONFIG_CLUSTER_NAME?= my-cluster
ECL_KUBECONFIG_DIRPATH?= $(HOME)/.kube/
# ECL_KUBECONFIG_FILENAME?= config
# ECL_KUBECONFIG_FILEPATH?= $(HOME)/.kube/config
# ECL_KUBECONFIG_NAME?= my-kubeconfig
ECL_KUBECONFIG_SETCONTEXT_ENABLE?= true
# ECL_KUBECONFIGS_DIRPATH?= $(HOME)/.kube
ECL_KUBECONFIGS_REGEX?= config*

# Derived parameters
ECL_KUBECONFIG_AWS_PROFILE?= $(ECL_CLUSTER_AWS_PROFILE)
ECL_KUBECONFIG_AWS_REGION?= $(ECL_CLUSTER_AWS_REGION)
ECL_KUBECONFIG_CLUSTER_NAME?= $(ECL_CLUSTER_NAME)
ECL_KUBECONFIG_FILEPATH?= $(if $(ECL_KUBECONFIG_FILENAME),$(ECL_KUBECONFIG_DIRPATH)$(ECL_KUBECONFIG_FILENAME))
ECL_KUBECONFIGS_DIRPATH?= $(ECL_KUBECONFIG_DIRPATH)

# Option parameters
__ECL_AUTO_KUBECONFIG__KUBECONFIG= $(if $(filter true, $(ECL_KUBECONFIG_AUTO_ENABLE)),--auto-kubeconfig)
__ECL_CLUSTER__KUBECONFIG= $(if $(ECL_KUBECONFIG_CLUSTER_NAME),--cluster=$(ECL_KUBECONFIG_CLUSTER_NAME))
__ECL_KUBECONFIG__KUBECONFIG= $(if $(ECL_KUBECONFIG_FILEPATH),--kubeconfig=$(ECL_KUBECONFIG_FILEPATH))
__ECL_PROFILE__KUBECONFIG= $(if $(ECL_KUBECONFIG_AWS_PROFILE),--profile=$(ECL_KUBECONFIG_AWS_PROFILE))
__ECL_REGION__KUBECONFIG= $(if $(ECL_KUBECONFIG_AWS_REGION),--region=$(ECL_KUBECONFIG_AWS_REGION))
__ECL_SET_KUBECONFIG_CONTEXT= $(if $(ECL_KUBECONFIG_SETCONTEXT_ENABLE),--set-kubeconfig-context=$(ECL_KUBECONFIG_SETCONTEXT_ENABLE))

# UI parameters

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_ecl_view_framework_macros ::
	@echo 'EksCtL::Kubeconfig ($(_EKSCTL_KUBECONFIG_MK_VERSION)) macros:'
	@echo

_ecl_view_framework_parameters ::
	@echo 'EksCtL::Kubeconfig ($(_EKSCTL_KUBECONFIG_MK_VERSION)) parameters:'
	@echo '    ECL_KUBECONFIG_AUTO_ENABLE=$(ECL_KUBECONFIG_AUTO_ENABLE)'
	@echo '    ECL_KUBECONFIG_AWS_PROFILE=$(ECL_KUBECONFIG_AWS_PROFILE)'
	@echo '    ECL_KUBECONFIG_AWS_REGION=$(ECL_KUBECONFIG_AWS_REGION)'
	@echo '    ECL_KUBECONFIG_CLUSTER_NAME=$(ECL_KUBECONFIG_CLUSTER_NAME)'
	@echo '    ECL_KUBECONFIG_DIRPATH=$(ECL_KUBECONFIG_DIRPATH)'
	@echo '    ECL_KUBECONFIG_FILENAME=$(ECL_KUBECONFIG_FILENAME)'
	@echo '    ECL_KUBECONFIG_FILEPATH=$(ECL_KUBECONFIG_FILEPATH)'
	@echo '    ECL_KUBECONFIG_NAME=$(ECL_KUBECONFIG_NAME)'
	@echo '    ECL_KUBECONFIGS_DIRPATH=$(ECL_KUBECONFIGS_DIRPATH)'
	@echo '    ECL_KUBECONFIGS_REGEX=$(ECL_KUBECONFIGS_REGEX)'
	@echo '    ECL_KUBECONFIGS_SET_NAME=$(ECL_KUBECONFIGS_SET_NAME)'
	@echo

_ecl_view_framework_targets ::
	@echo 'EksCtL::Kubeconfig ($(_EKSCTL_KUBECONFIG_MK_VERSION)) targets:'
	@echo '    _ecl_create_kubeconfig               - Create a new kubeconfig'
	@echo '    _ecl_delete_kubeconfig               - Delete a kubeconfig'
	@echo '    _ecl_refresh_kubeconfig              - Refresh a kubeconfig'
	@echo '    _ecl_show_kubeconfig                 - Show everything related to a kubeconfig'
	@echo '    _ecl_show_kubeconfig_content         - Show content of a kubeconfig'
	@echo '    _ecl_show_kubeconfig_contexts        - Show contexts of a kubeconfig'
	@echo '    _ecl_show_kubeconfig_description     - Show description of a kubeconfig'
	@echo '    _ecl_view_kubeconfigs                - View kubeconfig files'
	@echo '    _ecl_view_kubeconfigs_set            - View a set of kubeconfigs'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ecl_create_kubeconfig:
	@$(INFO) '$(ECL_UI_LABEL)Creating/refreshing kubeconfig "$(ECL_KUBECONFIG_NAME)" ...'; $(NORMAL)
	$(EKSCTL) utils write-kubeconfig $(strip $(__ECL_AUTO_KUBECONFIG__KUBECONFIG) $(__ECL_KUBECONFIG__KUBECONFIG) $(__ECL_CLUSTER__KUBECONFIG) $(__ECL_PROFILE__KUBECONFIG) $(__ECL_REGION__KUBECONFIG) $(__ECL_SET_KUBECONFIG_CONTEXT))

_ecl_delete_kubeconfig:
	@$(INFO) '$(ECL_UI_LABEL)Deleting kubeconfig "$(ECL_KUBECONFIG_NAME)" ...'; $(NORMAL)

_ecl_refresh_kubeconfig: _ecl_create_kubeconfig

_ecl_show_kubeconfig :: _ecl_show_kubeconfig_content _ecl_show_kubeconfig_contexts _ecl_show_kubeconfig_description

_ecl_show_kubeconfig_content:
	@$(INFO) '$(ECL_UI_LABEL)Showing content of kubeconfig "$(ECL_KUBECONFIG_NAME)" ...'; $(NORMAL)

_ecl_show_kubeconfig_contexts:
	@$(INFO) '$(ECL_UI_LABEL)Showing context of kubeconfig "$(ECL_KUBECONFIG_NAME)" ...'; $(NORMAL)

_ecl_show_kubeconfig_description:
	@$(INFO) '$(ECL_UI_LABEL)Showing description of kubeconfig "$(ECL_KUBECONFIG_NAME)" ...'; $(NORMAL)

_ecl_view_kubeconfigs:
	@$(INFO) '$(ECL_UI_LABEL)Viewing ALL kubeconfigs ...'; $(NORMAL)
	ls -al $(ECL_KUBECONFIGS_DIRPATH)

_ecl_view_kubeconfigs_set:
	@$(INFO) '$(ECL_UI_LABEL)Viewing kubeconfigs-set "$(ECL_KUBECONFIGS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Kubeconfigs are grouped based on provided directory and regex'; $(NORMAL)
	ls -al $(ECL_KUBECONFIGS_DIRPATH)$(ECL_KUBECONFIGS_REGEX)
