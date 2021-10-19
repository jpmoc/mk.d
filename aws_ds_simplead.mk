_AWS_DS_SIMPLEAD_MK_VERSION= $(_AWS_DS_MK_VERSION)

DS_SIMPLEAD_ADMINUSER_NAME:= Administrator
# DS_SIMPLEAD_ADMINUSER_PASSWORD?= MyPa5530rD
# DS_SIMPLEAD_ID?= d-1234567890
# DS_SIMPLEAD_IDS?= d-1234567890 ...
# DS_SIMPLEAD_NAME?= corp.amazonworkspaces.com
# DS_SIMPLEAD_SECURITYGROUP_ID?= sg-12345678
# DS_SIMPLEAD_SECURITYGROUP_NAME?= d-1234567890_controllers
# DS_SIMPLEAD_SHORTNAME?= corp
# DS_SIMPLEAD_SIZE?= Small
# DS_SIMPLEAD_URL?= d-926728b5f9.awsapps.com
# DS_SIMPLEAD_VPC_SETTINGS?= VpcId=string,SubnetIds=string,string
# DS_SIMPLEADS_SET_NAME?= my-simpleads-set

# Derived parameters
DS_SIMPLEAD_IDS?= $(DS_SIMPLEAD_ID)
DS_SIMPLEAD_SECURITYGROUP_NAME?= $(if $(DS_SIMPLEAD_ID),$(DS_SIMPLEAD_ID)_controllers)

# Option parameters
__DS_DESCRIPTION__SIMPLEAD= $(if $(DS_SIMPLEAD_DESCRIPTION), --description $(DS_SIMPLEAD_DESCRIPTION))
__DS_DIRECTORY_ID__SIMPLEAD= $(if $(DS_SIMPLEAD_ID), --directory-id $(DS_SIMPLEAD_ID))
__DS_DIRECTORY_IDS__SIMPLEAD= $(if $(DS_SIMPLEAD_IDS), --directory-ids $(DS_SIMPLEAD_IDS))
__DS_NAME__SIMPLEAD= $(if $(DS_SIMPLEAD_NAME), --name $(DS_SIMPLEAD_NAME))
__DS_PASSWORD__SIMPLEAD= $(if $(DS_SIMPLEAD_ADMINUSER_PASSWORD), --password $(DS_SIMPLEAD_ADMINUSER_PASSWORD))
__DS_SHORT_NAME__SIMPLEAD= $(if $(DS_SIMPLEAD_SHORTNAME), --short-name $(DS_SIMPLEAD_SHORTNAME))
__DS_SIZE__SIMPLEAD= $(if $(DS_SIMPLEAD_SIZE), --size $(DS_SIMPLEAD_SIZE))
__DS_VPC_SETTINGS__SIMPLEAD= $(if $(DS_SIMPLEAD_VPC_SETTINGS), --vpc-settings $(DS_SIMPLEAD_VPC_SETTINGS))

# UI parameters
DS_UI_VIEW_SIMPLEADS_FIELDS?= .{DirectoryId:DirectoryId,Name:Name,accessUrl:AccessUrl,size:Size,ssoEnabled:SsoEnabled,stage:Stage,type:Type}
DS_UI_VIEW_SIMPLEADS_SLICE?= ?Type=='SimpleAD'
DS_UI_VIEW_SIMPLEADS_SET_FIELDS?= $(DS_UI_VIEW_SIMPLEADS_FIELDS)
DS_UI_VIEW_SIMPLEADS_SET_SLICE?= $(DS_UI_VIEW_SIMEPLEADS_SLICE)

#--- Utilities

#--- MACROS
_ds_get_simplead_id= $(call _ds_get_simplead_id_N, $(DS_SIMPLEAD_NAME))
_ds_get_simplead_id_N= $(shell $(AWS) ds describe-directories --query "DirectoryDescriptions[?Name=='$(strip $(1))'].DirectoryId" --output text)

DS_GET_SIMPLEAD_IDS_SLICE?=
_ds_get_simplead_ids= $(call _ds_get_simplead_ids_S, $(DS_GET_SIMPLEAD_IDS_SLICE))
_ds_get_simplead_ids_S= $(shell $(AWS) ds describe-directories --query "DirectoryDescriptions[$(strip $(1))].DirectoryId" --output text)

_ds_get_simplead_name= $(call _ds_get_simplead_name_I, $(DS_SIMPLEAD_ID))
_ds_get_simplead_name_I= $(shell $(AWS) ds describe-directories --directory-ids $(1) --query "DirectoryDescriptions[].Name" --output text)

_ds_get_simplead_securitygroup_id= $(call _ds_get_simplead_securitygroup_id_I, $(DS_SIMPLEAD_ID))
_ds_get_simplead_securitygroup_id_I= $(shell $(AWS) ds describe-directories --directory-ids $(1) --query "DirectoryDescriptions[].VpcSettings.SecurityGroupId" --output text)

_ds_get_simplead_url= $(call _ds_get_simplead_url_I, $(DS_SIMPLEAD_ID))
_ds_get_simplead_url_I= $(shell $(AWS) ds describe-directories --directory-ids $(1) --query "DirectoryDescriptions[].AccessUrl" --output text)

#----------------------------------------------------------------------
# USAGE
#

