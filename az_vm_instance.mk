_AZ_VM_INSTANCE_MK_VERSION= $(_AZ_VM_MK_VERSION)

# VM_INSTANE_ADMIN_PASSWORD?= my-password
# VM_INSTANE_ADMIN_USERNAME?= emayssat
# VM_INSTANE_AUTHENTICATION_TYPE?= ssh
# VM_INSTANCE_COMPUTER_NAME?= bionic64
VM_INSTANCE_DELETE_NOWAIT?= false
VM_INSTANCE_DELETE_YES?= false
# VM_INSTANCE_EXEC_SCRIPTS?= 'chmod 440 /tmp/file'
# VM_INSTANCE_ID?= /subscriptions/59b066b1-4bd5-4a01-bbb1-14ee71d3d7fc/resourceGroups/LinuxGroup/providers/Microsoft.Compute/virtualMachines/LinuxB
# VM_INSTANCE_IDENTITY_NAME?= my-identity
# VM_INSTANCE_IMAGE_NAME?= UbuntuLTS
# VM_INSTANCE_LOCATION_ID?= westus2
# VM_INSTANCE_NAME?= Myinstance
# VM_INSTANCE_NIC_NAME?= MyinstanceVMNIC
# VM_INSTANCE_OS_TYPE?= Linux
# VM_INSTANCE_OSDISK_SIZE?= 30
# VM_INSTANCE_PUBLICIP_ADDRESS?= 1.1.1.1
# VM_INSTANCE_PUBLICIP_NAME?= LinuxBPublicIP
# VM_INSTANCE_RESOURCEGROUP_NAME?= MyResourceGroup
# VM_INSTANCE_SHOW_DETAILS?= false
# VM_INSTANCE_SIZE?= Standard_DS2_v2
VM_INSTANCE_SSHPUBLICKEY_FILEPATH?= $(HOME)/.ssh/id_rsa.pub
# VM_INSTANCES_IDS?=
# VM_INSTANCES_RESOURCEGROUP_NAME?= MyResourceGroup
# VM_INSTANCES_SET_NAME?=

# Derived parameters
VM_INSTANCE_ID?= $(if $(VM_INSTANCE_NAME),/subscriptions/$(VM_INSTANCE_SUBSCRIPTION_ID)/resourceGroups/$(VM_INSTANCE_RESOURCEGROUP_NAME)/providers/Microsoft.Compute/virtualMachines/$(VM_INSTANCE_NAME))
VM_INSTANCE_COMPUTER_NAME?= $(VM_INSTANCE_NAME)
VM_INSTANCE_LOCATION_ID?= $(VM_LOCATION_ID)
VM_INSTANCE_PUBLICIP_NAME?= $(NWK_PUBLICIP_NAME)
VM_INSTANCE_RESOURCEGROUP_NAME?= $(VM_RESOURCEGROUP_NAME)
VM_INSTANCE_SUBSCRIPTION_ID?= $(VM_SUBSCRIPTION_ID)
VM_INSTANCES_RESOURCEGROUP_NAME?= $(VM_INSTANCE_RESOURCEGROUP_NAME)
VM_INSTANCES_SET_NAME?= $(VM_INSTANCES_RESOURCEGROUP_NAME)

