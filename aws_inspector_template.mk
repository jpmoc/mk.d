_AWS_INSPECTOR_TEMPLATE_MK_VERSION= $(_AWS_INSPECTOR_MK_VERSION)

# IPR_TEMPLATE_ARNS?= arn:aws:inspector:us-west-2:123456789012:target/0-5SCarW2G/template/0-EqxQPYYm ...

# Derived variables

# Options variables
__IPR_ASSESSMENT_TEMPLATE_ARNS=
__IPR_FILTER_TEMPLATE=

# UI variables

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_ipr_view_makefile_macros ::
	@#echo 'AWS::InsPectoR::Template ($(_AWS_INSPECTOR_TEMPLATE_MK_VERSION)) macros:'
	@#echo

_ipr_view_makefile_targets ::
	@echo 'AWS::InsPectoR::Template ($(_AWS_INSPECTOR_TEMPLATE_MK_VERSION)) targets:'
	@echo '    _ipr_view_targets                       - View assessment targets'
	@echo

_ipr_view_makefile_variables ::
	@echo 'AWS::InsPectoR::Template ($(_AWS_INSPECTOR_TEMPLATE_MK_VERSION)) variables:'
	@echo '    RDS_TEMPLATE_TAGS=$(RDS_TEMPLATE_TAGS)'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#


_ipr_show_template:
	@$(INFO) '$(AWS_UI_LABEL)Showing assessment-template ...'; $(NORMAL)
	$(AWS) inspector describe-assessment-templates $(__IPR_ASSESSMENT_TEMPLATE_ARNS)

_ipr_view_templates:
	@$(INFO) '$(AWS_UI_LABEL)Viewing assessment-templates ...'; $(NORMAL)
	$(AWS) inspector list-assessment-templates $(__IPR_FILTER_TEMPLATE) --query "assessmentTemplateArns[]"
