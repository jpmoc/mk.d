_ARGOCD_SERVER_MK_VERSION= $(_ARGOCD_MK_VERSION)

# ACD_SERVER_HOSTPORT?= 127.0.0.1:8080
ACD_SERVER_INSECURE_FLAG?= false
# ACD_SERVER_NAME?= my-server

# Derived parameters

# Option parameters
__ACD_INSECURE= $(if $(filter true, $(ACD_SERVER_INSECURE_FLAG)),--insecure)

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_acd_view_framework_macros ::
	@echo 'ArgoCD::Server ($(_ARGOCD_SERVER_MK_VERSION)) macros:'
	@echo

_acd_view_framework_parameters ::
	@echo 'ArgoCD::Server ($(_ARGOCD_SERVER_MK_VERSION)) parameters:'
	@echo '    ACD_SERVER_HOSTPORT=$(ACD_SERVER_HOSTPORT)'
	@echo '    ACD_SERVER_INSECURE_FLAG=$(ACD_SERVER_INSECURE_FLAG)'
	@echo '    ACD_SERVER_NAME=$(ACD_SERVER_NAME)'
	@echo

_acd_view_framework_targets ::
	@echo 'ArgoCD::Server ($(_ARGOCD_SERVER_MK_VERSION)) targets:'
	@echo '    _acd_login_server                     - Login server'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_acd_login_server:
	@$(INFO) '$(ACD_UI_LABEL)Loging in server "$(ACD_SERVER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The default username is "admin"'; $(NORMAL)
	@$(WARN) 'The default password is the dynamically-generated server pod name'; $(NORMAL)
	$(ARGOCD) login $(__ACD_INSECURE) $(ACD_SERVER_HOSTPORT)