# Options parameters
__VM_ACCELERATED_NETWORKING=
__VM_ADMIN_PASSWORD= $(if $(VM_INSTANCE_ADMIN_PASSWORD),--admin-password $(VM_INSTANCE_ADMIN_PASSWORD))
__VM_ADMIN_USERNAME= $(if $(VM_INSTANCE_ADMIN_USERNAME),--admin-username $(VM_INSTANCE_ADMIN_USERNAME))
__VM_ASGS=
__VM_ASSIGN_IDENTITY= $(if $(VM_INSTANCE_IDENTITY_NAME),--assign-identity $(VM_INSTANCE_IDENTITY_NAME))
__VM_ATTACH_DATA_DISKS=
__VM_ATTACH_OS_DISK=
__VM_AUTHENTICATION_TYPE= $(if $(VM_INSTANCE_AUTHENTICATION_TYPE),--authentication-type $(VM_INSTANCE_AUTHENTICATION_TYPE))
__VM_AVAILABILITY_SET=
__VM_BOOT_DIAGNOSTICS_STORAGE=
__VM_COMPUTER_NAME= $(if $(VM_INSTANCE_COMPUTER_NAME),--computer-name $(VM_INSTANCE_COMPUTER_NAME))
__VM_CUSTOM_DATA=
__VM_DATA_DISK_CACHING=
__VM_DATA_DISK_SIZES_GB=
__VM_ENABLE_AGENT=
__VM_EPHEMERAL_OS_DISK=
__VM_EVICTION_POLICY=
__VM_GENERATE_SSH_KEYS=
__VM_HOST=
__VM_HOST_GROUP=
__VM_IDS__INSTANCE= $(if $(VM_INSTANCE_ID),--ids $(VM_INSTANCE_ID))
__VM_IDS__INSTANCES= $(if $(VM_INSTANCES_IDS),--ids $(VM_INSTANCES_IDS))
__VM_IMAGE= $(if $(VM_INSTANCE_IMAGE_NAME),--image $(VM_INSTANCE_IMAGE_NAME))
__VM_LICENSE_TYPE=
__VM_LOCATION__INSTANCE= $(if $(VM_INSTANCE_LOCATION_ID),--location $(VM_INSTANCE_LOCATION_ID))
__VM_MAX_PRICE=
__VM_NAME__INSTANCE= $(if $(VM_INSTANCE_NAME),--name $(VM_INSTANCE_NAME))
__VM_NICS=
__VM_NO_WAIT__INSTANCE= $(if $(filter true, $(VM_INSTANCE_DELETE_NOWAIT)),--no-wait)
__VM_OS_DISK_CACHING=
__VM_OS_DISK_NAME=
__VM_OS_DISK_SIZE_GB= $(if $(VM_INSTANCE_OSDISK_SIZE),--os-disk-size-gb $(VM_INSTANCE_OSDISK_SIZE))
__VM_OS_TYPE= $(if $(VM_INSTANCE_OS_TYPE),--os-type $(VM_INSTANCE_OS_TYPE))
__VM_PLAN_NAME=
__VM_PLAN_PRODUCT=
__VM_PLAN_PROMOTION_CODE=
__VM_PLAN_PUBLISHER=
__VM_PPG=
__VM_PRIORITY=
__VM_PRIVATE_IP_ADDRESS=
__VM_PUBLIC_IP_ADDRESS=
__VM_PUBLIC_IP_ADDRESS_ALLOCATION=
__VM_PUBLIC_IP_ADDRESS_DNS_NAME=
__VM_PUBLIC_IP_SKU=
__VM_RESOURCE_GROUP__INSTANCE= $(if $(VM_INSTANCE_RESOURCEGROUP_NAME),--resource-group $(VM_INSTANCE_RESOURCEGROUP_NAME))
__VM_RESOURCE_GROUP__INSTANCES= $(if $(VM_INSTANCES_RESOURCEGROUP_NAME),--resource-group $(VM_INSTANCES_RESOURCEGROUP_NAME))
__VM_ROLE=
__VM_SCOPE=
__VM_SCRIPTS__INSTANCE= $(if $(VM_INSTANCE_EXEC_SCRIPTS),--scripts $(VM_INSTANCE_EXEC_SCRIPTS))
__VM_SECRETS=
__VM_SIZE= $(if $(VM_INSTANCE_SIZE),--size $(VM_INSTANCE_SIZE))
__VM_SSH_DEST_KEY_PATH=
__VM_SSH_KEY_VALUE= $(if $(VM_INSTANCE_SSHPUBLICKEY_FILEPATH),--ssh-key-value @$(VM_INSTANCE_SSHPUBLICKEY_FILEPATH))
__VM_STORAGE_ACCOUNT=
__VM_STORAGE_CONTAINER_NAME=
__VM_STORAGE_SKU=
__VM_SUBNET=
__VM_SUBNET_ADDRESS_PREFIX=
__VM_TAGS__INSTANCE=
__VM_ULTRA_SSD_ENABLED=
__VM_USE_UNMANAGED_DISK=
__VM_VALIDATE=
__VM_VMSS__INSTANCE=
__VM_VNET_ADDRESS_PREFIX=
__VM_VNET_NAME=
__VM_WORKSPACE=
__VM_YES__INSTANCE= $(if $(filter true, $(VM_INSTANCE_DELETE_YES)),--yes)
__VM_ZONE=

# UI parameters

#--- Utilities

#--- MACRO
_vm_get_instance_nic_name= $(call _vm_get_instance_nic_name_N, $(VM_INSTANCE_NAME))
_vm_get_instance_nic_name_N= $(shell echo '$(strip $(1))VMNic')

