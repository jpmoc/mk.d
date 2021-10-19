_MULTIPASS_MACHINE_MK_VERSION= $(_MULTIPASS_MK_VERSION)

# MPS_MACHINE_CLIENTS_COUNT?= 2

# Derived variables

# Option variables
__MPS_CLIENTS= $(if $(MPS_MACHINE_CLIENTS_COUNT),--clients $(MPS_MACHINE_CLIENTS_COUNT))

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_lct_view_framework_macros ::
	@#echo 'Multipass::Machine ($(_MULTIPASS_MACHINE_MK_VERSION)) macros:'
	@#echo

_lct_view_framework_parameters ::
	@echo 'Multipass::Machine ($(_MULTIPASS_MACHINE_MK_VERSION)) parameters:'
	@echo '    MPS_MACHINE_CLIENTS_COUNT=$(MPS_MACHINE_CLIENTS_COUNT)'
	@echo

_lct_view_framework_targets ::
	@echo 'Multipass::Machine ($(_MULTIPASS_MACHINE_MK_VERSION)) targets:'
	@echo '    _lct_create_machine             - Create a machine'
	@echo '    _lct_view_machines              - View machines'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_lct_create_machine:
	@$(INFO) '$(MPS_UI_LABEL)Creating machine "$(MPS_MACHINE_NAME)" ...'; $(NORMAL)
	$(MULTIPASS) launch 
