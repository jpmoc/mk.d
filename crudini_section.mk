_CRUDINI_SECTION_MK_VERSION= $(_CRUDINI_MK_VERSION)

# CII_SECTION_FILE_FILEPATH?= ./my-ini-file.ini
# CII_SECTION_FILE_NAME?= ./my-ini-file.ini
# CII_SECTION_NAME?= section-name
# CII_SECTION_PARAMETER_NAME?= parameter-name

# Derived parameters
CII_SECTION_FILE_FILEPATH?=$(CII_FILE_FILEPATH)
CII_SECTION_FILE_NAME?=$(CII_FILE_NAME)
CII_SECTION_PARAMETER_NAME?=$(CII_PARAMETER_NAME)

# Option parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_cii_view_framework_macros ::
	@echo 'CrudInI::Section ($(_CRUDINI_SECTION_MK_VERSION)) macros:'
	@echo

_cii_view_framework_parameters ::
	@echo 'CrudInI::Section ($(_CRUDINI_SECTION_MK_VERSION)) parameters:'
	@echo '    CII_SECTION_FILE_FILEPATH=$(CII_SECTION_FILE_FILEPATH)'
	@echo '    CII_SECTION_FILE_NAME=$(CII_SECTION_FILE_NAME)'
	@echo '    CII_SECTION_NAME=$(CII_SECTION_NAME)'
	@echo '    CII_SECTION_PARAMETER_NAME=$(CII_SECTION_PARAMETER_NAME)'
	@echo

_cii_view_framework_targets ::
	@echo 'CrudInI::Section ($(_CRUDINI_SECTION_MK_VERSION)) targets:'
	@echo '    _cii_delete_section               - delete a section'
	@echo '    _cii_show_section                 - show everything related to a section'
	@echo '    _cii_show_section_parameters      - show parameters of a section'
	@echo '    _cii_view_sections                - view sections'
	@echo


#-----------------------------------------------------------------------
# PRIVATE TARGETS
#


#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cii_delete_section:
	@$(INFO) '$(CII_UI_LABEL)Deleting section "$(CII_SECTION_NAME)" ...'; $(NORMAL)
	$(CRUDINI) delete $(CII_SECTION_FILE_FILEPATH) $(CII_SECTION_NAME)

_cii_show_section: _cii_show_secton_parameters _cii_show_section_description

_cii_show_section_description:
	@$(INFO) '$(CII_UI_LABEL)Showing description of section "$(CII_SECTION_NAME)" ...'; $(NORMAL)

_cii_show_section_parameters:
	@$(INFO) '$(CII_UI_LABEL)Showing parameters of section "$(CII_SECTION_NAME)" ...'; $(NORMAL)A
	$(CRUDINI)  get $(CII_SECTION_FILE_FILEPATH) $(CII_SECTION_NAME)

_cii_view_sections:
	@$(INFO) '$(CII_UI_LABEL)Viewing section ...'; $(NORMAL)
	$(CRUDINI) get $(CII_FILE_FILEPATH) $(CII_FILE_SECTION_NAME) $(CII_FILE_PARAMETER_NAME)

