_TERRAFORM_TFESERVER_MK_VERSION= $(_TERRAFORM_MK_VERSION)

# TFM_TFESERVER_API_TOKEN?= M59...Yoo
TFM_TFESERVER_CREDENTIALS_FILEPATH?= $(HOME)/.terraform.d/credentials.tfrc.json
TFM_TFESERVER_ENDPOINT_PROTO?= https://
# TFM_TFESERVER_ENDPOINT_URL?= https://tfe.domain.com
# TFM_TFESERVER_NAME?= tfe.domain.com

# Derived variables
TFM_TFESERVER_ENDPOINT_URL?= $(if $(TFM_TFESERVER_NAME),$(TFM_TFESERVER_ENDPOINT_PROTO)$(TFM_TFESERVER_NAME))

# Options variables

# UI parameters
|_TFM_SHOW_TFESERVER_APITOKEN?= | head -c 10; echo '... (Truncated)'

# Utilities

#--- MACROS
_tfm_get_tfeserver_api_token= $(call _tfm_get_tfeserver_api_token_S, $(TFM_TFESERVER_NAME))
_tfm_get_tfeserver_api_token_S= $(call _tfm_get_tfeserver_api_token_SF, $(1), $(TFM_TFESERVER_CREDENTIALS_FILEPATH))
_tfm_get_tfeserver_api_token_SF= $(shell jq -r '.credentials."$(strip $(1))".token' $(2))

#----------------------------------------------------------------------
# USAGE
#

_tfm_view_framework_macros ::
	@echo 'TerraForM::TfeServer ($(_TERRAFORM_TFESERVER_MK_VERSION)) macros:'
	@echo

_tfm_view_framework_parameters ::
	@echo 'TerraForM::TfeServer ($(_TERRAFORM_TFESERVER_MK_VERSION)) parameters:'
	@echo '    TFM_TFESERVER_API_TOKEN=$(TFM_TFESERVER_API_TOKEN)'
	@echo '    TFM_TFESERVER_CREDENTIALS_FILEPATH=$(TFM_TFESERVER_CREDENTIALS_FILEPATH)'
	@echo '    TFM_TFESERVER_ENDPOINT_PROTO=$(TFM_TFESERVER_ENDPOINT_PROTO)'
	@echo '    TFM_TFESERVER_ENDPOINT_URL=$(TFM_TFESERVER_ENDPOINT_URL)'
	@echo '    TFM_TFESERVER_NAME=$(TFM_TFESERVER_NAME)'
	@echo

_tfm_view_framework_targets ::
	@echo 'TerraForM::TfeServer ($(_TERRAFORM_TFESERVER_MK_VERSION)) targets:'
	@echo '    _tfm_login_tfeserver               - Log in a TFE-server'
	@echo '    _tfm_show_tfeserver                - Show everything related to a TFE-server'
	@echo '    _tfm_show_tfeserver_apitoken       - Show API-token for a TFE-server'
	@echo '    _tfm_show_tfeserver_description    - Show description of a TFE-server'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_tfm_login_tfeserver:
	@$(INFO) '$(TFM_UI_LABEL)Logging in TFE server "$(TFM_TFESERVER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fetches an API token from a TFE server to be used for ALL future interactions with that server that require authorization'; $(NORMAL)
	@$(WARN) 'This operation opens a web browser and terminates only when that web browser is manually closed'; $(NORMAL)
	@$(WARN) 'This operation saves the generated API-token in ~/.terraform.d/credentials.tfrc.json'; $(NORMAL)
	$(TERRAFORM) login $(TFM_TFESERVER_NAME)

_tfm_show_tfeserver: _tfm_show_tfeserver_apitoken _tfm_show_tfeserver_description

_tfm_show_tfeserver_apitoken:
	@$(INGO) '$(TFM_UI_LABEL)Showing API-token for TFE-server "$(TFM_TFESERVER_NAME)"...'
	jq -r '.credentials."$(TFM_TFESERVER_NAME)".token' $(TFM_TFESERVER_CREDENTIALS_FILEPATH)$(|_TFM_SHOW_TFESERVER_APITOKEN)

_tfm_show_tfeserver_description:
	@$(INGO) '$(TFM_UI_LABEL)Showing description of TFE-server "$(TFM_TFESERVER_NAME)"...'
	dig +short $(TFM_TFESERVER_NAME)