_ds_view_framework_macros ::
	@echo 'AWS::DirectoryService::SimpleAD ($(_AWS_DS_SIMPLEAD_MK_VERSION)) macros:'
	@echo '    _ds_get_simplead_id_{|N}                  - Get the ID of a simple-AD (Name)'
	@echo '    _ds_get_simplead_ids_{|S}                 - Get the IDs of simple-ADs (Slice)'
	@echo '    _ds_get_simplead_name_{|I}                - Get the name of a simple-AD (Id)'
	@echo '    _ds_get_simplead_securitygroup_id_{|I}    - Get the ID of the security-group of a simple-AD (Id)'
	@echo '    _ds_get_simplead_url_{|I}                 - Get the URL of a simple-AD (Id)'
	@echo

_ds_view_framework_parameters ::
	@echo 'AWS::DirectoryService::SimpleAD ($(_AWS_DS_SIMPLEAD_MK_VERSION)) parameters:'
	@echo '    DS_SIMPLEAD_ADMINUSER_NAME?=$(DS_SIMPLEAD_ADMINUSER_NAME)'
	@echo '    DS_SIMPLEAD_ADMINUSER_PASSWORD?=$(DS_SIMPLEAD_ADMINUSER_PASSWORD)'
	@echo '    DS_SIMPLEAD_ID?=$(DS_SIMPLEAD_ID)'
	@echo '    DS_SIMPLEAD_IDS?=$(DS_SIMPLEAD_IDS)'
	@echo '    DS_SIMPLEAD_NAME?=$(DS_SIMPLEAD_NAME)'
	@echo '    DS_SIMPLEAD_SECURITYGROUP_ID?=$(DS_SIMPLEAD_SECURITYGROUP_ID)'
	@echo '    DS_SIMPLEAD_SECURITYGROUP_NAME?=$(DS_SIMPLEAD_SECURITYGROUP_NAME)'
	@echo '    DS_SIMPLEAD_SHORTNAME?=$(DS_SIMPLEAD_SHORTNAME)'
	@echo '    DS_SIMPLEAD_SIZE?=$(DS_SIMPLEAD_SIZE)'
	@echo '    DS_SIMPLEAD_URL?=$(DS_SIMPLEAD_URL)'
	@echo '    DS_SIMPLEAD_VPC_SETTINGS?=$(DS_SIMPLEAD_VPC_SETTINGS)'
	@echo '    DS_SIMPLEADS_SET_NAME?=$(DS_SIMPLEADS_SET_NAME)'
	@echo

_ds_view_framework_targets ::
	@echo 'AWS::DirectoryService::SimpleAD ($(_AWS_DS_SIMPLEAD_MK_VERSION)) targets:'
	@echo '    _ds_create_simplead               - Create a new simple-AD'
	@echo '    _ds_delete_simplead               - Delete an existing simple-AD'
	@echo '    _ds_show_simplead                 - Show everything related to a simple-AD'
	@echo '    _ds_view_simpleads                - View available simple-AD directories'
	@echo '    _ds_view_simpleads_set            - View a set of simple-AD directories'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ds_create_simplead:
	@$(INFO) '$(AWS_UI_LABEL)Creating a new simple-AD directory "$(DS_SIMPLEAD_NAME)" ...'; $(NORMAL)
	$(AWS) ds create-directory $(__DS_DESCRIPTION__SIMPLEAD) $(__DS_NAME__SIMPLEAD) $(__DS_PASSWORD__SIMPLEAD) $(_DS_SHORT_NAME__SIMPLEAD) $(__DS_SIZE__SIMPLEAD) $(__DS_VPC_SETTINGS__SIMPLEAD)

_ds_delete_simplead:
	@$(INFO) '$(AWS_UI_LABEL)Deleting simple-AD directory "$(DS_SIMPLEAD_NAME)" ...'; $(NORMAL)
	$(AWS) ds delete-directory $(__DS_DIRECTORY_ID__SIMPLEAD)

_ds_show_simplead:
	@$(INFO) '$(AWS_UI_LABEL)Showing simple-AD directory "$(DS_SIMPLEAD_NAME)" ...'; $(NORMAL)
	$(if $(DS_SIMPLEAD_ID), \
	$(AWS) ds describe-directories $(__DS_DIRECTORY_IDS__SIMPLEAD) --query "DirectoryDescriptions[]" \
	)

_ds_view_simpleads:
	@$(INFO) '$(AWS_UI_LABEL)Viewing simple-AD directories ...'; $(NORMAL)
	$(AWS) ds describe-directories $(_X__DS_DIRECTORY_IDS__SIMPLEAD) --query "DirectoryDescriptions[$(DS_UI_VIEW_SIMPLEADS_SLICE)]$(DS_UI_VIEW_SIMPLEADS_FIELDS)"

_ds_view_simpleads_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing simple-AD directories-set "$(DS_SIMPLEADS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Directories are grouped based on the provided IDs and/or slice'; $(NORMAL)
	$(AWS) ds describe-directories $(__DS_DIRECTORY_IDS__SIMPLEAD) --query "DirectoryDescriptions[$(DS_UI_VIEW_SIMPLEADS_SET_SLICE)]$(DS_UI_VIEW_SIMPLEADS_SET_FIELDS)"
