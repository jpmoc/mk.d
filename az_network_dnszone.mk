_AZ_NETWORK_DNSZONE_MK_VERSION= $(_AZ_NETWORK_MK_VERSION)

# NWK_DNSZONE_ID?= /subscription/... 
# NWK_DNSZONE_NAME?= subdomain.domain.com
# NWK_DNSZONE_RESOURCEGROUP_NAME?=
# NWK_DNSZONES_RESOURCEGROUP_NAME?=
# NWK_DNSZONES_SET_NAME?=

# Derived parameters
NWK_DNSZONE_ID?= /subscriptions/$(NWK_SUBSCRIPTION_ID)/resourceGroups/$(NWK_DNSZONE_RESOURCEGROUP_NAME)/providers/Microsoft.Network/dnszones/$(NWK_DNSZONE_NAME)
NWK_DNSZONE_RESOURCEGROUP_NAME?= $(NWK_RESOURCEGROUP_NAME)
NWK_DNSZONES_RESOURCEGROUP_NAME?= $(NWK_DNSZONE_RESOURCEGROUP_NAME)
NWK_DNSZONES_SET_NAME?= dns-zones@$(NWK_DNSZONES_RESOURCEGROUP_NAME)

# Options parameters
__NWK_NAME__DNSZONE= $(if $(NWK_DNSZONE_NAME),--name $(NWK_DNSZONE_NAME))
__NWK_RESOURCE_GROUP__DNSZONE= $(if $(NWK_DNSZONE_RESOURCEGROUP_NAME),--resource-group $(NWK_DNSZONE_RESOURCEGROUP_NAME))
__NWK_RESOURCE_GROUP__DNSZONES= $(if $(NWK_DNSZONES_RESOURCEGROUP_NAME),--resource-group $(NWK_DNSZONES_RESOURCEGROUP_NAME))
__NWK_ZONE_NAME__DNSZONE= $(if $(NWK_DNSZONE_NAME),--zone-name $(NWK_DNSZONE_NAME))

# UI parameters

#--- Utilities

#--- MACRO

#----------------------------------------------------------------------
# USAGE
#

_nwk_view_framework_macros ::
	@#echo 'AZ::NetWorK::DnsZone ($(_AZ_NETWORK_DNSZONE_MK_VERSION)) macros:'
	@#echo

_nwk_view_framework_parameters ::
	@echo 'AZ::NetWorK::DnsZone ($(_AZ_NETWORK_DNSZONE_MK_VERSION)) parameters:'
	@echo '    NWK_DNSZONE_ID=$(NWK_DNSZONE_ID)'
	@echo '    NWK_DNSZONE_NAME=$(NWK_DNSZONE_NAME)'
	@echo '    NWK_DNSZONE_RESOUCEGROUP_NAME=$(NWK_DNSZONE_RESOURCEGROUP_NAME)'
	@echo '    NWK_DNSZONES_RESOURCEGROUP_NAME=$(NWK_DNSZONES_RESOURCEGROUP_NAME)'
	@echo '    NWK_DNSZONES_SET_NAME=$(NWK_DNSZONES_SET_NAME)'
	@echo

_nwk_view_framework_targets ::
	@echo 'AZ::NetWork::DnsZone ($(_AZ_NETWORK_DNSZONE_MK_VERSION)) targets:'
	@echo '    _nwk_create_dnszone               - Create a dns-zone'
	@echo '    _nwk_delete_dnszone               - Delete a dns-zone'
	@echo '    _nwk_show_dnszone                 - Show everything related to a dns-zone'
	@echo '    _nwk_show_dnszone_a               - Show A-records of a dns-zone'
	@echo '    _nwk_show_dnszone_aaaa            - Show AAAA-records of a dns-zone'
	@echo '    _nwk_show_dnszone_caa             - Show CAA-records of a dns-zone'
	@echo '    _nwk_show_dnszone_cname           - Show CNAME-records of a dns-zone'
	@echo '    _nwk_show_dnszone_description     - Show description of a dns-zone'
	@echo '    _nwk_show_dnszone_dnsrecords      - Show DNS-records of a dns-zone'
	@echo '    _nwk_show_dnszone_mx              - Show MX-records of a dns-zone'
	@echo '    _nwk_show_dnszone_ns              - Show NS-records of a dns-zone'
	@echo '    _nwk_show_dnszone_ptr             - Show PTR-records of a dns-zone'
	@echo '    _nwk_show_dnszone_object          - Show object of a dns-zone'
	@echo '    _nwk_show_dnszone_records         - Show records of a dns-zone'
	@echo '    _nwk_show_dnszone_soa             - Show SOA-records of a dns-zone'
	@echo '    _nwk_show_dnszone_srv             - Show SRV-records of a dns-zone'
	@echo '    _nwk_show_dnszone_txt             - Show TXT-records of a dns-zone'
	@echo '    _nwk_view_dnszones                - View dns-zones'
	@echo '    _nwk_view_dnszones_set            - View set of dns-zones'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
