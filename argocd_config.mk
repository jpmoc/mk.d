_ARGOCD_CONFIG_MK_VERSION= $(_ARGOCD_MK_VERSION)

ACD_CONFIG_DIRPATH?= /home/vagrant/.argocd/
ACD_CONFIG_FILENAME?= config
# ACD_CONFIG_FILEPATH?= /home/vagrant/.argocd/config
# ACD_CONFIG_NAME?=

# Derived parameters
ACD_CONFIG_NAME?= $(ACD_CONFIG_FILENAME)
ACD_CONFIG_FILEPATH?= $(ACD_CONFIG_DIRPATH)$(ACD_CONFIG_FILENAME)

# Option parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_acd_view_framework_macros ::
	@echo 'ArgoCD::Config ($(_ARGOCD_CONFIG_MK_VERSION)) macros:'
	@echo

_acd_view_framework_parameters ::
	@echo 'ArgoCD::Config ($(_ARGOCD_CONFIG_MK_VERSION)) parameters:'
	@echo '    ACD_CONFIG_DIRPATH=$(ACD_CONFIG_DIRPATH)'
	@echo '    ACD_CONFIG_FILENAME=$(ACD_CONFIG_FILENAME)'
	@echo '    ACD_CONFIG_FILEPATH=$(ACD_CONFIG_FILEPATH)'
	@echo '    ACD_CONFIG_NAME=$(ACD_CONFIG_NAME)'
	@echo

_acd_view_framework_targets ::
	@echo 'ArgoCD::Config ($(_ARGOCD_CONFIG_MK_VERSION)) targets:'
	@echo '    _ago_show_config                     - Show everything related to a config'
	@echo '    _ago_show_config_content             - Show content of a config'
	@echo '    _ago_show_config_description         - Show description of a config'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_acd_show_config :: _acd_show_config_content _acd_show_config_description

_acd_show_config_content:
	@$(INFO) '$(ACD_UI_LABEL)Showing content of config "$(ACD_CONFIG_NAME)" ...'; $(NORMAL)
	cat $(ACD_CONFIG_FILEPATH)

_acd_show_config_description:
	@$(INFO) '$(ACD_UI_LABEL)Showing description of config "$(ACD_CONFIG_NAME)" ...'; $(NORMAL)
	ls -al $(ACD_CONFIG_FILEPATH)
