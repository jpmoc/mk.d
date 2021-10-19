_AWS_ROUTE53_MK_VERSION=0.99.3

# R53_HEALTH_CHECK_CONFIG?=file://C:\awscli\route53\create-health-check.json
# R53_HEALTH_CHECK_ID?=02ec8401-9879-4259-91fa-04e66d094674

__HEALTH_CHECK_CONFIG= $(if $(R53_HEALTH_CHECK_CONFIG), --health-check-config $(R53_HEALTH_CHECK_CONFIG))
__HEALTH_CHECK_ID= $(if $(R53_HEALTH_CHECK_ID), --health-check-id $(R53_HEALTH_CHECK_ID))

# Environment

# Computed parameters 

#--- Macro
get_hosted_zone_id=$(call get_hosted_zone_id_H, $(R53_HOSTED_ZONE))
get_hosted_zone_id_H=$(shell $(AWS) route53 list-hosted-zones --query 'HostedZones[?Name==`$(1).`].[Id]' --output text | sed s_/hostedzone/__)
get_hosted_zone_id_HD=$(if $(1),$(shell $(AWS) route53 list-hosted-zones --query 'HostedZones[?Name==`$(1).`].[Id]' --output text | sed s_/hostedzone/__),$(2))


DESCRIBE_HEALTH_CHECKS_FIELDS?=.[Id,HealthCheckConfig.IPAddress,HealthCheckConfig.Type,HealthCheckConfig.Port]
VIEW_HEALTH_CHECK_STATUS_FIELDS?=.[StatusReport.CheckedTime,StatusReport.Status,IPAddress]

#----------------------------------------------------------------------
# USAGE
#

_aws_view_makefile_macros :: _r53_view_makefile_macros
_r53_view_makefile_macros:
	@echo "AWS::Route53 ($(_AWS_ROUTE53_MK_VERSION)) macros:"
	@echo


_aws_view_makefile_targets :: _r53_view_makefile_targets
_r53_view_makefile_targets:
	@echo "AWS::Route53 ($(_AWS_ROUTE53_MK_VERSION)) targets:"
	@echo "    _r53_create_health_check            - Create a health check"
	@echo "    _r53_decribe_health_checks          - Describe health check"
	@echo "    _r53_get_health_check               - Get health check"
	@echo "    _r53_get_health_check_status        - Get health check status"
	@echo "    _r53_get_health_check_count         - Get the number of health checks in the account"
	@echo

_aws_view_makefile_variables :: _r53_view_makefile_variables
_r53_view_makefile_variables:
	@echo "AWS::Route53 ($(_AWS_ROUTE53_MK_VERSION)) variables:"
	@echo "    R53_HEALTH_CHECK_CONFIG=$(R53_HEALTH_CHECK_CONFIG)"
	@echo "    R53_HEALTH_CHECK_ID=$(R53_HEALTH_CHECK_ID)"
	@echo


#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_r53_create_health_check:
	$(AWS) route53 create-health-check $(__CALLER_REFERENCE) $(__HEALTH_CHECK_CONFIG)

_r53_describe_health_check:
	@$(INFO) "$(AWS_LABEL)Describing health check $(R53_HEALTH_CHECK_ID) ..."; $(NORMAL)
	$(AWS) route53 get-health-check $(__HEALTH_CHECK_ID)

_r53_describe_health_checks: __QUERY?= --query "HealthChecks[]$(DESCRIBE_HEALTH_CHECKS_FIELDS)"
_r53_describe_health_checks:
	@$(INFO) "$(AWS_LABEL)Listing all health checks ..."; $(NORMAL)
	$(AWS) route53 list-health-checks $(__FILTER) $(__QUERY)

_r53_get_health_check_status: __QUERY?=--query "HealthCheckObservations[]$(VIEW_HEALTH_CHECK_STATUS_FIELDS)"
_r53_get_health_check_status:
	@$(INFO) "$(AWS_LABEL)Reporting on the status of $(R53_HEALTH_CHECK_ID) ..."; $(NORMAL)
	$(AWS)  route53 get-health-check-status $(__HEALTH_CHECK_ID) $(__QUERY)

_r53_get_health_checks_count:
	$(AWS) route53 get-health-check-count
