_AWS_ROUTE53_HEALTHCHECK_MK_VERSION= $(_AWS_ROUTE53_MK_VERSION)

# R53_HEALTHCHECK_CONFIG?= file://./in/create-health-check.json
# R53_HEALTHCHECK_CONFIG_DIRPATH?= ./in/
# R53_HEALTHCHECK_CONFIG_FILENAME?= create-health-check.json
# R53_HEALTHCHECK_CONFIG_FILEPATH?= ./in/create-health-check.json
# R53_HEALTHCHECK_ID?= 02ec8401-9879-4259-91fa-04e66d094674
# R53_HEALTHCHECK_NAME?=i my-healthcheck

# Derived parameters
R53_HEALTHCHECK_CONFIG?= file://$(R53_HEALTHCHECK_CONFIG_FILEPATH)
R53_HEALTHCHECK_CONFIG_FILEPATH?= $(R53_HEALTHCHECK_CONFIG_DIRPATH)$(R53_HEALTHCHECK_CONFIG_FILENAME)

# Options
__R53_HEALTH_CHECK_CONFIG= $(if $(R53_HEALTHCHECK_CONFIG),--health-check-config $(R53_HEALTHCHECK_CONFIG))
__R53_HEALTH_CHECK_ID= $(if $(R53_HEALTHCHECK_ID),--health-check-id $(R53_HEALTHCHECK_ID))
__R53_FILTER__HEALTHCHECKS= $(if $(R53_HEALTHCHECKS_FILTER),--filter $(R53_HEALTHCHECKS_FILTER))

# Customizations
_R53_SHOW_HEALTHCHECK_STATUS_FIELDS?= .[StatusReport.CheckedTime,StatusReport.Status,IPAddress]
_R53_SHOW_HEALTHCHECK_FIELDS?= .[Id,HealthCheckConfig.IPAddress,HealthCheckConfig.Type,HealthCheckConfig.Port]

#--- Macro

#----------------------------------------------------------------------
# USAGE
#

_r53_list_macros ::
	@#echo 'AWS::Route53::HealthCheck ($(_AWS_ROUTE53_HEALTHCHECK_MK_VERSION)) macros:'
	@#echo

_r53_list_parameters ::
	@echo 'AWS::Route53::HealthCheck ($(_AWS_ROUTE53_HEALTHCHECK_MK_VERSION)) parameters:'
	@echo '    R53_HEALTHCHECK_CONFIG=$(R53_HEALTHCHECK_CONFIG)'
	@echo '    R53_HEALTHCHECK_CONFIG_DIRPATH=$(R53_HEALTHCHECK_CONFIG_DIRPATH)'
	@echo '    R53_HEALTHCHECK_CONFIG_FILENAME=$(R53_HEALTHCHECK_CONFIG_FILENAME)'
	@echo '    R53_HEALTHCHECK_CONFIG_FILEPATH=$(R53_HEALTHCHECK_CONFIG_FILEPATH)'
	@echo '    R53_HEALTHCHECK_ID=$(R53_HEALTHCHECK_ID)'
	@echo '    R53_HEALTHCHECK_NAME=$(R53_HEALTHCHECK_NAME)'
	@echo '    R53_HEALTHCHECKS_FILTER=$(R53_HEALTHCHECKS_FILTER)'
	@echo '    R53_HEALTHCHECKS_SET_NAME=$(R53_HEALTHCHECKS_SET_NAME)'
	@echo

_r53_list_targets ::
	@echo 'AWS::Route53::HealthCheck ($(_AWS_ROUTE53_HEALTHCHECK_MK_VERSION)) targets:'
	@echo '    _r53_create_healthcheck             - Create a health-check'
	@echo '    _r53_delete_healthcheck             - Delete a health-check'
	@echo '    _r53_list_healthchecks              - List all health-checks'
	@echo '    _r53_list_healthcheck_set           - List a set of health-checks'
	@echo '    _r53_show_healthcheck               - Show everything related to a health-check'
	@echo '    _r53_show_healthcheck_description   - Show the description of a health-check'
	@echo '    _r53_show_healthcheck_status        - Show the status of a helth-check'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_r53_create_healthcheck:
	@$(INFO) '$(R53_UI_LABEL)Creating health-check "$(R53_HEALTHCHECK_NAME)" ...'; $(NORMAL)
	$(AWS) route53 create-health-check $(__R53_CALLER_REFERENCE) $(__R53_HEALTH_CHECK_CONFIG)

_r53_delete_healthcheck:
	@$(INFO) '$(R53_UI_LABEL)Deleting health-check "$(R53_HEALTHCHECK_NAME)" ...'; $(NORMAL)

_r53_list_healthchecks:
	@$(INFO) '$(R53_UI_LABEL)Listing ALL health-checks ...'; $(NORMAL)
	$(AWS) route53 list-health-checks $(_X__R53_FILTER__HEALTHCHECKS) --query "HealthChecks[]$(_R53_LIST_HEALTHCHECKS_FIELDS)"

_r53_list_healthchecks_set:
	@$(INFO) '$(R53_UI_LABEL)Listing ALL health-checks ...'; $(NORMAL)
	$(AWS) route53 list-health-checks $(__R53_FILTER__HEALTHCHECKS) --query "HealthChecks[]$(_R53_LIST_HEALTHCHECKS_FIELDS)"

_R53_SHOW_HEALTHCHECK_TARGETS?= _r53_show_healthcheck_status _r53_show_healthcheck_description
_r53_show_healthcheck: $(_R53_SHOW_HEALTHCHECK_TARGETS)

_r53_show_healthcheck_description:
	@$(INFO) '$(R53_UI_LABEL)Showing description of health-check "$(R53_HEALTHCHECK_NAME)" ...'; $(NORMAL)
	$(AWS) route53 get-health-check $(__R53_HEALTH_CHECK_ID)

_r53_show_healthcheck_status:
	@$(INFO) '$(R53_UI_LABEL)Showing the status of "$(R53_HEALTHCHECK_NAME)" ...'; $(NORMAL)
	$(AWS)  route53 get-health-check-status $(__R53_HEALTH_CHECK_ID) --query "HealthCheckObservations[]$(_R53_SHOW_HEALTHCHECK_STATUS_FIELDS)"

_r53_get_health_checks_count:
	$(AWS) route53 get-health-check-count
