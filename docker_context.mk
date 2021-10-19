_DOCKER_RUNTIME_MK_VERSION= $(_DOCKER_MK_VERSION)

# DKR_CONTEXT_DESCRIPTION?= "Terminal 2"
# DKR_CONTEXT_DOCKER_URL?= host=ssh://127.0.0.1
DKR_CONTEXT_NAME?= default
# DKR_CONTEXTS_REGEX?= *
# DKR_CONTEXTS_SET_NAME?= my-context@@@

# Derived variables

# Option variables
__DKR_DESCRIPTION__CONTEXT= $(if $(DKR_CONTEXT_DESCRIPTION),--description $(DKR_CONTEXT_DESCRIPTION))
__DKR_DOCKER= $(if $(DKR_CONTEXT_DOCKER_URL),--docker $(DKR_CONTEXT_DOCKER_URL))

# UI variables

#--- Utility 

#--- MACROS

#----------------------------------------------------------------------
# Usage
#

_dkr_view_framework_macros ::
	@echo 'Docker::Context ($(_DOCKER_CONTEXT_MK_VERSION)) targets:'
	@echo

_dkr_view_framework_parameters ::
	@echo 'Docker::Context ($(_DOCKER_CONTEXT_MK_VERSION)) parameters:'
	@echo '    DKR_CONTEXT_DESCRIPTION= $(DKR_CONTEXT_DESCRIPTION)'
	@echo '    DKR_CONTEXT_DOCKER_URL= $(DKR_CONTEXT_DOCKER_URL)'
	@echo '    DKR_CONTEXT_NAME= $(DKR_CONTEXT_NAME)'
	@echo '    DKR_CONTEXTS_REGEX=$(DKR_CONTEXTS_REGEX)'
	@echo '    DKR_CONTEXTS_SET_NAME=$(DKR_CONTEXTS_SET_NAME)'
	@echo

_dkr_view_framework_targets ::
	@echo 'Docker::Context ($(_DOCKER_CONTEXT_MK_VERSION)) targets:'
	@echo '    _dkr_create_context                    - Create a new context'
	@echo '    _dkr_delete_context                    - Delete an existing context'
	@echo '    _dkr_show_context                      - Show everything related to a context'
	@echo '    _dkr_show_context_description          - Show description of a context'
	@echo '    _dkr_switch_context                    - Switching to a different context'
	@echo '    _dkr_view_contexts                     - View contexts'
	@echo '    _dkr_view_contexts_set                 - View a set of contexts'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_dkr_create_context:
	@$(INFO) '$(DKR_UI_LABEL)Creating context "$(DKR_CONTEXT_NAME)" ...'; $(NORMAL)
	$(DOCKER) context create $(strip $(__DKR_DESCRIPTION__CONTEXT) $(__DKR_DOCKER)) $(DKR_CONTEXT_NAME)

_dkr_delete_context:
	@$(INFO) '$(DKR_UI_LABEL)Deleting context "$(DKR_CONTEXT_NAME)" ...'; $(NORMAL)
	# $(DOCKER) context delete $(DKR_CONTEXT_NAME)

_dkr_show_context: _dkr_show_context_description

_dkr_show_context_description:
	@$(INFO) '$(DKR_UI_LABEL)Showing description of context "$(DKR_CONTEXT_NAME)" ...'; $(NORMAL)

_dkr_switch_context:
	@$(INFO) '$(DKR_UI_LABEL)Switching to context "$(DKR_CONTEXT_NAME)" ...'; $(NORMAL)
	$(DOCKER) context use $(DKR_CONTEXT_NAME)

_dkr_view_contexts:
	@$(INFO) '$(DKR_UI_LABEL)Viewing contexts ...'; $(NORMAL)
	$(DOCKER) context ls

_dkr_view_contexts_set:
	@$(INFO) '$(DKR_UI_LABEL)Viewing contexts-set "$(DKR_CONTEXTS_SET_NAME)"  ...'; $(NORMAL)
