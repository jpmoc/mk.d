_AWS_APIGATEWAY_DOMAINNAME_MK_VERSION= $(_AWS_APIGATEWAY_MK_VERSION)

# AGY_DOMAINNAME_CERTIFICATE_ARN?=
# AGY_DOMAINNAME_CERTIFICATE_BODY?=
# AGY_DOMAINNAME_CERTIFICATE_CHAIN?=
# AGY_DOMAINNAME_CERTIFICATE_NAME?=
# AGY_DOMAINNAME_CERTIFICATE_PRIVATEKEY?=
# AGY_DOMAINNAME_EDNPOINT_CONFIGURATION?=
# AGY_DOMAINNAME_NAME?= my-domain-name
# AGY_DOMAINNAME_REGIONALCERTIFICATE_ARN?=
# AGY_DOMAINNAME_REGIONALCERTIFICATE_NAME?=
# AGY_DOMAINNAMES_SET_NAME?=

# Derived parameters

# Option parameters
__AGY_CERTIFICATE_ARN= $(if $(AGY_DOMAINNAME_CERTIFICATE_ARN), --certificate-arn $(AGY_DOMAINNAME_CERTIFICATE_ARN))
__AGY_CERTIFICATE_BODY= $(if $(AGY_DOMAINNAME_CERTIFICATE_BODY), --certificate-body $(AGY_DOMAINNAME_CERTIFICATE_BODY))
__AGY_CERTIFICATE_CHAIN= $(if $(AGY_DOMAINNAME_CERTIFICATE_CHAIN), --certificate-chain $(AGY_DOMAINNAME_CERTIFICATE_CHAIN))
__AGY_CERTIFICATE_NAME= $(if $(AGY_DOMAINNAME_CERTIFICATE_NAME), --certificate-name $(AGY_DOMAINNAME_CERTIFICATE_NAME))
__AGY_CERTIFICATE_PRIVATE_KEY= $(if $(AGY_DOMAINNAME_CERTIFICATE_PRIVATE_KEY), --certificate-private-key $(AGY_DOMAINNAME_CERTIFICATE_PRIVATEKEY))
__AGY_ENDPOINT_CONFIGURATION= $(if $(AGY_DOMAINNAME_ENDPOINT_CONFIGURATION), --endpoint-configuration $(AGY_DOMAINNAME_ENDPOINT_CONFIGURATION))
__AGY_PATCH_OPERATIONS__DOMAINNAME= $(if $(AGY_DOMAINNAME_PATCH_OPERATIONS), --patch-operations $(AGY_DOMAINNAME_PATCH_OPERATIONS))
__AGY_REGIONAL_CERTIFICATE_ARN= $(if $(AGY_DOMAINNAME_REGIINALCERTIFICATE_ARN), --region-certificate-arn $(AGY_DOMAINNAME_REGIONALCERTIFICATE_ARN))
__AGY_REGIONAL_CERTIFICATE_NAME= $(if $(AGY_DOMAINNAME_REGIINALCERTIFICATE_NAME), --region-certificate-name $(AGY_DOMAINNAME_REGIONALCERTIFICATE_NAME))

# UI parameters
AGY_UI_VIEW_DOMAINNAMES_FIELDS?=
AGY_UI_VIEW_DOMAINNAMES_SET_FIELDS?= $(AGY_UI_VIEW_DOMAINNAMES_FIELDS)
AGY_UI_VIEW_DOMAINNAMES_SET_SLICE?=

#--- MACROS
_agy_get_domainname_id= $(call _agy_get_domainname_id_I, $(AGY_DOMAINNAME_INDEX))
_agy_get_domainname_id_I= $(call _agy_get_domainname_id_IR, $(1), $(AGY_DOMAINNAME_RESTAPI_ID))
_agy_get_domainname_id_IR= $(shell $(AWS) apigateway get-domainnames --rest-api-id $(2) --query "items[$(1)].id" --output text)

#----------------------------------------------------------------------
# USAGE
#
_agy_view_framework_macros ::
	@echo 'AWS::ApiGatewaY::DomainName ($(_AWS_APIGATEWAY_DOMAINNAME_MK_VERSION)) macros:'
	@echo '    _agy_get_domainname_id_{|N|NR}            - Get the ID of a domainname (Name,RestAPI)'
	@echo