_vm_get_instance_publicip_address= $(call _vm_get_instance_publicip_address_N, $(VM_INSTANCE_PUBLICIP_NAME))
_vm_get_instance_publicip_address_N= $(call _vm_get_instance_publicip_address_NG, $(1), $(VM_INSTANCE_RESOURCEGROUP_NAME))
_vm_get_instance_publicip_address_NG= $(call _vm_get_instance_publicip_address_NGS, $(1), $(2), $(VM_SUBSCRIPTION_ID_OR_NAME))
_vm_get_instance_publicip_address_NGS= $(shell $(AZ) network public-ip show --subscription $(3) --name $(1) --resource-group $(2) --query 'ipAddress' --output tsv)

_vm_get_instance_publicip_name= $(call _vm_get_instance_publicip_name_N, $(VM_INSTANCE_NAME))
_vm_get_instance_publicip_name_N= $(shell echo 'TO_IMPLEMENT')

#----------------------------------------------------------------------
# USAGE
#

_vm_view_framework_macros ::
	@echo 'AZ::VM::Instance ($(_AZ_VM_INSTANCE_MK_VERSION)) macros:'
	@echo '    _vm_get_instance_nic_name_{|N}                 - Get the name of an instance-nic (Name)'
	@echo '    _vm_get_instance_publicip_name_{|N}            - Get the name of an instance-public-ip (Name)'
	@echo '    _vm_get_instance_publicip_address_{|N|NG|NGS}  - Get the address of an instance-public-ip (Name,resourceGroup,Subscription)'
	@echo

_vm_view_framework_parameters ::
	@echo 'AZ::VM::Instance ($(_AZ_VM_INSTANCE_MK_VERSION)) parameters:'
	@echo '    VM_INSTANCE_ADMIN_PASSWORD=$(VM_INSTANCE_ADMIN_PASSWORD)'
	@echo '    VM_INSTANCE_ADMIN_USERNAME=$(VM_INSTANCE_ADMIN_USERNAME)'
	@echo '    VM_INSTANCE_AUTHENTICATION_TYPE=$(VM_INSTANCE_AUTHENTICATION_TYPE)'
	@echo '    VM_INSTANCE_COMPUTER_NAME=$(VM_INSTANCE_COMPUTER_NAME)'
	@echo '    VM_INSTANCE_DELETE_NOWAIT=$(VM_INSTANCE_DELETE_NOWAIT)'
	@echo '    VM_INSTANCE_DELETE_YES=$(VM_INSTANCE_DELETE_YES)'
	@echo '    VM_INSTANCE_EXEC_SCRIPTS=$(VM_INSTANCE_EXEC_SCRIPTS)'
	@echo '    VM_INSTANCE_ID=$(VM_INSTANCE_ID)'
	@echo '    VM_INSTANCE_IDENTITY_NAME=$(VM_INSTANCE_IDENTITY_NAME)'
	@echo '    VM_INSTANCE_IMAGE_NAME=$(VM_INSTANCE_IMAGE_NAME)'
	@echo '    VM_INSTANCE_LOCATION_ID=$(VM_INSTANCE_LOCATION_ID)'
	@echo '    VM_INSTANCE_NAME=$(VM_INSTANCE_NAME)'
	@echo '    VM_INSTANCE_NIC_NAME=$(VM_INSTANCE_NIC_NAME)'
	@echo '    VM_INSTANCE_OS_TYPE=$(VM_INSTANCE_OS_TYPE)'
	@echo '    VM_INSTANCE_OSDISK_SIZE=$(VM_INSTANCE_OSDISK_SIZE)'
	@echo '    VM_INSTANCE_PUBLICIP_ADDRESS=$(VM_INSTANCE_PUBLICIP_ADDRESS)'
	@echo '    VM_INSTANCE_PUBLICIP_NAME=$(VM_INSTANCE_PUBLICIP_NAME)'
	@echo '    VM_INSTANCE_RESOURCEGROUP_NAME=$(VM_INSTANCE_RESOURCEGROUP_NAME)'
	@echo '    VM_INSTANCE_SHOW_DETAILS=$(VM_INSTANCE_SHOW_DETAILS)'
	@echo '    VM_INSTANCE_SIZE=$(VM_INSTANCE_SIZE)'
	@echo '    VM_INSTANCE_SSHPUBLICKEY_FILEPATH=$(VM_INSTANCE_SSHPUBLICKEY_FILEPATH)'
	@echo '    VM_INSTANCES_IDS=$(VM_INSTANCES_IDS)'
	@echo '    VM_INSTANCES_RESOURCEGROUP_NAME=$(VM_INSTANCES_RESOURCEGROUP_NAME)'
	@echo '    VM_INSTANCES_SET_NAME=$(VM_INSTANCES_SET_NAME)'
	@echo

