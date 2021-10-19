_OPENSTACK_SERVER_MK_VERSION=0.99.3

# OSS_SERVER_FIXIP?= 10.66.255.51
# OSS_SERVER_FLAVOR?=
# OSS_SERVER_FLOATIP?=
# OSS_SERVER_ID?=
# OSS_SERVER_IMAGE?=
# OSS_SERVER_KEYNAME?=
# OSS_SERVER_NAME?= myInstance
# OSS_SERVER_NAME_OR_ID?=
# OSS_SERVER_MAX?= 1
# OSS_SERVER_MIN?= 1
# OSS_SERVER_NETWORK?=
# OSS_SERVER_PROJECT?=
# OSS_SERVER_PROJECT_DOMAIN?=
# OSS_SERVER_SECURITYGROUP?=
# OSS_SERVER_STATUS?= ACTIVE or SHUTOFF
# OSS_SERVER_USERNAME?= centos
OSS_SERVER_WAIT?= true 
# OSS_SERVERS_SET_NAME?= my-servers-set 
# OSS_SSH_IDENTITY?= ~/.ssh/private_key
# OSS_SSH_LOGIN?= centos
OSS_SSH_PUBLIC_IP?= false

# Derived parameters
OSS_SERVER_FLAVOR?= $(OSF_FLAVOR_NAME_OR_ID)
OSS_SERVER_FLOATIP?= $(SSH_REMOTE_IP)
OSS_SERVER_IMAGE?= $(OSI_IMAGE_NAME_OR_ID)
OSS_SERVER_KEYNAME?= $(OSK_KEYPAIR_NAME)
OSS_SERVER_NAME_OR_ID?= $(strip $(if $(OSS_SERVER_ID), $(OSS_SERVER_ID), $(OSS_SERVER_NAME)))
OSS_SERVER_NETWORK?= $(OSN_NETWORK_NAME_OR_ID)
OSS_SERVER_PROJECT?= $(OS_PROJECT_NAME)
OSS_SERVER_SECURITYGROUP?= $(OSSG_SECURITYGROUP_NAME_OR_ID)

# Options parameters
__OSS_FIXED_IP_ADDRESS?= $(if $(OSS_SERVER_FIXIP), --fixed-ip-address $(OSS_SERVER_FIXIP))
__OSS_FLAVOR?= $(if $(OSS_SERVER_FLAVOR), --flavor $(OSS_SERVER_FLAVOR))
__OSS_IDENTITY?= $(if $(OSS_SSH_IDENTITY), --identity $(OSS_SSH_IDENTITY))
__OSS_IMAGE?= $(if $(OSS_SERVER_IMAGE), --image $(OSS_SERVER_IMAGE))
__OSS_KEY_NAME?= $(if $(OSS_SERVER_KEYNAME), --key-name $(OSS_SERVER_KEYNAME))
__OSS_LOGIN?= $(if $(OSS_SSH_LOGIN), --login $(OSS_SSH_LOGIN))
__OSS_MAX?= $(if $(OSS_SERVER_MAX), --min $(OSS_SERVER_MAX))
__OSS_MIN?= $(if $(OSS_SERVER_MIN), --min $(OSS_SERVER_MIN))
__OSS_NIC?= $(if $(OSS_SERVER_NETWORK), --nic net-id=$(OSS_SERVER_NETWORK))
__OSS_PRIVATE?= $(if $(filter false, $(OSS_SSH_PUBLIC_IP)), --private)
__OSS_PROJECT?= $(if $(OSS_SERVER_PROJECT), --project $(OSS_SERVER_PROJECT))
__OSS_PROJECT_DOMAIN?= $(if $(OSS_SERVER_PROJECT_DOMAIN), --project-domain $(OSS_SERVER_PROJECT_DOMAIN))
__OSS_PUBLIC?= $(if $(filter true, $(OSS_SSH_PUBLIC_IP)), --public)
__OSS_SECURITY_GROUP?= $(if $(OSS_SERVER_SECURITYGROUP), --security-group $(OSS_SERVER_SECURITYGROUP))
__OSS_STATUS?= $(if $(OSS_SERVER_STATUS), --status $(OSS_SERVER_STATUS))
__OSS_WAIT?= $(if $(filter true, $(OSS_SERVER_WAIT)), --wait)

# UI parameters

