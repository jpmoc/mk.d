_CALICOCTL_MK_VERSION= 0.99.4

# CCL_AS_GROUP?=
# CCL_AS_USER?=

# Derived parameters

# Option parameters

# UI parameters
CCL_UI_LABEL?= [clicoctl] #

#--- Utilities
# __KUBECTL_OPTIONS+= $(if $(KUBECTL_VMODULE),--vmodule=$(KUBECTL_VMODULE))#

CALICOCTL_BIN?= calicoctl
CALICOCTL?= $(strip $(__CALICOCTL_ENVIRONMENT) $(CALICOCTL_ENVIRONMENT) $(CALICOCTL_BIN) $(__CALICOCTL_OPTIONS) $(CALICOCTL_OPTIONS))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _ccl_view_framework_macros
_ccl_view_framework_macros ::
	@#echo 'CalicoCtL ($(_CALICOCTL_MK_VERSION)) macros:'
	@#echo

_view_framework_parameters :: _ccl_view_framework_parameters
_ccl_view_framework_parameters ::
	@echo 'CalicoCtL ($(_CALICOCTL_MK_VERSION)) parameters:'
	@echo '    CCL_AS_GROUP=$(CCL_AS_GROUP)'
	@echo '    CCL_AS_USER=$(CCL_AS_USER)'
	@echo

_view_framework_targets :: _ccl_view_framework_targets
_ccl_view_framework_targets ::
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
_ccl_view_versions ::
	@$(INFO) '$(CCL_UI_LABEL)Viewing versions of dependencies ...'; $(NORMAL)
	calicoctl version
