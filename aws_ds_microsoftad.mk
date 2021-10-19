_AWS_DS_MICROSOFTAD_MK_VERSION= $(_AWS_DS_MK_VERSION)

DS_MICROSOFTAD_ADMINUSER_NAME:= Administrator
# DS_MICROSOFTAD_ADMINUSER_PASSWORD?= MyPa5530rD
# DS_MICROSOFTAD_ID?= d-1234567890
# DS_MICROSOFTAD_IDS?= d-1234567890 ...
# DS_MICROSOFTAD_NAME?= corp.amazonworkspaces.com
# DS_MICROSOFTAD_SECURITYGROUP_ID?= sg-12345678
# DS_MICROSOFTAD_SECURITYGROUP_NAME?= d-1234567890_controllers
# DS_MICROSOFTAD_SHORTNAME?= corp
# DS_MICROSOFTAD_EDITON?= Small
# DS_MICROSOFTAD_URL?= d-926728b5f9.awsapps.com
# DS_MICROSOFTAD_VPC_SETTINGS?= VpcId=string,SubnetIds=string,string
# DS_MICROSOFTADS_SET_NAME?= my-microsoftads-set

# Derived parameters
DS_MICROSOFTAD_IDS?= $(DS_MICROSOFTAD_ID)
DS_MICROSOFTAD_SECURITYGROUP_NAME?= $(if $(DS_MICROSOFTAD_ID),$(DS_MICROSOFTAD_ID)_controllers)

# Option parameters
__DS_DESCRIPTION__MICROSOFTAD= $(if $(DS_MICROSOFTAD_DESCRIPTION), --description $(DS_MICROSOFTAD_DESCRIPTION))
__DS_DIRECTORY_ID__MICROSOFTAD= $(if $(DS_MICROSOFTAD_ID), --directory-id $(DS_MICROSOFTAD_ID))
__DS_DIRECTORY_IDS__MICROSOFTAD= $(if $(DS_MICROSOFTAD_IDS), --directory-ids $(DS_MICROSOFTAD_IDS))
__DS_EDITON__MICROSOFTAD= $(if $(DS_MICROSOFTAD_EDITON), --edition $(DS_MICROSOFTAD_EDITON))
__DS_NAME__MICROSOFTAD= $(if $(DS_MICROSOFTAD_NAME), --name $(DS_MICROSOFTAD_NAME))
__DS_PASSWORD__MICROSOFTAD= $(if $(DS_MICROSOFTAD_ADMINUSER_PASSWORD), --password $(DS_MICROSOFTAD_ADMINUSER_PASSWORD))
__DS_SHORT_NAME__MICROSOFTAD= $(if $(DS_MICROSOFTAD_SHORTNAME), --short-name $(DS_MICROSOFTAD_SHORTNAME))
__DS_VPC_SETTINGS__MICROSOFTAD= $(if $(DS_MICROSOFTAD_VPC_SETTINGS), --vpc-settings $(DS_MICROSOFTAD_VPC_SETTINGS))

# UI parameters
DS_UI_VIEW_MICROSOFTADS_FIELDS?= .{DirectoryId:DirectoryId,Name:Name,accessUrl:AccessUrl,size:Size,ssoEnabled:SsoEnabled,stage:Stage,type:Type}
DS_UI_VIEW_MICROSOFTADS_SLICE?= ?Type=='MicrosoftAD'
DS_UI_VIEW_MICROSOFTADS_SET_FIELDS?= $(DS_UI_VIEW_MICROSOFTADS_FIELDS)
DS_UI_VIEW_MICROSOFTADS_SET_SLICE?= $(DS_UI_VIEW_SIMEPLEADS_SLICE)

#--- Utilities

#--- MACROS
_ds_get_microsoftad_id= $(call _ds_get_microsoftad_id_N, $(DS_MICROSOFTAD_NAME))
_ds_get_microsoftad_id_N= $(shell $(AWS) ds describe-directories --query "DirectoryDescriptions[?Name=='$(strip $(1))'].DirectoryId" --output text)

DS_GET_MICROSOFTAD_IDS_SLICE?=
_ds_get_microsoftad_ids= $(call _ds_get_microsoftad_ids_S, $(DS_GET_MICROSOFTAD_IDS_SLICE))
_ds_get_microsoftad_ids_S= $(shell $(AWS) ds describe-directories --query "DirectoryDescriptions[$(strip $(1))].DirectoryId" --output text)

_ds_get_microsoftad_name= $(call _ds_get_microsoftad_name_I, $(DS_MICROSOFTAD_ID))
_ds_get_microsoftad_name_I= $(shell $(AWS) ds describe-directories --directory-ids $(1) --query "DirectoryDescriptions[].Name" --output text)

_ds_get_microsoftad_securitygroup_id= $(call _ds_get_microsoftad_securitygroup_id_I, $(DS_MICROSOFTAD_ID))
_ds_get_microsoftad_securitygroup_id_I= $(shell $(AWS) ds describe-directories --directory-ids $(1) --query "DirectoryDescriptions[].VpcSettings.SecurityGroupId" --output text)

_ds_get_microsoftad_url= $(call _ds_get_microsoftad_url_I, $(DS_MICROSOFTAD_ID))
_ds_get_microsoftad_url_I= $(shell $(AWS) ds describe-directories --directory-ids $(1) --query "DirectoryDescriptions[].AccessUrl" --output text)

#----------------------------------------------------------------------
# USAGE
#

