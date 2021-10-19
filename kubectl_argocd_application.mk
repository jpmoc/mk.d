_KUBECTL_ARGOCD_APPLICATION_MK_VERSION= $(_KUBECTL_ARGOCD_MK_VERSION)

# KCL_APPLICATION_NAME?=
# KCL_APPLICATION_NAMESPACE_NAME?= default
# KCL_APPLICATION_PODS_SELECTOR?= app=application-name
# KCL_APPLICATIONS_FIELDSELECTOR?= metadata.name=my-application
# KCL_APPLICATIONS_NAMESPACE_NAME?= default
# KCL_APPLICATIONS_SELECTOR?=
# KCL_APPLICATIONS_SET_NAME?= my-applications-set
# KCL_APPLICATIONS_SHOW_LABELS?= true
# KCL_APPLICATIONS_WATCH_ONLY?= true

# Derived parameters
KCL_APPLICATION_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_APPLICATIONS_NAMESPACE_NAME?= $(KCL_APPLICATION_NAMESPACE_NAME)
KCL_APPLICATIONS_SET_NAME?= applications@$(KCL_APPLICATIONS_FIELDSELECTOR)@$(KCL_APPLICATIONS_SELECTOR)@$(KCL_APPLICATIONS_NAMESPACE_NAME)

# Option parameters
__KCL_ALL_NAMESPACES__APPLICATIONS=
__KCL_FIELD_SELECTOR__APPLICATIONS= $(if $(KCL_APPLICATIONS_FIELDSELECTOR),--field-selector $(KCL_APPLICATIONS_FIELDSELECTOR))
__KCL_NAMESPACE__APPLICATION= $(if $(KCL_APPLICATION_NAMESPACE_NAME),--namespace $(KCL_APPLICATION_NAMESPACE_NAME))
__KCL_NAMESPACE__APPLICATIONS= $(if $(KCL_APPLICATIONS_NAMESPACE_NAME),--namespace $(KCL_APPLICATIONS_NAMESPACE_NAME))
__KCL_OUTPUT__APPLICATIONS= $(if $(KCL_APPLICATIONS_OUTPUT),--output $(KCL_APPLICATIONS_OUTPUT))
__KCL_SELECTOR__APPLICATIONS= $(if $(KCL_APPLICATIONS_SELECTOR),--selector=$(KCL_APPLICATIONS_SELECTOR))
__KCL_SHOW_LABELS__APPLICATIONS= $(if $(filter true, $(KCL_APPLICATIONS_SHOW_LABELS)),--show-labels)
__KCL_WATCH_ONLY__APPLICATIONS= $(if $(KCL_APPLICATIONS_WATCH_ONLY),--watch-only=$(KCL_APPLICATIONS_WATCH_ONLY))

