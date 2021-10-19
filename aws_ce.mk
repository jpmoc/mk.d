_AWS_CE_MK_VERSION= 0.99.6

CE_CONTEXT?= COST_AND_USAGE
# CE_DIMENSION?= INSTANCE_TYPE
# CE_FILTER?=
# CE_GRANULARITY?= MONTHLY
# CE_GROUPBY?= INSTANCE_TYPE
# CE_RESERVATION_ACCOUNT_ID?= 123456789012
CE_RESERVATION_ACCOUNT_SCOPE?= PAYER
# CE_RESERVATION_LOOKBACK_PERIOD?= SIXTY_DAYS
# CE_RESERVATION_PAYMENT_OPTION?= PARTIAL_UPFRONT
# CE_RESERVATION_LIFESPAN?= THREE_YEARS
# CE_RESERVATION_SERVICE_SPECIFICATION?= EC2Specification={OfferingClass=STANDARD}
# CE_SEARCH_STRING?=
# CE_TAG_KEY?=
# CE_TIME_PERIOD?= Start=2018-01-01,End=2018-06-01

# Derived parameters
CE_RESERVATION_ACCOUNT_ID?= $(AWS_ACCOUNT_ID)

# Option parameters
__CE_ACCOUNT_ID= $(if $(CE_RESERVATION_ACCOUNT_ID), --account-id $(CE_RESERVATION_ACCOUNT_ID))
__CE_ACCOUNT_SCOPE= $(if $(CE_RESERVATION_ACCOUNT_SCOPE), --account-scope $(CE_RESERVATION_ACCOUNT_SCOPE))
__CE_CONTEXT= $(if $(CE_CONTEXT), --context $(CE_CONTEXT))
__CE_DIMENSION= $(if $(CE_DIMENSION), --dimension $(CE_DIMENSION))
__CE_FILTER=
__CE_GRANULARITY= $(if $(CE_GRANULARITY), --granularity $(CE_GRANULARITY))
__CE_GROUP_BY= $(if $(CE_GROUPBY), --group-by $(CE_GROUPBY))
__CE_LOOKBACK_PERIOD_IN_DAYS= $(if $(CE_RESERVATION_LOOKBACK_PERIOD), --lookback-period-in-days $(CE_RESERVATION_LOOKBACK_PERIOD))
__CE_METRICS= $(if $(CE_METRICS), --metrics $(CE_METRICS))
__CE_PAYMENT_OPTION= $(if $(CE_RESERVATION_PAYMENT_OPTION), --payment-option $(CE_RESERVATION_PAYMENT_OPTION))
__CE_SEARCH_STRING=
__CE_SERVICE=
__CE_SERVICE_SPECIFICATION= $(if $(CE_RESERVATION_SERVICE_SPECIFICATION), --service-specification $(CE_RESERVATION_SERVICE_SPECIFICATION))
__CE_TAG_KEY=
__CE_TERM_IN_YEARS= $(if $(CE_RESERVATION_LIFESPAN), --term-in-years $(CE_RESERVATION_LIFESPAN))
__CE_TIME_PERIOD= $(if $(CE_TIME_PERIOD), --time-period $(CE_TIME_PERIOD))

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _ce_view_framework_macros
_ce_view_framework_macros ::
	@#echo 'AWS::CE ($(_AWS_CE_MK_VERSION)) macros:'
	@#echo

