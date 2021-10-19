_AWS_XRAY_SERVICEGRAPH_MK_VERSION= $(_AWS_XRAY_MK_VERSION)

# XRY_SERVICEGRAPH_GROUP_ARN?=
# XRY_SERVICEGRAPH_GROUP_NAME?= Default
# XRY_SERVICEGRAPH_NAME?= Default
XRY_SERVICEGRAPH_TIMESTAMP_DELTA?= 21600 # 6 hours at most or $(shell echo "60*60*6" | bc)
# XRY_SERVICEGRAPH_TIMESTAMP_END?= $(shell date +%s)
# XRY_SERVICEGRAPH_TIMESTAMP_START?= $((date +%s - 600))
# XRY_SERVICEGRAPHS_SET_NAME?= my-service-graphs-set

# Derived parameters
XRY_SERVICEGRAPH_GROUP_ARN?= $(XRY_GROUP_ARN)
XRY_SERVICEGRAPH_GROUP_NAME?= $(XRY_GROUP_NAME)
XRY_SERVICEGRAPH_TIMESTAMP_END?= $(shell date +%s)
XRY_SERVICEGRAPH_TIMESTAMP_START?= $(shell echo $(XRY_SERVICEGRAPH_TIMESTAMP_END)-$(XRY_SERVICEGRAPH_TIMESTAMP_DELTA) | bc)

# Option parameters
__XRY_END_TIME= $(if $(XRY_SERVICEGRAPH_TIMESTAMP_END),--end-time $(XRY_SERVICEGRAPH_TIMESTAMP_END))
__XRY_GROUP_ARN__SERVICEGRAPH= $(if $(XRY_SERVICEGRAPH_GROUP_ARN),--group-arn $(XRY_SERVICEGRAPH_GROUP_ARN))
__XRY_GROUP_NAME__SERVICEGRAPH= $(if $(XRY_SERVICEGRAPH_GROUP_NAME),--group-name $(XRY_SERVICEGRAPH_GROUP_NAME))
__XRY_START_TIME= $(if $(XRY_SERVICEGRAPH_TIMESTAMP_START),--start-time $(XRY_SERVICEGRAPH_TIMESTAMP_START))

# UI parameters
XRY_UI_VIEW_SERVICEGRAPHS_FIELDS?=
XRY_UI_VIEW_SERVICEGRAPHS_SET_FIELDS?= $(XRY_UI_VIEW_SERVICEGRAPHS_FIELDS)
XRY_UI_VIEW_SERVICEGRAPHS_SET_SLICE?=

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_xry_view_framework_macros ::
	@echo 'AWS::XRaY::ServiceGraph ($(_AWS_XRAY_SERVICEGRAPH_MK_VERSION)) macros:'
	@echo

_xry_view_framework_parameters ::
	@echo 'AWS::XRaY::ServiceGraph ($(_AWS_XRAY_SERVICEGRAPH_MK_VERSION)) parameters:'
	@echo '    XRY_SERVICEGRAPH_GROUP_ARN=$(XRY_SERVICEGRAPH_GROUP_ARN)'
	@echo '    XRY_SERVICEGRAPH_GROUP_NAME=$(XRY_SERVICEGRAPH_GROUP_NAME)'
	@echo '    XRY_SERVICEGRAPH_NAME=$(XRY_SERVICEGRAPH_NAME)'
	@echo '    XRY_SERVICEGRAPH_TIMESTAMP_DELTA=$(XRY_SERVICEGRAPH_TIMESTAMP_DELTA)'
	@echo '    XRY_SERVICEGRAPH_TIMESTAMP_END=$(XRY_SERVICEGRAPH_TIMESTAMP_END)'
	@echo '    XRY_SERVICEGRAPH_TIMESTAMP_START=$(XRY_SERVICEGRAPH_TIMESTAMP_START)'
	@echo '    XRY_SERVICEGRAPHS_SET_NAME=$(XRY_SERVICEGRAPHS_SET_NAME)'
	@echo

_xry_view_framework_targets ::
	@echo 'AWS::XRaY::ServiceGraph ($(_AWS_XRAY_SERVICEGRAPH_MK_VERSION)) targets:'
	@echo '    _xry_show_servicegraph                      - Show everything related to a service-graph'
	@echo '    _xry_show_servicegraph_description          - Show description of a service-graph'
	@echo '    _xry_view_servicegraphs                     - View service-graphs'
	@echo '    _xry_view_servicegraphs_set                 - View a set of service-graphs'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_xry_show_servicegraph:: _xry_show_servicegraph_description

_xry_show_servicegraph_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of service-graph "$(XRY_SERVICEGRAPH_NAME)" ...'; $(NORMAL)
	$(AWS) xray get-service-graph $(__XRY_END_TIME) $(__XRY_GROUP_ARN__SERVICEGRAPH) $(__XRY_GROUP_NAME__SERVICEGRAPH) $(__XRY_START_TIME) --output json

_xry_view_servicegraphs:
	@$(INFO) '$(AWS_UI_LABEL)Viewing service-graphs ...'; $(NORMAL)

_xry_view_servicegraphs_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing service-graph-set "$(XRY_SERVICEGRAPHS_SET_NAME)" ...'; $(NORMAL)
