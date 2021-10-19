_AWS_XRAY_TRACE_MK_VERSION= $(_AWS_XRAY_MK_VERSION)

# XRY_TRACE_ID?=
# XRY_TRACE_NAME?=
# XRY_TRACE_RESOURCE_ARN?=
# XRY_TRACES_END_TIME?=
# XRY_TRACES_FILTER?=
# XRY_TRACES_ID?=
# XRY_TRACES_IDS?=
# XRY_TRACES_SAMPLING_ENABLED?= false
# XRY_TRACES_SET_NAME?=
# XRY_TRACES_START_TIME?=

# Derived parameters
XRY_TRACES_IDS?= $(XRY_TRACE_ID)

# Option parameters
__XRY_END_TIME__TRACE= $(if $(XRY_TRACES_END_TIME), --end-time $(XRY_TRACES_END_TIME))
__XRY_FILTER_EXPRESSION= $(if $(XRY_TRACES_FILTER), --filter-expression $(XRY_TRACES_FILTER))
__XRY_SAMPLING= $(if $(filter true, $(XRY_TRACES_SAMPLING_ENABLED)), --sampling, --no-sampling)
__XRY_START_TIME__TRACE= $(if $(XRY_TRACES_START_TIME), --start-time $(XRY_TRACES_START_TIME))
__XRY_TRACE_IDS= $(if $(XRY_TRACE_IDS), --trace-ids $(XRY_TRACE_IDS))

# UI parameters
XRY_UI_VIEW_TRACES_FIELDS?=
XRY_UI_VIEW_TRACES_SET_FIELDS?= $(XRY_UI_VIEW_TRACES_FIELDS)
XRY_UI_VIEW_TRACES_SET_SLICE?=

#--- Utilities

#--- MACROS

_xry_get_trace_id= $(call _xry_get_trace_id_N, $(XRY_TRACE_NAME))
_xry_get_trace_id_N= "$(shell $(AWS) xray get-trace-summaries --query "Traces[?Name=='$(strip $(1))'].Id" --output text)"

#----------------------------------------------------------------------
# USAGE
#

_xry_view_framework_macros ::
	@echo 'AWS::XRaY::Trace ($(_AWS_XRAY_TRACE_MK_VERSION)) macros:'
	@echo '    _xry_get_trace_id_{|N|NO}                     - Get the ID of a trace (Name,OrganizationId)'
	@echo

_xry_view_framework_parameters ::
	@echo 'AWS::XRaY::Trace ($(_AWS_XRAY_TRACE_MK_VERSION)) parameters:'
	@echo '    XRY_TRACE_ID=$(XRY_TRACE_ID)'
	@echo '    XRY_TRACE_NAME=$(XRY_TRACE_NAME)'
	@echo '    XRY_TRACE_RESOURCE_ARN=$(XRY_TRACE_RESOURCE_ARN)'
	@echo '    XRY_TRACES_END_TIME=$(XRY_TRACES_END_TIME)'
	@echo '    XRY_TRACES_SET_NAME=$(XRY_TRACES_SET_NAME)'
	@echo '    XRY_TRACES_START_TIME=$(XRY_TRACES_START_TIME)'
	@echo

_xry_view_framework_targets ::
	@echo 'AWS::XRaY::Trace ($(_AWS_XRAY_TRACE_MK_VERSION)) targets:'A
	@echo '    _xry_create_trace                           - Create a new trace'
	@echo '    _xry_delete_trace                           - Delete an existing trace'
	@echo '    _xry_show_trace                             - Show everything related to a trace'
	@echo '    _xry_show_trace_description                 - Show description of a trace'
	@echo '    _xry_view_traces                            - View traces'
	@echo '    _xry_view_traces_set                        - View a set of traces'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_xry_create_trace:
	@$(INFO) '$(AWS_UI_LABEL)Creating trace "$(XRY_TRACE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Traces are created by the monitored software'; $(NORMAL)

_xry_delete_trace:
	@$(INFO) '$(AWS_UI_LABEL)Deleting trace "$(XRY_TRACE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Traces are cannot be deleted'; $(NORMAL)
	@$(WARN) 'What is the retention policy?'; $(NORMAL)

_xry_show_trace: _xry_show_trace_graph _xry_show_trace_description

_xry_show_trace_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of trace "$(XRY_TRACE_NAME)" ...'; $(NORMAL)
	$(AWS) xray batch-get-traces $(_X__XRY_TRACE_IDS) --trace-ids $(XRY_TRACE_ID) --query "Traces[]"

_xry_show_trace_graph:
	@$(INFO) '$(AWS_UI_LABEL)Showing graph of trace "$(XRY_TRACE_NAME)" ...'; $(NORMAL)
	$(AWS) xray get-trace-graph $(_X__XRY_TRACE_IDS) --trace-ids $(XRY_TRACE_ID) # --query "Traces[]"

_xry_view_traces:
	@$(INFO) '$(AWS_UI_LABEL)Viewing traces ...'; $(NORMAL)
	$(AWS) xray get-trace-summaries $(_X__XRY_END_TIME__TRACE) $(_X__XRY_FILTER_EXPRESSION) $(_X__XRY_SAMPLING) $(_X__XRY_START_TIME__TRACE) # --query "Traces[]$(XRY_UI_VIEW_TRACES_FIELDS)"

_xry_view_traces_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing traces-set "$(XRY_TRACES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Protections are grouped based on the provided slice'; $(NORMAL)
	$(AWS) xray get-trace-summaries $(__XRY_END_TIME__TRACE) $(__XRY_FILTER_EXPRESSION) $(__XRY_SAMPLING) $(__XRY_START_TIME__TRACE) # --query "Traces[]$(XRY_UI_VIEW_TRACES_FIELDS)"
