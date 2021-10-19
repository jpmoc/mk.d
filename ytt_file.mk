_YTT_FILE_MK_VERSION= $(_YTT_MK_VERSION)

# YTT_FILE_NAME?= file.yaml
# YTT_FILE_DIRPATH?= ./in/
# YTT_FILE_FILENAME?= file.yaml
# YTT_FILE_FILEPATH?= ./in/file.yaml
YTT_FILE_OUTPUT_FORMAT?= yaml
# YTT_FILES_DIRPATH?=
# YTT_FILES_FILENAMES?=
# YTT_FILES_FILEPATHS?=
YTT_FILES_REGEX?= *
YTT_FILES_SET_NAME?= files@$(YTT_FILES_DIRPATH)$(YTT_FILES_REGEX)

# Derived parameters
YTT_FILE_DIRPATH?= $(YTT_INPUTS_DIRPATH)
YTT_FILE_FILEPATH?= $(YTT_FILE_DIRPATH)$(YTT_FILE_FILENAME)
YTT_FILE_NAME?= $(notdir $(YTT_FILE_FILEPATH))
YTT_FILES_DIRPATH?= $(YTT_FILE_DIRPATH)
YTT_FILES_FILEPATHS?= $(addprefix $(YTT_FILES_DIRPATH),$(YTT_FILES_FILENAMES))

# Option parameters
__YTT_FILE__FILE= $(if $(YTT_FILE_FILEPATH),--file $(YTT_FILE_FILEPATH))
__YTT_FILE__FILES= $(foreach F, $(YTT_FILES_FILEPATHS),--file $(F))

# Pipe parameters
_YTT_EXPAND_FILE_|?= # cat file.ytt |
_YTT_EXPAND_FILES_|?= # cat file.ytt |
|_YTT_EXPAND_FILE?=
|_YTT_EXPAND_FILES?=

# UI parameters

#--- Utilities

#--- MACROS
_ytt_get_files_filenames= $(call _ytt_get_files_filenames_R, $(YTT_FILES_REGEX) )
_ytt_get_files_filenames_R= $(call _ytt_get_files_filenames_RD, $(1), $(YTT_FILES_DIRPATH))
_ytt_get_files_filenames_RD= $(shell cd $(2) && ls $(1))

#----------------------------------------------------------------------
# USAGE
#

_ytt_view_framework_macros ::
	@echo 'YTT:::File ($(_YTT_FILE_MK_VERSION)) macros:'
	@echo '    _ytt_get_files_filenames_{|R|RD}       - Get the filenames'
	@echo

_ytt_view_framework_parameters ::
	@echo 'YTT:File: ($(_YTT_FILE_MK_VERSION)) parameters:'
	@echo '    YTT_FILE_DIRPATH=$(YTT_FILE_DIRPATH)'
	@echo '    YTT_FILE_FILENAME=$(YTT_FILE_FILENAME)'
	@echo '    YTT_FILE_FILEPATH=$(YTT_FILE_FILEPATH)'
	@echo '    YTT_FILE_NAME=$(YTT_FILE_NAME)'
	@echo '    YTT_FILE_OUTPUT_FORMAT=$(YTT_FILE_OUTPUT_FORMAT)'
	@echo '    YTT_FILES_DIRPATH=$(YTT_FILES_DIRPATH)'
	@echo '    YTT_FILES_FILENAMES=$(YTT_FILES_FILENAMES)'
	@echo '    YTT_FILES_FILEPATHS=$(YTT_FILES_FILEPATHS)'
	@echo '    YTT_FILES_REGEX=$(YTT_FILES_REGEX)'
	@echo '    YTT_FILES_SET_NAME=$(YTT_FILES_SET_NAME)'
	@echo

_ytt_view_framework_targets ::
	@echo 'YTT::File ($(_YTT_FILE_MK_VERSION)) targets:'
	@echo '    _ytt_edit_file                  - Edit a file'
	@echo '    _ytt_expand_file                - Expand a file'
	@echo '    _ytt_show_file                  - Show everything related to a file'
	@echo '    _ytt_show_file_content          - Show content of a file'
	@echo '    _ytt_show_file_description      - Show description of a file'
	@echo '    _ytt_view_files                 - View files'
	@echo '    _ytt_view_files_set             - View set of files'
	@echo


#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ytt_edit_file:
	@$(INFO) '$(YTT_UI_LABEL)Edit file "$(YTT_FILE_NAME)" ...'; $(NORMAL)
	$(EDITOR) $(YTT_FILE_FILEPATH)

_ytt_expand_file:
	@$(INFO) '$(YTT_UI_LABEL)Expanding file "$(YTT_FILE_NAME)" ...'; $(NORMAL)
	$(if $(filter-out -,$(YTT_FILE_FILEPATH)), cat $(YTT_FILE_FILEPATH); echo)
	$(_YTT_EXPAND_FILE_|) $(YTT) $(__YTT_FILE__FILE) $(|_YTT_EXPAND_FILE)

_ytt_expand_files:
	@$(INFO) '$(YTT_UI_LABEL)Expanding files-set "$(YTT_FILES_SET_NAME)" ...'; $(NORMAL)
	$(_YTT_EXPAND_FILES_|) $(YTT) $(__YTT_FILE__FILES) $(|_YTT_EXPAND_FILES)

_ytt_show_file: _ytt_show_file_content _ytt_show_file_description

_ytt_show_file_content:
	@$(INFO) '$(YTT_UI_LABEL)Showing content of file "$(YTT_FILE_NAME)" ...'; $(NORMAL)
	cat $(YTT_FILE_FILEPATH) 

_ytt_show_file_description:
	@$(INFO) '$(YTT_UI_LABEL)Showing content of file "$(YTT_FILE_NAME)" ...'; $(NORMAL)
	ls -al $(YTT_FILE_FILEPATH)

_ytt_view_files:
	@$(INFO) '$(YTT_UI_LABEL)Viewing files ...'; $(NORMAL)
	ls -al $(YTT_FILES_DIRPATH)

_ytt_view_files_set:
	@$(INFO) '$(YTT_UI_LABEL)Viewing files-set "$(YTT_FILES_SET_NAME)" ...'; $(NORMAL)
	ls -al $(YTT_FILES_DIRPATH)$(YTT_FILES_REGEX)