_agy_view_framework_parameters ::
	@echo 'AWS::ApiGatewaY::DomainName ($(_AWS_APIGATEWAY_DOMAINNAME_MK_VERSION)) parameters:'
	@echo '    AGY_DOMAINNAME_CERTIFICATE_ARN=$(AGY_DOMAINNAME_CERTIFICATE_ARN)'
	@echo '    AGY_DOMAINNAME_CERTIFICATE_BODY=$(AGY_DOMAINNAME_CERTIFICATE_BODY)'
	@echo '    AGY_DOMAINNAME_CERTIFICATE_CHAIN=$(AGY_DOMAINNAME_CERTIFICATE_CHAIN)'
	@echo '    AGY_DOMAINNAME_CERTIFICATE_NAME=$(AGY_DOMAINNAME_CERTIFICATE_NAME)'
	@echo '    AGY_DOMAINNAME_CERTIFICATE_PRIVATEKEY=$(AGY_DOMAINNAME_CERTIFICATE_PRIVATEKEY)'
	@echo '    AGY_DOMAINNAME_ENDPOINT_CONFIGURATION=$(AGY_DOMAINNAME_ENDPOINT_CONFIGURATION)'
	@echo '    AGY_DOMAINNAME_NAME=$(AGY_DOMAINNAME_NAME)'
	@echo '    AGY_DOMAINNAME_REGIONALCERTIFICATE_ARN=$(AGY_DOMAINNAME_REGIONALCERTIFICATE_ARN)'
	@echo '    AGY_DOMAINNAME_REGIONALCERTIFICATE_NAME=$(AGY_DOMAINNAME_REGIONALCERTIFICATE_NAME)'
	@echo '    AGY_DOMAINNAMES_SET_NAME=$(AGY_DOMAINNAMES_SET_NAME)'
	@echo

_agy_view_framework_targets ::
	@echo 'AWS::ApiGatewaY::DomainName ($(_AWS_APIGATEWAY_DOMAINNAME_MK_VERSION)) targets:'
	@echo '    _agy_create_domainname                   - Create a new domain-name'
	@echo '    _agy_delete_domainname                   - Delete an existing domain-name'
	@echo '    _agy_show_domainname                     - Show everything related to a domain-name'
	@echo '    _agy_show_domainname_description         - Show description of a domain-name'
	@echo '    _agy_update_domainname                   - Update a domain-name'
	@echo '    _agy_view_domainnames                    - View domain-names'
	@echo '    _agy_view_domainnames_set                - View a set of domain-names'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_agy_create_domainname:
	@$(INFO) '$(AWS_UI_LABEL)Creating domain-name "$(AGY_DOMAINNAME_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway create-domain-name $(__AGY_CERTIFICATE_ARN) $(__AGY_CERTIFICATE_BODY) $(__AGY_CERTIFICATE_CHAIN) $(__AGY_CERTIFICATE_NAME) $(__AGY_CERTIFICATE_PRIVATE_KEY) $(__AGY_ENDPOINT_CONFIGURATION) $(__AGY_REGIONAL_CERTIFICATE_ARN) $(__AGY_REGIONAL_CERTIFICATE_NAME)

_agy_delete_domainname:
	@$(INFO) '$(AWS_UI_LABEL)Deleting domain-name "$(AGY_DOMAINNAME_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway delete-domain-name $(__AGY_DOMAINNAME_NAME)

_agy_show_domainname:: _agy_show_domainname_description

_agy_show_domainname_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of domain-name "$(AGY_DOMAINNAME_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway get-domain-name $(__AGY_DOMAINNAME_NAME)

_agy_update_domainname:
	@$(INFO) '$(AWS_UI_LABEL)Updating domain-name "$(AGY_DOMAINNAME_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway update-domain-name $(__AGY_DOMAINNAME_NAME) $(__AGY_PATCH_OPERATIONS__DOMAINNAME)

_agy_view_domainnames:
	@$(INFO) '$(AWS_UI_LABEL)Viewing all domain-names ...'; $(NORMAL)
	$(AWS) apigateway get-domain-names --query "items[]$(AGY_UI_VIEW_DOMAINNAMES_FIELDS)"

_agy_view_domainnames_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing domain-names-set "$(AGY_DOMAINNAMES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Domain-names are grouped based on the provided slice'; $(NORMAL)
	$(AWS) apigateway get-domain-names --query "items[$(AGY_UI_VIEW_DOMAINNAMES_SET_SLICE)]$(AGY_UI_VIEW_DOMAINNAMES_SET_FIELDS)"
