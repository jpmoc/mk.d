_AWS_WORKDOCS_FOLDER_MK_VERSION= $(_AWS_WORKDOCS_MK_VERSION)

# WDS_FOLDER_ID?= 
# WDS_FOLDER_NAME?= email@adress.com
# WDS_FOLDERS_SET_NAME?=

# Derived parameters
WDS_FOLDER_NAME?= $(WDS_FOLDER_EMAIL)

# Option parameters
__WDS_FOLDER_ID= $(if $(WDS_FOLDER_ID), --folder-id $(WDS_FOLDER_ID))

# UI parameters
WDS_UI_VIEW_FOLDERS_FIELDS?=
WDS_UI_VIEW_FOLDERS_SET_FIELDS?= $(WDS_UI_VIEW_FOLDERS_FIELDS)
WDS_UI_VIEW_FOLDERS_SET_SLICE?=

#--- Utilities

#--- MACROS

_wds_get_folder_id= $(call _wds_get_folder_id_N, $(WDS_FOLDER_NAME))
_wds_get_folder_id_N= $(call _wds_get_folder_id_NO, $(1), $(WDS_FOLDER_ORGANIZATION_ID))
_wds_get_folder_id_NO= "$(shell $(AWS) workdocs describe-folders --organization-id $(2) --query "Users[?Username=='$(strip $(1))'].Id" --output text)"

#----------------------------------------------------------------------
# USAGE
#

_wds_view_framework_macros ::
	@echo 'AWS::WorkDocS::User ($(_AWS_WORKDOCS_FOLDER_MK_VERSION)) macros:'
	@echo '    _wds_get_folder_id_{|N|NO}                     - Get the ID of a folder (Name,OrganizationId)'
	@echo

_wds_view_framework_parameters ::
	@echo 'AWS::WorkDocS::User ($(_AWS_WORKDOCS_FOLDER_MK_VERSION)) parameters:'
	@echo '    WDS_FOLDER_ID=$(WDS_FOLDER_ID)'
	@echo '    WDS_FOLDER_NAME=$(WDS_FOLDER_NAME)'
	@echo '    WDS_FOLDERS_SET_NAME=$(WDS_FOLDERS_SET_NAME)'
	@echo

_wds_view_framework_targets ::
	@echo 'AWS::WorkDocS::User ($(_AWS_WORKDOCS_FOLDER_MK_VERSION)) targets:'
	@echo '    _wds_create_folder                           - Create a new folder'
	@echo '    _wds_delete_folder                           - Delete an existing folder'
	@echo '    _wds_show_folder                             - Show everything related to a folder'
	@echo '    _wds_update_folder                           - Update a folder'
	@echo '    _wds_view_folders                            - View folders'
	@echo '    _wds_view_folders_set                        - View a set of folders'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_wds_create_folder:
	@$(INFO) '$(AWS_UI_LABEL)Creating folder "$(WDS_FOLDER_NAME)" ...'; $(NORMAL)
	$(AWS) workdocs create-folder $(__WDS_AUTHENTICATION_TOKEN) $(__WDS_NAME__FOLDER) $(__WDS_PARENT_FOLDER_ID)

_wds_delete_folder:
	@$(INFO) '$(AWS_UI_LABEL)Deleting folder "$(WDS_FOLDER_NAME)" ...'; $(NORMAL)
	$(AWS) workdocs delete-folder $(__WDS_AUTHENTICATION_TOKEN) $(__WDS_FOLDER_ID)

_wds_show_folder: _wds_show_folder_contents

_wds_show_folder_contents:
	@$(INFO) '$(AWS_UI_LABEL)Showing contents of folder "$(WDS_FOLDER_NAME)" ...'; $(NORMAL)
	$(AWS) workdocs describe-folder-contents $(__WDS_AUTHENTICATION_TOKEN) $(__WDS_FOLDER_ID) $(__WDS_INCLUDE) $(__WDS_ORDER) $(__WDS_SORT) $(__WDS_TYPE)

_wds_show_rootfolder:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of folder "$(WDS_FOLDER_NAME)" ...'; $(NORMAL)
	$(AWS) workdocs describe-root-folders $(__WDS_AUTHENTICATION_TOKEN) $(__WDS_LIMIT) $(__WDS_MARKER)

_wds_update_folder:
	@$(INFO) '$(AWS_UI_LABEL)Updating folder "$(WDS_FOLDER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The email address, organization-id, password, foldername cannot be updated!'; $(NORMAL)
	$(AWS) workdocs update-folder $(__WDS_AUTHENTICATION_TOKEN) $(__WDS_GIVEN_NAME) $(__WDS_GRANT_POWERFOLDER_PRIVILEGES) $(__WDS_LOCALE) $(__WDS_STORAGE_RULE) $(__WDS_SURNAME) $(__WDS_TIME_ZONE_ID) $(__WDS_TYPE) $(__WDS_FOLDER_ID)

_wds_view_folders:
	@$(INFO) '$(AWS_UI_LABEL)Viewing folders ...'; $(NORMAL)
	$(AWS) workdocs describe-folders $(__WDS_AUTHENTICATION_TOKEN) $(_X__WDS_FIELDS) $(_X__WDS_INCLUDE) $(_X__WDS_ORDER) $(__WDS_ORGANIZATION_ID) $(_X__WDS_SORT) $(_X__WDS_FOLDER_IDS) $(_X__WDS_FOLDER_QUERY) --query "Users[]$(WDS_UI_VIEW_FOLDERS_FIELDS)"

_wds_view_folders_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing folders-set "$(WDS_FOLDERS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Users are grouped based on the provided folder-ids, organization-id, slice'; $(NORMAL)
	$(AWS) workdocs describe-folders $(__WDS_AUTHENTICATION_TOKEN) $(__WDS_FIELDS) $(__WDS_INCLUDE) $(__WDS_ORDER) $(__WDS_ORGANIZATION_ID) $(__WDS_SORT) $(__WDS_FOLDER_IDS) $(__WDS_FOLDER_QUERY) --query "Users[$(WDS_UI_VIEW_FOLDERS_SET_SLICE)]$(WDS_UI_VIEW_FOLDERS_SET_FIELDS)"
