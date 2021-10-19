_AWS_APIGATEWAY_CLIENTCERTIFICATE_MK_VERSION= $(_AWS_APIGATEWAY_MK_VERSION)

# AGY_CLIENTCERTIFICATE_DESCRIPTION?=
# AGY_CLIENTCERTIFICATE_ID?=
# AGY_CLIENTCERTIFICATE_NAME?=
# AGY_CLIENTCERTIFICATE_PATCH_OPERATIONS?=
# AGY_CLIENTCERTIFICATES_SET_NAME?=

# Derived parameters

# Option parameters
__AGY_CLIENT_CERTIFICATE_ID= $(if $(AGY_CLIENTCERTIFICATE_ID), --client-certificate-id $(AGY_CLIENTCERTIFICATE_ID))
__AGY_DESCRIPTION__CLIENTCERTIFICATE= $(if $(AGY_CLIENTCERTIFICATE_DESCRIPTION), --description $(AGY_CLIENTCERTIFICATE_DESCRIPTION))
__AGY_PATCH_OPERATIONS__CLIENTCERTIFICATE= $(if $(AGY_CLIENTCERTIFICATE_PATCH_OPERATIONS), --patch-operations $(AGY_CLIENTCERTIFICATE_PATCH_OPERATIONS))

# UI parameters
AGY_UI_VIEW_CLIENTCERTIFICATES_FIELDS?=
AGY_UI_VIEW_CLIENTCERTIFICATES_SET_FIELDS?= $(AGY_UI_VIEW_CLIENTCERTIFICATES_FIELDS)
AGY_UI_VIEW_CLIENTCERTIFICATES_SET_SLICE?=

#--- MACROS
_agy_get_clientcertificate_id= $(call _agy_get_clientcertificate_id_I, $(AGY_CLIENTCERTIFICATE_INDEX))
_agy_get_clientcertificate_id_I= $(shell $(AWS) apigateway get-client-certificates --rest-api-id $(2) --query "items[$(1)].id" --output text)

#----------------------------------------------------------------------
# USAGE
#
_agy_view_framework_macros ::
	@echo 'AWS::ApiGatewaY::ClientCertificate ($(_AWS_APIGATEWAY_CLIENTCERTIFICATE_MK_VERSION)) macros:'
	@echo '    _agy_get_clientcertificate_id_{|N|NR}            - Get the ID of a clientcertificate (Name,RestAPI)'
	@echo

_agy_view_framework_parameters ::
	@echo 'AWS::ApiGatewaY::ClientCertificate ($(_AWS_APIGATEWAY_CLIENTCERTIFICATE_MK_VERSION)) parameters:'
	@echo '    AGY_CLIENTCERTIFICATE_DESCRIPTION=$(AGY_CLIENTCERTIFICATE_DESCRIPTION)'
	@echo '    AGY_CLIENTCERTIFICATE_ID=$(AGY_CLIENTCERTIFICATE_ID)'
	@echo '    AGY_CLIENTCERTIFICATE_NAME=$(AGY_CLIENTCERTIFICATE_NAME)'
	@echo '    AGY_CLIENTCERTIFICATE_PATCH_OPERATIONS=$(AGY_CLIENTCERTIFICATE_PATCH_OPERATIONS)'
	@echo '    AGY_CLIENTCERTIFICATES_SET_NAME=$(AGY_CLIENTCERTIFICATES_SET_NAME)'
	@echo

_agy_view_framework_targets ::
	@echo 'AWS::ApiGatewaY::ClientCertificate ($(_AWS_APIGATEWAY_CLIENTCERTIFICATE_MK_VERSION)) targets:'
	@echo '    _agy_create_clientcertificate                   - Create a new client-certificate'
	@echo '    _agy_delete_clientcertificate                   - Delete an existing client-certificate'
	@echo '    _agy_show_clientcertificate                     - Show everything related to an client-certificate'
	@echo '    _agy_show_clientcertificate_description         - Show description of an client-certificate'
	@echo '    _agy_update_clientcertificate                   - Update an client-certificate'
	@echo '    _agy_view_clientcertificates                    - View client-certificates'
	@echo '    _agy_view_clientcertificates_set                - View a set of client-certificates'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_agy_create_clientcertificate:
	@$(INFO) '$(AWS_UI_LABEL)Creating client-certificate "$(AGY_CLIENTCERTIFICATE_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway generate-client-certificate $(__AGY_DESCRIPTION__CLIENTCERTIFICATE)

_agy_delete_clientcertificate:
	@$(INFO) '$(AWS_UI_LABEL)Deleting client-certificate "$(AGY_CLIENTCERTIFICATE_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway delete-client-certificate $(__AGY_CLIENT_CERTIFICATE_ID)

_agy_show_clientcertificate:: _agy_show_clientcertificate_description

_agy_show_clientcertificate_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of client-certificate "$(AGY_CLIENTCERTIFICATE_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway get-client-certificate $(__AGY_CLIENT_CERTIFICATE_ID)

_agy_update_clientcertificate:
	@$(INFO) '$(AWS_UI_LABEL)Updating client-certificate "$(AGY_CLIENTCERTIFICATE_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway update-client-certificate $(__AGY_CLIENT_CERTIFICATE_ID) $(__AGY_PATCH_OPERATIONS__CLIENTCERTIFICATE)

_agy_view_clientcertificates:
	@$(INFO) '$(AWS_UI_LABEL)Viewing all client-certificates ...'; $(NORMAL)
	$(AWS) apigateway get-client-certificates --query "items[]$(AGY_UI_VIEW_CLIENTCERTIFICATES_FIELDS)"

_agy_view_clientcertificates_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing client-certificates-set "$(AGY_CLIENTCERTIFICATES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Client-certificates are grouped based on the provided slice'; $(NORMAL)
	$(AWS) apigateway get-client-certificates --query "items[$(AGY_UI_VIEW_CLIENTCERTIFICATES_SET_SLICE)]$(AGY_UI_VIEW_CLIENTCERTIFICATES_SET_FIELDS)"
