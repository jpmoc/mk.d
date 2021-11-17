_KUBECTL_API_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_API_OUTPUT_FORMAT?= wide
# KCL_API_RESOURCES_NAMESPACES?= true
# KCL_API_RESOURCES_VERBS?= get list

# Derived parameters

# Options
__KCL_API_GROUP=
__KCL_NAMESPACED= $(if $(KCL_API_RESOURCES_NAMESPACED),--namespaced=$(KCL_API_RESOURCES_NAMESPACES))
__KCL_OUTPUT__API= $(if $(KCL_API_OUTPUT_FORMAT),--output $(KCL_API_OUTPUT_FORMAT))
__KCL_VERBS= $(if $(KCL_API_RESOURCES_VERBS),--verbs $(subst $(SPACE),$(COMMA),$(KCL_API_RESOURCES_VERBS)))

# Customizations

# Macros

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@#echo 'KubeCtL::API ($(_KUBECTL_API_MK_VERSION)) macros:'
	@#echo

_kcl_list_parameters ::
	@echo 'KubeCtL::API ($(_KUBECTL_API_MK_VERSION)) parameters:'
	@echo '    KCL_API_OUTPUT_FORMAT=$(KCL_API_OUTPUT_FORMAT)'
	@echo '    KCL_API_RESOURCES_NAMESPACED=$(KCL_API_RESOURCES_NAMESPACED)'
	@echo '    KCL_API_RESOURCES_VERBS=$(KCL_API_RESOURCES_VERBS)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::API ($(_KUBECTL_API_MK_VERSION)) targets:'
	@echo '    _kcl_show_api                       - Show everything related to the API'
	@echo '    _kcl_show_api_resources             - Show resources to the API'
	@echo '    _kcl_show_api_versions              - Show versions of the API'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_KCL_SHOW_API_TARGETS?= _kcl_show_api_resources _kcl_show_api_versions
_kcl_show_api: $(_KCL_SHOW_API_TARGETS)

_kcl_show_api_resources:
	@$(INFO) '$(KCL_UI_LABEL)Showing supported resources on this cluster ...'; $(NORMAL)
	@$(WARN) 'This maps k8s objects to installed API'; $(NORMAL)
	@$(WARN) 'More at https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.18/'; $(NORMAL)
	$(KUBECTL) api-resources $(__KCL_API_GROUP) $(__KCL_NAMESPACED) $(__KCL_OUTPUT__API) $(__KCL_VERBS)

_kcl_show_api_versions:
	@$(INFO) '$(KCL_UI_LABEL)Showing which API/version combos are available on this cluster...'; $(NORMAL)
	$(KUBECTL) api-versions

_KCL_SHOW_APISERVICE_TARGETS?= _kcl_show_apiservice_description
_kcl_show_apiservice: $(_KCL_SHOW_APISERVICE_TARGETS)

_kcl_show_apiservice_description:
	@$(INFO) '$(KCL_UI_LABEL)Shogin description of API-service "$(KCL_APISERVICE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe apiservices.apiregistration.k8s.io v1beta.compose.docket.com
	# https://speakerdeck.com/thockin/dockercon-2018-kubernetes-extensibility?slide=44

_kcl_list_apiservices:
	@$(INFO) '$(KCL_UI_LABEL)Listing ALL API/version combos available on this cluster...'; $(NORMAL)
	$(KUBECTL) get apiservices.apiregistration.k8s.io#
