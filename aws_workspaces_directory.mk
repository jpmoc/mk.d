_AWS_WORKSPACES_DIRECTORY_MK_VERSION= $(_AWS_WORKSPACES_MK_VERSION)

# WSS_DIRECTORY_ID?= 
# WSS_DIRECTORY_IDS?= 
# WSS_DIRECTORY_NAME?= 
# WSS_DIRECTORIES_SET_NAME?= my-directorys-set

# Derived parameters
WSS_DIRECTORY_IDS?= $(WSS_DIRECTORY_ID)

# Option parameters
__WSS_DIRECTORY_IDS= $(if $(WSS_DIRECTORY_IDS), --directory-ids $(WSS_DIRECTORY_IDS))

# UI parameters
WSS_UI_VIEW_DIRECTORIES_FIELDS?=
WSS_UI_VIEW_DIRECTORIES_SET_FIELDS?= $(WSS_UI_VIEW_DIRECTORIES_FIELDS)
WSS_UI_VIEW_DIRECTORIES_SET_SLICE?=

#--- Utilities

#--- MACROS
WSS_DIRECTORY_NAME__GET?= $(shell echo $(WSS_DIRECTORY_NAME))
_wss_get_directory_id= $(call _wss_get_directory_id_N, $(WSS_DIRECTORY_NAME__GET))
_wss_get_directory_id_N= $(shell $(AWS) workspaces describe-workspace-directories --query "Bundles[?Name=='$(strip $(1))'].DirectoryId" --output text)

WSS_GET_DIRECTORY_IDS_SLICE?=
_wss_get_directory_ids= $(call _wss_get_directory_ids_S, $(WSS_GET_DIRECTORY_IDS_SLICE))
_wss_get_directory_ids_S= $(shell $(AWS) workspaces describe-workspace-directories --query "Bundles[$(strip $(1))].DirectoryId" --output text)

#----------------------------------------------------------------------
# USAGE
#

_wss_view_framework_macros ::
	@echo 'AWS::WorkSpaceS::Directory ($(_AWS_WORKSPACES_DIRECTORY_MK_VERSION)) macros:'
	@echo '    _wss_get_directory_id_{|N}          - Get the ID of a directory (Name)'
	@echo '    _wss_get_directory_ids_{|S}         - Get the IDs of directorys (Slice)'
	@echo

_wss_view_framework_parameters ::
	@echo 'AWS::WorkSpaceS::Directory ($(_AWS_WORKSPACES_DIRECTORY_MK_VERSION)) parameters:'
	@echo '    WSS_DIRECTORY_ID?=$(WSS_DIRECTORY_ID)'
	@echo '    WSS_DIRECTORY_IDS?=$(WSS_DIRECTORY_IDS)'
	@echo '    WSS_DIRECTORY_NAME?=$(WSS_DIRECTORY_NAME)'
	@echo

_wss_view_framework_targets ::
	@echo 'AWS::WorkSpaceS::Directory ($(_AWS_WORKSPACES_DIRECTORY_MK_VERSION)) targets:'
	@echo '    _wss_show_directory                 - Show everything related to a directory'
	@echo '    _wss_view_directories               - View available directories'
	@echo '    _wss_view_directories_set           - View a set of directories'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_wss_show_directory:
	@$(INFO) '$(AWS_UI_LABEL)Showing directory "$(WSS_DIRECTORY_NAME)" ...'; $(NORMAL)
	$(AWS) workspaces describe-workspace-directories $(__WSS_DIRECTORY_IDS) $(_X__WSS_OWNER)

_wss_view_directories:
	@$(INFO) '$(AWS_UI_LABEL)Viewing directories ...'; $(NORMAL)
	$(AWS) workspaces describe-workspace-directories $(_X__WSS_DIRECTORY_IDS) --query "Directories[]$(WSS_UI_VIEW_DIRECTORIES_FIELDS)"

_wss_view_directories_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing directories-set "$(WSS_DIRECTORIES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Directories are grouped based on the provided IDs and/or slice'; $(NORMAL)
	$(AWS) workspaces describe-workspace-directories $(__WSS_DIRECTORY_IDS) --query "Directories[$(WSS_UI_VIEW_DIRECTORIES_SET_SLICE)]$(WSS_UI_VIEW_DIRECTORIES_SET_FIELDS)"
