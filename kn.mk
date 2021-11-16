_KN_MK_VERSION= 0.99.4

# KN_CURL?= time curl
# KN_DIG?= dig
KN_DNSNAME_DOMAIN?= example.com
# KN_NAMESPACE_NAME?= default
KN_UI_LABEL?= [kn] #

# Derived parameters
KN_CURL?= $(CURL)
KN_DIG?= $(DIG)

# Options

# Customizations

#--- Utilities
# __KUBECTL_OPTIONS+= $(if $(KUBECTL_VMODULE),--vmodule=$(KUBECTL_VMODULE))#

KN_BIN?= kn
KN?= $(strip $(__KN_ENVIRONMENT) $(KN_ENVIRONMENT) $(KN_BIN) $(__KN_OPTIONS) $(KN_OPTIONS))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_list_macros :: _kn_list_macros
_kn_list_macros ::
	@#echo 'KN ($(_KN_MK_VERSION)) macros:'
	@#echo

_list_parameters :: _kn_list_parameters
_kn_list_parameters ::
	@echo 'KN ($(_KN_MK_VERSION)) parameters:'
	@echo '    KN_DNSNAME_DOMAIN=$(KN_DNSNAME_DOMAIN)'
	@echo '    KN_NAMESPACE_NAME=$(KN_NAMESPACE_NAME)'
	@echo '    KN_UI_LABEL=$(KN_UI_LABEL)'
	@echo

_list_targets :: _kn_list_targets
_kn_list_targets ::
	@echo 'KN ($(_KN_MK_VERSION)) targets:'
	@echo '    _kn_install_dependencies              - Install dependencies'
	@echo '    _kn_list_sourcetypes                  - List available source types'
	@echo '    _kn_view_versions                     - View versions of dependencies'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/kn_broker.mk
-include $(MK_DIR)/kn_channel.mk
-include $(MK_DIR)/kn_pingsource.mk
-include $(MK_DIR)/kn_revision.mk
-include $(MK_DIR)/kn_route.mk
-include $(MK_DIR)/kn_service.mk
-include $(MK_DIR)/kn_subscription.mk
-include $(MK_DIR)/kn_trigger.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_dependencies :: _kn_install_dependencies
_kn_install_dependencies ::
	@$(INFO) '$(KN_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	@$(WARN) 'Install docs @ https://knative.dev/docs/install/install-kn/'; $(NORMAL)
	which kn
	kn version

_kn_list_sourcetypes:
	@$(INFO) '$(KN_UI_LABEL)Listing ALL source-types ...'; $(NORMAL)
	$(KN) source list-types

_view_versions :: _kn_show_versions
_kn_show_versions ::
	@$(INFO) '$(KN_UI_LABEL)Showing versions of dependencies ...'; $(NORMAL)
	kn version
