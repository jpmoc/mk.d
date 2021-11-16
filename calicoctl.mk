_CALICOCTL_MK_VERSION= 0.99.4

# CCL_AS_GROUP?=
# CCL_AS_USER?=
CCL_UI_LABEL?= [clicoctl] #

# Derived parameters

# Options

# Customizations

#--- Utilities
# __KUBECTL_OPTIONS+= $(if $(KUBECTL_VMODULE),--vmodule=$(KUBECTL_VMODULE))#

CALICOCTL_BIN?= calicoctl
CALICOCTL?= $(strip $(__CALICOCTL_ENVIRONMENT) $(CALICOCTL_ENVIRONMENT) $(CALICOCTL_BIN) $(__CALICOCTL_OPTIONS) $(CALICOCTL_OPTIONS))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_list_macros :: _ccl_list_macros
_ccl_list_macros ::
	@#echo 'CalicoCtL ($(_CALICOCTL_MK_VERSION)) macros:'
	@#echo

_list_parameters :: _ccl_list_parameters
_ccl_list_parameters ::
	@echo 'CalicoCtL ($(_CALICOCTL_MK_VERSION)) parameters:'
	@echo '    CCL_AS_GROUP=$(CCL_AS_GROUP)'
	@echo '    CCL_AS_USER=$(CCL_AS_USER)'
	@echo '    CCL_UI_LABEL=$(CCL_UI_LABEL)'
	@echo

_list_targets :: _ccl_list_targets
_ccl_list_targets ::
	@echo 'CalicoCtL ($(_CALICOCTL_MK_VERSION)) targets:'
	@echo '    _ccl_install_dependencies              - Install dependencies'
	@echo '    _ccl_view_versions                     - View versions of dependencies'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/kubectl_api.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _ccl_install_dependencies
_ccl_install_dependencies ::
	@$(INFO) '$(CCL_UI_LABEL)Installing dependencies...'; $(NORMAL)
	@$(WARN) 'Install docs @ https://docs.projectcalico.org/getting-started/clis/calicoctl/install'; $(NORMAL)
	which calicoctl
	calicoctl version

_view_versions :: _ccl_view_versions
_ccl_show_versions ::
	@$(INFO) '$(CCL_UI_LABEL)Showing versions of dependencies ...'; $(NORMAL)
	calicoctl version