#  TARGETS
#


_nwk_create_dnszone:
	@$(INFO) '$(NWK_UI_LABEL)Creating dns-zone "$(NWK_DNSZONE_NAME)" ...'; $(NORMAL)
	$(AZ) network dns zone create $(__NWK_NAME__DNSZONE) $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__DNSZONE) $(__NWK_SUBSCRIPTION)

_nwk_delete_dnszone:
	@$(INFO) '$(NWK_UI_LABEL)Deleting dns-zone "$(NWK_DNSZONE_NAME)" ...'; $(NORMAL)
	$(AZ) network dns zone delete $(__NWK_NAME__DNSZONE) $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__DNSZONE) $(__NWK_SUBSCRIPTION)

_nwk_show_dnszone :: _nwk_show_dnszone_nameservers _nwk_show_dnszone_object _nwk_show_dnszone_records _nwk_show_dnszone_description

_nwk_show_dnszone_a:
	@$(INFO) '$(NWK_UI_LABEL)Showing A-records of dns-zone "$(NWK_DNSZONE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the mapping between hostname and IPv4 addresses'; $(NORMAL)
	$(AZ) network dns record-set a list $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__DNSZONE) $(__NWK_SUBSCRIPTION) $(__NWK_ZONE_NAME__DNSZONE)

_nwk_show_dnszone_aaaa:
	@$(INFO) '$(NWK_UI_LABEL)Showing AAAA-records of dns-zone "$(NWK_DNSZONE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the mapping between hostnames and IPv6 addresses'; $(NORMAL)
	$(AZ) network dns record-set aaaa list $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__DNSZONE) $(__NWK_SUBSCRIPTION) $(__NWK_ZONE_NAME__DNSZONE)

_nwk_show_dnszone_caa:
	@$(INFO) '$(NWK_UI_LABEL)Showing CAA-records of dns-zone "$(NWK_DNSZONE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the acceptable CA for a host or the domain'; $(NORMAL)
	$(AZ) network dns record-set caa list $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__DNSZONE) $(__NWK_SUBSCRIPTION) $(__NWK_ZONE_NAME__DNSZONE)

_nwk_show_dnszone_cname:
	@$(INFO) '$(NWK_UI_LABEL)Showing CNAME-records of dns-zone "$(NWK_DNSZONE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the mapping of host-aliases'; $(NORMAL)
	$(AZ) network dns record-set cname list $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__DNSZONE) $(__NWK_SUBSCRIPTION) $(__NWK_ZONE_NAME__DNSZONE)

_nwk_show_dnszone_description:
	@$(INFO) '$(NWK_UI_LABEL)Showing description of dns-zone "$(NWK_DNSZONE_NAME)" ...'; $(NORMAL)
	$(AZ) network dns zone show $(__NWK_NAME__DNSZONE) $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__DNSZONE) $(__NWK_SUBSCRIPTION)

_nwk_show_dnszone_nameservers:
	@$(INFO) '$(NWK_UI_LABEL)Showing domain-name-servers of dns-zone "$(NWK_DNSZONE_NAME)" ...'; $(NORMAL)
	$(AZ) network dns zone show $(__NWK_NAME__DNSZONE) $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__DNSZONE) $(__NWK_SUBSCRIPTION) --query '@.nameServers[]'

_nwk_show_dnszone_mx:
	@$(INFO) '$(NWK_UI_LABEL)Showing MX-records of dns-zone "$(NWK_DNSZONE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the names of the mail exchange servers for the domain'; $(NORMAL)
	$(AZ) network dns record-set mx list $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__DNSZONE) $(__NWK_SUBSCRIPTION) $(__NWK_ZONE_NAME__DNSZONE)