_vm_view_framework_targets ::
	@echo 'AZ::VM::Instance ($(_AZ_VM_INSTANCE_MK_VERSION)) targets:'
	@echo '    _vm_create_instance                - Create an instance'
	@echo '    _vm_delete_instance                - Delete an instance'
	@echo '    _vm_exec_instance                  - Execute a script on an instance'
	@echo '    _vm_show_instance                  - Show everything related to an instance'
	@echo '    _vm_show_instance_description      - Show description of an instance'
	@echo '    _vm_show_instance_keypair          - Show keypair of an instance'
	@echo '    _vm_show_instance_nic              - Show nic of an instance'
	@echo '    _vm_show_instance_publicip         - Show public-ip of an instance'
	@echo '    _vm_view_instances                 - View instances'
	@echo '    _vm_view_instances_set             - View a set of instances'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vm_create_instance:
	@$(INFO) '$(VM_UI_LABEL)Creating instance "$(VM_INSTANCE_NAME)" ...'; $(NORMAL)
	$(AZ) vm create $(strip $(__VM_ACCELERATED_NETWORKING) $(__VM_ADMIN_PASSWORD) $(__VM_ADMIN_USERNAME) $(__VM_ASGS) $(__VM_ASSIGN_IDENTITY) $(__VM_ATTACH_DATA_DISKS) $(__VM_ATTACH_OS_DISK) $(__VM_AUTHENTICATION_TYPE) $(__VM_AVAILABILITY_SET) $(__VM_BOOT_DIAGNOSTICS_STORAGE) $(__VM_COMPUTER_NAME) $(__VM_CUSTOM_DATA) $(__VM_DATA_DISK_CACHING) $(__VM_DATA_DISK_SIZED_GB) $(__VM_ENABLE_AGENT) $(__VM_EPHEMERAL_OS_DISK) $(__VM_EVICTION_POLICY) $(__VM_GENERATE_SSH_KEYS) $(__VM_HOST) $(__VM_HOST_GROUP) $(__VM_IMAGE) $(__VM_LICENSE_TYPE) $(__VM_LOCATION__INSTANCE) $(__VM_MAX_BILLING) $(__VM_NAME__INSTANCE) $(__VM_NICS) $(__VM_NO_WAIT) $(__VM_NSG) $(__VM_OS_DISK_CACHING) $(__VM_OS_DISK_NAME) $(__VM_OS_DISK_SIZE_GB) $(__VM_OS_TYPE) $(__VM_PLAN_NAME) $(__VM_PLAN_PRODUCT) $(__VM_PROMOTION_CODE) $(__VM_PLAN_PUBLISHED) $(__VM_PPG) $(__VM_PRIORITY) $(__VM_PRIVATE_IP_ADDRESS) $(__VM_PUBLIC_IP_ADDRESS) $(__VM_PUBLIC_IP_ADDRESS_ALLOCATION) $(__VM_PUBLIC_IP_ADDRESS_DNS_NAME) $(__VM_PUBLIC_IP_SKU) $(__VM_RESOURCE_GROUP__INSTANCE) $(__VM_ROLE) $(__VM_SCOPE) $(__VM_SECRETS) $(__VM_SIZE) $(__VM_SSH_DEST_KEY_PATH) $(__VM_SSH_KEY_VALUE) $(__VM_STORAGE_ACCOUNT) $(__VM_STORAGE_CONTAINER_NAME) $(__VM_STORAGE_SKU) $(__VM_SUBNET) $(__VM_SUBNET_ADDRESS_PREFIX) $(__VM_SUBSCRIPTION) $(__VM_TAGS__INSTANCE) $(__VM_ULTRA_SSD_ENABLED) $(__VM_USE_UNMANAGED_DISK) $(__VM_VALIDATE) $(__VM_VNET_ADDRESS_PREFIX) $(__VM_VNET_NAME) $(__VM_WORKSPACE) $(__VM_ZONE))

