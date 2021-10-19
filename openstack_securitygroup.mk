_OPENSTACK_SECURITYGROUP_MK_VERSION= 0.99.3

# OSSG_RULE_DESTINATION_PORT?= 1:65535
# OSSG_RULE_EGRESS?= false
# OSSG_RULE_ETHERTYPE?= IPv4
# OSSG_RULE_ICMP_CODE?=
# OSSG_RULE_ICMP_TYPE?=
# OSSG_RULE_ID?= d4832850-201b-487a-a5d0-82fe9b019c43
# OSSG_RULE_INGRESS?= true
# OSSG_RULE_PROTOCOL?= tcp
# OSSG_RULE_REMOTE_GROUP?=
# OSSG_RULE_REMOTE_IP?=
OSSG_RULE_SECURITYGROUP?= $(OSSG_SECURITYGROUP_NAME_OR_ID)
# OSSG_SECURITYGROUP_DESCRIPTION?=
# OSSG_SECURITYGROUP_ID?=
OSSG_SECURITYGROUP_NAME?= default
# OSSG_SECURITYGROUP_NAME_OR_ID?=
# OSSG_SECURITYGROUP_PROJECT?= $(OS_PROJECT_NAME_OR_ID)
OSSG_SECURITYGROUP_PROJECT?= $(OS_PROJECT_NAME)
# OSSG_SECURITYGROUP_PROJECT_DOMAIN?=

# Derived parameters
OSSG_SECURITYGROUP_NAME_OR_ID?= $(strip $(if $(OSSG_SECURITYGROUP_ID), $(OSSG_SECURITYGROUP_ID), $(OSSG_SECURITYGROUP_NAME)))

# Option parameters
__OSSG_DESCRIPTION?= $(if $(OSSG_SECURITYGROUP_DESCRIPTION), --description $(OSSG_SECURITYGROUP_DESCRIPTION))
__OSSG_DST_PORT?= $(if $(OSSG_RULE_DESTINATION_PORT), --dst-port $(OSSG_RULE_DESTINATION_PORT))
__OSSG_EGRESS?= $(if $(filter true, $(OSSG_RULE_EGRESS)), --egress)
__OSSG_ETHERTYPE?= $(if $(OSSG_RULE_ETHERTYPE), --ethertype $(OSSG_RULE_ETHERTYPE))
__OSSG_FIT_WIDTH?= $(__OS_FIT_WIDTH)
__OSSG_FORMAT?= $(__OS_FORMAT)
__OSSG_ICMP_CODE?= $(if $(OSSG_RULE_ICMP_CODE), --icmp-code $(OSSG_RULE_ICMP_CODE))
__OSSG_ICMP_TYPE?= $(if $(OSSG_RULE_ICMP_TYPE), --icmp-code $(OSSG_RULE_ICMP_TYPE))
__OSSG_INGRESS?= $(if $(filter true, $(OSSG_RULE_INGRESS)), --ingress)
__OSSG_LONG?= --long
__OSSG_PROJECT?= $(if $(OSSG_SECURITYGROUP_PROJECT), --project $(OSSG_SECURITYGROUP_PROJECT))
__OSSG_PROJECT_DOMAIN?= $(if $(OSSG_SECURITYGROUP_PROJECT_DOMAIN), --project-domain $(OSSG_SECURITYGROUP_PROJECT_DOMAIN))
__OSSG_PROTOCOL?= $(if $(OSSG_RULE_PROTOCOL), --protocol $(OSSG_RULE_PROTOCOL))
__OSSG_REMOTE_GROUP?= $(if $(OSSG_RULE_REMOTE_GROUP), --remote-group $(OSSG_RULE_REMOTE_GROUP))
__OSSG_REMOTE_IP?= $(if $(OSSG_RULE_REMOTE_IP), --remote-ip $(OSSG_RULE_REMOTE_IP))

# UI parameters

#--- MACROS
# Several groups have the 'default' name! We need to filter based on project ID, which is only available in 'list' command and not 'show'!
# I cannot filter based on name as well ...
_ossg_get_default_id=$(shell $(OPENSTACK) security group list $(__OSSG_PROJECT) --format json | jq -r '.[] | select(.Name =="default") | .ID')
_ossg_get_group_id_N=$(call _ossg_get_group_parameter_NP, $(1), id)
_ossg_get_group_name_I=$(call _ossg_get_group_parameter_NP, $(1), name)
_ossg_get_group_parameter_NP=$(shell $(OPENSTACK) security group show $(1) --column $(2) --format value)

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _ossg_view_framework_macros
_ossg_view_framework_macros ::
	@echo "OpenStack::SecurityGroup ($(_OPENSTACK_SECURITYGROUP_MK_VERSION)) macros:"
	@echo "    _ossg_get_default_id                   - Get the ID of the default security group in current project"
	@echo "    _ossg_get_group_id_N                   - Get the ID of a security group given its name"
	@echo "    _ossg_get_group_name_I                 - Get the name of a security group given its ID"
	@echo "    _ossg_get_group_name_I                 - Get the name of a security group given its ID"
	@echo

