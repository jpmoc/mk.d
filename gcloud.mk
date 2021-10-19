_GCLOUD_MK_VERSION= 0.99.3

GCD_ACTIVECONFIGURATION_NAME?= default
# GCD_ACTIVECREDENTIALEDACCOUNT_NAME?= emayssat@vmware.com
# GCD_FLATTEN?=
# GCD_FORMAT?= json
# GCD_LOG_HTTP?=
# GCD_PROJECT_NAME?= "nsx-sm"
# GCD_QUIET?=
# GCD_TRACETOKEN?=
# GCD_USER_OUTPUT_ENABLED?=
# GCD_VERBOSITY?=

# Derived parameters

# Options parameters

# UI parameters
GCD_UI_LABEL?= [$(strip $(GCD_ACTIVECONFIGURATION_NAME) $(GCD_PROJECT_NAME) $(GCD_ACTIVECREDENTIALEDACCOUNT_NAME))] #

#--- Utilities
__GCLOUD_OPTIONS+= $(if $(GCD_ACTIVECONFIGURATION_NAME),--configuration $(GCD_ACTIVECONFIGURATION_NAME))
__GCLOUD_OPTIONS+= $(if $(GCD_ACTIVECREDENTIALEDACCOUNT_NAME),--account $(GCD_ACTIVECREDENTIALEDACCOUNT_NAME))
__GCLOUD_OPTIONS+= $(if $(GCD_FLATTEN),--flatten $(GCD_FLATTEN))
__GCLOUD_OPTIONS+= $(if $(GCD_FORMAT),--format $(GCD_FORMAT))
__GCLOUD_OPTIONS+= $(if $(GCD_LOG_HTTP),--log-http $(GCD_LOG_HTTP))
__GCLOUD_OPTIONS+= $(if $(GCD_PROJECT_NAME),--project $(GCD_PROJECT_NAME))
__GCLOUD_OPTIONS+= $(if $(GCD_QUIET),--quiet $(GCD_QUIET))
__GCLOUD_OPTIONS+= $(if $(GCD_TRACETOKEN),--trace-token $(GCD_TRACETOKEN))
__GCLOUD_OPTIONS+= $(if $(GCD_USER_OUTPUT_ENABLED),--trace-token $(GCD_USER_OUTPUT_ENABLED))
__GCLOUD_OPTIONS+= $(if $(GCD_VERBOSITY),--verbosity $(GCD_VERBOSITY))

GCLOUD?= $(__GCLOUD_ENVIRONMENT) $(GCLOUD_ENVIRONMENT) gcloud $(__GCLOUD_OPTIONS) $(GCLOUD_OPTIONS)

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_install_framework_dependencies :: _gcd_install_framework_dependencies
_gcd_install_framework_dependencies ::
	@echo 'GClouD:: ($(_GCLOUD_MK_VERSION)) dependencies:'
	echo "deb http://packages.cloud.google.com/apt cloud-sdk-$(shell lsb_release -c -s) main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
	sudo apt-get update && sudo apt-get install -y google-cloud-sdk
	sudo apt-get install -y google-cloud-sdk-app-engine-java

_view_framework_macros :: _gcd_view_framework_macros
_gcd_view_framework_macros ::
	@echo 'GClouD:: ($(_GCLOUD_MK_VERSION)) targets:'
	@echo


_view_framework_parameters :: _gcd_view_framework_parameters
_gcd_view_framework_parameters ::
	@echo 'GCP:: ($(_GCLOUD_MK_VERSION)) parameters:'
	@echo '    GCLOUD=$(GCLOUD)'
	@echo '    GCD_ACTIVECONFIGURATION_NAME=$(GCD_ACTIVECONFIGURATION_NAME)'
	@echo '    GCD_ACTIVECREDENTIALEDACCOUNT_NAME=$(GCD_ACTIVECREDENTIALEDACCOUNT_NAME)'
	@echo '    GCD_FLATTEN=$(GCD_FLATTEN)'
	@echo '    GCD_FORMAT=$(GCD_FORMAT)'
	@echo '    GCD_LOG_HTTP=$(GCD_LOG_HTTP)'
	@echo '    GCD_PROJECT_NAME=$(GCD_PROJECT_NAME)'
	@echo '    GCD_QUIET=$(GCD_QUIET)'
	@echo '    GCD_TRACETOKEN=$(GCD_TRACETOKEN)'
	@echo '    GCD_USER_OUTPUT_ENABLED=$(GCD_USER_OUTPUT_ENABLED)'
	@echo '    GCD_VERBOSITY=$(GCD_VERBOSITY)'
	@echo

_view_framework_targets :: _gcd_view_framework_targets
_gcd_view_framework_targets ::
	@echo 'GClouD:: ($(_GCLOUD_MK_VERSION)) targets:'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?=.
-include $(MK_DIR)/gcloud_alpha.mk
-include $(MK_DIR)/gcloud_app.mk
-include $(MK_DIR)/gcloud_auth.mk
-include $(MK_DIR)/gcloud_beta.mk
-include $(MK_DIR)/gcloud_bigtable.mk
-include $(MK_DIR)/gcloud_builds.mk
-include $(MK_DIR)/gcloud_components.mk
-include $(MK_DIR)/gcloud_composer.mk
-include $(MK_DIR)/gcloud_compute.mk
-include $(MK_DIR)/gcloud_config.mk
-include $(MK_DIR)/gcloud_container.mk
-include $(MK_DIR)/gcloud_dataflow.mk
-include $(MK_DIR)/gcloud_dataproc.mk
-include $(MK_DIR)/gcloud_datastore.mk
-include $(MK_DIR)/gcloud_debug.mk
-include $(MK_DIR)/gcloud_deploymentmanager.mk
-include $(MK_DIR)/gcloud_dns.mk
-include $(MK_DIR)/gcloud_domains.mk
-include $(MK_DIR)/gcloud_endpoints.mk
-include $(MK_DIR)/gcloud_firebase.mk
-include $(MK_DIR)/gcloud_functions.mk
-include $(MK_DIR)/gcloud_iam.mk
-include $(MK_DIR)/gcloud_iot.mk
-include $(MK_DIR)/gcloud_kms.mk
-include $(MK_DIR)/gcloud_logging.mk
-include $(MK_DIR)/gcloud_ml.mk
-include $(MK_DIR)/gcloud_mlengine.mk
-include $(MK_DIR)/gcloud_organizations.mk
-include $(MK_DIR)/gcloud_projects.mk
-include $(MK_DIR)/gcloud_pubsub.mk
-include $(MK_DIR)/gcloud_redis.mk
-include $(MK_DIR)/gcloud_services.mk
-include $(MK_DIR)/gcloud_source.mk
-include $(MK_DIR)/gcloud_spanner.mk
-include $(MK_DIR)/gcloud_sql.mk
-include $(MK_DIR)/gcloud_topic.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_gcd_init:
	$(GCLOUD) init --console-only --skip-diagnostics
