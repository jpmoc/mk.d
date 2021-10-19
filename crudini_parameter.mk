_CRUDINI_PARAMETER_MK_VERSION= $(_CRUDINI_MK_VERSION)

# CII_PARAMETER_FILE_NAME?= ./my-ini-file.ini
# CII_PARAMETER_NAME?= parameter-name
# CII_PARAMETER_SECTION_NAME?= section-name
# CII_PARAMETER_VALUE?= value

# Derived parameters
CII_PARAMETER_FILE_FILEPATH?=$(CII_FILE_FILEPATH)
CII_PARAMETER_FILE_NAME?=$(CII_FILE_NAME)
CII_PARAMETER_SECTION_NAME?=$(CII_SECTION_NAME)

# Option parameters

# UI parameters

#--- Utilities

#--- MACROS

_cii_get_parameter_value= $(call _cii_get_parameter_value, $(CII_PARAMETER_NAME))
_cii_get_parameter_value_N= $(call _cii_get_parameter_value_NS, $(1), $(CII_PARAMETER_SECTION_NAME))
_cii_get_parameter_value_NS= $(call _cii_get_parameter_value_NSF, $(1), $(2), $(CII_PARAMETER_FILE_FILEPATH))
_cii_get_parameter_value_NSF= $(shell $(CRUDINI) --get $(3) $(2) $(1))

#----------------------------------------------------------------------
# USAGE
#

_cii_view_framework_macros ::
	@echo 'CrudInI::Parameter ($(_CRUDINI_PARAMETER_MK_VERSION)) macros:'
	@echo '    _cii_get_parameter_value_{|N|NS|NSF}     - get the value of a parameter (Name,Section,Filepath)'
	@echo

_cii_view_framework_parameters ::
	@echo 'CrudInI::Parameter ($(_CRUDINI_PARAMETER_MK_VERSION)) parameters:'
	@echo '    CII_PARAMETER_FILE_NAME=$(CII_PARAMETER_FILE_NAME)'
	@echo '    CII_PARAMETER_NAME=$(CII_PARAMETER_NAME)'
	@echo '    CII_PARAMETER_SECTION_NAME=$(CII_PARAMETER_SECTION_NAME)'
	@echo '    CII_PARAMETER_VALUE=$(CII_PARAMETER_VALUE)'
	@echo

_cii_view_framework_targets ::
	@echo 'CrudInI::Parameter ($(_CRUDINI_PARAMETER_MK_VERSION)) targets:'
	@echo '    _cii_create_parameter             - create a parameter'
	@echo '    _cii_delete_parameter             - delete a parameter'
	@echo '    _cii_get_parameter_value          - get value of a parameter'
	@echo '    _cii_update_parameter             - update a parameter'
	@echo


#-----------------------------------------------------------------------
# PRIVATE TARGETS
#


#-----------------------------------------------------------------------
# PUBLIC TARGETS
#


_cii_create_parameter:
	@$(INFO) '$(CII_UI_LABEL)Creating  of parameter "$(CII_PARAMETER_NAME)" ...'; $(NORMAL)
	$(CRUDINI) --set $(CII_PARAMETER_FILE_FILEPATH) $(CII_PARAMETER_SECTION_NAME) $(CII_PARAMETER_NAME)

_cii_delete_parameter:
	@$(INFO) '$(CII_UI_LABEL)Deleting  of parameter "$(CII_PARAMETER_NAME)" ...'; $(NORMAL)
	$(CRUDINI) --get $(CII_PARAMETER_FILE_FILEPATH) $(CII_PARAMETER_SECTION_NAME) $(CII_PARAMETER_NAME)

_cii_get_parameter_value:
	@$(INFO) '$(CII_UI_LABEL)Getting value of parameter "$(CII_PARAMETER_NAME)" ...'; $(NORMAL)
	$(CRUDINI) --get $(CII_PARAMETER_FILE_FILEPATH) $(CII_PARAMETER_SECTION_NAME) $(CII_PARAMETER_NAME)

_cci_update_parameter: _cii_create_parameter
