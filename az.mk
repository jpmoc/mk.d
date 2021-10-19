_AZ_MK_VERSION= 0.99.3

# AZ_INPUTS_DIRPATH?= ./in/
# AZ_LOCATION_ID?= westus2
# AZ_MODE_DEBUG?= false
# AZ_MODE_INTERACTIVE?= false
# AZ_MODE_NOWAIT?= false
# AZ_MODE_YES?= false
# AZ_OUTPUT_FORMAT?= table
# AZ_OUTPUTS_DIRPATH?= ./out/
# AZ_RESOURCEGROUP_NAME?= my-resource-group
# AZ_SUBSCRIPTION_ID?= 59b066b1-4bd5-4a01-bbb1-XXXXXXXXXXXX
# AZ_SUBSCRIPTION_ID_OR_NAME?= 59b066b1-4bd5-4a01-bbb1-XXXXXXXXXXXX
# AZ_SUBSCRIPTION_NAME?= my-subscription
# AZ_TENANT_ID?= b39138ca-3cee-4b4a-a4d6-XXXXXXXXXXXX
# AZ_TENANT_NAME?= CompanyInc

# Derived parameters
AZ_INPUTS_DIRPATH?= $(CMN_INPUTS_DIRPATH)
AZ_MODE_DEBUG?= $(CMN_MODE_DEBUG)
AZ_MODE_INTERACTIVE?= $(CMN_MODE_INTERACTIVE)
AZ_MODE_NOWAIT?= $(CMN_MODE_NOWAIT)
AZ_MODE_YES?= $(CMN_MODE_YES)
AZ_OUTPUTS_DIRPATH?= $(CMN_OUTPUTS_DIRPATH)
AZ_SUBSCRIPTION_ID_OR_NAME?= $(if $(AZ_SUBSCRIPTION_ID),$(AZ_SUBSCRIPTION_ID),$(AZ_UBSCRIPTION_NAME))

# Options parameters

# UI parameters
AZ_UI_LABEL?= [$(strip $(firstword $(subst -,$(SPACE),$(AZ_SUBSCRIPTION_ID_OR_NAME))))-... $(AZ_LOCATION_ID) $(AZ_RESOURCEGROUP_NAME)] #

#--- Utilities
AZ_BIN?= az
AZ?= $(strip $(__AZ_ENVIRONMENT) $(AZ_ENVIRONMENT) $(AZ_BIN) $(__AZ_OPTIONS) $(AZ_OPTIONS))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _az_view_framework_macros
_az_view_framework_macros ::
	@echo 'AZ ($(_AZ_MK_VERSION)) macros:'
	@echo


_view_framework_parameters :: _az_view_framework_parameters
_az_view_framework_parameters ::
	@echo 'AZ ($(_AZ_MK_VERSION)) parameters:'
	@echo '    AZ=$(AZ)'
	@echo '    AZ_INPUTS_DIRPATH=$(AZ_INPUTS_DIRPATH)'
	@echo '    AZ_LOCATION_ID=$(AZ_LOCATION_ID)'
	@echo '    AZ_MODE_DEBUG=$(AZ_MODE_DEBUG)'
	@echo '    AZ_MODE_INTERACTIVE=$(AZ_MODE_INTERACTIVE)'
	@echo '    AZ_MODE_NOWAIT=$(AZ_MODE_NOWAIT)'
	@echo '    AZ_MODE_YES=$(AZ_MODE_YES)'
	@echo '    AZ_OUTPUT_FORMAT=$(AZ_OUTPUT_FORMAT)'
	@echo '    AZ_OUTPUTS_DIRPATH=$(AZ_OUTPUTS_DIRPATH)'
	@echo '    AZ_RESOURCEGROUP_NAME=$(AZ_RESOURCEGROUP_NAME)'
	@echo '    AZ_SUBSCRIPTION_ID=$(AZ_SUBSCRIPTION_ID)'
	@echo '    AZ_SUBSCRIPTION_ID_OR_NAME=$(AZ_SUBSCRIPTION_ID_OR_NAME)'
	@echo '    AZ_SUBSCRIPTION_NAME=$(AZ_SUBSCRIPTION_NAME)'
	@echo '    AZ_TENANT_ID=$(AZ_TENANT_ID)'
	@echo '    AZ_TENANT_NAME=$(AZ_TENANT_NAME)'
	@echo

_view_framework_targets :: _az_view_framework_targets
_az_view_framework_targets ::
	@echo 'AZ ($(_AZ_MK_VERSION)) targets:'
	@echo '    _az_install_dependencies              - Install dependencies'
	@echo '    _az_show_version                      - Show versions of utilities '
	@echo '    _az_view_account_limits               - Display account limits'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?=.
# Utilities

