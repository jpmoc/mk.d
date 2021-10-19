_KIND_APIVERSION_MK_VERSION= $(_KIND_MK_VERSION)

KND_APIVERSION_IMAGE_FAMILY?= kindest/node
# KND_APIVERSION_IMAGE_NAME?= kindest/node:v1.19.4
KND_APIVERSION_NAME?= v1.19.4
KND_APIVERSIONS_REGEX?= *
# KND_APIVERSIONS_SET_NAME?= my-clusters-set

# Derived variables
KND_APIVERSION_IMAGE_NAME?= $(KND_APIVERSION_IMAGE_FAMILY):$(KND_APIVERSION_NAME)
KND_APIVERSIONS_SET_NAME?= api-versions@$(KND_APIVERSIONS_REGEX)

# Option variables

# Pipe parameters
|_KND_VIEW_APIVERSIONS_SET?= | grep -E '$(KND_APIVERSIONS_REGEX)'

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_knd_view_framework_macros ::
	@#echo 'KiND::ApiVersion ($(_KIND_APIVERSION_MK_VERSION)) macros:'
	@#echo

_knd_view_framework_parameters ::
	@echo 'KiND::ApiVersion ($(_KIND_APIVERSION_MK_VERSION)) parameters:'
	@echo '    KND_APIVERSION_IMAGE_FAMILY=$(KND_APIVERSION_IMAGE_FAMILY)'
	@echo '    KND_APIVERSION_IMAGE_NAME=$(KND_APIVERSION_IMAGE_NAME)'
	@echo '    KND_APIVERSION_NAME=$(KND_APIVERSION_NAME)'
	@echo '    KND_APIVERSIONS_REGEX=$(KND_APIVERSIONS_REGEX)'
	@echo '    KND_APIVERSIONS_SET_NAME=$(KND_APIVERSIONS_SET_NAME)'
	@echo

_knd_view_framework_targets ::
	@echo 'KiND::ApiVersion ($(_KIND_APIVERSION_MK_VERSION)) targets:'
	@echo '    _knd_show_apiversion               - Show everything related to an api-version'
	@echo '    _knd_show_apiversion_description   - Show description of an api-version'
	@echo '    _knd_view_apiversions              - View all api-versions'
	@echo '    _knd_view_apiversions_set          - View a set of api-versions'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_knd_show_apiversion: _knd_show_apiversion_description

_knd_show_apiversion:
	@$(INFO) '$(KND_UI_LABEL)Showing description of api-version "$(KND_APIVERSION_NAME)" ...'; $(NORMAL)

_knd_view_apiversions:
	@$(INFO) '$(KND_UI_LABEL)Viewing api-versions" ...'; $(NORMAL)
	wget -q https://registry.hub.docker.com/v1/repositories/kindest/node/tags -O -  | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n'  | awk -F: '{print $$3}'

_knd_view_apiversionset:
	@$(INFO) '$(KND_UI_LABEL)Viewing api-versions-set "$(KND_APIVERSIONS_SET_NAME)" ...'; $(NORMAL)
	wget -q https://registry.hub.docker.com/v1/repositories/kindest/node/tags -O -  | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n'  | awk -F: '{print $$3}' $(|_KND_VIEW_APIVERSIONS_SET)