_nwk_show_dnszone_ns:
	@$(INFO) '$(NWK_UI_LABEL)Showing NS-records of dns-zone "$(NWK_DNSZONE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the names of the authoritative nameservers for the domain'; $(NORMAL)
	$(AZ) network dns record-set ns list $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__DNSZONE) $(__NWK_SUBSCRIPTION) $(__NWK_ZONE_NAME__DNSZONE)

_nwk_show_dnszone_ptr:
	@$(INFO) '$(NWK_UI_LABEL)Showing PTR-records of dns-zone "$(NWK_DNSZONE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the mapping between IPv4/6 and FQDN. Used for reverse DNS'; $(NORMAL)
	$(AZ) network dns record-set ptr list $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__DNSZONE) $(__NWK_SUBSCRIPTION) $(__NWK_ZONE_NAME__DNSZONE)

_nwk_show_dnszone_object:
	@$(INFO) '$(NWK_UI_LABEL)Showing object of dns-zone "$(NWK_DNSZONE_NAME)" ...'; $(NORMAL)
	$(AZ) network dns zone show $(__NWK_NAME__DNSZONE) $(_X__NWK_OUTPUT) --output json $(__NWK_RESOURCE_GROUP__DNSZONE) $(__NWK_SUBSCRIPTION)

_nwk_show_dnszone_records :: _nwk_show_dnszone_a _nwk_show_dnszone_aaaa _nwk_show_dnszone_caa _nwk_show_dnszone_cname _nwk_show_dnszone_mx _nwk_show_dnszone_ns _nwk_show_dnszone_ptr _nwk_show_dnszone_soa _nwk_show_dnszone_srv _nwk_show_dnszone_txt

_nwk_show_dnszone_soa:
	@$(INFO) '$(NWK_UI_LABEL)Showing SOA-records of dns-zone "$(NWK_DNSZONE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The operation returns only one SOA record per domain. That record includes:'; $(NORMAL)
	@$(WARN) ' * the primary nameserver'; $(NORMAL)
	@$(WARN) ' * the responsible party for the domain'; $(NORMAL)
	@$(WARN) ' * a serial/timestamp that changes whenever you update the domain'; $(NORMAL)
	@$(WARN) ' * the number of seconds before a zone-refresh'; $(NORMAL)
	@$(WARN) ' * the number of seconds before a failed zone-refresh should be retried'; $(NORMAL)
	@$(WARN) ' * the upper limit in seconds before a zone is considered no longer authoritative'; $(NORMAL)
	@$(WARN) ' * the negative-result TTL (aka negative caching)'; $(NORMAL)
	$(AZ) network dns record-set soa show $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__DNSZONE) $(__NWK_SUBSCRIPTION) $(__NWK_ZONE_NAME__DNSZONE) --query "@.soaRecord"

_nwk_show_dnszone_srv:
	@$(INFO) '$(NWK_UI_LABEL)Showing SRV-records of dns-zone "$(NWK_DNSZONE_NAME)" ...'; $(NORMAL)
	$(AZ) network dns record-set srv list $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__DNSZONE) $(__NWK_SUBSCRIPTION) $(__NWK_ZONE_NAME__DNSZONE)

_nwk_show_dnszone_txt:
	@$(INFO) '$(NWK_UI_LABEL)Showing TXT-records of dns-zone "$(NWK_DNSZONE_NAME)" ...'; $(NORMAL)
	$(AZ) network dns record-set txt list $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__DNSZONE) $(__NWK_SUBSCRIPTION) $(__NWK_ZONE_NAME__DNSZONE)

_nwk_view_dnszones:
	@$(INFO) '$(NWK_UI_LABEL)View dns-zones ...'; $(NORMAL)
	$(AZ) network dns zone list $(__NWK_OUTPUT) $(_X__NWK_RESOURCE_GROUP__DNSZONES) $(__NWK_SUBSCRIPTION)

_nwk_view_dnszones_set:
	@$(INFO) '$(NWK_UI_LABEL)View dns-zones-set "$(NWK_DNSZONES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Public-dns-zones are grouped based on provided resource-group, ...'; $(NORMAL)
	$(AZ) network dns zone list $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__DNSZONES) $(__NWK_SUBSCRIPTION)
