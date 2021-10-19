_APPCHECK_PRODUCT_MK_VERSION= $(_APPCHECK_MK_VERSION)

# ACK_PRODUCT_API_URL?=
# ACK_PRODUCT_ARTIFACT_URL?= http://get.videolan.org/vlc/2.2.1/macosx/vlc-2.2.1.dmg
# ACK_PRODUCT_FILENAME?= 
# ACK_PRODUCT_GROUP_ID?= 4
# ACK_PRODUCT_GROUP_ENDPOINTURL?= https://appcheck.eng.vmware.com/group/4/
# ACK_PRODUCT_GROUP_NAME?= NSBU
# ACK_PRODUCT_ID?= 97845
# ACK_PRODUCT_NAME?= NSBU
# ACK_PRODUCT_REPORT_URL?= https://appcheck.eng.vmware.com/products/98096/
# ACK_PRODUCTS_SET_NAME?= my-products-set

# Derived parameters
ACK_PRODUCT_API_URL?= $(ACK_API_URL)
ACK_PRODUCT_ARTIFACT_URL?= $(ACK_ARTIFACT_URL)
ACK_PRODUCT_ENDPOINT_URL?= $(ACK_ENDPOINT_URL)/products
ACK_PRODUCT_FILENAME?= $(notdir $(ACK_ARTIFACT_FILEPATH))
ACK_PRODUCT_GROUP_ENDPOINTURL?= $(ACK_GROUP_ENDPOINT_URL)/$(ACK_PRODUCT_GROUP_ID)/
ACK_PRODUCT_GROUP_ID?= $(ACK_GROUP_ID)
ACK_PRODUCT_GROUP_NAME?= $(ACK_GROUP_NAME)
ACK_PRODUCT_NAME?= $(ACK_ARTIFACT_NAME)
ACK_PRODUCT_REPORT_URL?= $(ACK_PRODUCT_ENDPOINT_URL)/$(ACK_PRODUCT_ID)/

# Option parameters
__ACK_HEADERS__PRODUCT+= $(if $(ACK_PRODUCT_GROUP_ID),--header 'Group: $(ACK_PRODUCT_GROUP_ID)')
__ACK_HEADERS__PRODUCT+= $(if $(ACK_PRODUCT_ARTIFACT_URL),--header 'Url: $(ACK_PRODUCT_ARTIFACT_URL)')

# Pipe parameters
|_ACK_FETCH_PRODUCT?= | jq '.'
|_ACK_SHOW_PRODUCT_COMPONENTS?= | jq --monochrome-output '.res'
|_ACK_SHOW_PRODUCT_DESCRIPTION?= | jq --monochrome-output '.'
|_ACK_SHOW_PRODUCT_VULNERABILITIES?= | jq --monochrome-output '.'
|_ACK_VIEW_PRODUCTS?= | jq --monochrome-output '[.products[]] | sort_by(.product_id) | .[-5:]'
|_ACK_VIEW_PRODUCTS_SET?= $(|_ACK_VIEW_PRODUCTS)

# UI parameters
 
#--- Utilities

#--- MACROS
_ack_get_product_id= $(call _ack_get_product_id_N, $(ACK_PRODUCT_NAME))
_ack_get_product_id_N= $(call _ack_get_product_id_NG, $(1), $(ACK_PRODUCT_GROUP_ID))
_ack_get_product_id_NG= $(call _ack_get_product_id_NGU, $(1), $(2), $(ACK_PRODUCT_API_URL))
_ack_get_product_id_NGU= $(shell $(APPCHECK) -s -X GET $(strip $(3))/apps/$(strip $(2))/ | jq '.products[] | select(.name=="$(strip $(1))").product_id')

#----------------------------------------------------------------------
# USAGE
#

_ack_view_framework_macros ::
	@echo 'AppChecK::Product ($(_APPCHECK_PRODUCT_MK_VERSION)) macros:'
	@echo '    _ack_get_product_id_{|N|NG|NGU}        - Get the product id (Name,GroupId,Url)'
	@echo

