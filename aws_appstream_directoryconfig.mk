_AWS_APPSTREAM_DIRECTORYCONFIG_MK_VERSION= $(_AWS_APPSTREAM_MK_VERSION)

# ASM_DIRECTORYCONFIG_DIRECTORY_NAME?= 
# ASM_DIRECTORYCONFIG_DIRECTORY_NAMES?= 
# ASM_DIRECTORYCONFIGS_SET_NAME?= 

# Derived parameters
ASM_DIRECTORYCONFIG_DIRECTORY_NAMES?= $(ASM_DIRECTORYCONFIG_DIRECTORY_NAME)

# Option parameters
__ASM_DIRECTORY_NAMES= $(if $(ASM_DIRECTORY_NAMES), --directory-names $(ASM_DIRECTORY_NAMES))

# UI parameters
ASM_UI_VIEW_DIRECTORYCONFIGS__FIELDS?=
ASM_UI_VIEW_DIRECTORYCONFIGS_SET_FIELDS?= $(ASM_UI_VIEW_DIRECTORYCONFIGS_FIELDS)
ASM_UI_VIEW_DIRECTORYCONDIGS_SET_SLICE?=

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_asm_view_framework_macros ::
	@echo 'AWS::AppStreaM::DirectoryConfig ($(_AWS_APPSTREAM_DIRECTORYCONFIG_MK_VERSION)) macros:'
	@echo

_asm_view_framework_parameters ::
	@echo 'AWS::AppStreaM::DirectoryConfig ($(_AWS_APPSTREAM_DIRECTORYCONFIG_MK_VERSION)) parameters:'
	@echo '    ASM_DIRECTORYCONFIG_DIRECTORY_NAME=$(ASM_DIRECTORYCONFIG_DIRECTORY_NAME)'
	@echo '    ASM_DIRECTORYCONFIG_DIRECTORY_NAMES=$(ASM_DIRECTORYCONFIG_DIRECTORY_NAMES)'
	@echo '    ASM_DIRECTORYCONFIGS_SET_NAME=$(ASM_DIRECTORYCONFIGS_SET_NAME)'
	@echo

_asm_view_framework_targets ::
	@echo 'AWS::AppStreaM::DirectoryConfig ($(_AWS_APPSTREAM_DIRECTORYCONFIG_MK_VERSION)) targets:'A
	@echo '    _asm_create_directoryconfig               - Create a new directory-config'
	@echo '    _asm_delete_directoryconfig               - Delete an existing directory-config'
	@echo '    _asm_show_directoryconfig                 - Show everything related to a directory-config'
	@echo '    _asm_view_directoryconfigs                - View directory-configs'
	@echo '    _asm_view_directoryconfigs_set            - View a set of directory-configs'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_asm_create_directoryconfig:

_asm_delete_directoryconfig:

_asm_show_directoryconfig:

_asm_view_directoryconfigs:
	@$(INFO) '$(AWS_UI_LABEL)Viewing directory-configs ...'; $(NORMAL)
	$(AWS) appstream describe-directory-configs $(_X__ASM_DIRECTORY_NAMES) # --query "DirectoryConfigs[]$(ASM_UI_VIEW_DIRECTORYCONFIGS_FIELDS)"

_asm_view_directoryconfigs_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing directory-configs-set "$(ASM_DIRECTORYCONFIGS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Directory-configs are grouped based on the provided directory-names and/or slice'; $(NORMAL)
	$(AWS) appstream describe-directory-configs $(__ASM_DIRECTORY_NAMES) # --query "DirectoryConfigs[$(ASM_UI_VIEW_DIRECTORYCONFIGS_SET_SLICE)]$(ASM_UI_VIEW_DIRECTORYCONFIGS_SET_FIELDS)"
