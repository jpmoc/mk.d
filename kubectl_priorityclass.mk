_KUBECTL_PRIORITYCLASS_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_PRIORITYCLASS_DESCRIPTION?=
# KCL_PRIORITYCLASS_LABELS_KEYVALUES?= istio-injection=enabled ...
# KCL_PRIORITYCLASS_MANIFEST_DIRPATH?= ./in/
# KCL_PRIORITYCLASS_MANIFEST_FILENAME?= priorityclass.yml
# KCL_PRIORITYCLASS_MANIFEST_FILEPATH?= ./in/priorityclass.yml
# KCL_PRIORITYCLASS_NAME?= 
# KCL_PRIORITYCLASS_VALUE?= 1000000
# KCL_PRIORITYCLASSES_SELECTOR?=
# KCL_PRIORITYCLASSES_SET_NAME?= my-priority-classes-set

# Derived parameters
KCL_PRIORITYCLASS_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_PRIORITYCLASS_FILEPATH?= $(KCL_PRIORITYCLASS_DIRPATH)$(KCL_PRIORITYCLASS_FILENAME)

# Option parameters
__KCL_FILENAME__PRIORITYCLASS= $(if $(KCL_PRIORITYCLASS_MANIFEST_FILEPATH),--filename $(KCL_PRIORITYCLASS_MANIFEST_FILENAME))

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@#echo 'KubeCtL::PriorityClass ($(_KUBECTL_PRIORITYCLASS_MK_VERSION)) macros:'
	@#echo

_kcl_list_parameters ::
	@echo 'KubeCtL::PriorityClass ($(_KUBECTL_PRIORITYCLASS_MK_VERSION)) parameters:'
	@echo '    KCL_PRIORITYCLASS_DESCRIPTION=$(KCL_PRIORITYCLASS_DESCRIPTION)'
	@echo '    KCL_PRIORITYCLASS_LABELS_KEYVALUES=$(KCL_PRIORITYCLASS_LABELS_KEYVALUES)'
	@echo '    KCL_PRIORITYCLASS_MANIFEST_DIRPATH=$(KCL_PRIORITYCLASS_MANIFEST_DIRPATH)'
	@echo '    KCL_PRIORITYCLASS_MANIFEST_FILENAME=$(KCL_PRIORITYCLASS_MANIFEST_FILENAME)'
	@echo '    KCL_PRIORITYCLASS_MANIFEST_FILEPATH=$(KCL_PRIORITYCLASS_MANIFEST_FILEPATH)'
	@echo '    KCL_PRIORITYCLASS_NAME=$(KCL_PRIORITYCLASS_NAME)'
	@echo '    KCL_PRIORITYCLASS_VALUE=$(KCL_PRIORITYCLASS_VALUE)'
	@echo '    KCL_PRIORITYCLASSES_SELECTOR=$(KCL_PRIORITYCLASSES_SELECTOR)'
	@echo '    KCL_PRIORITYCLASSES_SET_NAME=$(KCL_PRIORITYCLASSES_SET_NAME)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::PriorityClass ($(_KUBECTL_PRIORITYCLASS_MK_VERSION)) targets:'
	@echo '    _kcl_apply_priorityclass                       - Apply a manifest with a priority-class'
	@echo '    _kcl_create_priorityclass                      - Create a new priority-class'
	@echo '    _kcl_delete_priorityclass                      - Delete an existing priority-class'
	@echo '    _kcl_edit_priorityclass                        - Edit a priority-class'
	@echo '    _kcl_explain_priorityclass                     - Explain the priority-class object'
	@echo '    _kcl_show_priorityclass                        - Show everything related to a priority-class'
	@echo '    _kcl_show_priorityclass_description            - Show description of a priority-class'
	@echo '    _kcl_show_priorityclass_pods                   - Show pods with a priority-class'
	@echo '    _kcl_unapply_priorityclass                     - Unapply a manifest with a priority-class'
	@echo '    _kcl_list_priorityclasses                      - List all priority-classes'
	@echo '    _kcl_list_priorityclasses_set                  - List a set of priority-classes'
	@echo '    _kcl_watch_priorityclasses                     - Watch all priority-classes'
	@echo '    _kcl_watch_priorityclasses_set                 - Watch a set of priority-classes'
	@echo '    _kcl_write_priorityclasses                     - Write manifest for one-or-more priority-classes'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_apply_priorityclass:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest with priority-class "$(KCL_PRIORITYCLASS_NAME)" ...'; $(NORMAL)
	cat $(KCL_PRIORITYCLASS_MANIFEST_FILEPATH)
	$(KUBECTL) apply $(__KCL_FILENAME__PRIORITYCLASS)

