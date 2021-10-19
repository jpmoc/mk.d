_VMC_CSP_MK_VERSION= 0.99.0

# CSP_ACCESS_TOKEN?=
# CSP_HOST_URL?=
# CSP_MODE_DEBUG?= true
CSP_OUTPUT?= json
# CSP_REFRESH_TOKEN?=
# CSP_VERBOSITY_LEVEL?= 0

# Derived variables
CSP_MODE_DEBUG?= $(CMN_MODE_DEBUG)
CSP_VERBOSITY_LEVEL?= $(CMN_VERBOSITY_LEVEL)

# Option variables

# UI variables
CSP_UI_LABEL?= $(VMC_UI_LABEL)
 
#--- Utilities
__CSP_OPTIONS+= $(if $(filter true, $(CSP_DEBUG_MODE)),--debug)
__CSP_OPTIONS+= $(if $(filter-out 0, $(CSP_VERBOSITY_LEVEL)),--verbose)
CSP_BIN?= csp
CSP?= $(strip $(__CSP_ENVIRONMENT) $(CSP_ENVIRONMENT) $(CSP_BIN) $(__CSP_OPTIONS) $(CSP_OPTIONS))

__CSPCURL_OPTIONS+= $(if $(CSP_OUTPUT),--header 'accept: application/$(CSP_OUTPUT)')
__CSPCURL_OPTIONS+= $(if $(CSP_ACCESS_TOKEN),--header 'csp-auth-token: $(CSP_ACCESS_TOKEN)')
__CSPCURL_OPTIONS+= $(if $(filter true,$(CSP_MODE_DEBUG)),--verbose)
__CSPCURL_OPTIONS+= --show-error --silent
CSPCURL_BIN?= curl
CSPCURL?= $(strip $(__CSPCURL_ENVIRONMENT) $(CSPCURL_ENVIRONMENT) $(CSPCURL_BIN) $(__CSPCURL_OPTIONS) $(CSPCURL_OPTIONS))

__CSPJQ_OPTIONS+= --monochrome-output
CSPJQ_BIN?= jq
CSPJQ?= $(strip $(__CSPJQ_ENVIRONMENT) $(CSPJQ_ENVIRONMENT) $(CSPJQ_BIN) $(__CSPJQ_OPTIONS) $(CSPJQ_OPTIONS)) 

#--- MACROS

_csp_get_access_token= $(call _csp_get_access_token_R, $(CSP_REFRESH_TOKEN))
_csp_get_access_token_R= $(call _csp_get_access_token_RH, $(1), $(CSP_HOST_URL))
_csp_get_access_token_RH= $(shell curl --data 'refresh_token=$(CSP_REFRESH_TOKEN)' --header "Content-Type: application/x-www-form-urlencoded" --silent --request POST $(strip $(2))/csp/gateway/am/api/auth/api-tokens/authorize | jq -r .access_token)

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _csp_view_framework_macros
_csp_view_framework_macros ::
	@echo 'VmwareCloud::CSP ($(_VMC_CSP_MK_VERSION)) macros:'
	@echo '    _csp_get_access_token_(|R|RH)          - Get an access-token (Refresh_token,Host_url)'
	@echo

include gmsl

_view_framework_parameters :: _csp_view_framework_parameters
_csp_view_framework_parameters ::
	@echo 'VmwareCloud::CSP ($(_VMC_CSP_MK_VERSION)) parameters:'
	@echo '    CSP=$(CSP)'
	@echo '    CSPCURL=$(CSPCURL)'
	@echo '    CSPJQ=$(CSPJQ)'
	@echo
	@#echo '    CSP_ACCESS_TOKEN=$(if $(CSP_ACCESS_TOKEN), ...)'
	@echo '    CSP_ACCESS_TOKEN=$(CSP_ACCESS_TOKEN)'
	@echo '    CSP_HOST_URL=$(CSP_HOST_URL)'
	@echo '    CSP_MODE_DEBUG=$(CSP_MODE_DEBUG)'
	@#echo '    CSP_REFRESH_TOKEN=$(if $(CSP_REFRESH_TOKEN), ...)'
	@echo '    CSP_REFRESH_TOKEN=$(CSP_REFRESH_TOKEN)'
	@echo