_view_framework_parameters :: _ossg_view_framework_parameters
_ossg_view_framework_parameters ::
	@echo "OpenStack::SecurityGroup ($(_OPENSTACK_SECURITYGROUP_MK_VERSION)) parameters:"
	@echo "    OSSG_RULE_DESTINATION_PORT=$(OSSG_RULE_DESTINATION_PORT)"
	@echo "    OSSG_RULE_ETHERTYPE=$(OSSG_RULE_ETHERTYPE)"
	@echo "    OSSG_RULE_ICMP_CODE=$(OSSG_RULE_ICMP_CODE)"
	@echo "    OSSG_RULE_ICMP_TYPE=$(OSSG_RULE_ICMP_TYPE)"
	@echo "    OSSG_RULE_ID=$(OSSG_RULE_ID)"
	@echo "    OSSG_RULE_INGRESS=$(OSSG_RULE_INGRESS)"
	@echo "    OSSG_RULE_PROTOCOL=$(OSSG_RULE_PROTOCOL)"
	@echo "    OSSG_RULE_REMOTE_GROUP=$(OSSG_RULE_REMOTE_GROUP)"
	@echo "    OSSG_RULE_REMOTE_IP=$(OSSG_RULE_REMOTE_IP)"
	@echo "    OSSG_RULE_SECURITYGROUP=$(OSSG_RULE_SECURITYGROUP)"
	@echo "    OSSG_SECURITYGROUP_DESCRIPTION=$(OSSG_SECURITYGROUP_DESCRIPTION)"
	@echo "    OSSG_SECURITYGROUP_ID=$(OSSG_SECURITYGROUP_ID)"
	@echo "    OSSG_SECURITYGROUP_NAME=$(OSSG_SECURITYGROUP_NAME)"
	@echo "    OSSG_SECURITYGROUP_NAME_OR_ID=$(OSSG_SECURITYGROUP_NAME_OR_ID)"
	@echo "    OSSG_SECURITYGROUP_PROJECT=$(OSSG_SECURITYGROUP_PROJECT)"
	@echo "    OSSG_SECURITYGROUP_PROJECT_DOMAIN=$(OSSG_SECURITYGROUP_PROJECT_DOMAIN)"
	@echo

_view_framework_targets :: _ossg_view_framework_targets
_ossg_view_framework_targets ::
	@echo "OpensStack::SecurityGroup ($(_OPENSTACK_SECURITYGROUP_MK_VERSION)) targets:"
	@echo "    _ossg_create_rule                      - Create a new rule for the current securiity group"
	@echo "    _ossg_create_security_group            - Create a new security group"
	@echo "    _ossg_delete_rule                      - Delete an existing rule of the currenta securiity group"
	@echo "    _ossg_delete_security_group            - Delete an existing security group"
	@echo "    _ossg_show_security_group              - Show details of a given security group"
	@echo "    _ossg_view_rules                       - List rules attached to a security group"
	@echo "    _ossg_view_security_groups             - List existing security groups"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ossg_create_rule:
	@$(INFO) "$(OS_UI_LABEL)Creating a new rule for security group '$(OSSG_RULE_SECURITYGROUP)' ..."; $(NORMAL)
	$(OPENSTACK) security group rule create $(_X__OSSG_DESCRIPTION_RULE) $(__OSSG_DST_PORT) $(__OSSG_EGRESS) $(__OSSG_ETHERTYPE) $(__OSSG_INGRESS) $(__OSSG_PROJECT) $(__OSSG_PROJECT_DOMAIN) $(__OSSG_PROTOCOL) $(__OSSG_REMOTE_GROUP) $(__OSSG_REMOTE_IP) $(OSSG_RULE_SECURITYGROUP)

_ossg_create_security_group:
	@$(INFO) "$(OS_UI_LABEL)Creating security group '$(OSSG_SECURITYGROUP_NAME)' ..."; $(NORMAL)
	@$(WARN) "Several security groups can have the same name!"; $(NORMAL)
	$(OPENSTACK) security group create $(__OSSG_DESCRIPTION) $(__OSSG_PROJECT) $(__OSSG_PROJECT_DOMAIN) $(OSSG_SECURITYGROUP_NAME)

_ossg_delete_rule:
	@$(INFO) "$(OS_UI_LABEL)Creating an existing rule for security group '$(OSSG_RULE_SECURITYGROUP)' ..."; $(NORMAL)
	X$(OPENSTACK) security group rule delete $(OSSG_RULE_ID)


_ossg_delete_security_group:
	@$(INFO) "$(OS_UI_LABEL)Deleting security group '$(OSSG_SECURITYGROUP_NAME)' ..."; $(NORMAL)
	$(OPENSTACK) security group delete $(OSSG_SECURITYGROUP_NAME_OR_ID)

_ossg_show_security_group:
	@$(INFO) "$(OS_UI_LABEL)Show security group '$(OSSG_SECURITYGROUP_NAME_OR_ID)' ..."; $(NORMAL)
	$(OPENSTACK) security group show $(__OSSG_FIT_WIDTH) $(__OSSG_FORMAT) $(OSSG_SECURITYGROUP_NAME_OR_ID)

_ossg_view_rules:
	@$(INFO) "$(OS_UI_LABEL)View rules of security group '$(OSSG_RULE_SECURITYGROUP)' ..."; $(NORMAL)
	$(OPENSTACK) security group rule list $(__OSSG_EGRESS) $(__OSSG_FIT_WIDTH) $(__OSSG_FORMAT) $(__OSSG_INGRESS) $(__OSSG_LONG) $(__OSSG_PROTOCOL) $(OSSG_RULE_SECURITYGROUP)

_ossg_view_security_groups:
	@$(INFO) "$(OS_UI_LABEL)View security groups ..."; $(NORMAL)
	$(OPENSTACK) security group list $(__OSSG_FIT_WIDTH) $(__OSSG_FORMAT) $(_X__OSSG_LONG) $(__OSSG_PROJECT) $(__OSSG_PROJECT_DOMAIN)
