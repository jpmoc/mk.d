_KUBECTL_EVENT_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_EVENT_NAME?= aws-ecr-
# KCL_EVENT_NAMESPACE_NAME?= default
# KCL_EVENT_OUTPUT?= json
# KCL_EVENTS_NAMESPACE_NAME?= default
# KCL_EVENTS_OUTPUT?= yaml
# KCL_EVENTS_SET_NAME?= my-events-set
# KCL_EVENTS_WATCH_ONLY?= true

# Derived parameters
KCL_EVENT_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_EVENT_NAMES?= $(KCL_EVENT_NAME)
KCL_EVENT_OUTPUT?= $(KCL_OUTPUT)
KCL_EVENTS_NAMESPACE_NAME?= $(KCL_EVENT_NAMESPACE_NAME)
KCL_EVENTS_OUTPUT?= $(KCL_EVENT_OUTPUT)
KCL_EVENTS_SET_NAME?= $(KCL_EVENTS_NAMESPACE_NAME)
KCL_EVENTS_WATCH_ONLY?= $(KCL_WATCH_ONLY)

# Option parameters
__KCL_ALL_NAMESPACES__EVENTS=
__KCL_NAMESPACE__EVENT= $(if $(KCL_EVENT_NAMESPACE_NAME),--namespace $(KCL_EVENT_NAMESPACE_NAME))
__KCL_NAMESPACE__EVENTS= $(if $(KCL_EVENTS_NAMESPACE_NAME),--namespace $(KCL_EVENTS_NAMESPACE_NAME))
__KCL_OUTPUT__EVENT= $(if $(KCL_EVENT_OUTPUT_FORMAT),--output $(KCL_EVENT_OUTPUT_FORMAT))
__KCL_WATCH__EVENTS=
__KCL_WATCH_ONLY__EVENTS= $(if $(KCL_EVENTS_WATCH_ONLY),--watch-only=$(KCL_EVENTS_WATCH_ONLY))

# UI parameters
|_KCL_VIEW_EVENTS?=
|_KCL_VIEW_EVENTS_SET?=
|_KCL_WATCH_EVENTS?=
|_KCL_WATCH_EVENTS_SET?= 

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::Event ($(_KUBECTL_EVENT_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::Event ($(_KUBECTL_EVENT_MK_VERSION)) parameters:'
	@echo '    KCL_EVENT_NAME=$(KCL_EVENT_NAME)'
	@echo '    KCL_EVENT_NAMESPACE_NAME=$(KCL_EVENT_NAMESPACE_NAME)'
	@echo '    KCL_EVENTS_NAMESPACE_NAME=$(KCL_EVENTS_NAMESPACE_NAME)'
	@echo '    KCL_EVENTS_OUTPUT=$(KCL_EVENTS_OUTPUT)'
	@echo '    KCL_EVENTS_SET_NAME=$(KCL_EVENTS_SET_NAME)'
	@echo '    KCL_EVENTS_WATCH_ONLY=$(KCL_EVENTS_WATCH_ONLY)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::Event ($(_KUBECTL_EVENT_MK_VERSION)) targets:'
	@echo '    _kcl_create_event                  - Create a new event'
	@echo '    _kcl_delete_event                  - Delete an existing event'
	@echo '    _kcl_explain_event                 - Explain the event object'
	@echo '    _kcl_show_event                    - Show everything related to an event'
	@echo '    _kcl_show_event_description        - Show the description of an event'
	@echo '    _kcl_view_events                   - View all events'
	@echo '    _kcl_view_events_set               - View a set of events'
	@echo '    _kcl_watch_events                  - Watch events'
	@echo '    _kcl_watch_events_set              - Watch a set of events'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_create_event:

_kcl_delete_event:

_kcl_explain_event:
	@$(INFO) '$(KCL_UI_LABEL)Explaining service object ...'; $(NORMAL)
	$(KUBECTL) explain event

_kcl_show_event: _kcl_show_event_description

_kcl_show_event_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description event "$(KCL_EVENT_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe event $(__KCL_NAMESPACE__EVENT) $(KCL_EVENT_NAME)

_kcl_view_events:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL events ...'; $(NORMAL)
	$(KUBECTL) get event --all-namespaces=true $(_X__KCL_NAMESPACE__EVENTS) $(|_KCL_VIEW_EVENTS)

_kcl_view_events_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing events-set "$(KCL_EVENTS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Events are grouped based on the provided namespace'; $(NORMAL)
	$(KUBECTL) get event --all-namespaces=false $(__KCL_NAMESPACE__EVENTS) $(|_KCL_VIEW_EVENTS_SET)

_kcl_watch_events:
	@$(INFO) '$(KCL_UI_LABEL)Watching events ...'; $(NORMAL)
	$(KUBECTL) get event $(strip $(_X__KCL_ALL_NAMESPACES__EVENTS) --all-namespaces=true $(_X__KCL_NAMESPACE__EVENTS) $(_X__KCL_WATCH__EVENTS) --watch=true $(__KCL_WATCH_ONLY__EVENTS) ) $(|_KCL_WATCH_EVENTS)

_kcl_watch_events_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching events-set "$(KCL_EVENTS_SET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get event $(strip $(_X__KCL_ALL_NAMESPACES__EVENTS) $(__KCL_NAMESPACE__EVENTS) $(_X__KCL_WATCH__EVENTS) --watch=true $(__KCL_WATCH_ONLY__EVENTS) ) $(|_KCL_WATCH_EVENTS_SET)
