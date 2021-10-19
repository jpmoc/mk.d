_AWS_SUPPORT_CASE_MK_VERSION=$(_AWS_SUPPORT_MK_VERSION)

# SPT_CASE_ID?= 6091024271 

# Derived variables

# Options variables
__SPT_CASE_ID= $(if $(SPT_CASE_ID),--case-id $(SPT_CASE_ID))

# UI variables

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_spt_view_makefile_macros ::
	@echo 'AWS::SuPporT::Case ($(_AWS_SUPPORT_CASE_MK_VERSION)) macros:'
	@echo

_spt_view_makefile_targets ::
	@echo 'AWS::SuPporT::Case ($(_AWS_SUPPORT_CASE_MK_VERSION)) targets:'
	@echo '    _spt_view_cases            - View existing cases'
	@echo 

_spt_view_makefile_variables ::
	@echo 'AWS::SuPporT::Case ($(_AWS_SUPPORT_CASE_MK_VERSION)) variables:'
	@echo '    _spt_create_case                   - Create a new case'
	@echo '    _spt_resolve_case                  - Resolve a case'
	@echo '    _spt_show_case                     - Show everything related to a case'
	@echo '    _spt_show_case_communications      - Show communications excahnged in a case'
	@echo '    _spt_view_cases                    - View all the open cases'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_spt_create_case:
	@$(INFO) '$(AWS_UI_LABEL)Creating a new case ...'; $(NORMAL)

_spt_resolve_case:
	@$(INFO) '$(AWS_UI_LABEL)Resolving case ...'; $(NORMAL)

_spt_show_case: _spt_show_case_attachment _spt_show_case_communications

_spt_show_case_attachment:

_spt_show_case_communications:
	@$(INFO) '$(AWS_UI_LABEL)Showing communication in case ...'; $(NORMAL)
	$(AWS) support describe-communications $(__SPT_CASE_ID)

_spt_view_cases:
	@$(INFO) '$(AWS_UI_LABEL)Viewing cases ...'; $(NORMAL)
	$(AWS) support describe-cases $(__SPT_AFTER_TIME) $(__SPT_BEFORE_TIME) $(__SPT_CASE_ID_LIST) $(__SPT_DISPLAY_ID) $(__SPT_INCLUDE_COMMUNICATION) $(__SPT_INCLUDE_RESOLVED_CASS) $(__SPT_LANGUAGE)