# Services
-include $(MK_DIR)/az_account.mk
-include $(MK_DIR)/az_acr.mk
-include $(MK_DIR)/az_acs.mk
-include $(MK_DIR)/az_ad.mk
-include $(MK_DIR)/az_advisor.mk
-include $(MK_DIR)/az_aks.mk
-include $(MK_DIR)/az_ams.mk
-include $(MK_DIR)/az_apim.mk
-include $(MK_DIR)/az_appconfig.mk
-include $(MK_DIR)/az_appservice.mk
-include $(MK_DIR)/az_artifacts.mk
-include $(MK_DIR)/az_backup.mk
-include $(MK_DIR)/az_batch.mk
-include $(MK_DIR)/az_batchai.mk
-include $(MK_DIR)/az_billing.mk
-include $(MK_DIR)/az_boards.mk
-include $(MK_DIR)/az_bot.mk
-include $(MK_DIR)/az_cache.mk
-include $(MK_DIR)/az_cdn.mk
-include $(MK_DIR)/az_cloud.mk
-include $(MK_DIR)/az_cognitiveservices.mk
-include $(MK_DIR)/az_configure.mk
-include $(MK_DIR)/az_consumption.mk
-include $(MK_DIR)/az_container.mk
-include $(MK_DIR)/az_cosmodb.mk
-include $(MK_DIR)/az_deployment.mk
-include $(MK_DIR)/az_deploymentmanager.mk
-include $(MK_DIR)/az_devops.mk
-include $(MK_DIR)/az_disk.mk
-include $(MK_DIR)/az_dla.mk
-include $(MK_DIR)/az_dls.mk
-include $(MK_DIR)/az_dms.mk
-include $(MK_DIR)/az_eventgrid.mk
-include $(MK_DIR)/az_eventhubs.mk
-include $(MK_DIR)/az_extension.mk
-include $(MK_DIR)/az_feature.mk
-include $(MK_DIR)/az_feedback.mk
-include $(MK_DIR)/az_find.mk
-include $(MK_DIR)/az_functionapp.mk
-include $(MK_DIR)/az_group.mk
-include $(MK_DIR)/az_hdinsight.mk
-include $(MK_DIR)/az_identity.mk
-include $(MK_DIR)/az_image.mk
-include $(MK_DIR)/az_interactive.mk
-include $(MK_DIR)/az_iot.mk
-include $(MK_DIR)/az_iotcentral.mk
-include $(MK_DIR)/az_keyvault.mk
-include $(MK_DIR)/az_kusto.mk
-include $(MK_DIR)/az_lab.mk
-include $(MK_DIR)/az_lock.mk
-include $(MK_DIR)/az_login.mk
-include $(MK_DIR)/az_logout.mk
-include $(MK_DIR)/az_managedapp.mk
-include $(MK_DIR)/az_maps.mk
-include $(MK_DIR)/az_mariadb.mk
-include $(MK_DIR)/az_monitor.mk
-include $(MK_DIR)/az_mysql.mk
-include $(MK_DIR)/az_netappfiles.mk
-include $(MK_DIR)/az_network.mk
-include $(MK_DIR)/az_openshift.mk
-include $(MK_DIR)/az_pipelines.mk
-include $(MK_DIR)/az_policy.mk
-include $(MK_DIR)/az_postgress.mk
-include $(MK_DIR)/az_ppg.mk
-include $(MK_DIR)/az_provider.mk
-include $(MK_DIR)/az_redis.mk
-include $(MK_DIR)/az_relay.mk
-include $(MK_DIR)/az_repos.mk
-include $(MK_DIR)/az_reservations.mk
-include $(MK_DIR)/az_resource.mk
-include $(MK_DIR)/az_rest.mk
-include $(MK_DIR)/az_role.mk
-include $(MK_DIR)/az_search.mk
-include $(MK_DIR)/az_security.mk
-include $(MK_DIR)/az_selftest.mk
-include $(MK_DIR)/az_servicebus.mk
-include $(MK_DIR)/az_sf.mk
-include $(MK_DIR)/az_sig.mk
-include $(MK_DIR)/az_signalr.mk
-include $(MK_DIR)/az_snapshot.mk
-include $(MK_DIR)/az_sql.mk
-include $(MK_DIR)/az_storage.mk
-include $(MK_DIR)/az_tag.mk
-include $(MK_DIR)/az_vm.mk
-include $(MK_DIR)/az_vmss.mk
-include $(MK_DIR)/az_webapp.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _az_install_dependencies
_az_install_dependencies ::
	@$(INFO) '$(AZ_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	@$(WARN) 'Install docs @ https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-apt?view=azure-cli-latest#install'; $(NORMAL)
	curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
	# $(SUDO) apt-get install azure-cli
	which az
	az --version

_view_versions :: _az_show_version
_az_show_version ::
	@$(INFO) '$(AZ_UI_LABEL)Showing version of dependencies ...'; $(NORMAL)
	az --version