#--- MACROS
_oss_get_instance_id_N=$(shell $(OPENSTACK) server show $(1) --column ID --format value)
_oss_get_instance_name_I=$(shell $(OPENSTACK) server show $(1) --column name --format value)
_oss_get_instance_parameter_NP=$(shell $(OPENSTACK) server show $(1) --column $(2) --format value)

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _oss_view_framework_macros
_oss_view_framework_macros ::
	@echo 'OpenStack::Server ($(_OPENSTACK_SERVER_MK_VERSION)) targets:'
	@echo '    _oss_get_instance_id_N          - Get the instance ID given its name'
	@echo '    _oss_get_instance_name_N        - Get the instance name given its ID'
	@echo '    _oss_get_instance_parameter_NP  - Get an instance parameter given its name/ID'
	@echo

_view_framework_targets :: _oss_view_framework_targets
_oss_view_framework_targets ::
	@echo 'OpensStack::Server ($(_OPENSTACK_SERVER_MK_VERSION)) targets:'
	@echo '    _oss_add_fixed_ip                  - Add a fixed IP to an instance'
	@echo '    _oss_add_floating_ip               - Add a floating IP to an instance'
	@echo '    _oss_create_instance               - Create a new instance'
	@echo '    _oss_delete_instance               - Delete an existing instance'
	@echo '    _oss_remove_fixed_ip               - Remove a fixed IP from an instance'
	@echo '    _oss_remove_floating_ip            - Remove a floating IP from an instance'
	@echo '    _oss_show_console_logs             - Show console logs of a given instance'
	@echo '    _oss_show_console_url              - Show console URL of a given instance'
	@echo '    _oss_show_instance                 - Show details of a given instance'
	@echo '    _oss_ssh_instance                  - Ssh into a given instance'
	@echo '    _oss_view_instances                - View instances in current project'
	@echo '    _oss_view_instances_set            - View a set of instances in current project'
	@echo

_view_framework_parameters :: _oss_view_framework_parameters
_oss_view_framework_parameters ::
	@echo 'OpenStack::Server ($(_OPENSTACK_SERVER_MK_VERSION)) parameters:'
	@echo '    OSS_SERVER_FIXIP=$(OSS_SERVER_FIXIP)'
	@echo '    OSS_SERVER_FLAVOR=$(OSS_SERVER_FLAVOR)'
	@echo '    OSS_SERVER_FLOATIP=$(OSS_SERVER_FLOATIP)'
	@echo '    OSS_SERVER_ID=$(OSS_SERVER_ID)'
	@echo '    OSS_SERVER_IMAGE=$(OSS_SERVER_IMAGE)'
	@echo '    OSS_SERVER_KEYNAME=$(OSS_SERVER_KEYNAME)'
	@echo '    OSS_SERVER_MAX=$(OSS_SERVER_MAX)'
	@echo '    OSS_SERVER_MIN=$(OSS_SERVER_MIN)'
	@echo '    OSS_SERVER_NAME=$(OSS_SERVER_NAME)'
	@echo '    OSS_SERVER_NAME_OR_ID=$(OSS_SERVER_NAME_OR_ID)'
	@echo '    OSS_SERVER_NETWORK=$(OSS_SERVER_NETWORK)'
	@echo '    OSS_SERVER_PROJECT=$(OSS_SERVER_PROJECT)'
	@echo '    OSS_SERVER_PROJECT_DOMAIN=$(OSS_SERVER_PROJECT_DOMAIN)'
	@echo '    OSS_SERVER_SECURITYGROUP=$(OSS_SERVER_SECURITYGROUP)'
	@echo '    OSS_SERVER_STATUS=$(OSS_SERVER_STATUS)'
	@echo '    OSS_SERVER_USERNAME=$(OSS_SERVER_STATUS)'
	@echo '    OSS_SERVER_WAIT=$(OSS_SERVER_WAIT)'
	@echo '    OSS_SERVERS_SET_NAME=$(OSS_SERVERS_SET_NAME)'
	@echo '    OSS_SSH_IDENTITY=$(OSS_SSH_IDENTITY)'
	@echo '    OSS_SSH_LOGIN=$(OSS_SSH_LOGIN)'
	@echo '    OSS_SSH_PUBLIC_IP=$(OSS_SSH_PUBLIC_IP)'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_oss_add_fixed_ip:
	@$(INFO) "$(OS_UI_LABEL)Attaching fixed IP '$(OSS_SERVER_FIXIP)' to instance '$(OSS_SERVER_NAME_OR_ID)' ..."; $(NORMAL)
	$(OPENSTACK) server add fixed ip $(__OSS_FIXED_IP_ADDRESS) $(OSS_SERVER_NAME_OR_ID) $(OSS_SERVER_NETWORK)

