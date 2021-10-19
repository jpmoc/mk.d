_EB_ENVIRONMENT_MK_VERSION= $(_EB_MK_VERSION)

# EB_PROFILE?=

# Derived parameters

# Options parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_eb_view_framework_macros ::
	@echo 'EB::Environment ($(_EB_ENVIRONMENT_MK_VERSION)) targets:'
	@echo

_eb_view_framework_parameters ::
	@echo 'EB::Environment ($(_EB_ENVIRONMENT_MK_VERSION)) parameters:'
	@echo

_eb_view_framework_targets ::
	@echo 'EB::Environment ($(_EB_ENVIRONMENT_MK_VERSION)) targets:'
	@echo '    _eb_create_environment          - Create a new environment'
	@echo '    _eb_delete_environment          - Delete an existing environment'
	@echo '    _eb_show_environment            - Show everything related to an environment'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_eb_create_environment:
	@$(INFO) '$(EB_UI_LABEL)Creating an environment'; $(NORMAL)
	$(EB) create

_eb_delete_environment:
	@$(INFO) '$(EB_UI_LABEL)Deleting environment'; $(NORMAL)
	$(EB) terminate

_eb_show_environment: _eb_show_environment_config _eb_show_environmnent_health _eb_show_environment_status

_eb_show_environment_config:
	@$(INFO) '$(EB_UI_LABEL)Showing config of environment'; $(NORMAL)
	$(EB) config

_eb_show_environment_health:
	@$(INFO) '$(EB_UI_LABEL)Showing health of environment'; $(NORMAL)
	$(EB) health

_eb_show_environment_status:
	@$(INFO) '$(EB_UI_LABEL)Showing status of environment'; $(NORMAL)
	$(EB) status
