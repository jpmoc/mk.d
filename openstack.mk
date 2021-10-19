_OPENSTACK_MK_VERSION=0.99.3

# OS_AUTH_URL?=https://api-snap1.client.metacloud.net:5000/v2.0
# OS_CACERT?=
# OS_CLOUD?=
# OS_COMPUTE_API_VERSION?=2
OS_FIT_WIDTH?=true
OS_FORMAT?=table
# OS_IMAGE_API_VERSION?=2
# OS_INTERFACE?=
# OS_LONG_OUTPUT?= true
# OS_MAX_WIDTH?= 80
# OS_NETWORK_API_VERSION?=2
# OS_OBJECT_API_VERSION?=1
# OS_REGION_NAME?=RegionOne
# OS_PASSWORD?=<my_passsword>
# OS_PREFIX?= my_                      # Only supported in --format shell !?
# OS_PROJECT_ID?=<project_id>
# OS_PROJECT_NAME?=<project_name>
# OS_TENANT_ID?=<tenantid>
# OS_TENANT_NAME?=<tenant_name>
# OS_USERNAME?=<my_sername>

OS_PROJECT_NAME_OR_ID?= $(strip $(if $(OS_PROJECT_ID), $(OS_PROJECT_ID), $(OS_PROJECT_NAME)))
OS_TENANT_NAME_OR_ID?= $(strip $(if $(OS_TENANT_ID), $(OS_TENANT_ID), $(OS_TENANT_NAME)))

# Option parameters
__OS_FIT_WIDTH?= $(if $(filter true,$(OS_FIT_WIDTH)), --fit-width)
__OS_FORMAT?= $(if $(OS_FORMAT), --format $(OS_FORMAT))
__OS_LONG?= $(if $(filter true,$(OS_LONG_OUTPUT)), --long)
__OS_MAX_WIDTH?= $(if $(OS_MAX_WIDTH), --max-width $(OS_MAX_WIDTH))

# UI parameters
OS_UI_LABEL?=[$(strip $(OS_USERNAME) $(OS_TENANT_NAME)/$(OS_PROJECT_NAME) $(OS_REGION_NAME))] #

#--- Utilities
__OPENSTACK_OPTIONS+= $(if $(OS_AUTH_URL), --os-auth-url $(OS_AUTH_URL))
__OPENSTACK_OPTIONS+= $(if $(OS_COMPUTE_API_VERSION), --os-compute-api-version $(OS_COMPUTE_API_VERSION))
__OPENSTACK_OPTIONS+= $(if $(OS_IMAGE_API_VERSION), --os-image-api-version $(OS_IMAGE_API_VERSION))
__OPENSTACK_OPTIONS+= $(if $(OS_NETWORK_API_VERSION), --os-network-api-version $(OS_NETWORK_API_VERSION))
__OPENSTACK_OPTIONS+= $(if $(OS_OBJECT_API_VERSION), --os-object-api-version $(OS_OBJECT_API_VERSION))
__OPENSTACK_OPTIONS+= $(if $(OS_PROJECT_ID), --os-project-id $(OS_PROJECT_ID))
__OPENSTACK_OPTIONS+= $(if $(OS_REGION_NAME), --os-region-name $(OS_REGION_NAME))
__OPENSTACK_OPTIONS+= $(if $(OS_USERNAME), --os-username $(OS_USERNAME))
OPENSTACK?=$(__OPENSTACK_ENVIRONMENT) $(OPENSTACK_ENVIRONMENT) openstack $(__OPENSTACK_OPTIONS) $(OPENSTACK_OPTIONS)

__NEUTRON_OPTIONS?= $(__OPENSTACK_OPTIONS)

NEUTRON?=$(__NEUTRON_ENVIRONMENT) $(NEUTRON_ENVIRONMENT) neutron $(__NEUTRON_OPTIONS) $(NEUTRON_OPTIONS)

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_install_framework_dependencies :: _os_install_framework_dependencies
_os_install_framework_dependencies ::
	sudo apt-get install python python-dev
	sudo pip install --upgrade  python-openstackclient
	sudo apt-get install qemu-utils
	sudo apt-get install jq

_view_framework_macros :: _os_view_framework_macros
_os_view_framework_macros ::
	@echo "OpenStack:: ($(_OPENSTACK_MK_VERSION)) targets:"
	@echo

