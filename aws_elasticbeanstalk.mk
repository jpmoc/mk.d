_AWS_ELASTICBEANSTALK_MK_VERSION= 0.99.6

# EBK_CNAME_PREFIX?= my-cname
# EBK_SOLUTIONSTACK_NAME?= 64bit Amazon Linux 2018.03 v2.7.0 running PHP 7.1

# Derived parameters

# Option parameters
__EBK_CNAME_PREFIX= $(if $(EBK_CNAME_PREFIX), --cname-prefix $(EBK_CNAME_PREFIX))

# UI parameters
EBK_UI_VIEW_ACCOUNT_LIMITS_FIELDS?= .{ApplicationVersionQuota:ApplicationVersionQuota.Maximum,ApplicationQuota:ApplicationQuota.Maximum,EnvironmentQuota:EnvironmentQuota.Maximum,ConfigurationTemplateQuota:ConfigurationTemplateQuota.Maximum,CustomPlatformQuota:CustomPlatformQuota.Maximum}

# EBK_UI_VIEW_PLATFORMS_FIELDS?= .{os:OperatingSystemName,platformCategory:PlatformCategory,platformOwner:PlatformOwner,operatingSystemVersion:OperatingSystemVersion,platformStatus:PlatformStatus,PlatformArn:PlatformArn}
EBK_UI_VIEW_PLATFORMS_FIELDS?= .{platformStatus:PlatformStatus,PlatformArn:PlatformArn}
EBK_UI_VIEW_PLATFORMS_SET_FIELDS?= $(EBK_UI_VIEW_PLATFORMS_FIELDS)
EBK_UI_VIEW_PLATFORMS_SET_SLICE?=

EBK_UI_VIEW_SOLUTIONSTACKS_FIELDS?= | @.{SolutionStackName:@}
EBK_UI_VIEW_SOLUTIONSTACKS_SET_FIELDS?= $(EBK_UI_VIEW_SOLUTIONSTACKS_FIELDS)
EBK_UI_VIEW_SOLUTIONSTACKS_SET_SLICE?=

#--- MACROS
_ebk_get_application_fqdn= $(call _ebk_get_application_fqdn_C, $(EBK_CNAME_PREFIX))
_ebk_get_application_fqdn= $(shell echo $(EBK_CNAME_PREFIX).$(AWS_REGION).elasticbeanstalk.com)

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _ebk_view_framework_macros
_ebk_view_framework_macros ::
	@#echo 'AWS::ElasticBeanstalK ($(_AWS_ELASTICBEANSTALK_MK_VERSION)) macros:'
	@#echo

_aws_view_framework_parameters :: _ebk_view_framework_parameters
_ebk_view_framework_parameters ::
	@echo 'AWS::ElasticBeanstalK ($(_AWS_ELASTICBEANSTALK_MK_VERSION)) parameters:'
	@echo '    EBK_CNAME_PREFIX=$(EBK_CNAME_PREFIX)'
	@echo '    EBK_SOLITIONSTACK_NAME=$(EBK_SOLUTIONSTACK_NAME)'
	@echo

_aws_view_framework_targets :: _ebk_view_framework_targets
_ebk_view_framework_targets ::
	@echo 'AWS::ElasticBeanstalK ($(_AWS_ELASTICBEANSTALK_MK_VERSION)) targets:'
	@echo '    _ebk_check_dns_availability      - Check if URL is available'
	@echo '    _ebk_show_account_limits         - Show attributes/limits/quotas of AWS account'
	@echo '    _ebk_show_solutionstack          - Show everything related to a solution-stack'
	@echo '    _ebk_view_platforms              - View supported platforms'
	@echo '    _ebk_view_solutionstacks         - View supported solution-stacks'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/aws_elasticbeanstalk_application.mk
-include $(MK_DIR)/aws_elasticbeanstalk_applicationversion.mk
-include $(MK_DIR)/aws_elasticbeanstalk_environment.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ebk_check_dns_availability:
	@$(INFO) '$(AWS_UI_LABEL)Checking DNS availability ...'; $(NORMAL)
	$(AWS) elasticbeanstalk check-dns-availability $(__EBK_CNAME_PREFIX)

_ebk_show_solutionstack:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of solution-stack ...'; $(NORMAL)
	$(AWS) elasticbeanstalk list-available-solution-stacks --query "SolutionStackDetails[?SolutionStackName=='$(EBK_SOLUTIONSTACK_NAME)']"

_aws_view_account_limits :: _ebk_view_account_limits
_ebk_view_account_limits:
	@$(INFO) '$(AWS_UI_LABEL)Showing attributes/limits/quotas of account "$(AWS_ACCOUNT_ID)" ...'; $(NORMAL)
	$(AWS) elasticbeanstalk describe-account-attributes --query "ResourceQuotas$(EBK_UI_VIEW_ACCOUNT_LIMITS_FIELDS)"

_ebk_view_platforms:
	@$(INFO) '$(AWS_UI_LABEL)Viewing available platforms ...'; $(NORMAL)
	$(AWS) elasticbeanstalk list-platform-versions --query "PlatformSummaryList[]$(EBK_UI_VIEW_PLATFORMS_FIELDS)"

_ebk_view_platforms_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing available platforms ...'; $(NORMAL)
	$(AWS) elasticbeanstalk list-platform-versions --query "PlatformSummaryList[$(EBK_UI_VIEW_PLATFORMS_SET_SLICE)]$(EBK_UI_VIEW_PLATFORMS_SET_FIELDS)"

_ebk_view_solutionstacks:
	@$(INFO) '$(AWS_UI_LABEL)Viewing available solution-stacks ...'; $(NORMAL)
	$(AWS) elasticbeanstalk list-available-solution-stacks --query "SolutionStacks[]$(EBK_UI_VIEW_SOLUTIONSTACKS_FIELDS)"

_ebk_view_solutionstacks_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing solution-stacks-set "$(EBK_SOLUTIONSTACKS_SET_NAME)" ...'; $(NORMAL)
	$(AWS) elasticbeanstalk list-available-solution-stacks --query "SolutionStacks[$(EBK_UI_VIEW_SOLUTIONSTACKS_SET_SLICE)]$(EBK_UI_VIEW_SOLUTIONSTACKS_SET_FIELDS)"