_ds_view_framework_macros ::
	@echo 'AWS::DirectoryService::Directory ($(_AWS_DS_MICROSOFTAD_MK_VERSION)) macros:'
	@echo '    _ds_get_microsoftad_id_{|N}                  - Get the ID of a microsoft-AD (Name)'
	@echo '    _ds_get_microsoftad_ids_{|S}                 - Get the IDs of microsoft-ADs (Slice)'
	@echo '    _ds_get_microsoftad_name_{|I}                - Get the name of a microsoft-AD (Id)'
	@echo '    _ds_get_microsoftad_securitygroup_id_{|I}    - Get the ID of the security-group of a microsoft-AD (Id)'
	@echo '    _ds_get_microsoftad_url_{|I}                 - Get the URL of a microsoft-AD (Id)'
	@echo

_ds_view_framework_parameters ::
	@echo 'AWS::DirectoryService::Directory ($(_AWS_DS_MICROSOFTAD_MK_VERSION)) parameters:'
	@echo '    DS_MICROSOFTAD_ADMINUSER_NAME?=$(DS_MICROSOFTAD_ADMINUSER_NAME)'
	@echo '    DS_MICROSOFTAD_ADMINUSER_PASSWORD?=$(DS_MICROSOFTAD_ADMINUSER_PASSWORD)'
	@echo '    DS_MICROSOFTAD_EDITON?=$(DS_MICROSOFTAD_EDITON)'
	@echo '    DS_MICROSOFTAD_ID?=$(DS_MICROSOFTAD_ID)'
	@echo '    DS_MICROSOFTAD_IDS?=$(DS_MICROSOFTAD_IDS)'
	@echo '    DS_MICROSOFTAD_NAME?=$(DS_MICROSOFTAD_NAME)'
	@echo '    DS_MICROSOFTAD_SECURITYGROUP_ID?=$(DS_MICROSOFTAD_SECURITYGROUP_ID)'
	@echo '    DS_MICROSOFTAD_SECURITYGROUP_NAME?=$(DS_MICROSOFTAD_SECURITYGROUP_NAME)'
	@echo '    DS_MICROSOFTAD_SHORTNAME?=$(DS_MICROSOFTAD_SHORTNAME)'
	@echo '    DS_MICROSOFTAD_URL?=$(DS_MICROSOFTAD_URL)'
	@echo '    DS_MICROSOFTAD_VPC_SETTINGS?=$(DS_MICROSOFTAD_VPC_SETTINGS)'
	@echo '    DS_MICROSOFTADS_SET_NAME?=$(DS_MICROSOFTADS_SET_NAME)'
	@echo

_ds_view_framework_targets ::
	@echo 'AWS::DirectoryService::Directory ($(_AWS_DS_MICROSOFTAD_MK_VERSION)) targets:'
	@echo '    _ds_create_microsoftad               - Create a new microsoft-AD'
	@echo '    _ds_delete_microsoftad               - Delete an existing microsoft-AD'
	@echo '    _ds_show_microsoftad                 - Show everything related to a microsoft-AD'
	@echo '    _ds_view_microsoftads                - View available microsoft-AD directories'
	@echo '    _ds_view_microsoftads_set            - View a set of microsoft-AD directories'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ds_create_microsoftad:
	@$(INFO) '$(AWS_UI_LABEL)Creating a new microsoft-AD directory "$(DS_MICROSOFTAD_NAME)" ...'; $(NORMAL)
	$(AWS) ds create-directory $(__DS_DESCRIPTION__MICROSOFTAD) $(__DS_EDITION__MICROSOFTAD) $(__DS_NAME__MICROSOFTAD) $(__DS_PASSWORD__MICROSOFTAD) $(_DS_SHORT_NAME__MICROSOFTAD) $(__DS_VPC_SETTINGS__MICROSOFTAD)

_ds_delete_microsoftad:
	@$(INFO) '$(AWS_UI_LABEL)Deleting microsoft-AD directory "$(DS_MICROSOFTAD_NAME)" ...'; $(NORMAL)
	$(AWS) ds delete-directory $(__DS_DIRECTORY_ID__MICROSOFTAD)

_ds_show_microsoftad:
	@$(INFO) '$(AWS_UI_LABEL)Showing microsoft-AD directory "$(DS_MICROSOFTAD_NAME)" ...'; $(NORMAL)
	$(if $(DS_MICROSOFTAD_ID), \
	$(AWS) ds describe-directories $(__DS_DIRECTORY_IDS__MICROSOFTAD) --query "DirectoryDescriptions[]" \
	)

_ds_view_microsoftads:
	@$(INFO) '$(AWS_UI_LABEL)Viewing microsoft-AD directories ...'; $(NORMAL)
	$(AWS) ds describe-directories $(_X__DS_DIRECTORY_IDS__MICROSOFTAD) --query "DirectoryDescriptions[$(DS_UI_VIEW_MICROSOFTADS_SLICE)]$(DS_UI_VIEW_MICROSOFTADS_FIELDS)"

_ds_view_microsoftads_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing microsoft-AD directories-set "$(DS_MICROSOFTADS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Directories are grouped based on the provided IDs and/or slice'; $(NORMAL)
	$(AWS) ds describe-directories $(__DS_DIRECTORY_IDS__MICROSOFTAD) --query "DirectoryDescriptions[$(DS_UI_VIEW_MICROSOFTADS_SET_SLICE)]$(DS_UI_VIEW_MICROSOFTADS_SET_FIELDS)"
