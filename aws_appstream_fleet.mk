_AWS_APPSTREAM_FLEET_MK_VERSION= $(_AWS_APPSTREAM_MK_VERSION)

# ASM_FLEET_NAME?= 
# ASM_FLEET_NAMES?= 
# ASM_FLEETS_SET_NAME?= 

# Derived parameters
ASM_FLEET_NAMES?= $(ASM_FLEET_NAME)

# Option parameters
__ASM_NAMES__FLEET= $(if $(ASM_FLEET_NAMES), --names $(ASM_FLEET_NAMES))

# UI parameters
ASM_UI_VIEW_FLEETS__FIELDS?=
ASM_UI_VIEW_FLEETS_SET_FIELDS?= $(ASM_UI_VIEW_FLEETS_FIELDS)
ASM_UI_VIEW_FLEETS_SET_SLICE?=

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_asm_view_framework_macros ::
	@echo 'AWS::AppStreaM::Fleet ($(_AWS_APPSTREAM_FLEET_MK_VERSION)) macros:'
	@echo

_asm_view_framework_parameters ::
	@echo 'AWS::AppStreaM::Fleet ($(_AWS_APPSTREAM_FLEET_MK_VERSION)) parameters:'
	@echo '    ASM_FLEET_NAME=$(ASM_FLEET_NAME)'
	@echo '    ASM_FLEET_NAMES=$(ASM_FLEET_NAMES)'
	@echo '    ASM_FLEETS_SET_NAME=$(ASM_FLEETS_SET_NAME)'
	@echo

_asm_view_framework_targets ::
	@echo 'AWS::AppStreaM::Fleet ($(_AWS_APPSTREAM_FLEET_MK_VERSION)) targets:'A
	@echo '    _asm_create_fleet               - Create a new fleet'
	@echo '    _asm_delete_fleet               - Delete an existing fleet'
	@echo '    _asm_show_fleet                 - Show everything related to a fleet'
	@echo '    _asm_view_fleets                - View fleets'
	@echo '    _asm_view_fleets_set            - View a set of fleets'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_asm_create_fleet:

_asm_delete_fleet:

_asm_show_fleet:

_asm_view_fleets:
	@$(INFO) '$(AWS_UI_LABEL)Viewing fleets ...'; $(NORMAL)
	$(AWS) appstream describe-fleets $(_X__ASM_NAMES__FLEET)

_asm_view_fleets_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing fleets-set "$(ASM_FLEETS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Fleets are grouped based on the provided fleet-names and/or slice'; $(NORMAL)
	$(AWS) appstream describe-fleets $(__ASM_NAMES__FLEET)
