_AWS_DS_ADCONNECTOR_MK_VERSION= $(_AWS_DS_MK_VERSION)

# DS_ADCONNECTOR_ADMINUSER_PASSWORD?= 
# DS_ADCONNECTOR_CONNECT_SETTINGS?= VpcId=string,SubnetIds=string,string,CustomerDnsIps=string,string,CustomerUserName=string
# DS_ADCONNECTOR_ID?= d-1234567890
# DS_ADCONNECTOR_IDS?= d-1234567890 ...
# DS_ADCONNECTOR_NAME?= corp.amazonworkspaces.com
# DS_ADCONNECTOR_SECURITYGROUP_ID?= sg-12345678
# DS_ADCONNECTOR_SECURITYGROUP_NAME?= d-1234567890_controllers
# DS_ADCONNECTOR_SHORTNAME?= corp
# DS_ADCONNECTOR_SIZE?= Small
# DS_ADCONNECTOR_URL?= d-926728b5f9.awsapps.com
# DS_ADCONNECTORS_SET_NAME?= my-adconnectors-set

# Derived parameters
DS_ADCONNECTOR_IDS?= $(DS_ADCONNECTOR_ID)
DS_ADCONNECTOR_SECURITYGROUP_NAME?= $(if $(DS_ADCONNECTOR_ID),$(DS_ADCONNECTOR_ID)_controllers)

# Option parameters
__DS_CONNECT_SETTINGS__ADCONNECTOR= $(if $(DS_ADCONNECTOR_CONNECT_SETTINGS), --connect-settings $(DS_ADCONNECTOR_CONNECT_SETTINGS))
__DS_DESCRIPTION__ADCONNECTOR= $(if $(DS_ADCONNECTOR_DESCRIPTION), --description $(DS_ADCONNECTOR_DESCRIPTION))
__DS_DIRECTORY_ID__ADCONNECTOR= $(if $(DS_ADCONNECTOR_ID), --directory-id $(DS_ADCONNECTOR_ID))
__DS_DIRECTORY_IDS__ADCONNECTOR= $(if $(DS_ADCONNECTOR_IDS), --directory-ids $(DS_ADCONNECTOR_IDS))
__DS_NAME__ADCONNECTOR= $(if $(DS_ADCONNECTOR_NAME), --name $(DS_ADCONNECTOR_NAME))
__DS_PASSWORD__ADCONNECTOR= $(if $(DS_ADCONNECTOR_ADMINUSER_PASSWORD), --password $(DS_ADCONNECTOR_ADMINUSER_PASSWORD))
__DS_SHORT_NAME__ADCONNECTOR= $(if $(DS_ADCONNECTOR_SHORTNAME), --short-name $(DS_ADCONNECTOR_SHORTNAME))
__DS_SIZE__ADCONNECTOR= $(if $(DS_ADCONNECTOR_SIZE), --size $(DS_ADCONNECTOR_SIZE))

# UI parameters
DS_UI_VIEW_ADCONNECTORS_FIELDS?= .{DirectoryId:DirectoryId,Name:Name,accessUrl:AccessUrl,size:Size,ssoEnabled:SsoEnabled,stage:Stage,type:Type}
DS_UI_VIEW_ADCONNECTORS_SLICE?= ?Type=='SimpleAD'
DS_UI_VIEW_ADCONNECTORS_SET_FIELDS?= $(DS_UI_VIEW_ADCONNECTORS_FIELDS)
DS_UI_VIEW_ADCONNECTORS_SET_SLICE?= $(DS_UI_VIEW_SIMEPLEADS_SLICE)

#--- Utilities

#--- MACROS
_ds_get_adconnector_id= $(call _ds_get_adconnector_id_N, $(DS_ADCONNECTOR_NAME))
_ds_get_adconnector_id_N= $(shell $(AWS) ds describe-directories --query "DirectoryDescriptions[?Name=='$(strip $(1))'].DirectoryId" --output text)

DS_GET_ADCONNECTOR_IDS_SLICE?=
_ds_get_adconnector_ids= $(call _ds_get_adconnector_ids_S, $(DS_GET_ADCONNECTOR_IDS_SLICE))
_ds_get_adconnector_ids_S= $(shell $(AWS) ds describe-directories --query "DirectoryDescriptions[$(strip $(1))].DirectoryId" --output text)

_ds_get_adconnector_name= $(call _ds_get_adconnector_name_I, $(DS_ADCONNECTOR_ID))
_ds_get_adconnector_name_I= $(shell $(AWS) ds describe-directories --directory-ids $(1) --query "DirectoryDescriptions[].Name" --output text)

_ds_get_adconnector_securitygroup_id= $(call _ds_get_adconnector_securitygroup_id_I, $(DS_ADCONNECTOR_ID))
_ds_get_adconnector_securitygroup_id_I= $(shell $(AWS) ds describe-directories --directory-ids $(1) --query "DirectoryDescriptions[].VpcSettings.SecurityGroupId" --output text)

_ds_get_adconnector_url= $(call _ds_get_adconnector_url_I, $(DS_ADCONNECTOR_ID))
_ds_get_adconnector_url_I= $(shell $(AWS) ds describe-directories --directory-ids $(1) --query "DirectoryDescriptions[].AccessUrl" --output text)

#----------------------------------------------------------------------
# USAGE
#

