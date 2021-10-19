_VMC_VKE_MK_VERSION= 0.99.0

# VKE_INTERACTIVE_MODE?= false
# VKE_LOGFILE_FILEPATH?= ~/vke.log
# VKE_MODE_DEBUG?= true
# VKE_OUTPUT?= json
# VKE_REGION?= us-west-1

# Derived variables
VKE_MODE_DEBUG?= $(CMN_MODE_DEBUG)
VKE_MODE_INTERACTIVE?= $(CMN_MODE_INTERACTIVE)
VKE_REGION?= $(AWS_REGION)

# Option variables
__VKE_REGION= $(if $(VKE_REGION),--region $(VKE_REGION))

# UI variables
VKE_UI_LABEL?= $(VMC_UI_LABEL)
 
#--- Utilities
__VKE_OPTIONS+= $(if $(filter true, $(VKE_DEBUG_MODE)),--detail)
__VKE_OPTIONS+= $(if $(filter false, $(VKE_INTERACTIVE_MODE)),--non-interactive)
__VKE_OPTIONS+= $(if $(VKE_LOGFILE_FILEPATH),--logfile $(VKE_LOGFILE_FILEPATH))
__VKE_OPTIONS+= $(if $(VKE_OUTPUT),--output $(VKE_OUPUT))

VKE_BIN?= vke
VKE?= $(strip $(__VKE_ENVIRONMENT) $(VKE_ENVIRONMENT) $(VKE_BIN) $(__VKE_OPTIONS) $(VKE_OPTIONS) )

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_install_framework_dependencies :: _vke_install_framework_dependencies
_vke_install_framework_dependencies:
	@$(INFO) '$(VKE_UI_LABEL)Install VKE dependencies ....'; $(NORMAL)
	wget https://s3.amazonaws.com/vke-cli-us-east-1/latest/linux64/vke
	# wget https://s3.amazonaws.com/vke-cli-us-east-1/0.9.2/linux64/vke
	chmod +x vke
	sudo mv vke /usr/local/bin
	which vke
	vke --version

_view_framework_macros :: _vke_view_framework_macros
_vke_view_framework_macros ::
	@#echo 'VMC::VKE ($(_VMC_VKE_CLUSTER_MK_VERSION)) macros:'
	@#echo

_view_framework_parameters :: _vke_view_framework_parameters
_vke_view_framework_parameters ::
	@echo 'VMC::VKE ($(_VMC_VKE_MK_VERSION)) parameters:'
	@echo '    VKE=$(VKE)'
	@echo '    VKE_DEBUG_MODE=$(VKE_DEBUG_MODE)'
	@echo '    VKE_INTERACTIVE_MODE=$(VKE_INTERACTIVE_MODE)'
	@echo '    VKE_LOGFILE_FILEPATH=$(VKE_LOGFILE_FILEPATH)'
	@echo '    VKE_OUTPUT=$(VKE_OUTPUT)'
	@echo

_view_framework_targets :: _vke_view_framework_targets
_vke_view_framework_targets ::
	@echo 'VMC::VKE ($(_VMC_VKE_MK_VERSION)) targets:'
	@echo '    _vke_decode_accesstoken              - Decoding access-token'
	@echo '    _vke_show_version                    - Show the version'
	@echo '    _vke_view_apiversions                - View API-version'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/vmc_vke_account.mk
-include $(MK_DIR)/vmc_vke_cluster.mk
-include $(MK_DIR)/vmc_vke_clustertemplate.mk
-include $(MK_DIR)/vmc_vke_clusterversion.mk
# -include $(MK_DIR)/vmc_vke_documentation.mk
-include $(MK_DIR)/vmc_vke_folder.mk
-include $(MK_DIR)/vmc_vke_group.mk
-include $(MK_DIR)/vmc_vke_iam.mk
-include $(MK_DIR)/vmc_vke_kubeconfig.mk
-include $(MK_DIR)/vmc_vke_namespace.mk
-include $(MK_DIR)/vmc_vke_organization.mk
-include $(MK_DIR)/vmc_vke_peering.mk
-include $(MK_DIR)/vmc_vke_project.mk
-include $(MK_DIR)/vmc_vke_role.mk
-include $(MK_DIR)/vmc_vke_user.mk
-include $(MK_DIR)/vmc_vke_vkesystem.mk

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vke_decode_accesstoken:
	@$(INFO) '$(VKE_UI_LABEL)Decoding VKE JWS ...'; $(NORMAL)
	echo "eyJzdWIiOiJlbWF5c3NhdEB2bXdhcmUuY29tIiwiaXNzIjoiaHR0cHM6XC9cL2xpZ2h0d2F2ZS52a2UuY2xvdWQudm13YXJlLmNvbVwvb3BlbmlkY29ubmVjdFwvODJjNTE4MTUtYmNlZC00YjAwLWE0OWEtYjc0ZThmOGY2NmYxIiwiZ3JvdXBzIjpbIjgyYzUxODE1LWJjZWQtNGIwMC1hNDlhLWI3NGU4ZjhmNjZmMVxcVktFU2VydmljZVVzZXJzIiwiODJjNTE4MTUtYmNlZC00YjAwLWE0OWEtYjc0ZThmOGY2NmYxXFxFdmVyeW9uZSJdLCJ0b2tlbl9jbGFzcyI6ImFjY2Vzc190b2tlbiIsInRva2VuX3R5cGUiOiJCZWFyZXIiLCJhdWQiOlsiZW1heXNzYXRAdm13YXJlLmNvbSIsInJzX2FkbWluX3NlcnZlciIsInJzX3ZtZGlyIl0sInNjb3BlIjoicnNfYWRtaW5fc2VydmVyIGF0X2dyb3VwcyBvcGVuaWQgb2ZmbGluZV9hY2Nlc3MgcnNfdm1kaXIgaWRfZ3JvdXBzIiwibXVsdGlfdGVuYW50IjpmYWxzZSwiZXhwIjoxNTQwODgzNjc0LCJpYXQiOjE1NDA4NDA0NzQsImp0aSI6IkZQb21UOEpQUlBCdWxXaDBaVllha25KdWNLSC0xSG4yNWx0RWo3WHMtYjAiLCJ0ZW5hbnQiOiI4MmM1MTgxNS1iY2VkLTRiMDAtYTQ5YS1iNzRlOGY4ZjY2ZjEiLCJhZG1pbl9zZXJ2ZXJfcm9sZSI6Ikd1ZXN0VXNlciJ9" | base64 --decode | jq '.'

_vke_show_version:
	@$(INFO) '$(VKE_UI_LABEL)Showing version of VKE utility ...'; $(NORMAL)
	vke --version

_vke_view_apiversions:
	@$(INFO) '$(VKE_UI_LABEL)Showing available API-versions ...'; $(NORMAL)
	$(VKE) cluster versions list $(__VKE_REGION)