_view_framework_parameters :: _os_view_framework_parameters
_os_view_framework_parameters ::
	@echo "OpenStack:: ($(_OPENSTACK_MK_VERSION)) parameters:"
	@echo "    NEUTRON=$(NEUTRON)"
	@echo "    OPENSTACK=$(OPENSTACK)"
	@echo "    OS_AUTH_URL=$(OS_AUTH_URL)"
	@echo "    OS_CACERT=$(OS_CACERT)"
	@echo "    OS_CLOUD=$(OS_CLOUD)"
	@echo "    OS_COMPUTE_API_VERSION=$(OS_COMPUTE_API_VERSION)"
	@echo "    OS_FIT_WIDTH=$(OS_FIT_WIDTH)"
	@echo "    OS_FORMAT=$(OS_FORMAT)"
	@echo "    OS_IMAGE_API_VERSION=$(OS_IMAGE_API_VERSION)"
	@echo "    OS_INTERFACE=$(OS_INTERFACE)"
	@echo "    OS_LABEL=$(OS_LABEL)"
	@echo "    OS_MAX_WIDTH=$(OS_MAX_WIDTH)"
	@echo "    OS_NETWORK_API_VERSION=$(OS_NETWORK_API_VERSION)"
	@echo "    OS_PASSWORD=$(OS_PASSWORD)"
	@echo "    OS_PREFIX=$(OS_PREFIX)"
	@echo "    OS_PROJECT_ID=$(OS_PROJECT_ID)"
	@echo "    OS_PROJECT_NAME=$(OS_PROJECT_NAME)"
	@echo "    OS_PROJECT_NAME_OR_ID=$(OS_PROJECT_NAME_OR_ID)"
	@echo "    OS_REGION_NAME=$(OS_REGION_NAME)"
	@echo "    OS_TENANT_ID=$(OS_TENANT_ID)"
	@echo "    OS_TENANT_NAME=$(OS_TENANT_NAME)"
	@echo "    OS_TENANT_NAME_OR_ID=$(OS_TENANT_NAME_OR_ID)"
	@echo "    OS_USERNAME=$(OS_USERNAME)"
	@echo

_view_framework_targets :: _os_view_framework_targets
_os_view_framework_targets ::
	@echo "OpensStack:: ($(_OPENSTACK_MK_VERSION)) targets:"
	@echo "    _os_show_project_usage          - Show the resource usage of the current project"
	@echo "    _os_show_configuration          - Show the current configuration"
	@echo "    _os_view_availability_zones     - View existing availability zones"
	@echo "    _os_view_extensions             - View installed extensions"
	@echo "    _os_view_projects               - View existing projects"
	@echo "    _os_view_project_usages         - View usages of all existing projects"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?=.
-include $(MK_DIR)/openstack_flavor.mk
-include $(MK_DIR)/openstack_floatingip.mk
-include $(MK_DIR)/openstack_image.mk
-include $(MK_DIR)/openstack_ip.mk
-include $(MK_DIR)/openstack_keypair.mk
-include $(MK_DIR)/openstack_network.mk
-include $(MK_DIR)/openstack_port.mk
-include $(MK_DIR)/openstack_router.mk
-include $(MK_DIR)/openstack_server.mk
-include $(MK_DIR)/openstack_service.mk
-include $(MK_DIR)/openstack_securitygroup.mk
-include $(MK_DIR)/openstack_stack.mk
-include $(MK_DIR)/openstack_subnet.mk
-include $(MK_DIR)/openstack_user.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_os_show_configuration:
	@$(INFO) "$(OS_LABEL)Show current configuration ..."; $(NORMAL)
	$(OPENSTACK) configuration show $(__OS_FIT_WIDTH) $(__OS_FORMAT)

_os_show_project_usage:
	@$(INFO) "$(OS_LABEL)Show project usage ..."; $(NORMAL)
	@$(WARN) "Current project is '$(OS_PROJECT_NAME)'"; $(NORMAL)
	$(OPENSTACK) usage show $(__OS_FORMAT)

_os_view_availability_zones:
	@$(INFO) "$(OS_LABEL)View availability zones ..."; $(NORMAL)
	@$(WARN) "For compute service ..."; $(NORMAL)
	-$(OPENSTACK) availability zone list --compute $(__OS_LONG)
	@$(WARN) "For volume service ..."; $(NORMAL)
	-$(OPENSTACK) availability zone list --volume $(__OS_LONG)
	@$(WARN) "For network service ..."; $(NORMAL)
	-$(OPENSTACK) availability zone list --network $(__OS_LONG)

_os_view_extensions:
	@$(INFO) "$(OS_LABEL)View extensions ..."; $(NORMAL)
	$(OPENSTACK) extension list 

_os_view_projects:
	@$(INFO) "$(OS_LABEL)View projects ..."; $(NORMAL)
	$(OPENSTACK) project list $(__OS_FORMAT) $(__OS_LONG)

_os_view_project_usages:
	@$(INFO) "$(OS_LABEL)View usage for each project ..."; $(NORMAL)
	$(OPENSTACK) usage list $(__OS_FORMAT)