_vm_delete_instance:
	@$(INFO) '$(VM_UI_LABEL)Deleting instance "$(VM_INSTANCE_NAME)" ...'; $(NORMAL)
	$(AZ) vm delete $(__VM_IDS__INSTANCE) $(__VM_NAME__INSTANCE) $(__VM_NO_WAIT__INSTANCE) $(__VM_RESOURCE_GROUP__INSTANCE) $(__VM_YES__INSTANCE)

_vm_exec_instance:
	@$(INFO) '$(VM_UI_LABEL)Exec-ing as root on instance "$(VM_INSTANCE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation executes a shell script as root on the instance'; $(NORMAL)
	$(AZ) vm run-command invoke --command-id RunShellScript $(__VM_NAME__INSTANCE) $(__VM_RESOURCE_GROUP__INSTANCE) $(__VM_SCRIPTS__INSTANCE)

_vm_show_instance :: _vm_show_instance_keypair _vm_show_instance_nic _vm_show_instance_object _vm_show_instance_publicip _vm_show_instance_description

_vm_show_instance_description:
	@$(INFO) '$(VM_UI_LABEL)Showing description of instance "$(VM_INSTANCE_NAME)" ...'; $(NORMAL)
	$(AZ) vm show $(__VM_IDS__INSTANCE) $(__VM_NAME__INSTANCE) $(__VM_OUTPUT) $(__VM_RESOURCE_GROUP__INSTANCE) $(__VM_SHOW_DETAILS) 

_vm_show_instance_keypair:
	@$(INFO) '$(VM_UI_LABEL)Showing keypair-modulus of instance "$(VM_INSTANCE_NAME)" ...'; $(NORMAL)
	$(AZ) vm show $(__VM_IDS__INSTANCE) $(__VM_NAME__INSTANCE) $(_X__VM_OUTPUT) --output tsv $(__VM_RESOURCE_GROUP__INSTANCE) $(__VM_SHOW_DETAILS) --query 'osProfile.linuxConfiguration.ssh.publicKeys[0].keyData'

_vm_show_instance_nic:
	@$(INFO) '$(VM_UI_LABEL)Showing NIC of instance "$(VM_INSTANCE_NAME)" ...'; $(NORMAL)
	$(if $(VM_INSTANCE_NIC_NAME), \
		$(AZ) network nic show $(__VM_OUTPUT) $(_VM_SUBSCRIPTION) --name $(VM_INSTANCE_NIC_NAME) $(__VM_RESOURCE_GROUP__INSTANCE) \
	, @\
		echo 'VM_INSTANCE_NIC_NAME not set'; \
	)

_vm_show_instance_object:
	@$(INFO) '$(VM_UI_LABEL)Showing object of instance "$(VM_INSTANCE_NAME)" ...'; $(NORMAL)
	$(AZ) vm show $(__VM_IDS__INSTANCE) $(__VM_NAME__INSTANCE) $(_X__VM_OUTPUT) --output json $(__VM_RESOURCE_GROUP__INSTANCE) $(__VM_SHOW_DETAILS) 

_vm_show_instance_publicip:
	@$(INFO) '$(VM_UI_LABEL)Showing public-ip of instance "$(VM_INSTANCE_NAME)" ...'; $(NORMAL)
	$(if $(VM_INSTANCE_PUBLICIP_NAME), \
		$(AZ) network public-ip show --name $(VM_INSTANCE_PUBLICIP_NAME) $(__VM_OUTPUT) $(__VM_RESOURCE_GROUP__INSTANCE) $(__VM_SUBSCRIPTION) \
	, @\
		echo 'VM_INSTANCE_PUBLICIP_NAME not set'; \
	)

_vm_view_instances:
	@$(INFO) '$(VM_UI_LABEL)Viewing instances ...'; $(NORMAL)
	$(AZ) vm list $(__VM_OUTPUT) $(_X__VM_RESOURCE_GROUP__INSTANCES) $(__VM_SHOW_DETAILS) $(__VM_SUBSCRIPTION)

_vm_view_instances_set:
	@$(INFO) '$(VM_UI_LABEL)Viewing instances-set "$(VM_INSTANCES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Instances are grouped based on provided resource-group and query-filter'; $(NORMAL)
	$(AZ) vm list $(__VM_OUTPUT) $(__VM_RESOURCE_GROUP__INSTANCES) $(__VM_SHOW_DETAILS) $(__VM_SUBSCRIPTION) 
