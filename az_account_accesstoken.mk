_AZ_ACCOUNT_ACCESSTOKEN_MK_VERSION= $(_AZ_ACCOUNT_MK_VERSION)

# ACT_ACCESSTOKEN_NAME?= my-token
# ACT_ACCESSTOKEN_SUBSCRIPTION_ID?= 59b066b1-4bd5-4a01-bbb1-14ee71d3d7fc
# ACT_ACCESSTOKEN_TOKEN?=
# ACT_ACCESSTOKENS_SET_NAME?= my-tokens-set

# Derived parameters
ACT_ACCESSTOKEN_NAME?= $(AZ_ACCESSTOKEN_NAME)
ACT_ACCESSTOKEN_SUBSCRIPTION_ID?= $(AZ_SUBSCRIPTION_ID)

# Options parameters
__ACT_SUBSCRIPTION__ACCESSTOKEN= $(if $(ACT_ACCESSTOKEN_SUBSCRIPTION_ID),--subscription $(ACT_ACCESSTOKEN_SUBSCRIPTION_ID))

# UI parameters

#--- Utilities

#--- MACRO
_act_get_accesstoken_token= $(call _act_get_accesstoken_token_S, $(ACT_ACCESSTOKEN_SUBSCRIPTION_ID))
_act_get_accesstoken_token_S= $(shell $(AZ) account get-access-token --subscription $(1) | jq '@.accessToken')

#----------------------------------------------------------------------
# USAGE
#

_act_view_framework_macros ::
	@echo 'AZ::ACcounT::AccessToken ($(_AZ_ACCOUNT_ACCESSTOKEN_MK_VERSION)) macros:'
	@echo '    _act_get_accesstoken_token_{|S}       - Get an access-token (Subscription)'
	@echo

_act_view_framework_parameters ::
	@echo 'AZ::ACcounT::AccessToken ($(_AZ_ACCOUNT_ACCESSTOKEN_MK_VERSION)) parameters:'
	@echo '    ACT_ACCESSTOKEN_NAME=$(ACT_ACCESSTOKEN_NAME)'
	@echo '    ACT_ACCESSTOKEN_SUBSCRIPTION_ID=$(ACT_ACCESSTOKEN_SUBSCRIPTION_ID)'
	@echo '    ACT_ACCESSTOKENS_SET_NAME=$(ACT_ACCESSTOKENS_SET_NAME)'
	@echo

_act_view_framework_targets ::
	@echo 'AZ::ACcounT::AccessToken ($(_AZ_ACCOUNT_ACCESSTOKEN_MK_VERSION)) targets:'
	@echo '    _act_create_accesstoken               - Create an access-token'
	@echo '    _act_decode_accesstoken               - Decode an access-token'
	@echo '    _act_delete_accesstoken               - Delete an access-token'
	@echo '    _act_show_accesstoken                 - Show everything related to an access-token'
	@echo '    _act_show_accesstoken_description     - Show description of an access-token'
	@echo '    _act_view_accesstokens                - View access-tokens'
	@echo '    _act_view_accesstokens_set            - View access-tokens-set'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_act_create_accesstoken:
	@$(INFO) '$(ACT_UI_LABEL)Creating access-token "$(ACT_ACCESSTOKEN_NAME)" ...'; $(NORMAL)
	$(AZ) account get-access-token $(__ACT_SUBSCRIPTION__ACCESSTOKEN)

_act_decode_accesstoken: _ACT_ACCESSTOKEN_TOKEN_PARTS?= $(subst .,$(SPACE),$(ACT_ACCESSTOKEN_TOKEN))
_act_decode_accesstoken: _ACT_ACCESSTOKEN_TOKEN_JOSEHEADER?= $(word 1, $(_ACT_ACCESSTOKEN_TOKEN_PARTS))
_act_decode_accesstoken: _ACT_ACCESSTOKEN_TOKEN_CLAIMSET?= $(word 2, $(_ACT_ACCESSTOKEN_TOKEN_PARTS))
_act_decode_accesstoken: _ACT_ACCESSTOKEN_TOKEN_SIGNATURE?= $(word 3, $(_ACT_ACCESSTOKEN_TOKEN_PARTS))
_act_decode_accesstoken:
	@$(INFO) '$(ACT_UI_LABEL)Decoding an access-token ...'; $(NORMAL)
	@$(WARN) 'ACT uses JWT/JWS/Json Web Signature'; $(NORMAL)
	@echo 'ACT_ACCESSTOKEN_TOKEN=$(ACT_ACCESSTOKEN_TOKEN)'
	@echo
	@$(WARN) 'The 1st part of the JWS is the JOSE header'; $(NORMAL)
	printf "$(_ACT_ACCESSTOKEN_TOKEN_JOSEHEADER)" | base64 --decode | jq --monochrome-output '.'
	@echo
	@$(WARN) 'The 2nd part of the JWS is the payload/claim-set'; $(NORMAL)
	printf "$(_ACT_ACCESSTOKEN_TOKEN_CLAIMSET)" | base64 --decode 2>/dev/null | jq --monochrome-output '.'
	@echo
	@$(WARN) 'The 3rd part of the JWS is the signature'; $(NORMAL)
	@echo '$(_ACT_ACCESSTOKEN_TOKEN_SIGNATURE)'
	@$(WARN) 'The signature was not base64-decoded because it most likely includes special characters that can mess up terminals'; $(NORMAL)

_act_delete_accesstoken:
	@$(INFO) '$(ACT_UI_LABEL)Deleting token "$(ACT_ACCESSTOKEN_NAME)" ...'; $(NORMAL)

_act_show_accesstoken: _act_show_accesstoken_object _act_show_accesstoken_description

_act_show_accesstoken_description:
	@$(INFO) '$(ACT_UI_LABEL)Showing description of token "$(ACT_ACCESSTOKEN_NAME)" ...'; $(NORMAL)
	# $(AZ) account show $(__ACT_OUTPUT) $(__ACT_SDK_AUTH) $(__ACT_SUBSCRIPTIOB__ACCESSTOKEN)

_act_show_accesstoken_object:
	@$(INFO) '$(ACT_UI_LABEL)Showing object of token "$(ACT_ACCESSTOKEN_NAME)" ...'; $(NORMAL)
	# $(AZ) account show $(_X__ACT_OUTPUT) $(__ACT_SDK_AUTH) $(__ACT_SUBSCRIPTIOB__ACCESSTOKEN)

_act_view_accesstokens:
	@$(INFO) '$(ACT_UI_LABEL)Viewing tokens ...'; $(NORMAL)
	# $(AZ) account list $(__ACT_ALL) $(__ACT_OUTPUT) $(__ACT_SUBSCRIPTIOB__ACCESSTOKEN)

_act_view_accesstokens_set:
	@$(INFO) '$(ACT_UI_LABEL)Viewing tokens-set "$(ACT_ACCESSTOKENS_SET_NAME)" ...'; $(NORMAL)
	@# $(WARN) 'Subscriptions are grouped based on enable-status'; $(NORMAL) 
	# $(AZ) account list $(_X__ACT_ALL) $(__ACT_OUTPUT) $(__ACT_SUBSCRIPTIOB__ACCESSTOKEN)