_kcl_create_priorityclass:
	@$(INFO) '$(KCL_UI_LABEL)Creating priority-class "$(KCL_PRIORITYCLASS_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) create priorityclass $(__KCL_DESCRIPTION__PRIORITYCLASS) $(KCL_PRIORITYCLASS_NAME)

_kcl_delete_priorityclass:
	@$(INFO) '$(KCL_UI_LABEL)Deleting priority-class "$(KCL_PRIORITYCLASS_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete priorityclass $(KCL_PRIORITYCLASS_NAME)

_kcl_edit_priorityclass:
	@$(INFO) '$(KCL_UI_LABEL)Editing priority-class "$(KCL_PRIORITYCLASS_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit priorityclass $(KCL_PRIORITYCLASS_NAME)

_kcl_explain_priorityclass:
	@$(INFO) '$(KCL_UI_LABEL)Explaining priority-class object ...'; $(NORMAL)
	$(KUBECTL) explain priorityclass

_kcl_label_priorityclass:
	@$(INFO) '$(KCL_UI_LABEL)Labelling priority-class "$(KCL_PRIORITYCLASS_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label priorityclass $(KCL_PRIORITYCLASS_NAME) $(KCL_PRIORITYCLASS_LABELS_KEYVALUES)

_kcl_list_priorityclasses:
	@$(INFO) '$(KCL_UI_LABEL)Listing ALL priority-classes ...'; $(NORMAL)
	$(KUBECTL) get priorityclasses $(_X__KCL_SELECTOR_PRIORITYCLASSES)

_kcl_list_priorityclasses_set:
	@$(INFO) '$(KCL_UI_LABEL)Listing priority-classes-set "$(KCL_PRIORITYCLASSES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Priority-classes are grouped based on selector, ...'; $(NORMAL)
	$(KUBECTL) get priorityclasses $(__KCL_SELECTOR_PRIORITYCLASSES)

_KCL_SHOW_PRIORITYCLASS_TARGETS?= _kcl_show_priorityclass_pods _kcl_show_priorityclass_description
_kcl_show_priorityclass: $(_KCL_SHOW_PRIORITYCLASS_TARGETS)

_kcl_show_priorityclass_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of priority-class "$(KCL_PRIORITYCLASS_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe priorityclass $(KCL_PRIORITYCLASS_NAME) 

_kcl_show_priorityclass_pods:
	@$(INFO) '$(KCL_UI_LABEL)Showing pods with priority-class "$(KCL_PRIORITYCLASS_NAME)" ...'; $(NORMAL)
	# To be implmeneted

_kcl_unapply_priorityclass:
	@$(INFO) '$(KCL_UI_LABEL)Unapplying manifest with priority-class "$(KCL_PRIORITYCLASS_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete $(__KCL_FILENAME__PRIORITYCLASS)

_kcl_watch_priorityclasses:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL priority-classes ...'; $(NORMAL)

_kcl_watch_priorityclasses_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching priority-classes-set "$(KCL_PRIORITYCLASSES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Priority-classes are grouped based on selector, ...'; $(NORMAL)

_kcl_write_priorityclasses:
	@$(INFO) '$(KCL_UI_LABEL)Writing manifest for one-or-more priority-classes ...'; $(NORMAL)
	$(WRITER) $(KCL_PRIORITYCLASSES_MANIFEST_FILEPATH)
