_AWS_INSPECTOR_TARGET_MK_VERSION= $(_AWS_INSPECTOR_MK_VERSION)

# RDS_TARGET_DESCRIPTION?= "This is my description"

# Derived variables

# Options variables
__IPR_FILTER_TARGET=

# UI variables

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_ipr_view_makefile_macros ::
	@#echo 'AWS::InsPectoR::Target ($(_AWS_INSPECTOR_TARGET_MK_VERSION)) macros:'
	@#echo

_ipr_view_makefile_targets ::
	@echo 'AWS::InsPectoR::Target ($(_AWS_INSPECTOR_TARGET_MK_VERSION)) targets:'
	@echo '    _ipr_view_targets                       - View assessment targets'
	@echo

_ipr_view_makefile_variables ::
	@echo 'AWS::InsPectoR::Target ($(_AWS_INSPECTOR_TARGET_MK_VERSION)) variables:'
	@echo '    RDS_TARGET_TAGS=$(RDS_TARGET_TAGS)'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ipr_view_targets:
	@$(INFO) '$(AWS_UI_LABEL)Viewing assessment-targets ...'; $(NORMAL)
	$(AWS) inspector list-assessment-targets $(__IPR_FILTER_TARGET) --query "assessmentTargetArns[]"
