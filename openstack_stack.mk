_OPENSTACK_STACK_MK_VERSION= 0.99.3

# OSSK_STACK_NAME?= MyStack

# Derived parameters

# Option parameters

# UI parameters

#--- MACROS

_oosk_get_output_P= $(call _ossk_get_output_NK, $(1), $(OSSK_STACK_NAME))
_ossk_get_output_PN= $(shell $(OPENSTACK) stack output show $(2) $(1) --column output_value --format value)

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _ossk_view_framework_macros
_ossk_view_framework_macros ::
	@echo "OpenStack::StacK ($(_OPENSTACK_STACK_MK_VERSION)) macros:"
	@echo "    _ossk_get_output_{P|PN}       - Get a stack output (Parm, StackName)"
	@echo

_view_framework_parameters :: _ossk_view_framework_parameters
_ossk_view_framework_parameters ::
	@echo "OpenStack::Stack ($(_OPENSTACK_STACK_MK_VERSION)) parameters:"
	@echo "    OSSK_STACK_NAME=$(OSSK_STACK_NAME)"
	@echo

_view_framework_targets :: _ossk_view_framework_targets
_ossk_view_framework_targets ::
	@echo "OpensStack::StacK ($(_OPENSTACK_STACK_MK_VERSION)) targets:"
	@echo "    _ossk_create_stack            - Create a new stack"
	@echo "    _ossk_delete_stack            - Delete an existing stack"
	@echo "    _ossk_view_stack_events       - View stack events"
	@echo "    _ossk_view_stacks             - View existing stacks"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_assk_create_stack:
	@$(INFO) "$(OS_UI_LABEL)Create stack '$(OSSK_STACK_NAME)' ..."; $(NORMAL)
	$(OPENSTACK) stack output show $(OSSK_STACK_NAME)

_assk_delete_stack:
	@$(INFO) "$(OS_UI_LABEL)Delete stack '$(OSSK_STACK_NAME)' ..."; $(NORMAL)
	$(OPENSTACK) stack delete $(OSSK_STACK_NAME)

_assk_view_stack_outputs:
	@$(INFO) "$(OS_UI_LABEL)View outputs of stack '$(OSSK_STACK_NAME)' ..."; $(NORMAL)
	$(OPENSTACK) stack output show $(OSSK_STACK_NAME)

_ossk_show_stack:
	@$(INFO) "$(OS_UI_LABEL)Show stack '$(OSSK_STACK_NAME)' ..."; $(NORMAL)
	$(OPENSTACK) stack show $(OSSK_STACK_NAME)

_ossk_view_stack_events:
	@$(INFO) "$(OS_UI_LABEL)View stack events ..."; $(NORMAL)
	$(OPENSTACK) stack event list $(OSSK_STACK_NAME)

_ossk_view_stacks:
	@$(INFO) "$(OS_UI_LABEL)View stacks ..."; $(NORMAL)
	$(OPENSTACK) stack list