_aws_view_framework_parameters :: _ce_view_framework_parameters
_ce_view_framework_parameters ::
	@echo 'AWS::CE ($(_AWS_CE_MK_VERSION)) parameters:'
	@echo '    CE_CONTEXT=$(CE_CONTEXT)'
	@echo '    CE_DIMENSION=$(CE_DIMENSION)'
	@echo '    CE_GRANULARITY=$(CE_GRANULARITY)'
	@echo '    CE_GROUPBY=$(CE_GROUPBY)'
	@echo '    CE_RESERVATION_ACCOUNT_ID=$(CE_RESERVATION_ACCOUNT_ID)'
	@echo '    CE_RESERVATION_ACCOUNT_SCOPE=$(CE_RESERVATION_ACCOUNT_SCOPE)'
	@echo '    CE_RESERVATION_LIFESPAN=$(CE_RESERVATION_LIFESPAN)'
	@echo '    CE_RESERVATION_LOOKBACK_PERIOD=$(CE_RESERVATION_LOOKBACK_PERIOD)'
	@echo '    CE_RESERVATION_PAYMENT_OPTION=$(CE_RESERVATION_PAYMENT_OPTION)'
	@echo '    CE_RESERVATION_SERVICE_SPECIFICATION=$(CE_RESERVATION_SERVICE_SPECIFICATION)'
	@echo '    CE_SEARCH_STRING=$(CE_SEARCH_STRING)'
	@echo '    CE_TAG_KEY=$(CE_TAG_KEY)'
	@echo '    CE_TIME_PERIOD=$(CE_TIME_PERIOD)'
	@echo

_aws_view_framework_targets :: _ce_view_framework_targets
_ce_view_framework_targets ::
	@echo 'AWS::CE ($(_AWS_CE_MK_VERSION)) targets:'
	@echo '    _ce_show_costandusage                       - Show cost and resource usage'
	@echo '    _ce_show_dimensionvalues                    - Show dimension-values'
	@echo '    _ce_show_reservation                        - Show everythin related to reservations'
	@echo '    _ce_show_reservation_coverage               - Show reservation-coverage'
	@echo '    _ce_show_reservation_recommendedpurchase    - Recommend a purchase of R I'
	@echo '    _ce_show_reservation_utilization            - Show reservation-coverage'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ce_show_costandusage:
	@$(INFO) '$(AWS_UI_LABEL)Showing cost-and-usage ...'; $(NORMAL)
	$(AWS) ce get-cost-and-usage $(__CE_FILTER) $(__CE_GRANULARITY) $(__CE_GROUP_BY) $(__CE_METRICS) $(__CE_TIME_PERIOD)

_ce_show_dimensionvalues:
	@$(INFO) '$(AWS_UI_LABEL)Showing dimension-values ...'; $(NORMAL)
	$(AWS) ce get-dimension-values $(__CE_CONTEXT) $(__CE_DIMENSION) $(__CE_SEARCH_STRING) $(__CE_TIME_PERIOD)

_ce_show_reservation: _ce_show_reservation_coverage _ce_show_reservation_recommandedpurchase _ce_show_reservation_utilization

_ce_show_reservation_coverage:
	@$(INFO) '$(AWS_UI_LABEL)Showing reservation-coverage ...'; $(NORMAL)
	$(AWS) ce get-reservation-coverage $(__CE_FILTER) $(__CE_GRANULARITY) $(__CE_GROUP_BY) $(__CE_TIME_PERIOD)

_ce_show_reservation_recommendedpurchase:
	@$(INFO) '$(AWS_UI_LABEL)Recommending purchase for reservation-coverage ...'; $(NORMAL)
	$(AWS) ce get-reservation-purchase-recommendation $(__CE_ACCOUNT_ID) $(__CE_ACCOUNT_SCOPE) $(__CE_LOOKBACK_PERIOD_IN_DAYS) $(__CE_PAYMENT_OPTION) $(__CE_SERVICE) $(__CE_SERVICE_SPECIFICATION) $(__CE_TERM_IN_YEARS)

_ce_show_reservation_utilization:
	@$(INFO) '$(AWS_UI_LABEL)Showing reservation-utilization ...'; $(NORMAL)
	$(AWS) ce get-reservation-utilization $(__CE_FILTER) $(__CE_GRANULARITY) $(__CE_GROUP_BY) $(__CE_TIME_PERIOD)

_ce_show_tags:
	@$(INFO) '$(AWS_UI_LABEL)Showing tags ...'; $(NORMAL)
	$(AWS) ce get-tags $(__CE_SEARCH_STRING) $(__CE_TAG_KEY) $(__CE_GROUP_BY) $(__CE_TIME_PERIOD)

