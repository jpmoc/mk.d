_CRUDINI_FILE_MK_VERSION= $(_CRUDINI_MK_VERSION)

# CII_FILE_FILEPATH?= ./my-ini-file.ini
# CII_FILE_NAME?= my-ini-file.ini
# CII_FILE_PARAMETER_NAME?= parameter-name
# CII_FILE_SECTION_NAME?= section-name

# Derived parameters
CII_FILE_NAME?= $(notdir $(CII_FILE_FILEPATH)) 
CII_FILE_PARAMETER_NAME?= $(CII_PARAMETER_NAME)
CII_FILE_SECTION_NAME?= $(CII_SECTION_NAME)

# Option parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_cii_view_framework_macros ::
	@echo 'CrudInI::File ($(_CRUDINI_FILE_MK_VERSION)) macros:'
	@echo

_cii_view_framework_parameters ::
	@echo 'CrudInI::File ($(_CRUDINI_FILE_MK_VERSION)) parameters:'
	@echo '    CII_FILE_FILEPATH?=$(CII_FILE_FILEPATH)'
	@echo '    CII_FILE_NAME?=$(CII_FILE_NAME)'
	@echo '    CII_FILE_PARAMETER_NAME=$(CII_FILE_PARAMETER_NAME)'
	@echo '    CII_FILE_SECTION_NAME=$(CII_FILE_SECTION_NAME)'
	@echo

_cii_view_framework_targets ::
	@echo 'CrudInI::File ($(_CRUDINI_FILE_MK_VERSION)) targets:'
	@echo '    _cii_show_file                 - show everything related to a file'
	@echo '    _cii_show_file_description     - show description of a file'
	@echo


#-----------------------------------------------------------------------
# PRIVATE TARGETS
#


#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cii_show_file: _cii_show_file_description

_cii_show_file_description:
	@$(INFO) '$(CII_UI_LABEL)Showing description of file "$(CII_FILE_NAME)" ...'; $(NORMAL)
	ls -al $(CII_FILE_FILEPATH)
