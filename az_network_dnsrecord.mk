_AZ_NETWORK_DNSRECORD_MK_VERSION= $(_AZ_NETWORK_MK_VERSION)

# NWK_DNSRECORD_A_IPADDRESS?= 10.10.10.10
NWK_DNSRECORD_DELETEYES_FLAG?= false
# NWK_DNSRECORD_DNSZONE_NAME?=
# NWK_DNSRECORD_FQDN?= www.example.com
# NWK_DNSRECORD_NAME?=
# NWK_DNSRECORD_RESOURCEGROUP_NAME?=
NWK_DNSRECORD_TTL?= 3600
# NWK_DNSRECORD_TXT_VALUE?= pIj3FJsFz-q0xh4xCi4fvMn5SWI16n5doFVYn7zmsb4
# NWK_DNSRECORD_TYPE?= a
NWK_DNSRECORDS_REGEX?= '.*'
# NWK_DNSRECORDS_RESOURCEGROUP_NAME?=
# NWK_DNSRECORDS_SET_NAME?=
# NWK_DNSRECORDS_TYPE?= a

# Derived parameters
NWK_DNSRECORD_DNSZONE_NAME?= $(NWK_DNSZONE_NAME)
NWK_DNSRECORD_FQDN?= $(NWK_DNSRECORD_NAME).$(NWK_DNSRECORD_DNSZONE_NAME)
NWK_DNSRECORD_RESOURCEGROUP_NAME?= $(NWK_RESOURCEGROUP_NAME)
NWK_DNSRECORDS_RESOURCEGROUP_NAME?= $(NWK_DNSRECORD_RESOURCEGROUP_NAME)
NWK_DNSRECORDS_DNSZONE_NAME?= $(NWK_DNSRECORD_DNSZONE_NAME)
NWK_DNSRECORDS_SET_NAME?= dns-records@$(NWK_DNSRECORDS_DNSZONE_NAME)
NWK_DNSRECORDS_TYPE?= $(NWK_DNSRECORD_TYPE)

# Options parameters
__NWK_IF_MATCH__DNSRECORD=
__NWK_IPV4_ADDRESS= $(if $(filter a,$(NWK_DNSRECORD_TYPE)),$(if $(NWK_DNSRECORD_A_IPADDRESS),--ipv4-address $(NWK_DNSRECORD_A_IPADDRESS)))
__NWK_NAME__DNSRECORD= $(if $(NWK_DNSRECORD_NAME),--name $(NWK_DNSRECORD_NAME))
__NWK_RECORD_SET_NAME= $(if $(NWK_DNSRECORD_NAME),--record-set-name $(NWK_DNSRECORD_NAME))
__NWK_RESOURCE_GROUP__DNSRECORD= $(if $(NWK_DNSRECORD_RESOURCEGROUP_NAME),--resource-group $(NWK_DNSRECORD_RESOURCEGROUP_NAME))
__NWK_RESOURCE_GROUP__DNSRECORDS= $(if $(NWK_DNSRECORDS_RESOURCEGROUP_NAME),--resource-group $(NWK_DNSRECORDS_RESOURCEGROUP_NAME))
__NWK_TTL__DNSRECORD= $(if $(filter-out txt,$(NWK_DNSRECORD_TYPE)),$(if $(NWK_DNSRECORD_TTL),--ttl $(NWK_DNSRECORD_TTL)))
__NWK_VALUE__DNSRECORD= $(if $(filter txt,$(NWK_DNSRECORD_TYPE)),$(if $(NWK_DNSRECORD_TXT_VALUE),--value $(NWK_DNSRECORD_TXT_VALUE)))
__NWK_YES__DNSRECORD= $(if $(filter true,$(NWK_DNSRECORD_DELETEYES_FLAG)),--yes)
__NWK_ZONE_NAME__DNSRECORD= $(if $(NWK_DNSRECORD_DNSZONE_NAME),--zone-name $(NWK_DNSRECORD_DNSZONE_NAME))
__NWK_ZONE_NAME__DNSRECORDS= $(if $(NWK_DNSRECORDS_DNSZONE_NAME),--zone-name $(NWK_DNSRECORDS_DNSZONE_NAME))

# UI parameters

#--- Utilities

#--- MACRO

#----------------------------------------------------------------------
# USAGE
#

_nwk_view_framework_macros ::
	@#echo 'AZ::NetWorK::DnsRecord ($(_AZ_NETWORK_DNSRECORD_MK_VERSION)) macros:'
	@#echo

