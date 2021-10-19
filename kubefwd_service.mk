_KUBEFWD_SERVICE_MK_VERSION= $(_KUBEFWD_MK_VERSION)

# KFD_SERVICES_NAMESPACE_NAME?= my-namespace
# KFD_SERVICES_SELECTOR?= app=wx,component=api

# Derived parameters
KFD_SERVICES_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KFD_SERVICES_SELECTOR?= $(KCL_SERVICES_SELECTOR)

# Option parameters
__KFD_NAMESPACE__SERVICES= $(if $(KFD_SERVICES_NAMESPACE_NAME),--namespace $(KFD_SERVICES_NAMESPACE_NAME))
__KFD_SELECTOR__SERVICES= $(if $(KFD_SERVICES_SELECTOR),--selector $(KFD_SERVICES_SELECTOR))

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kfd_view_framework_macros ::
	@#echo 'KubeFwD::Service ($(_KUBEFWD_SERVICE_MK_VERSION)) macros:'
	@#echo

_kfd_view_framework_parameters ::
	@echo 'KubeFwD::Service ($(_KUBEFWD_SERVICE_MK_VERSION)) parameters:'
	@echo '    KFD_SERVICES_NAMESPACE_NAME=$(KFD_SERVICE_NAMESPACE_NAME)'
	@echo '    KFD_SERVICES_SELECTOR=$(KFD_SERVICE_SELECTOR)'
	@echo

_kfd_view_framework_targets ::
	@echo 'KubeFwD::Service ($(_KUBEFWD_SERVICE_MK_VERSION)) targets:'
	@echo '    _kfd_portforward_services           - Port-forward the selected services'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kfd_portforward_services:
	@$(INFO) '$(KCL_UI_LABEL)Port-forwarding services ...'; $(NORMAL)
	@$(WARN) 'This operation is blocking and will time out after 5 minutes of inactivity'; $(NORMAL)
	$(KUBEFWD) services $(__KFD_NAMESPACE__SERVICES) $(__KFD_SELECTOR__SERVICES)