_ds_view_framework_macros ::
	@echo 'AWS::DirectoryService::ADConnector ($(_AWS_DS_ADCONNECTOR_MK_VERSION)) macros:'
	@echo '    _ds_get_adconnector_id_{|N}                  - Get the ID of a AD-connector (Name)'
	@echo '    _ds_get_adconnector_ids_{|S}                 - Get the IDs of AD-connectors (Slice)'
	@echo '    _ds_get_adconnector_name_{|I}                - Get the name of a AD-connector (Id)'
	@echo '    _ds_get_adconnector_securitygroup_id_{|I}    - Get the ID of the security-group of a AD-connector (Id)'
	@echo '    _ds_get_adconnector_url_{|I}                 - Get the URL of a AD-connector (Id)'
	@echo

_ds_view_framework_parameters ::
	@echo 'AWS::DirectoryService::ADConnector ($(_AWS_DS_ADCONNECTOR_MK_VERSION)) parameters:'
	@echo '    DS_ADCONNECTOR_ADMINUSER_NAME?=$(DS_ADCONNECTOR_ADMINUSER_NAME)'
	@echo '    DS_ADCONNECTOR_ADMINUSER_PASSWORD?=$(DS_ADCONNECTOR_ADMINUSER_PASSWORD)'
	@echo '    DS_ADCONNECTOR_ID?=$(DS_ADCONNECTOR_ID)'
	@echo '    DS_ADCONNECTOR_IDS?=$(DS_ADCONNECTOR_IDS)'
	@echo '    DS_ADCONNECTOR_NAME?=$(DS_ADCONNECTOR_NAME)'
	@echo '    DS_ADCONNECTOR_SECURITYGROUP_ID?=$(DS_ADCONNECTOR_SECURITYGROUP_ID)'
	@echo '    DS_ADCONNECTOR_SECURITYGROUP_NAME?=$(DS_ADCONNECTOR_SECURITYGROUP_NAME)'
	@echo '    DS_ADCONNECTOR_SHORTNAME?=$(DS_ADCONNECTOR_SHORTNAME)'
	@echo '    DS_ADCONNECTOR_SIZE?=$(DS_ADCONNECTOR_SIZE)'
	@echo '    DS_ADCONNECTOR_URL?=$(DS_ADCONNECTOR_URL)'
	@echo '    DS_ADCONNECTOR_CONNECT_SETTINGS?=$(DS_ADCONNECTOR_CONNECT_SETTINGS)'
	@echo '    DS_ADCONNECTORS_SET_NAME?=$(DS_ADCONNECTORS_SET_NAME)'
	@echo

_ds_view_framework_targets ::
	@echo 'AWS::DirectoryService::ADConnector ($(_AWS_DS_ADCONNECTOR_MK_VERSION)) targets:'
	@echo '    _ds_create_adconnector               - Create a new AD-connector'
	@echo '    _ds_delete_adconnector               - Delete an existing AD-connector'
	@echo '    _ds_show_adconnector                 - Show everything related to a AD-connector'
	@echo '    _ds_view_adconnectors                - View available AD-connector directories'
	@echo '    _ds_view_adconnectors_set            - View a set of AD-connector directories'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ds_create_adconnector:
	@$(INFO) '$(AWS_UI_LABEL)Creating a new AD-connector directory "$(DS_ADCONNECTOR_NAME)" ...'; $(NORMAL)
	$(AWS) ds connect-directory $(__DS_DESCRIPTION__ADCONNECTOR) $(__DS_NAME__ADCONNECTOR) $(__DS_PASSWORD__ADCONNECTOR) $(_DS_SHORT_NAME__ADCONNECTOR) $(__DS_SIZE__ADCONNECTOR) $(__DS_CONNECT_SETTINGS__ADCONNECTOR)

_ds_delete_adconnector:
	@$(INFO) '$(AWS_UI_LABEL)Deleting AD-connector directory "$(DS_ADCONNECTOR_NAME)" ...'; $(NORMAL)
	$(AWS) ds delete-directory $(__DS_DIRECTORY_ID__ADCONNECTOR)

_ds_show_adconnector:
	@$(INFO) '$(AWS_UI_LABEL)Showing AD-connector directory "$(DS_ADCONNECTOR_NAME)" ...'; $(NORMAL)
	$(if $(DS_ADCONNECTOR_ID__ADCONNECTOR), \
	$(AWS) ds describe-directories $(__DS_DIRECTORY_IDS__ADCONNECTOR) --query "DirectoryDescriptions[]" \
	)

_ds_view_adconnectors:
	@$(INFO) '$(AWS_UI_LABEL)Viewing AD-connector directories ...'; $(NORMAL)
	$(AWS) ds describe-directories $(_X__DS_DIRECTORY_IDS__ADCONNECTOR) --query "DirectoryDescriptions[$(DS_UI_VIEW_ADCONNECTORS_SLICE)]$(DS_UI_VIEW_ADCONNECTORS_FIELDS)"

_ds_view_adconnectors_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing AD-connector directories-set "$(DS_ADCONNECTORS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Directories are grouped based on the provided IDs and/or slice'; $(NORMAL)
	$(AWS) ds describe-directories $(__DS_DIRECTORY_IDS__ADCONNECTOR) --query "DirectoryDescriptions[$(DS_UI_VIEW_ADCONNECTORS_SET_SLICE)]$(DS_UI_VIEW_ADCONNECTORS_SET_FIELDS)"
