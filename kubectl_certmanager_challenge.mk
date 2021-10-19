_KUBECTL_CERTMANAGER_CHALLENGE_MK_VERSION= $(_KUBECTL_CERTMANAGER_MK_VERSION)

# KCL_CHALLENGE_LABELS_KEYVALUES?= key=value ...
# KCL_CHALLENGE_NAME?= my-challenge 
# KCL_CHALLENGE_NAMESPACE_NAME?= default
# KCL_CHALLENGES_FIELDSELECTOR?= metadata.name=my-challenge
# KCL_CHALLENGES_MANIFEST_DIRPATH?= ./in/
# KCL_CHALLENGES_MANIFEST_FILENAME?= challenge.yaml 
# KCL_CHALLENGES_MANIFEST_FILEPATH?= ./in/challenge.yaml 
# KCL_CHALLENGES_MANIFEST_URL?= http:/n.com/manifest.yaml
# KCL_CHALLENGES_MANIFESTS_DIRPATH?= ./in/manifests/
# KCL_CHALLENGES_NAMESPACE_NAME?= default
# KCL_CHALLENGES_SELECTOR?=
# KCL_CHALLENGES_SET_NAME?= my-challengesigningrequests-set

# Derived parameters
KCL_CHALLENGE_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_CHALLENGES_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_CHALLENGES_MANIFEST_FILEPATH?= $(if $(KCL_CHALLENGES_MANIFEST_FILENAME),$(KCL_CHALLENGES_MANIFEST_DIRPATH)$(KCL_CHALLENGES_MANIFEST_FILENAME))
KCL_CHALLENGES_NAMESPACE_NAME?= $(KCL_CHALLENGE_NAMESPACE_NAME)
KCL_CHALLENGES_SET_NAME?= challenges@@@$(KCL_CHALLENGES_NAMESPACE_NAME)

