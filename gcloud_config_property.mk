_GCLOUD_CONFIG_PROPERTY_MK_VERSION= $(_GCLOUD_CONFIG_MK_VERSION)

# GCG_PROPERTY_COMPUTEREGION_VALUE?=
# GCG_PROPERTY_COMPUTEZONE_VALUE?=
# GCG_PROPERTY_CONFIGURATION_NAME?= default
# GCG_PROPERTY_NAME?= compute/region
# GCG_PROPERTY_VALUE?=

# Derived parameters
GKE_PROPERTY_CONFIGURATION_NANE?= $(GKE_CONFIGURATION_NAME)

# Options parameters

# UI parameters

#--- Utilities

#--- MACROS
_gke_get_property_value= $(call _gke_get_property_value_N, $(GKE_PROPERTY_NAME))
_gke_get_property_value_N= $(call _gke_get_property_value_NC, $(1), $(GCG_PROPERTY_CONFIGURATION_NAME))
_gke_get_property_value_NC= $(shell $(GCLOUD)  config configurations describe $(2) --format "value(properties.$(strip $(subst /,., $(1))))")

#----------------------------------------------------------------------
# USAGE
#

_gcg_view_framework_macros ::
	@echo 'Gcloud::ConfiG::Property ($(_GCLOUD_CONFIG_PROPERTY_MK_VERSION)) macros:'
	@echo '    _gke_get_property_{|N|NC}            - Get the value of a property (Name,Configuration)'
	@echo


_gcg_view_framework_parameters ::
	@echo 'Gcloud::ConfiG::Property ($(_GCLOUD_CONFIG_PROPERTY_MK_VERSION)) parameters:'
	@echo '    GCG_PROPERTY_COMPUTEREGION_VALUE=$(GCG_PROPERTY_CONPUTEREGION_VALUE)'
	@echo '    GCG_PROPERTY_COMPUTEZONE_VALUE=$(GCG_PROPERTY_COMPUTEZONE_VALUE)'
	@echo '    GCG_PROPERTY_CONFIGURATION_NAME=$(GCG_PROPERTY_CONFIGURATION_NAME)'
	@echo '    GCG_PROPERTY_COREACCOUNT_VALUE=$(GCG_PROPERTY_COREACCOUNT_VALUE)'
	@echo '    GCG_PROPERTY_NAME=$(GCG_PROPERTY_NAME)'
	@echo '    GCG_PROPERTY_VALUE=$(GCG_PROPERTY_VALUE)'
	@echo

_gcg_view_framework_targets ::
	@echo 'Gcloud::ConfiG::Property ($(_GCLOUD_CONFIG_PROPERTY_MK_VERSION)) targets:'
	@echo '    _gcq_set_account                     - Set the core/account property'
	@echo '    _gcq_set_property                    - Set a property'
	@echo '    _gcq_set_region                      - Set the compute/region property'
	@echo '    _gcq_set_zone                        - Set the compute/zone property'
	@echo '    _gcq_view_properties                 - View all properties'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_gcg_set_account:
	@$(INFO) '$(GCD_UI_LABEL)Setting property.core.account in configuration ...'; $(NORMAL)
	$(GCLOUD) config set core/account $(GCG_PROPERTY_COREACCOUNT_VALUE)

_gcg_set_property:
	@$(INFO) '$(GCD_UI_LABEL)Setting $(GCG_PROPERT_NAME) in configuration ...'; $(NORMAL)
	$(GCLOUD) config set $(GCG_PROPERTY_NAME) $(GCG_PROPERTY_VALUE)

_gcg_set_region:
	$(GCLOUD) config set compute/region $(GCG_PROPERTY_COMPUTEREGION_VALUE)

_gcg_set_zone:
	$(GCLOUD) config set compute/zone $(GCG_PROPERTY_COMPUTEZONE_VALUE)

_gcg_view_properties:
	@$(INFO) '$(GCD_UI_LABEL)Viewing all properties ...'; $(NORMAL)
	$(GCLOUD) config set compute/zone $(GCG_PROPERTY_COMPUTEZONE_VALUE)
