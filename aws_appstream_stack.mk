_AWS_APPSTREAM_STACK_MK_VERSION= $(_AWS_APPSTREAM_MK_VERSION)

# ASM_STACK_NAME?= 
# ASM_STACK_NAMES?= 
# ASM_STACKS_SET_NAME?= 

# Derived parameters
ASM_STACK_NAMES?= $(ASM_STACK_NAME)

# Option parameters
__ASM_NAMES__STACK= $(if $(ASM_STACK_NAMES), --names $(ASM_STACK_NAMES))

# UI parameters
ASM_UI_VIEW_STACKS__FIELDS?=
ASM_UI_VIEW_STACKS_SET_FIELDS?= $(ASM_UI_VIEW_STACKS_FIELDS)
ASM_UI_VIEW_STACKS_SET_SLICE?=

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_asm_view_framework_macros ::
	@echo 'AWS::AppStreaM::Fleet ($(_AWS_APPSTREAM_STACK_MK_VERSION)) macros:'
	@echo

_asm_view_framework_parameters ::
	@echo 'AWS::AppStreaM::Fleet ($(_AWS_APPSTREAM_STACK_MK_VERSION)) parameters:'
	@echo '    ASM_STACK_NAME=$(ASM_STACK_NAME)'
	@echo '    ASM_STACK_NAMES=$(ASM_STACK_NAMES)'
	@echo '    ASM_STACKS_SET_NAME=$(ASM_STACKS_SET_NAME)'
	@echo

_asm_view_framework_targets ::
	@echo 'AWS::AppStreaM::Fleet ($(_AWS_APPSTREAM_STACK_MK_VERSION)) targets:'A
	@echo '    _asm_create_stack               - Create a new stack'
	@echo '    _asm_delete_stack               - Delete an existing stack'
	@echo '    _asm_show_stack                 - Show everything related to a stack'
	@echo '    _asm_view_stacks                - View stacks'
	@echo '    _asm_view_stacks_set            - View a set of stacks'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_asm_create_stack:

_asm_delete_stack:

_asm_show_stack:

_asm_view_stacks:
	@$(INFO) '$(AWS_UI_LABEL)Viewing stacks ...'; $(NORMAL)
	$(AWS) appstream describe-stacks $(_X__ASM_NAMES__STACK)

_asm_view_stacks_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing stacks-set "$(ASM_STACKS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Fleets are grouped based on the provided stack-names and/or slice'; $(NORMAL)
	$(AWS) appstream describe-stacks $(__ASM_NAMES__STACK)