# Option parameters
__KCL_FILENAME__CHALLENGES+= $(if $(KCL_CHALLENGES_MANIFEST_FILEPATH),--filename $(KCL_CHALLENGES_MANIFEST_FILEPATH))
__KCL_FILENAME__CHALLENGES+= $(if $(KCL_CHALLENGES_MANIFEST_URL),--filename $(KCL_CHALLENGES_MANIFEST_URL))
__KCL_FILENAME__CHALLENGES+= $(if $(KCL_CHALLENGES_MANIFESTS_DIRPATH),--filename $(KCL_CHALLENGES_MANIFESTS_DIRPATH))
__KCL_NAMESPACE__CHALLENGE= $(if $(KCL_CHALLENGE_NAMESPACE_NAME),--namespace $(KCL_CHALLENGE_NAMESPACE_NAME))
__KCL_NAMESPACE__CHALLENGES= $(if $(KCL_CHALLENGES_NAMESPACE_NAME),--namespace $(KCL_CHALLENGES_NAMESPACE_NAME))

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::CertManager::Challenge ($(_KUBECTL_CERTMANAGER_CHALLENGE_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::CertManager::Challenge ($(_KUBECTL_CERTMANAGER_CHALLENGE_MK_VERSION)) parameters:'
	@echo '    KCL_CHALLENGE_LABELS_KEYVALUES=$(KCL_CHALLENGE_LABELS_KEYVALUES)'
	@echo '    KCL_CHALLENGE_NAME=$(KCL_CHALLENGE_NAME)'
	@echo '    KCL_CHALLENGE_NAMESPACE_NAME=$(KCL_CHALLENGE_NAMESPACE_NAME)'
	@echo '    KCL_CHALLENGES_FIELDSELECTOR=$(KCL_CHALLENGES_FIELDSELECTOR)'
	@echo '    KCL_CHALLENGES_MANIFEST_DIRPATH=$(KCL_CHALLENGES_MANIFEST_DIRPATH)'
	@echo '    KCL_CHALLENGES_MANIFEST_FILENAME=$(KCL_CHALLENGES_MANIFEST_FILENAME)'
	@echo '    KCL_CHALLENGES_MANIFEST_FILEPATH=$(KCL_CHALLENGES_MANIFEST_FILEPATH)'
	@echo '    KCL_CHALLENGES_MANIFEST_URL=$(KCL_CHALLENGES_MANIFEST_URL)'
	@echo '    KCL_CHALLENGES_MANIFESTS_DIRPATH=$(KCL_CHALLENGES_MANIFESTS_DIRPATH)'
	@echo '    KCL_CHALLENGES_NAMESPACE_NAME=$(KCL_CHALLENGES_NAMESPACE_NAME)'
	@echo '    KCL_CHALLENGES_SELECTOR=$(KCL_CHALLENGES_SELECTOR)'
	@echo '    KCL_CHALLENGES_SET_NAME=$(KCL_CHALLENGES_SET_NAME)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::CertManager::Challenge ($(_KUBECTL_CERTMANAGER_CHALLENGE_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_challenge               - Annotate a challenge'
	@echo '    _kcl_apply_challenges                 - Apply a manifest for one-or-more challenges'
	@echo '    _kcl_create_challenge                 - Create a new challenge'
	@echo '    _kcl_delete_challenge                 - Delete an existing challenge'
	@echo '    _kcl_diff_challenges                  - Diff a manifest for one-or-more challenges'
	@echo '    _kcl_edit_challenge                   - Edit a challenge'
	@echo '    _kcl_explain_challenge                - Explain the challenge object'
	@echo '    _kcl_show_challenge                   - Show everything related to a challenge'
	@echo '    _kcl_show_challenge_description       - Show description of a challenge'
	@echo '    _kcl_show_challenge_state             - Show state of a challenge'
	@echo '    _kcl_unapply_challenges               - Un-apply a manifest for one-or-more challenge'
	@echo '    _kcl_unlabel_challenge                - Un-label a challenge'
	@echo '    _kcl_update_challenge                 - Update a challenge'
	@echo '    _kcl_view_challenges                  - View challenges'
	@echo '    _kcl_view_challenges_set              - View set of challenges'
	@echo '    _kcl_watch_challenges                 - Watch challenges'
	@echo '    _kcl_watch_challenges_set             - Watch a set of challenges'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_challenge:
	@$(INFO) '$(KCL_UI_LABEL)Annotating challenge "$(KCL_CHALLENGE_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) annotate $(__KCL_NAMESPACE__CHALLENGE) $(KCL_CHALLENGE_NAME)

_kcl_apply_challenge: _kcl_apply_challenges
_kcl_apply_challenges:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more challenges ...'; $(NORMAL)
	$(if $(KCL_CHALLENGES_MANIFEST_FILEPATH), cat $(KCL_CHALLENGES_MANIFEST_FILEPATH); echo)
	$(if $(KCL_CHALLENGES_MANIFEST_URL), curl -L $(KCL_CHALLENGES_MANIFEST_URL); echo)
	$(if $(KCL_CHALLENGES_MANIFESTS_DIRPATH), ls -al $(KCL_CHALLENGES_MANIFESTS_DIRPATH); echo)
	$(KUBECTL) apply $(__KCL_FILENAME__CHALLENGES) $(__KCL_NAMESPACE__CHALLENGES)

_kcl_create_challenge:
	@$(INFO) '$(KCL_UI_LABEL)Creating challenge "$(KCL_CHALLENGE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) create challenge $(__KCL_NAMESPACE__CHALLENGE) $(KCL_CHALLENGE_NAME)

_kcl_delete_challenge:
	@$(INFO) '$(KCL_UI_LABEL)Deleting challenge "$(KCL_CHALLENGE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete challenge $(__KCL_NAMESPACE__CHALLENGE) $(KCL_CHALLENGE_NAME)

_kcl_diff_challenge: _kcl_diff_challenges
_kcl_diff_challenges:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing cluster-state with manifest for one-or-more challenges ...'; $(NORMAL)
	# cat $(KCL_CHALLENGES_MANIFEST_FILEPATH)
	# curl -L $(KCL_CHALLENGES_MANIFEST_URL)
	# ls -al $(KCL_CHALLENGES_MANIFESTS_DIRPATH)
	$(KUBECTL) diff $(__KCL_FILENAME__CHALLENGES) $(__KCL_NAMESPACE__CHALLENGES)

_kcl_edit_challenge:
	@$(INFO) '$(KCL_UI_LABEL)Editing challenge "$(KCL_CHALLENGE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit challenge $(__KCL_NAMESPACE__CHALLENGE) $(KCL_CHALLENGE_NAME)

_kcl_explain_challenge:
	@$(INFO) '$(KCL_UI_LABEL)Explaining challenge object ...'; $(NORMAL)
	$(KUBECTL) explain challenge

_kcl_label_challenge:
	@$(INFO) '$(KCL_UI_LABEL)Labelling challenge "$(KCL_CHALLENGE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label challenge $(__KCL_NAMESPACE__CHALLENGE) $(KCL_CHALLENGE_NAME) $(KCL_CHALLENGE_LABELS_KEYVALUES)

_kcl_show_challenge :: _kcl_show_challenge_description

_kcl_show_challenge_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of challenge "$(KCL_CHALLENGE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe challenge $(__KCL_NAMESPACE__CHALLENGE) $(KCL_CHALLENGE_NAME) 

_kcl_unapply_challenge: _kcl_unapply_challenges
_kcl_unapply_challenges:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more challenges ...'; $(NORMAL)
	# cat $(KCL_CHALLENGES_MANIFEST_FILEPATH)
	# curl -L $(KCL_CHALLENGES_MANIFEST_URL)
	# ls -al $(KCL_CHALLENGES_MANIFESTS_DIRPATH)
	$(KUBECTL) delete $(__KCL_FILENAME__CHALLENGES) $(__KCL_NAMESPACE__CHALLENGES)

_kcl_unlabel_challenge:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling challenge "$(KCL_CHALLENGE_NAME)" ...'; $(NORMAL)

_kcl_update_challenge:
	@$(INFO) '$(KCL_UI_LABEL)Updating challenge "$(KCL_CHALLENGE_NAME)" ...'; $(NORMAL)

_kcl_view_challenges:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL challenges ...'; $(NORMAL)
	$(KUBECTL) get challenges --all-namespaces=true $(_X__KCL_NAMESPACE__CHALLENGES) $(_X__KCL_SELECTOR_CHALLENGES)

_kcl_view_challenges_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing challenges-set "$(KCL_CHALLENGES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Challenges are grouped based on provided namespace, field-selector, selector, ...'; $(NORMAL)
	$(KUBECTL) get challenges --all-namespaces=false $(__KCL_FIELD_SELECTOR__CHALLENGES) $(__KCL_NAMESPACE__CHALLENGES) $(__KCL_SELECTOR__CHALLENGES)

_kcl_watch_challenges:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL challenges ...'; $(NORMAL)

_kcl_watch_challenges_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching challenges-set "$(KCL_CHALLENGES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Challenges are grouped based on provided namespace, field-selector, selector, ...'; $(NORMAL)
