_AWS_PI_MK_VERSION= 0.99.6

# PI_DIMENSIONKEYS_IDENTIFIER?=

# Derived parameters

# Option parameters
__PI_END_TIME=
__PI_FILTER=
__PI_GROUP_BY=
__PI_IDENTIFIER= $(if $(PI_DIMENSIONKEYS_IDENTIFIER), --identifier $(PI_DIMENSIONKEYS_IDENTIFIER))
__PI_METRIC=
__PI_PARTITION_BY=
__PI_PERIOD_IN_SECONDS=
__PI_SERVICE_TYPE= --service-type RDS
__PI_START_TIME=


# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _pi_view_framework_macros
_pi_view_framework_macros ::
	@#echo 'AWS::PerformanceInsights ($(_AWS_PI_MK_VERSION)) macros:'
	@#echo

_aws_view_framework_parameters :: _pi_view_framework_parameters
_pi_view_framework_parameters ::
	@echo 'AWS::PerformanceInsights ($(_AWS_PI_MK_VERSION)) parameters:'
	@echo

_aws_view_framework_targets :: _pi_view_framework_targets
_pi_view_framework_targets ::
	@echo 'AWS::PerformanceInsights ($(_AWS_PI_MK_VERSION)) targets:'
	@echo '    _pi_get_resourcemetrics         - Get a metrics from a dimension-keys?'
	@echo '    _pi_view_dimensionkeys          - View dimension-keys'
	@echo '    _pi_view_dimensionkeys_set      - View a set of dimension-keys'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_pi_get_resourcemetrics:



_pi_view_dimensionkeys:
	@$(INFO) '$(AWS_UI_LABEL)Viewing dimension-keys ...'; $(NORMAL)
	$(AWS) pi describe-dimension-keys $(__PI_END_TIME) $(__PI_FILTER) $(__PI_GROUP_BY) $(__PI_IDENTIFIER) $(__PI_METRIC) $(__PI_PARTITION_BY) $(__PI_PERIOD_IN_SECONDS) $(__PI_SERVICE_TYPE) $(__PI_START_TIME)

_pi_view_dimensionkeys_set:
