_KUBECTL_KNATIVE_IMAGE_MK_VERSION= $(_KUBECTL_KNATIVE_MK_VERSION)

# KCL_IMAGE_KUSTOMIZATION_DIRPATH?= ./in/
# KCL_IMAGE_NAME?= go-helloworld-00001
# KCL_IMAGE_NAMESPACE_NAME?= default
# KCL_IMAGE_IMAGES_SELECTOR?= serving.knative.dev/revision=go-helloworld
# KCL_IMAGES_FIELDSELECTOR?= metadata.name=my-image
# KCL_IMAGES_MANIFEST_DIRPATH?= ./in/
# KCL_IMAGES_MANIFEST_FILENAME?= manifest.yaml
# KCL_IMAGES_MANIFEST_FILEPATH?= ./in/manifest.yaml
KCL_IMAGES_MANIFEST_STDINFLAG?= false
# KCL_IMAGES_MANIFEST_URL?= http://...
# KCL_IMAGES_MANIFESTS_DIRPATH?= ./in/manifests/
# KCL_IMAGES_NAMESPACE_NAME?= default
# KCL_IMAGES_OUTPUT?= wide
# KCL_IMAGES_SELECTOR?=
# KCL_IMAGES_SET_NAME?= my-set
# KCL_IMAGES_SHOW_LABELS?= true
# KCL_IMAGES_WATCH_ONLY?= true

# Derived parameters
KCL_IMAGE_KUSTOMIZATION_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_IMAGE_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_IMAGE_NAME?= $(if $(KCL_IMAGE_ID),$(KCL_IMAGE_KSERVICE_NAME)-$(KCL_IMAGE_ID))
KCL_IMAGES_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_IMAGES_MANIFEST_FILEPATH?= $(if $(KCL_IMAGES_MANIFEST_FILENAME),$(KCL_IMAGES_MANIFEST_DIRPATH)$(KCL_IMAGES_MANIFEST_FILENAME))
KCL_IMAGES_NAMESPACE_NAME?= $(KCL_IMAGE_NAMESPACE_NAME)
KCL_IMAGES_SET_NAME?= images@$(KCL_IMAGES_FIELDSELECTOR)@$(KCL_IMAGES_SELECTOR)@$(KCL_IMAGES_NAMESPACE_NAME)

# Option parameters
__KCL_ALL_NAMESPACES__IMAGES=
__KCL_FIELD_SELECTOR__IMAGES= $(if $(KCL_IMAGES_FIELDSELECTOR),--field-selector $(KCL_IMAGES_FIELDSELECTOR))
__KCL_FILENAME__IMAGES+= $(if $(KCL_IMAGES_MANIFEST_FILEPATH),--filename $(KCL_IMAGES_MANIFEST_FILEPATH))
__KCL_FILENAME__IMAGES+= $(if $(filter true,$(KCL_IMAGES_MANIFEST_STDINFLAG)),--filename -)
__KCL_FILENAME__IMAGES+= $(if $(KCL_IMAGES_MANIFEST_URL),--filename $(KCL_IMAGES_MANIFEST_URL))
__KCL_FILENAME__IMAGES+= $(if $(KCL_IMAGES_MANIFESTS_DIRPATH),--filename $(KCL_IMAGES_MANIFESTS_DIRPATH))
__KCL_KUSTOMIZE__IMAGE= $(if $(KCL_IMAGE_KUSTOMIZATION_DIRPATH),--kustomize $(KCL_IMAGE_KUSTOMIZATION_DIRPATH))
__KCL_NAMESPACE__IMAGE= $(if $(KCL_IMAGE_NAMESPACE_NAME),--namespace $(KCL_IMAGE_NAMESPACE_NAME))
__KCL_NAMESPACE__IMAGES= $(if $(KCL_IMAGES_NAMESPACE_NAME),--namespace $(KCL_IMAGES_NAMESPACE_NAME))
__KCL_OUTPUT__IMAGES= $(if $(KCL_IMAGES_OUTPUT),--output $(KCL_IMAGES_OUTPUT))
__KCL_SELECTOR__IMAGES= $(if $(KCL_IMAGES_SELECTOR),--selector=$(KCL_IMAGES_SELECTOR))
__KCL_SHOW_LABELS__IMAGE= $(if $(filter true, $(KCL_IMAGE_SHOW_LABELS)),--show-labels)
__KCL_WATCH_ONLY__IMAGES= $(if $(KCL_IMAGES_WATCH_ONLY),--watch-only=$(KCL_IMAGES_WATCH_ONLY))