# Pipe parameters

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::ArgoCD::Application ($(_KUBECTL_ARGOCD_APPLICATION_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::ArgoCD::Application ($(_KUBECTL_ARGOCD_APPLICATION_MK_VERSION)) parameters:'
	@echo '    KCL_APPLICATION_NAME=$(KCL_APPLICATION_NAME)'
	@echo '    KCL_APPLICATION_NAMESPACE_NAME=$(KCL_APPLICATION_NAMESPACE_NAME)'
	@echo '    KCL_APPLICATION_PODS_SELECTOR=$(KCL_APPLICATION_PODS_SELECTOR)'
	@echo '    KCL_APPLICATIONS_FIELDSELECTOR=$(KCL_APPLICATIONS_FIELDSELECTOR)'
	@echo '    KCL_APPLICATIONS_NAMESPACE_NAME=$(KCL_APPLICATIONS_NAMESPACE_NAME)'
	@echo '    KCL_APPLICATIONS_OUTPUT=$(KCL_APPLICATIONS_OUTPUT)'
	@echo '    KCL_APPLICATIONS_SELECTOR=$(KCL_APPLICATIONS_SELECTOR)'
	@echo '    KCL_APPLICATIONS_SET_NAME=$(KCL_APPLICATIONS_SET_NAME)'
	@echo '    KCL_APPLICATIONS_SHOW_LABELS=$(KCL_APPLICATIONS_SHOW_LABELS)'
	@echo '    KCL_APPLICATIONS_WATCH_ONLY=$(KCL_APPLICATIONS_WATCH_ONLY)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::ArgoCD::Application ($(_KUBECTL_ARGOCD_APPLICATION_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_application            - Annotate an application'
	@echo '    _kcl_apply_application               - Apply manifest for one-or-more applications'
	@echo '    _kcl_create_application              - Create a new application'
	@echo '    _kcl_delete_application              - Delete an existing application'
	@echo '    _kcl_diff_application                - Diff manifest for one-or-more applications'
	@echo '    _kcl_edit_application                - Edit a application'
	@echo '    _kcl_explain_application             - Explain the application object'
	@echo '    _kcl_kustomize_application           - Kustomize one-or-more applications'
	@echo '    _kcl_label_application               - Label a application'
	@echo '    _kcl_show_application                - Show everything related to a application'
	@echo '    _kcl_show_application_description    - Show the description of a application'
	@echo '    _kcl_show_application_object         - Show the object of a application'
	@echo '    _kcl_show_application_pods           - Show the pods of a application'
	@echo '    _kcl_show_application_state          - Show the state of a application'
	@echo '    _kcl_unapply_application             - Unapply a application'
	@echo '    _kcl_update_application              - Update a application'
	@echo '    _kcl_view_applications               - View all applications'
	@echo '    _kcl_view_applications_set           - View a set of applications'
	@echo '    _kcl_watch_applications              - Watch applications'
	@echo '    _kcl_watch_applications_set          - Watch a set of applications'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_application:
	@$(INFO) '$(KCL_UI_LABEL)Annotating application "$(KCL_APPLICATION_NAME)" ...'; $(NORMAL)

_kcl_apply_application: _kcl_apply_applications
_kcl_apply_applications:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more applications ...'; $(NORMAL)
	# $(if $(KCL_APPLICATION_MANIFEST_FILEPATH), cat $(KCL_APPLICATION_MANIFEST_FILEPATH))
	# $(if $(KCL_APPLICATION_MANIFEST_URL), curl -L $(KCL_APPLICATION_MANIFEST_URL))
	# $(KUBECTL) apply $(__KCL_FILENAME__APPLICATION) $(__KCL_NAMESPACE__APPLICATION)

_kcl_create_application:
	@$(INFO) '$(KCL_UI_LABEL)Creating application "$(KCL_APPLICATION_NAME)" ...'; $(NORMAL)

_kcl_delete_application:
	@$(INFO) '$(KCL_UI_LABEL)Deleting application "$(KCL_APPLICATION_NAME)" ...'; $(NORMAL)

_kcl_diff_application: _kcl_diff_applications
_kcl_diff_applications:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing manifest for one-or-more applications ...'; $(NORMAL)
	# cat $(KCL_APPLICATION_MANIFEST_FILEPATH)
	# curl -L $(KCL_APPLICATION_MANIFEST_URL)
	# $(KUBECTL) diff $(__KCL_FILENAME__APPLICATION) $(__KCL_NAMESPACE__APPLICATION)

_kcl_edit_application:
	@$(INFO) '$(KCL_UI_LABEL)Editing application "$(KCL_APPLICATION_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit application $(__KCL_NAMESPACE__APPLICATION) $(KCL_APPLICATION_NAME)

_kcl_explain_application:
	@$(INFO) '$(KCL_UI_LABEL)Explaining application object ...'; $(NORMAL)
	$(KUBECTL) explain application

_kcl_kustomize_application: _kcl_kustomize_applications
_kcl_kustomize_applications:
	@$(INFO) '$(KCL_UI_LABEL)Kustomizing one-or-more applications ...'; $(NORMAL)
	# $(KUBECTL) kustomize $(KCL_APPLICATION_KUSTOMIZATION_DIRPATH) $(|_KCL_KUSTOMIZE_APPLICATION)

_kcl_label_application:
	@$(INFO) '$(KCL_UI_LABEL)Labeling application "$(KCL_APPLICATION_NAME)" ...'; $(NORMAL)

_kcl_show_application: _kcl_show_application_object _kcl_show_application_pods _kcl_show_application_state _kcl_show_application_description

_kcl_show_application_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description application "$(KCL_APPLICATION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Within the cluster, this application is accessible at $(KCL_APPLICATION_NAME).$(KCL_APPLICATION_NAMESPACE_NAME).svc.cluster.local'; $(NORMAL)
	$(KUBECTL) describe application $(__KCL_NAMESPACE__APPLICATION) $(KCL_APPLICATION_NAME)

_kcl_show_application_object:
	@$(INFO) '$(KCL_UI_LABEL)Showing object of application "$(KCL_APPLICATION_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get application $(__KCL_NAMESPACE__APPLICATION) --output yaml $(KCL_APPLICATION_NAME) 

_kcl_show_application_pods:
	@$(INFO) '$(KCL_UI_LABEL)Showing pods of application "$(KCL_APPLICATION_NAME)" ...'; $(NORMAL)
	$(if $(KCL_APPLICATION_PODS_FIELDSELECTOR)$(KCL_APPLICATION_PODS_SELECTOR), \
		$(KUBECTL) get pods $(__KCL_NAMESPACE__APPLICATION) --output wide \
			$(if $(KCL_APPLICATION_PODS_FIELDSELECTOR),--field-selector $(KCL_APPLICATION_PODS_FIELDSELECTOR)) \
			$(if $(KCL_APPLICATION_PODS_SELECTOR),--selector $(KCL_APPLICATION_PODS_SELECTOR)) \
	, @\
		echo 'KCL_APPLICATION_PODS_FIELDSELECTOR not set'; \
		echo 'KCL_APPLICATION_PODS_SELECTOR not set'; \
	)

_kcl_show_application_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of application "$(KCL_APPLICATION_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get application $(__KCL_NAMESPACE__APPLICATION) $(KCL_APPLICATION_NAME) 

_kcl_unapply_application: _kcl_unapply_applications
_kcl_unapply_applications:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more applications ...'; $(NORMAL)
	# cat $(KCL_APPLICATION_MANIFEST_FILEPATH)
	# curl -L $(KCL_APPLICATION_MANIFEST_FILEPATH)
	# $(KUBECTL) delete $(__KCL_FILENAME__APPLICATION) $(__KCL_NAMESPACE__APPLICATION)

_kcl_unlabel_application:
	@$(INFO) '$(KCL_UI_LABEL)Un-labeling manifest for application "$(KCL_APPLICATION_NAME)" ...'; $(NORMAL)

_kcl_update_application:
	@$(INFO) '$(KCL_UI_LABEL)Updating application "$(KCL_APPLICATION_NAME)" ...'; $(NORMAL)

_kcl_view_applications:
	@$(INFO) '$(KCL_UI_LABEL)Viewing applications ...'; $(NORMAL)
	$(KUBECTL) get applications --all-namespaces=true $(_X__KCL_NAMESPACE__APPLICATIONS) $(__KCL_OUTPUT__APPLICATIONS) $(_X__KCL_SELECTOR__APPLICATIONS)$(__KCL_SHOW_LABELS__APPLICATIONS)

_kcl_view_applications_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing applications-set "$(KCL_APPLICATIONS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Applications are grouped based on the provided namespace, field-selector, selector, and ...'; $(NORMAL)
	$(KUBECTL) get applications --all-namespaces=false $(__KCL_FIELD_SELECTOR__APPLICATIONS) $(__KCL_NAMESPACE__APPLICATIONS) $(__KCL_OUTPUT__APPLICATIONS) $(__KCL_SELECTOR__APPLICATIONS) $(__KCL_SHOW_LABELS__APPLICATIONS)

_kcl_watch_applications:
	@$(INFO) '$(KCL_UI_LABEL)Watching applications ...'; $(NORMAL)
	$(KUBECTL) get applications $(strip $(_X__KCL_ALL_NAMESPACES__APPLICATIONS) --all-namespaces=true $(_X__KCL_NAMESPACE__APPLICATIONS) $(__KCL_OUTPUT__APPLICATIONS) $(_X__KCL_SELECTOR__APPLICATIONS) $(_X__KCL_WATCH__APPLICATIONS) --watch=true $(__KCL_WATCH_ONLY__APPLICATIONS) )

_kcl_watch_applications_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching applications ...'; $(NORMAL)
	$(KUBECTL) get applications $(strip $(__KCL_ALL_NAMESPACES__APPLICATIONS) $(__KCL_NAMESPACE__APPLICATIONS) $(__KCL_OUTPUT__APPLICATIONS) $(__KCL_SELECTOR__APPLICATIONS) $(_X__KCL_WATCH__APPLICATIONS) --watch=true $(__KCL_WATCH_ONLY__APPLICATIONS) )