_ack_view_framework_parameters ::
	@echo 'AppChecK::Product ($(_APPCHECK_PRODUCT_MK_VERSION)) parameters:'
	@echo '    ACK_PRODUCT_API_URL=$(ACK_PRODUCT_API_URL)'
	@echo '    ACK_PRODUCT_ARTIFCAT_URL=$(ACK_PRODUCT_ARTIFACT_URL)'
	@echo '    ACK_PRODUCT_ENDPOINT_URL=$(ACK_PRODUCT_EDNPOINT_URL)'
	@echo '    ACK_PRODUCT_FILENAME=$(ACK_PRODUCT_FILENAME)'
	@echo '    ACK_PRODUCT_GROUP_ENDPOINTURL=$(ACK_PRODUCT_GROUP_ENDPOINTURL)'
	@echo '    ACK_PRODUCT_GROUP_ID=$(ACK_PRODUCT_GROUP_ID)'
	@echo '    ACK_PRODUCT_GROUP_NAME=$(ACK_PRODUCT_GROUP_NAME)'
	@echo '    ACK_PRODUCT_ID=$(ACK_PRODUCT_ID)'
	@echo '    ACK_PRODUCT_NAME=$(ACK_PRODUCT_NAME)'
	@echo '    ACK_PRODUCT_REPORT_URL=$(ACK_PRODUCT_REPORT_URL)'
	@echo '    ACK_PRODUCTS_SET_NAME=$(ACK_PRODUCTS_SET_NAME)'
	@echo

_ack_view_framework_targets ::
	@echo 'AppChecK::Product ($(_APPCHECK_PRODUCT_MK_VERSION)) targets:'
	@echo '    _ack_fetch_product              - Fetch an artifact for a product'
	@echo '    _ack_show_product               - Show everything related to a product'
	@echo '    _ack_show_product_descriptin    - Show description of a product'
	@echo '    _ack_view_products              - View products'
	@echo '    _ack_view_products_set          - View a set of products'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ack_fetch_product:
	@$(INFO) '$(ACK_UI_LABEL)Fetching artifact for product "$(ACK_PRODUCT_NAME)" ...'; $(NORMAL)
	$(APPCHECK) -s -X POST $(__ACK_HEADERS__PRODUCT) $(ACK_PRODUCT_API_URL)/fetch/ $(|_ACK_FETCH_PRODUCT)

_ack_show_product: _ack_show_product_report _ack_show_product_vulnerabilities _ack_show_product_description

_ack_show_product_components:
	@$(INFO) '$(ACK_UI_LABEL)Show components of product "$(ACK_PRODUCT_NAME)" ...'; $(NORMAL)
	$(APPCHECK) -s -X GET $(ACK_PRODUCT_API_URL)/product/$(strip $(ACK_PRODUCT_ID))/ $(|_ACK_SHOW_PRODUCT_COMPONENTS)

_ack_show_product_description:
	@$(INFO) '$(ACK_UI_LABEL)Show description of product "$(ACK_PRODUCT_NAME)" ...'; $(NORMAL)
	$(APPCHECK) -s -X GET $(ACK_PRODUCT_API_URL)/apps/?q=file:$(ACK_PRODUCT_FILENAME) $(|_ACK_SHOW_PRODUCT_DESCRIPTION)
	@$(WARN) 'Status code: B~Busy R~Ready F~Failed'; $(NORMAL)

_ack_show_product_report:
	@$(INFO) '$(ACK_UI_LABEL)Show report for product "$(ACK_PRODUCT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Go to $(ACK_PRODUCT_REPORT_URL)'; $(NORMAL)

_ack_show_product_vulnerabilities:
	@$(INFO) '$(ACK_UI_LABEL)Show vulnerabilities of product "$(ACK_PRODUCT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Format documentation at https://appcheck.eng.vmware.com/help/api/#result-format-json'; $(NORMAL)
	$(APPCHECK) -s -X GET $(ACK_PRODUCT_API_URL)/product/$(strip $(ACK_PRODUCT_ID))/ $(|_ACK_SHOW_PRODUCT_VULNERABILITIES)
	@$(WARN) 'Format documentation at https://appcheck.eng.vmware.com/help/api/#result-format-json'; $(NORMAL)

_ack_view_products:
	@$(INFO) '$(ACK_UI_LABEL)View products ...'; $(NORMAL)
	@$(WARN) 'This operation returns products from every groups'; $(NORMAL)
	$(APPCHECK) -s -X GET $(ACK_PRODUCT_API_URL)/apps/$(_X_ACK_PRODUCT_GROUP_ID) $(|_ACK_VIEW_PRODUCTS)

_ack_view_products_set:
	@$(INFO) '$(ACK_UI_LABEL)View products-set "$(ACK_PRODUCTS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Products are grouped based on group-id, ordered, and sliced'; $(NORMAL)
	@$(WARN) 'UI @ Group URL: $(ACK_PRODUCT_GROUP_ENDPOINTURL)'; $(NORMAL)
	$(APPCHECK) -s -X GET $(ACK_PRODUCT_API_URL)/apps/$(ACK_PRODUCT_GROUP_ID)/ $(|_ACK_VIEW_PRODUCTS_SET)