_nwk_view_framework_parameters ::
	@echo 'AZ::NetWorK::DnsRecord ($(_AZ_NETWORK_DNSRECORD_MK_VERSION)) parameters:'
	@echo '    NWK_DNSRECORD_A_IPADDRESS=$(NWK_DNSRECORD_A_IPADDRESS)'
	@echo '    NWK_DNSRECORD_DELETEYES_FLAG=$(NWK_DNSRECORD_DELETEYES_FLAG)'
	@echo '    NWK_DNSRECORD_DNSZONE_NAME=$(NWK_DNSRECORD_DNSZONE_NAME)'
	@echo '    NWK_DNSRECORD_FQDN=$(NWK_DNSRECORD_FQDN)'
	@echo '    NWK_DNSRECORD_NAME=$(NWK_DNSRECORD_NAME)'
	@echo '    NWK_DNSRECORD_RESOUCEGROUP_NAME=$(NWK_DNSRECORD_RESOURCEGROUP_NAME)'
	@echo '    NWK_DNSRECORD_TTL=$(NWK_DNSRECORD_TTL)'
	@echo '    NWK_DNSRECORD_TXT_VALUE=$(NWK_DNSRECORD_TXT_VALUE)'
	@echo '    NWK_DNSRECORD_TYPE=$(NWK_DNSRECORD_TYPE)'
	@echo '    NWK_DNSRECORDS_REGEX=$(NWK_DNSRECORDS_REGEX)'
	@echo '    NWK_DNSRECORDS_RESOUCEGROUP_NAME=$(NWK_DNSRECORDS_RESOURCEGROUP_NAME)'
	@echo '    NWK_DNSRECORDS_SET_NAME=$(NWK_DNSRECORDS_SET_NAME)'
	@echo '    NWK_DNSRECORDS_TYPE=$(NWK_DNSRECORDS_TYPE)'
	@echo

_nwk_view_framework_targets ::
	@echo 'AZ::NetWork::DnsRecord ($(_AZ_NETWORK_DNSRECORD_MK_VERSION)) targets:'
	@echo '    _nwk_create_dnsrecord               - Create a dns-record'
	@echo '    _nwk_delete_dnsrecord               - Delete a dns-record'
	@echo '    _nwk_show_dnsrecord                 - Show everything related to a dns-record'
	@echo '    _nwk_show_dnsrecord_description     - Show description of a dns-record'
	@echo '    _nwk_show_dnsrecord_resolution      - Show resolution of a dns-record'
	@echo '    _nwk_view_dnsrecords                - View dns-records'
	@echo '    _nwk_view_dnsrecords_set            - View set of dns-records'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
#  TARGETS
#

_nwk_create_dnsrecord:
	@$(INFO) '$(NWK_UI_LABEL)Creating dns-record "$(NWK_DNSRECORD_NAME)" ...'; $(NORMAL)
	$(AZ) network dns record-set $(NWK_DNSRECORD_TYPE) add-record $(__NWK_IPV4_ADDRESS) $(__NWK_OUTPUT) $(__NWK_RECORD_SET_NAME) $(__NWK_RESOURCE_GROUP__DNSRECORD) $(__NWK_SUBSCRIPTION) $(__NWK_TTL__DNSRECORD) $(__NWK_VALUE__DNSRECORD) $(__NWK_ZONE_NAME__DNSRECORD)

_nwk_delete_dnsrecord:
	@$(INFO) '$(NWK_UI_LABEL)Deleting dns-record "$(NWK_DNSRECORD_NAME)" ...'; $(NORMAL)
	$(AZ) network dns record-set $(NWK_DNSRECORD_TYPE) delete $(__NWK_IF_MATCH__DNSRECORD) $(__NWK_NAME__DNSRECORD) $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__DNSRECORD) $(__NWK_SUBSCRIPTION) $(__NWK_YES__DNSRECORD) $(__NWK_ZONE_NAME__DNSRECORD)

_nwk_show_dnsrecord :: _nwk_show_dnsrecord_resolution _nwk_show_dnsrecord_description

_nwk_show_dnsrecord_description:
	@$(INFO) '$(NWK_UI_LABEL)Showing description of dns-record "$(NWK_DNSRECORD_NAME)" ...'; $(NORMAL)
	$(AZ) network dns record-set $(NWK_DNSRECORD_TYPE) show $(__NWK_NAME__DNSRECORD) $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__DNSRECORD) $(__NWK_SUBSCRIPTION) $(__NWK_ZONE_NAME__DNSRECORD)

_nwk_show_dnsrecord_resolution:
	@$(INFO) '$(NWK_UI_LABEL)Showing resolution of propagated of dns-record "$(NWK_DNSRECORD_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns information that is cached and therefore may not be up to date'; $(NORMAL)
	dig $(NWK_DNSRECORD_TYPE) $(NWK_DNSRECORD_FQDN)

_nwk_view_dnsrecords:
	@$(INFO) '$(NWK_UI_LABEL)View dns-records ...'; $(NORMAL)
	$(AZ) network dns record-set $(NWK_DNSRECORDS_TYPE) list $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__DNSRECORDS) $(__NWK_SUBSCRIPTION) $(__NWK_ZONE_NAME__DNSRECORDS)

_nwk_view_dnsrecords_set:
	@$(INFO) '$(NWK_UI_LABEL)View dns-records-set "$(NWK_DNSRECORDS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Dns-records are grouped based on provided resource-group, zone-name, record-type, and regex...'; $(NORMAL)
	$(AZ) network dns record-set $(NWK_DNSRECORDS_TYPE) list $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__DNSRECORDS) $(__NWK_SUBSCRIPTION) $(__NWK_ZONE_NAME__DNSRECORDS) | grep -E $(NWK_DNSRECORDS_REGEX)
