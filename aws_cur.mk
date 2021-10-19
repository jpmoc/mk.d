_AWS_CUR_MK_VERSION= 0.99.6

# CUR_ENDPOINT_URL?= https://cur.us-east-1.amazonaws.com/
# CUR_REPORTDEFINITION?=
# CUR_REPORTDEFINITION_FILEPATH?= ./report-definition.json
# CUR_REPORTDEFINITION_NAME?= my-report-definition
# CUR_REPORT_NAME?= my-report

# Derived parameters
CUR_ENDPOINT_URL?= https://cur.$(AWS_REGION).amazonaws.com/
CUR_REPORTDEFINITION?= $(if $(CUR_REPORTDEFINITION_FILEPATH),file://$(CUR_REPORTDEFINITION_FILEPATH))
CUR_REPORTDEFINITION_NAME?= $(CUR_REPORT_NAME)

# Option parameters
__CUR_REPORT_DEFINITION?= $(if $(CUR_REPORTDEFINITION), --report-definition $(CUR_REPORTDEFINITION))
__CUR_REPORT_NAME?= $(if $(CUR_REPORT_NAME), --report-name $(CUR_REPORT_NAME))

# UI parameters
CUR_UI_SHOW_REPORTDEFINITION_FIELDS?=
CUR_UI_VIEW_REPORTDEFINITIONS_FIELDS?= .{ReportName:ReportName,compression:Compression,format:Format,s3Bucket:S3Bucket,s3Prefix:S3Prefix,s3Region:S3Region,timeUnit:TimeUnit}

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _cur_view_framework_macros
_cur_view_framework_macros ::
	@#echo 'AWS::CUR ($(_AWS_CUR_MK_VERSION)) macros:'
	@#echo

_aws_view_framework_parameters :: _cur_view_framework_parameters
_cur_view_framework_parameters ::
	@echo 'AWS::CUR ($(_AWS_CUR_MK_VERSION)) parameters:'
	@echo '    CUR_ENDPOINT_URL=$(CUR_ENDPOINT_URL)'
	@echo '    CUR_REPORT_DEFINITION=$(CUR_REPORT_DEFINITION)'
	@echo '    CUR_REPORT_DEFINITION_FILEPATH=$(CUR_REPORT_DEFINITION_FILEPATH)'
	@echo '    CUR_REPORT_NAME=$(CUR_REPORT_NAME)'
	@echo

_aws_view_framework_targets :: _cur_view_framework_targets
_cur_view_framework_targets ::
	@echo 'AWS::CUR ($(_AWS_CUR_MK_VERSION)) targets:'
	@echo '    _cur_create_reportdefinition               - Create a new report-definition'
	@echo '    _cur_delete_reportdefinition               - Delete an existing report-definition'
	@echo '    _cur_show_reportdefinition                 - Show a report-definition'
	@echo '    _cur_view_reportdefinition                 - View report-definitions'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cur_create_reportdefinition:
	@$(INFO) '$(AWS_UI_LABEL)Creating a report-definition ...'; $(NORMAL)
	$(if $(CUR_REPORTDEFINITION_FILEPATH), cat $(CUR_REPORTDEFINITION_FILEPATH))
	$(AWS) cur put-report-definition $(__CUR_REPORT_DEFINITION)

_cur_delete_reportdefinition:
	@$(INFO) '$(AWS_UI_LABEL)Deleting report-definition "$(CUR_REPORTDEFINITION_NAME)" ...'; $(NORMAL)
	$(AWS) cur delete-report-definition $(__CUR_REPORT_NAME)

_cur_show_reportdefinition:
	@$(INFO) '$(AWS_UI_LABEL)Showing report-definitions "$(CUR_REPORTDEFINITION_NAME)" ...'; $(NORMAL)
	$(AWS) cur describe-report-definitions --query "ReportDefinitions[?ReportName=='$(CUR_REPORT_NAME)']$(CUR_UI_SHOW_REPORTDEFINITION_FIELDS)"

_cur_view_reportdefinitions:
	@$(INFO) '$(AWS_UI_LABEL)Viewing report-definitions ...'; $(NORMAL)
	$(AWS) cur describe-report-definitions --query "ReportDefinitions[]$(CUR_UI_VIEW_REPORTDEFINITIONS_FIELDS)"