_oss_add_floating_ip:
	@$(INFO) "$(OS_UI_LABEL)Attaching floating IP '$(OSS_SERVER_FLOATIP)' to instance '$(OSS_SERVER_NAME_OR_ID)' ..."; $(NORMAL)
	# THIS DOES NOT SEEM TO BE WORKING! See openstack_network for neutron version
	$(OPENSTACK) server add floating ip $(__OSS_FIXED_IP_ADDRESS) $(OSS_SERVER_NAME_OR_ID) $(OSS_SERVER_FLOATIP)

_oss_create_instance:
	@$(INFO) "$(OS_UI_LABEL)Creating instance '$(OSS_SERVER_NAME)' ..."; $(NORMAL)
	$(OPENSTACK) server create $(__OSS_FLAVOR) $(__OSS_IMAGE) $(__OSS_KEY_NAME) $(__OSS_MAX) $(__OSS_MIN) $(__OSS_NIC) $(__OSS_SECURITY_GROUP) $(__OSS_STATUS) $(__OSS_WAIT) $(OSS_SERVER_NAME)

_oss_delete_instance:
	@$(INFO) "$(OS_UI_LABEL)Deleting instance '$(OSS_SERVER_NAME_OR_ID)' ..."; $(NORMAL)
	$(OPENSTACK) server delete $(OSS_SERVER_NAME_OR_ID)

_oss_remove_fixed_ip:
	@$(INFO) "$(OS_UI_LABEL)Detaching fixed IP '$(OSS_SERVER_FIXIP)' from instance '$(OSS_SERVER_NAME_OR_ID)' ..."; $(NORMAL)
	$(OPENSTACK) server remove fixed ip $(OSS_SERVER_NAME_OR_ID) $(OSS_SERVER_FIXIP)

_oss_remove_floating_ip:
	@$(INFO) "$(OS_UI_LABEL)Detaching floating IP '$(OSS_SERVER_FLOATIP)' from instance '$(OSS_SERVER_NAME_OR_ID)' ..."; $(NORMAL)
	# THIS DOES NOT SEEM TO BE WORKING! See openstack_network for neutron version
	$(OPENSTACK) server remove floating ip $(OSS_SERVER_NAME_OR_ID) $(OSS_SERVER_FLOATIP)

_oss_show_console_logs:
	@$(INFO) "$(OS_UI_LABEL)Show console logs for instance '$(OSS_SERVER_NAME_OR_ID)' ..."; $(NORMAL)
	$(OPENSTACK) console log show $(OSS_SERVER_NAME_OR_ID)

_oss_show_console_url:
	@$(INFO) "$(OS_UI_LABEL)Show console URL for instance '$(OSS_SERVER_NAME_OR_ID)' ..."; $(NORMAL)
	$(OPENSTACK) console url show $(OSS_SERVER_NAME_OR_ID)

_oss_show_instance:
	@$(INFO) "$(OS_UI_LABEL)Show details for instance '$(OSS_SERVER_NAME_OR_ID)' ..."; $(NORMAL)
	$(OPENSTACK) server show $(OSS_SERVER_NAME_OR_ID)

_oss_ssh_instance:
	@$(INFO) "$(OS_UI_LABEL)Sshing instance '$(OSS_SERVER_NAME_OR_ID)' ..."; $(NORMAL)
	$(OPENSTACK) server ssh $(__OSS_IDENTITY) $(__OSS_LOGIN) $(__OSS_PRIVATE) $(__OSS_PUBLIC) $(OSS_SERVER_NAME_OR_ID)

_oss_view_instances:
	@$(INFO) '$(OS_UI_LABEL)View instances ...'; $(NORMAL)
	$(OPENSTACK) server list $(_X__OSS_FLAVOR) $(_X__OSS_IMAGE) $(_X__OSS_STATUS)

_oss_view_instances_set:
	@$(INFO) '$(OS_UI_LABEL)View instances-set "$(OSS_INSTANCES_SET_NAME)"  ...'; $(NORMAL)
	@$(WARN) 'Instances can be grouped based on flavor, image, and status'; $(NORMAL)
	$(OPENSTACK) server list $(__OSS_FLAVOR) $(__OSS_IMAGE) $(__OSS_STATUS)
