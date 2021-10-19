_AWS_PRICING_MK_VERSION= 0.99.6

PCG_FORMAT_VERSION?= aws_v1
PCG_SERVICE_ATTRIBUTE?= productFamily
# PCG_SERVICE_ATTRIBUTES?= productFamily ...
# PCG_SERVICE_NAME?= AWSCodeCommit
# PCG_SERVICE_NAMES?= AWSCodeCommit ...

# Derived parameters
PCG_SERVICE_ATTRIBUTES?= $(PCG_SERVICE_ATTRIBUTE)
PCG_SERVICE_NAMES?= $(PCG_SERVICE_NAME)

# Options parameters
__PCG_ATTRIBUTE_NAME?= $(if $(PCG_SERVICE_ATTRIBUTE), --attribute-name $(PCG_SERVICE_ATTRIBUTE))
__PCG_FORMAT_VERSION= $(if $(PCG_FORMAT_VERSION), --format-version $(PCG_FORMAT_VERSION))
__PCG_SERVICE_CODE= $(if $(PCG_SERVICE_NAME), --service-code $(PCG_SERVICE_NAME))

# UI parameters
PCG_UI_VIEW_PRODUCTS_FIELDS?=
PCG_UI_VIEW_SERVICES_FIELDS?= .ServiceCode

#--- Utilities

# https://pricing.us-east-1.amazonaws.com/offers/v1.0/aws/AmazonEC2/20180531023538/us-west-1/index.json

#--- MACROS
_pcg_get_service_attributes= $(call _pcg_get_service_attributes_N, $(PCG_SERVICE_NAME))
_pcg_get_service_attributes_N= $(shell $(AWS) pricing describe-services --service-code $(1) --query  "Services[0].AttributeNames" --output text)

_pcg_get_service_names= $(shell $(AWS) pricing describe-services  --format-version aws_v1  --query "Services[].ServiceCode" --output text)

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _pcg_view_framework_macros
_pcg_view_framework_macros ::
	@echo 'AWS::PriCinG ($(_AWS_PRICING_MK_VERSION)) macros:'
	@echo '    _pcg_get_service_attributes_{|N}        - Get all attributes for a service (Name)'
	@echo '    _pcg_get_service_names                  - Get the names of the available services'
	@echo

_aws_view_framework_parameters :: _pcg_view_framework_parameters
_pcg_view_framework_parameters ::
	@echo 'AWS::PriCinG ($(_AWS_PRICING_MK_VERSION)) parameters:'
	@echo '    PCG_SERVICE_ATTRIBUTE=$(PCG_SERVICE_ATTRIBUTE)'
	@echo '    PCG_SERVICE_ATTRIBUTES=$(PCG_SERVICE_ATTRIBUTES)'
	@echo '    PCG_FORMAT_VERSION=$(PCG_FORMAT_VERSION)'
	@echo '    PCG_SERVICE_NAME=$(PCG_SERVICE_NAME)'
	@echo

_aws_view_framework_targets :: _pcg_view_framework_targets
_pcg_view_framework_targets ::
	@echo 'AWS::PriCinG ($(_AWS_PRICING_MK_VERSION)) targets:'
	@echo '    _pcg_show_service                       - Show everything related to a given service'
	@echo '    _pcg_show_service_attribute             - Show values of an attribute of a service'
	@echo '    _pcg_show_service_attributes            - Show all attributes of a service'
	@echo '    _pcg_show_service_description           - Show description of a service'
	@echo '    _pcg_view_products                      - View product for anall availabe services'
	@echo '    _pcg_view_services                      - View all availabe services'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_pcg_show_service: _pcg_show_service_attributes _pcg_show_service_pricing0 _pcg_show_service_description

_pcg_show_service_attribute:
	@$(INFO) '$(AWS_UI_LABEL)Showing values for attribute "$(PCG_SERVICE_ATTRIBUTE)" of service "$(PCG_SERVICE_NAME)" ...'; $(NORMAL)
	$(AWS) pricing get-attribute-values $(__PCG_ATTRIBUTE_NAME) $(__PCG_SERVICE_CODE) --query "AttributeValues[].Value"

_pcg_show_service_attributes:
	$(foreach A, $(PCG_SERVICE_ATTRIBUTES), \
		$(MAKE) --no-print-directory PCG_SERVICE_ATTRIBUTE=$(A) _pcg_show_service_attribute; \
	)

_pcg_show_service_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of service "$(PCG_SERVICE_NAME)" ...'; $(NORMAL)
	$(AWS) pricing describe-services $(__PCG_FORMAT_VERSION) $(__PCG_SERVICE_CODE)

_pcg_show_service_pricing0:
	@$(INFO) '$(AWS_UI_LABEL)Showing sample product/pricing for service "$(PCG_SERVICE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'For complete pricing information, directly ask for service pricing!'; $(NORMAL) 
	$(AWS) pricing get-products $(__PCG_FORMAT_VERSION) $(__PCG_SERVICE_CODE) --query "PriceList[0]$(PCG_UI_VIEW_PRODUCTS_FIELDS)" --output text | jq '.' | head -40

_pcg_show_service_pricing:
	@$(INFO) '$(AWS_UI_LABEL)Showing available products/pricing for service "$(PCG_SERVICE_NAME)" ...'; $(NORMAL)
	$(AWS) pricing get-products $(__PCG_FORMAT_VERSION) $(__PCG_SERVICE_CODE) --query "PriceList[]$(PCG_UI_VIEW_PRODUCTS_FIELDS)" --output text | jq '.'

_pcg_view_services:
	@$(INFO) '$(AWS_UI_LABEL)Viewing available AWS service ...'; $(NORMAL)
	@$(WARN) 'Services are also service codes!'; $(NORMAL)
	$(AWS) pricing describe-services $(__PCG_FORMAT_VERSION) $(_X__PCG_SERVICE_CODE) --query "Services[]$(PCG_UI_VIEW_SERVICES_FIELDS)"