_view_framework_targets :: _csp_view_framework_targets
_csp_view_framework_targets ::
	@echo 'VmwareCloud::CSP ($(_VMC_CSP_MK_VERSION)) targets:'
	@echo '    _csp_decode_accesstoken              - Get an access-token'
	@echo '    _csp_get_accesstoken                 - Get an access-token'
	@echo '    _csp_install_dependencies            - Install dependencies'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/vmc_csp_configuration.mk
-include $(MK_DIR)/vmc_csp_container.mk
-include $(MK_DIR)/vmc_csp_organization.mk
-include $(MK_DIR)/vmc_csp_organizationinvitation.mk
-include $(MK_DIR)/vmc_csp_polltask.mk
-include $(MK_DIR)/vmc_csp_principaluser.mk
-include $(MK_DIR)/vmc_csp_service.mk
-include $(MK_DIR)/vmc_csp_serviceaccess.mk
-include $(MK_DIR)/vmc_csp_servicedefinition.mk
-include $(MK_DIR)/vmc_csp_serviceinstance.mk
-include $(MK_DIR)/vmc_csp_serviceinvitation.mk
-include $(MK_DIR)/vmc_csp_user.mk

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_csp_decode_accesstoken: _CSP_ACCESS_TOKEN?= $(subst .,$(SPACE),$(CSP_ACCESS_TOKEN))
_csp_decode_accesstoken: _CSP_ACCESSTOKEN_JOSE_HEADER?= $(word 1, $(_CSP_ACCESS_TOKEN))
_csp_decode_accesstoken: _CSP_ACCESSTOKEN_CLAIM_SET?= $(word 2, $(_CSP_ACCESS_TOKEN))
_csp_decode_accesstoken: _CSP_ACCESSTOKEN_SIGNATURE?= $(word 3, $(_CSP_ACCESS_TOKEN))
_csp_decode_accesstoken:
	@$(INFO) '$(CSP_UI_LABEL)Decoding an access-token ...'; $(NORMAL)
	@$(WARN) 'CSP uses JWT/JWS/Json Web Signature'; $(NORMAL)
	@echo 'CSP_ACCESS_TOKEN=$(_CSP_ACCESS_TOKEN)'
	@echo
	@$(WARN) 'The 1st part of the JWS is the JOSE header'; $(NORMAL)
	printf "$(_CSP_ACCESSTOKEN_JOSE_HEADER)" | base64 --decode | jq --monochrome-output '.'
	@echo
	@$(WARN) 'The 2nd part of the JWS is the payload/claim-set'; $(NORMAL)
	printf "$(_CSP_ACCESSTOKEN_CLAIM_SET)" | base64 --decode 2>/dev/null | jq --monochrome-output '.'
	@echo
	@$(WARN) 'The 3rd part of the JWS is the signature'; $(NORMAL)
	@echo '$(_CSP_ACCESSTOKEN_SIGNATURE)'
	@$(WARN) 'The signature was not base64-decoded because it most likely includes special characters that can mess up terminals'; $(NORMAL)

_csp_get_accesstoken:
	@$(INFO) '$(CSP_UI_LABEL)Getting an access-token ...'; $(NORMAL)
	curl  --data 'refresh_token=$(CSP_REFRESH_TOKEN)' --header "Content-Type: application/x-www-form-urlencoded" --header "Accept: application/json" --silent --request POST  '$(CSP_HOST_URL)/csp/gateway/am/api/auth/api-tokens/authorize' | jq '.'
	@$(WARN) 'Passing the refresh_token via query param still works, but is deprecated!'; $(NORMAL)
	# curl -sSX POST $(CSP_HOST_URL)/csp/gateway/am/api/auth/api-tokens/authorize\?refresh_token\=$(CSP_REFRESH_TOKEN) | jq -r .access_token

_install_framework_dependencies :: _csp_install_dependencies
_csp_install_dependencies:
	@$(INFO) '$(CSP_UI_LABEL)Installing csp-cli ....'; $(NORMAL)
	# https://confluence.eng.vmware.com/pages/viewpage.action?spaceKey=NSXPC&title=CSP++Commands+and+CLI+usage
	wget https://build-artifactory.eng.vmware.com/artifactory/csp-files-local/com/vmware/csp/csp-cli/1.0-201806271205-1035/csp-cli_linux_amd64_1.0-201806271205-1035 -O csp-cli
	chmod +x csp-cli
	sudo mv csp-cli /usr/local/bin/
	sudo ln -s /usr/local/bin/csp-bin /usr/local/bin/csp
	which csp
	csp --help