# Pipe parameters
|_KCL_KUSTOMIZE_IMAGE?=

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::Knative::Image ($(_KUBECTL_KNATIVE_IMAGE_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::Knative::Image ($(_KUBECTL_KNATIVE_IMAGE_MK_VERSION)) parameters:'
	@echo '    KCL_IMAGE_NAME=$(KCL_IMAGE_NAME)'
	@echo '    KCL_IMAGE_NAMESPACE_NAME=$(KCL_IMAGE_NAMESPACE_NAME)'
	@echo '    KCL_IMAGES_FIELDSELECTOR=$(KCL_IMAGES_FIELDSELECTOR)'
	@echo '    KCL_IMAGES_MANIFEST_DIRPATH=$(KCL_IMAGES_MANIFEST_DIRPATH)'
	@echo '    KCL_IMAGES_MANIFEST_FILENAME=$(KCL_IMAGES_MANIFEST_FILENAME)'
	@echo '    KCL_IMAGES_MANIFEST_FILEPATH=$(KCL_IMAGES_MANIFEST_FILEPATH)'
	@echo '    KCL_IMAGES_MANIFEST_STDINFLAG=$(KCL_IMAGES_MANIFEST_STDINFLAG)'
	@echo '    KCL_IMAGES_MANIFEST_URL=$(KCL_IMAGES_MANIFEST_URL)'
	@echo '    KCL_IMAGES_MANIFESTS_DIRPATH=$(KCL_IMAGES_MANIFESTS_DIRPATH)'
	@echo '    KCL_IMAGES_NAMESPACE_NAME=$(KCL_IMAGES_NAMESPACE_NAME)'
	@echo '    KCL_IMAGES_OUTPUT=$(KCL_IMAGES_OUTPUT)'
	@echo '    KCL_IMAGES_SELECTOR=$(KCL_IMAGES_SELECTOR)'
	@echo '    KCL_IMAGES_SET_NAME=$(KCL_IMAGES_SET_NAME)'
	@echo '    KCL_IMAGES_SHOW_LABELS=$(KCL_IMAGES_SHOW_LABELS)'
	@echo '    KCL_IMAGES_WATCH_ONLY=$(KCL_IMAGES_WATCH_ONLY)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::Knative::Image ($(_KUBECTL_KNATIVE_IMAGE_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_image                 - Annotate a knative-image'
	@echo '    _kcl_apply_images                   - Apply manifest for one-or-more knative-images'
	@echo '    _kcl_create_image                   - Create a new knative-image'
	@echo '    _kcl_delete_image                   - Delete an existing knative-image'
	@echo '    _kcl_diff_image                     - Diff manifest for one-or-more knative-images'
	@echo '    _kcl_edit_image                     - Edit a knative-image'
	@echo '    _kcl_explain_image                  - Explain the knative-image object'
	@echo '    _kcl_kustomize_image                - Kustomize one-or-more knative-images'
	@echo '    _kcl_label_image                    - Label a knative-image'
	@echo '    _kcl_show_image                     - Show everything related to a knative-image'
	@echo '    _kcl_show_image_description         - Show the description of a knative-image'
	@echo '    _kcl_show_image_object              - Show the object of a knative-image'
	@echo '    _kcl_unapply_images                 - Unapply amnifest for one-or-more knative-images'
	@echo '    _kcl_update_image                   - Update a knative-image'
	@echo '    _kcl_view_images                    - View all knative-images'
	@echo '    _kcl_view_images_set                - View a set of knative-images'
	@echo '    _kcl_watch_images                   - Watch knative-images'
	@echo '    _kcl_watch_images_set               - Watch a set of knative-images'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_image:
	@$(INFO) '$(KCL_UI_LABEL)Annotating knative-image "$(KCL_IMAGE_NAME)" ...'; $(NORMAL)
	# $(KUBECTL) annotate ...

_kcl_apply_image: _kcl_apply_images
_kcl_apply_images:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more knative-images ...'; $(NORMAL)
	$(if $(KCL_IMAGES_MANIFEST_FILEPATH),cat $(KCL_IMAGES_MANIFEST_FILEPATH))
	$(if $(filter true,$(KCL_IMAGES_MANIFEST_STDINFLAG)),$(_KCL_APPLY_IMAGES_|)cat)
	$(if $(KCL_IMAGES_MANIFEST_URL),curl -L $(KCL_IMAGES_MANIFEST_URL))
	$(if $(KCL_IMAGES_MANIFESTS_DIRPATH),ls -al $(KCL_IMAGES_MANIFESTS_DIRPATH))
	$(_KCL_APPLY_IMAGES_|)$(KUBECTL) apply $(__KCL_FILENAME__IMAGES) $(__KCL_NAMESPACE__IMAGES)

_kcl_create_image:
	@$(INFO) '$(KCL_UI_LABEL)Creating knative-image "$(KCL_IMAGE_NAME)" ...'; $(NORMAL)

_kcl_delete_image:
	@$(INFO) '$(KCL_UI_LABEL)Deleting knative-image "$(KCL_IMAGE_NAME)" ...'; $(NORMAL)

_kcl_diff_image: _kcl_diff_images
_kcl_diff_images:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing manifest for one-or-more knative-images ...'; $(NORMAL)
	# cat $(KCL_IMAGES_MANIFEST_FILEPATH)
	# $(_KCL_DIFF_IMAGES_|)cat
	# curl -L $(KCL_IMAGES_MANIFEST_URL)
	# ls -al $(KCL_IMAGES_MANIFESTS_DIRPATH)
	$(_KCL_DIFF_IMAGES_|)$(KUBECTL) diff $(__KCL_FILENAME__IMAGES) $(__KCL_NAMESPACE__IMAGES)

_kcl_edit_image:
	@$(INFO) '$(KCL_UI_LABEL)Editing knative-image "$(KCL_IMAGE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit rev $(__KCL_NAMESPACE__IMAGE) $(KCL_IMAGE_NAME)

_kcl_explain_image:
	@$(INFO) '$(KCL_UI_LABEL)Explaining knative-image object ...'; $(NORMAL)
	$(KUBECTL) explain image

_kcl_kustomize_image: _kcl_kustomize_images
_kcl_kustomize_images:
	@$(INFO) '$(KCL_UI_LABEL)Kustomizing one-or-more knative-images ...'; $(NORMAL)
	$(KUBECTL) kustomize $(KCL_IMAGE_KUSTOMIZATION_DIRPATH) $(|_KCL_KUSTOMIZE_IMAGE)

_kcl_label_image:
	@$(INFO) '$(KCL_UI_LABEL)Labeling knative-image "$(KCL_IMAGE_NAME)" ...'; $(NORMAL)

_KCL_SHOW_IMAGE_TARGETS?= _kcl_show_image_object _kcl_show_image_state _kcl_show_image_description
_kcl_show_image :: $(_KCL_SHOW_IMAGE_TARGETS)

_kcl_show_image_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description knative-serverless-service "$(KCL_IMAGE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Within the cluster, this service is accessible at $(KCL_IMAGE_NAME).$(KCL_IMAGE_NAMESPACE_NAME).svc.cluster.local'; $(NORMAL)
	$(KUBECTL) describe rev $(__KCL_NAMESPACE__IMAGE) $(KCL_IMAGE_NAME)

_kcl_show_image_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of knative-serverless-service "$(KCL_IMAGE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get rev $(__KCL_NAMESPACE__IMAGE) --output yaml $(KCL_IMAGE_NAME) 

_kcl_unapply_image: _kcl_unapply_images
_kcl_unapply_images:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more knative-serverless-services ...'; $(NORMAL)
	# cat $(KCL_IMAGES_MANIFEST_FILEPATH)
	# $(_KCL_UNAPPLY_IMAGES_|)cat
	# curl -L $(KCL_IMAGES_MANIFEST_FILEPATH)
	# curl -L $(KCL_IMAGES_MANIFESTS_DIRPATH)
	$(_KCL_UNAPPLY_IMAGES_|)$(KUBECTL) delete $(__KCL_FILENAME__IMAGES) $(__KCL_NAMESPACE__IMAGES)

_kcl_unlabel_image:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling manifest for knative-serverless-service "$(KCL_IMAGE_NAME)" ...'; $(NORMAL)

_kcl_update_image:
	@$(INFO) '$(KCL_UI_LABEL)Updating knative-serverless-service "$(KCL_IMAGE_NAME)" ...'; $(NORMAL)

_kcl_view_images:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL knative-images ...'; $(NORMAL)
	$(KUBECTL) get king --all-namespaces=true $(_X__KCL_NAMESPACE__IMAGES) $(__KCL_OUTPUT__IMAGES) $(_X__KCL_SELECTOR__IMAGES)$(__KCL_SHOW_LABELS__IMAGES)

_kcl_view_images_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing knative-images-set "$(KCL_IMAGES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Knative-serverless-services are grouped based on the provided namespace, field-selector, selector, and ...'; $(NORMAL)
	$(KUBECTL) get king --all-namespaces=false $(__KCL_FIELD_SELECTOR__IMAGES) $(__KCL_NAMESPACE__IMAGES) $(__KCL_OUTPUT__IMAGES) $(__KCL_SELECTOR__IMAGES) $(__KCL_SHOW_LABELS__IMAGES)

_kcl_watch__images:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL knative-images ...'; $(NORMAL)
	$(KUBECTL) get king $(strip $(_X__KCL_ALL_NAMESPACES__IMAGES) --all-namespaces=true $(_X__KCL_NAMESPACE__IMAGES) $(__KCL_OUTPUT__IMAGES) $(_X__KCL_SELECTOR__IMAGES) $(_X__KCL_WATCH__IMAGES) --watch=true $(__KCL_WATCH_ONLY__IMAGES) )

_kcl_watch_images_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching knative-images-set "$(KCL_IMAGES_SET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get king $(strip $(__KCL_ALL_NAMESPACES__IMAGES) $(__KCL_NAMESPACE__IMAGES) $(__KCL_OUTPUT__IMAGES) $(__KCL_SELECTOR__IMAGES) $(_X__KCL_WATCH__IMAGES) --watch=true $(__KCL_WATCH_ONLY__IMAGES) )
