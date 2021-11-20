_KUBECTL_SECRET_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_SECRET_ANNOTATIONS_KEYS= key1 ...
# KCL_SECRET_ANNOTATIONS_KEYVALUES= key1=value1 ...
# KCL_SECRET_CACERT?= 
# KCL_SECRET_CACERT_DIRPATH?= ./in/ 
KCL_SECRET_CACERT_FILENAME?= ca.crt
# KCL_SECRET_CACERT_FILEPATH?= ./in/ca.crt
# KCL_SECRET_CERTIFICATE_DIRPATH?= ./in/
# KCL_SECRET_CERTIFICATE_FILENAME?= certificate.crt
# KCL_SECRET_CERTIFICATE_FILEPATH?= ./in/certificate.crt
# KCL_SECRET_COPY_NAME?= my-secret-copy
# KCL_SECRET_COPY_NAMESPACENAME?= default
# KCL_SECRET_DOCKER_EMAIL?= my@email.com
# KCL_SECRET_DOCKER_PASSWORD?= XXXXXXXXXX
# KCL_SECRET_DOCKER_SERVER?= https://index.docker.io/v1/
# KCL_SECRET_DOCKER_USERNAME?= malliot
# KCL_SECRET_DOWNLOAD_DIRPATH?= ./
# KCL_SECRET_FIELD_JSONPATH?= .spec
# KCL_SECRET_FILE_DIRPATH?= ./in/
# KCL_SECRET_FILE_FILENAME?= secret.txt
# KCL_SECRET_FILE_FILEPATH?= ./in/secret.txt
# KCL_SECRET_FILES_FILEPATHS?= ./in/secret.txt ...
# KCL_SECRET_JWT?=
# KCL_SECRET_KEYS= "tls.crt" "tls.key" client-secret ...
# KCL_SECRET_KUSTOMIZATION_DIRPATH= ./
# KCL_SECRET_LABELS_KEYS= key1 ...
# KCL_SECRET_LABELS_KEYVALUES= key1=value1 ...
# KCL_SECRET_LITERALS_KEYVALUES= username=devuser ...
# KCL_SECRET_NAME?= my-secret
# KCL_SECRET_NAMESPACE_NAME?= default
# KCL_SECRET_PATCH?= "$(cat patch.yaml)"
# KCL_SECRET_PATCH_DIRPATH?= ./in/
# KCL_SECRET_PATCH_FILENAME?= patch.yaml
# KCL_SECRET_PATCH_FILEPATH?= ./in/patch.yaml
# KCL_SECRET_PATCH_TYPE?= merge
# KCL_SECRET_PRIVATEKEY_DIRPATH?= ./in/
# KCL_SECRET_PRIVATEKEY_FILENAME?= certificate.key
# KCL_SECRET_PRIVATEKEY_FILEPATH?= ./in/certificate.key
KCL_SECRET_TYPE?= generic
# KCL_SECRETS_FIELDSELECTOR?= metadata.name=my-secret
# KCL_SECRETS_MANIFEST_DIRPATH?= ./in/
# KCL_SECRETS_MANIFEST_FILENAME?= manifest.yaml
# KCL_SECRETS_MANIFEST_FILEPATH?= ./in/manifest.yaml
KCL_SECRETS_MANIFEST_STDINFLAG?= false
# KCL_SECRETS_MANIFEST_URL?= http://...
# KCL_SECRETS_MANIFESTS_DIRPATH?= ./in/manifests/
# KCL_SECRETS_NAMESPACE_NAME?= default
# KCL_SECRETS_SELECTOR?= app=istio
# KCL_SECRETS_SET_NAME?= my-secrets-set

# Derived parameters
KCL_SECRET_CACERT_DIRPATH?= $(KCL_OUTPUTS_DIRPATH)
KCL_SECRET_CACERT_FILEPATH?= $(KCL_SECRET_CACERT_DIRPATH)$(KCL_SECRET_CACERT_FILENAME)
KCL_SECRET_CERTIFICATE_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_SECRET_CERTIFICATE_FILEPATH?= $(KCL_SECRET_CERTIFICATE_DIRPATH)$(KCL_SECRET_CERTIFICATE_FILENAME)
KCL_SECRET_COPY_NAME?= $(KCL_SECRET_NAME)
KCL_SECRET_COPY_NAMESPACENAME?= $(KCL_SECRET_NAMESPACE_NAME)
KCL_SECRET_DOWNLOAD_DIRPATH?= $(KCL_OUTPUTS_DIRPATH)$(KCL_SECRET_NAME)/
KCL_SECRET_FILE_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_SECRET_FILE_FILEPATH?= $(if $(KCL_SECRET_FILE_FILENAME),$(KCL_SECRET_FILE_DIRPATH)$(KCL_SECRET_FILE_FILENAME))
KCL_SECRET_FILES_FILEPATHS?= $(KCL_SECRET_FILE_FILEPATH)
KCL_SECRET_KUSTOMIZATION_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_SECRETS_MANIFEST_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_SECRETS_MANIFEST_FILEPATH?= $(KCL_SECRETS_MANIFEST_DIRPATH)$(KCL_SECRETS_MANIFEST_FILENAME)
KCL_SECRET_NAMESPACE_NAME?= $(KCL_NAMESPACE_NAME)
KCL_SECRET_NAMES?= $(KCL_SECRET_NAME)
KCL_SECRET_PRIVATEKEY_DIRPATH?= $(KCL_INPUTS_DIRPATH)
KCL_SECRET_PRIVATEKEY_FILEPATH?= $(KCL_SECRET_PRIVATEKEY_DIRPATH)$(KCL_SECRET_PRIVATEKEY_FILENAME)
KCL_SECRETS_NAMESPACE_NAME?= $(KCL_SECRET_NAMESPACE_NAME)
KCL_SECRETS_SET_NAME?= secrets@$(KCL_SECRETS_NAMESPACE_NAME)

# Options
__KCL_CERT__SECRET= $(if $(KCL_SECRET_CERTIFICATE_FILEPATH),--cert $(KCL_SECRET_CERTIFICATE_FILEPATH))
__KCL_DOCKER_EMAIL= $(if $(KCL_SECRET_DOCKER_EMAIL),--docker-email $(KCL_SECRET_DOCKER_EMAIL))
__KCL_DOCKER_SERVER= $(if $(KCL_SECRET_DOCKER_SERVER),--docker-server $(KCL_SECRET_DOCKER_SERVER))
__KCL_DOCKER_PASSWORD= $(if $(KCL_SECRET_DOCKER_PASSWORD),--docker-password $(KCL_SECRET_DOCKER_PASSWORD))
__KCL_DOCKER_USERNAME= $(if $(KCL_SECRET_DOCKER_USERNAME),--docker-username $(KCL_SECRET_DOCKER_USERNAME))
__KCL_FILENAME__SECRETS+= $(if $(KCL_SECRETS_MANIFEST_FILEPATH),--filename $(KCL_SECRETS_MANIFEST_FILEPATH))
__KCL_FILENAME__SECRETS+= $(if $(filter true,$(KCL_SECRETS_MANIFEST_STDINFLAG)),--filename -)
__KCL_FILENAME__SECRETS+= $(if $(KCL_SECRETS_MANIFEST_URL),--filename $(KCL_SECRETS_MANIFEST_URL))
__KCL_FILENAME__SECRETS+= $(if $(KCL_SECRETS_MANIFESTS_DIRPATH),--filename $(KCL_SECRETS_MANIFESTS_DIRPATH))
__KCL_KUSTOMIZE__SECRET= $(if $(KCL_SECRET_KUSTOMIZATION_DIRPATH),--kustomize $(KCL_SECRET_KUSTOMIZATION_DIRPATH))
__KCL_FROM_FILE__SECRET= $(foreach F, $(KCL_SECRET_FILES_FILEPATHS),--from-file $(F))
__KCL_FROM_LITERAL__SECRET= $(foreach KV, $(KCL_SECRET_LITERALS_KEYVALUES),--from-literal $(KV))
__KCL_KEY__SECRET= $(if $(KCL_SECRET_PRIVATEKEY_FILEPATH),--key $(KCL_SECRET_PRIVATEKEY_FILEPATH))
__KCL_NAMESPACE__SECRET= $(if $(KCL_SECRET_NAMESPACE_NAME),--namespace $(KCL_SECRET_NAMESPACE_NAME))
__KCL_NAMESPACE__SECRETS= $(if $(KCL_SECRETS_NAMESPACE_NAME),--namespace $(KCL_SECRETS_NAMESPACE_NAME))
__KCL_OUTPUT__SECRET= $(if $(KCL_SECRET_OUTPUT_FORMAT),--output $(KCL_SECRET_OUTPUT_FORMAT))
__KCL_OVERWRITE__SECRET=
__KCL_PATCH__SECRET=
__KCL_RECURSIVE__SECRET=
__KCL_TYPE__SECRET=

# Customizations
_KCL_APPLY_SECRETS_|?= #
_KCL_DIFF_SECRETS_|?= $(_KCL_APPLY_SECRETS_|)
_KCL_PATCH_SECRET_|?= #
_KCL_UNAPPLY_SECRETS_|?= $(_KCL_APPLY_SECRETS_|)
|_KCL_CREATE_SECRET?= # --dry-run -o yaml | kubectl apply -f -
|_KCL_KUSTOMIZE_SECRET?= #
|_KCL_SHOW_SECRET_TYPE?= ; echo
|_KCL_PATCH_SECRET?= #

# Macros

# Used with service-account's secrets
_kcl_get_secret_cacert= $(call _kcl_get_secret_cacert_N, $(KCL_SECRET_NAME))
_kcl_get_secret_cacert_N= $(call _kcl_get_secret_cacert_NN, $(1), $(KCL_SECRET_NAMESPACE_NAME))
_kcl_get_secret_cacert_NN= $(call _kcl_get_secret_cacert_NNF, $(1), $(2), $(KCL_SECRET_CACERT_FILEPATH))
_kcl_get_secret_cacert_NNF= $(shell $(KUBECTL) get secret --namespace $(2) $(1) --output jsonpath="{.data['ca\.crt']}" | base64 --decode > $(3); echo "@$(strip $(3))")

# Used with service-account's secretes
_kcl_get_secret_jwt= $(call _kcl_get_secret_jwt_N, $(KCL_SECRET_NAME))
_kcl_get_secret_jwt_N= $(call _kcl_get_secret_jwt_NN, $(1), $(KCL_SECRET_NAMESPACE_NAME))
_kcl_get_secret_jwt_NN= $(shell $(KUBECTL) get secret --namespace $(2) $(1) --output jsonpath="{.data.token}" | base64 --decode)

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@echo 'KubeCtL::Secret ($(_KUBECTL_SECRET_MK_VERSION)) macros:'
	@echo '    _kcl_get_secret_cacert_{|N|NN|NNF}  - Get the CA-cert in a a secret (Name,Namespace,Filepath)'
	@echo '    _kcl_get_secret_jwt_{|N|NN}         - Get the JWT in a a secret (Name,Namespace)'
	@echo

_kcl_list_parameters ::
	@echo 'KubeCtL::Secret ($(_KUBECTL_SECRET_MK_VERSION)) parameters:'
	@echo '    KCL_SECRET_ANNOTATIONS_KEYS=$(KCL_SECRET_ANNOTATIONS_KEYS)'
	@echo '    KCL_SECRET_ANNOTATIONS_KEYVALUES=$(KCL_SECRET_ANNOTATIONS_KEYVALUES)'
	@echo '    KCL_SECRET_CACERT=$(KCL_SECRET_CACERT)'
	@echo '    KCL_SECRET_CACERT_DIRPATH=$(KCL_SECRET_CACERT_DIRPATH)'
	@echo '    KCL_SECRET_CACERT_FILENAME=$(KCL_SECRET_CACERT_FILENAME)'
	@echo '    KCL_SECRET_CACERT_FILEPATH=$(KCL_SECRET_CACERT_FILEPATH)'
	@echo '    KCL_SECRET_CERTIFICATE_DIRPATH=$(KCL_SECRET_CERTIFICATE_DIRPATH)'
	@echo '    KCL_SECRET_CERTIFICATE_FILENAME=$(KCL_SECRET_CERTIFICATE_FILENAME)'
	@echo '    KCL_SECRET_CERTIFICATE_FILEPATH=$(KCL_SECRET_CERTIFICATE_FILEPATH)'
	@echo '    KCL_SECRET_DOCKER_EMAIL=$(KCL_SECRET_DOCKER_EMAIL)'
	@echo '    KCL_SECRET_DOCKER_PASSWORD=$(KCL_SECRET_DOCKER_PASSWORD)'
	@echo '    KCL_SECRET_DOCKER_SERVER=$(KCL_SECRET_DOCKER_SERVER)'
	@echo '    KCL_SECRET_DOCKER_USERNAME=$(KCL_SECRET_DOCKER_USERNAME)'
	@echo '    KCL_SECRET_DOWNLOAD_DIRPATH=$(KCL_SECRET_DOWNLOAD_DIRPATH)'
	@echo '    KCL_SECRET_FIELD_JSONPATH=$(KCL_SECRET_FIELD_JSONPATH)'
	@echo '    KCL_SECRET_FILE_DIRPATH=$(KCL_SECRET_FILE_DIRPATH)'
	@echo '    KCL_SECRET_FILE_FILENAME=$(KCL_SECRET_FILE_FILENAME)'
	@echo '    KCL_SECRET_FILE_FILEPATH=$(KCL_SECRET_FILE_FILEPATH)'
	@echo '    KCL_SECRET_FILES_FILEPATHS=$(KCL_SECRET_FILES_FILEPATHS)'
	@echo '    KCL_SECRET_KEYS=$(KCL_SECRET_KEYS)'
	@echo '    KCL_SECRET_KUSTOMIZATION_DIRPATH=$(KCL_SECRET_KUSTOMIZATION_DIRPATH)'
	@echo '    KCL_SECRET_LABELS_KEYS=$(KCL_SECRET_LABELS_KEYS)'
	@echo '    KCL_SECRET_LABELS_KEYVALUES=$(KCL_SECRET_LABELS_KEYVALUES)'
	@echo '    KCL_SECRET_LITERALS_KEYVALUES=$(KCL_SECRET_LITERALS_KEYVALUES)'
	@echo '    KCL_SECRET_JWT=$(KCL_SECRET_JWT)'
	@echo '    KCL_SECRET_NAME=$(KCL_SECRET_NAME)'
	@echo '    KCL_SECRET_NAMESPACE_NAME=$(KCL_SECRET_NAMESPACE_NAME)'
	@echo '    KCL_SECRET_PATCH=$(KCL_SECRET_PATCH)'
	@echo '    KCL_SECRET_PATCH_DIRPATH=$(KCL_SECRET_PATCH_DIRPATH)'
	@echo '    KCL_SECRET_PATCH_FILENAME=$(KCL_SECRET_PATCH_FILENAME)'
	@echo '    KCL_SECRET_PATCH_FILEPATH=$(KCL_SECRET_PATCH_FILEPATH)'
	@echo '    KCL_SECRET_PATCH_TYPE=$(KCL_SECRET_PATCH_TYPE)'
	@echo '    KCL_SECRET_PRIVATEKEY_DIRPATH=$(KCL_SECRET_PRIVATEKEY_DIRPATH)'
	@echo '    KCL_SECRET_PRIVATEKEY_FILENAME=$(KCL_SECRET_PRIVATEKEY_FILENAME)'
	@echo '    KCL_SECRET_PRIVATEKEY_FILEPATH=$(KCL_SECRET_PRIVATEKEY_FILEPATH)'
	@echo '    KCL_SECRET_TYPE=$(KCL_SECRET_TYPE)'
	@echo '    KCL_SECRETS_FIELDSELECTOR=$(KCL_SECRETS_FIELDSELECTOR)'
	@echo '    KCL_SECRETS_MANIFEST_DIRPATH=$(KCL_SECRETS_MANIFEST_DIRPATH)'
	@echo '    KCL_SECRETS_MANIFEST_FILENAME=$(KCL_SECRETS_MANIFEST_FILENAME)'
	@echo '    KCL_SECRETS_MANIFEST_FILEPATH=$(KCL_SECRETS_MANIFEST_FILEPATH)'
	@echo '    KCL_SECRETS_MANIFEST_STDINFLAG=$(KCL_SECRETS_MANIFEST_STDINFLAG)'
	@echo '    KCL_SECRETS_MANIFEST_URL=$(KCL_SECRETS_MANIFEST_URL)'
	@echo '    KCL_SECRETS_MANIFESTS_DIRPATH=$(KCL_SECRETS_MANIFESTS_DIRPATH)'
	@echo '    KCL_SECRETS_NAMESPACE_NAME=$(KCL_SECRETS_NAMESPACE_NAME)'
	@echo '    KCL_SECRETS_SELECTOR=$(KCL_SECRETS_SELECTOR)'
	@echo '    KCL_SECRETS_SET_NAME=$(KCL_SECRETS_SET_NAME)'
	@echo

_kcl_list_targets ::
	@echo 'KubeCtL::Secret ($(_KUBECTL_SECRET_MK_VERSION)) targets:'
	@echo '    _kcl_annotate_secret                - Annotate a secret'
	@echo '    _kcl_apply_secrets                  - Apply a manifest for one-or-more secret'
	@echo '    _kcl_copy_secret                    - Copy a secret in another'
	@echo '    _kcl_create_secret                  - Create a secret'
	@echo '    _kcl_delete_secret                  - Delete an existing secret'
	@echo '    _kcl_diff_secrets                   - Diff a manifest for one-or-more secrets'
	@echo '    _kcl_download_secret                - Download assets from a secret'
	@echo '    _kcl_edit_secret                    - Edit a secret'
	@echo '    _kcl_explain_secret                 - Explain the secret object'
	@echo '    _kcl_kustomize_secret               - Kustomize one-or-more secrets'
	@echo '    _kcl_label_secret                   - Label a secret'
	@echo '    _kcl_list_secrets                   - List all secrets'
	@echo '    _kcl_list_secrets_set               - List a set ofsecrets'
	@echo '    _kcl_patch_secret                   - Patch a secret'
	@echo '    _kcl_show_secret                    - Show everything related to a secret'
	@echo '    _kcl_show_secret_description        - Show the description of a secret'
	@echo '    _kcl_show_secret_endpoints          - Show the endpoints of a secret'
	@echo '    _kcl_show_secret_pods               - Show the pods using a secret'
	@echo '    _kcl_unannotate_secret              - Un-annotate a secret'
	@echo '    _kcl_unapply_secrets                - Un-apply a manifest for one-or-more secrets'
	@echo '    _kcl_unlabel_secret                 - Un-label a secret'
	@echo '    _kcl_watch_secrets                  - Watch all secrets'
	@echo '    _kcl_watch_secrets_set              - Watch a set of secrets'
	@echo '    _kcl_write_secrets                  - Write a manifest for one-or-more secrets'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#



#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_annotate_secret:
	@$(INFO) '$(KCL_UI_LABEL)Annotating secret "$(KCL_SECRET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) annotate $(__KCL_NAMESPACE__SECRET) $(KCL_SECRET_NAME) $(KCL_SECRET_ANNOTATIONS_KEYVALUES)

_kcl_apply_secret: _kcl_apply_secrets
_kcl_apply_secrets:
	@$(INFO) '$(KCL_UI_LABEL)Applying manifest for one-or-more secrets ...'; $(NORMAL)
	$(if $(KCL_SECRETS_MANIFEST_FILEPATH),cat $(KCL_SECRETS_MANIFEST_FILEPATH); echo)
	$(if $(filter $(KCL_SECRETS_MANIFEST_STDINFLAG)),$(_KCL_APPLY_SECRETS_|)cat)
	$(if $(KCL_SECRETS_MANIFEST_URL),curl -L $(KCL_SECRETS_MANIFEST_URL); echo)
	$(if $(KCL_SECRETS_MANIFESTS_DIRPATH),ls -al $(KCL_SECRETS_MANIFESTS_DIRPATH); echo)
	$(_KCL_APPLY_SECRETS_|)$(KUBECTL) apply $(__KCL_FILENAME__SECRETS) $(__KCL_NAMESPACE__SECRETS)

_kcl_create_secret:
	@$(INFO) '$(KCL_UI_LABEL)Creating secret "$(KCL_SECRET_NAME)" ...'; $(NORMAL)
	$(if $(filter generic, $(KCL_SECRET_TYPE)), \
		$(KUBECTL) create secret generic $(__KCL_FROM_FILE__SECRET) $(__KCL_FROM_LITERAL__SECRET) $(__KCL_NAMESPACE__SECRET) $(KCL_SECRET_NAME) \
	)
	$(if $(filter tls, $(KCL_SECRET_TYPE)), \
		cat $(KCL_SECRET_CERTIFICATE_FILEPATH); echo; \
		cat $(KCL_SECRET_PRIVATEKEY_FILEPATH) | head -3; echo; \
		$(KUBECTL) create secret tls $(__KCL_CERT__SECRET) $(__KCL_KEY__SECRET) $(__KCL_NAMESPACE__SECRET) $(KCL_SECRET_NAME) $(|_KCL_CREATE_SECRET) \
	)
	$(if $(filter docker-registry, $(KCL_SECRET_TYPE)), \
		$(KUBECTL) create secret docker-registry $(__KCL_DOCKER_EMAIL) $(__KCL_DOCKER_PASSWORD) $(__KCL_DOCKER_SERVER) $(__KCL_DOCKER_USERNAME) $(__KCL_NAMESPACE__SECRET) $(KCL_SECRET_NAME) $(|_KCL_CREATE_SECRET) \
	)

_kcl_delete_secret:
	@$(INFO) '$(KCL_UI_LABEL)Deleting secret "$(KCL_SECRET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) delete secret $(__KCL_NAMESPACE__SECRET) $(KCL_SECRET_NAME)

_kcl_copy_secret:
	@$(INFO) '$(KCL_UI_LABEL)Copying secret "$(KCL_SECRET_NAME)@$(KCL_SECRET_NAMESPACE_NAME)" to "$(KCL_SECRET_COPY_NAME)@$(KCL_SECRET_COPY_NAMESPACENAME)"...'; $(NORMAL)
	@$(WARN) 'This operation copy the entire content of the secret including annotations and labels'; $(NORMAL)
	@$(WARN) 'This operation is a no-op if the name and namespace of the copy are the same as the original secret'; $(NORMAL)
	$(KUBECTL) get secret $(__KCL_NAMESPACE__SECRET) $(KCL_SECRET_NAME) --output yaml \
		| sed 's/namespace: $(KCL_SECRET_NAMESPACE_NAME)/namespace: $(KCL_SECRET_COPY_NAMESPACENAME)/' \
		| sed 's/name: $(KCL_SECRET_NAME)/name: $(KCL_SECRET_COPY_NAME)/' \
		| $(KUBECTL) apply -f -

_kcl_diff_secret: _kcl_diff_secrets
_kcl_diff_secrets:
	@$(INFO) '$(KCL_UI_LABEL)Diff-ing manifest for one-or-more secrets ...'; $(NORMAL)
	@$(WARN) 'This operation submits the manifest to the cluster to take webhooks into consideration'; $(NORMAL)
	# cat $(KCL_SECRETS_MANIFEST_FILEPATH)
	# $(_KCL_DIFF_SECRETS_|)cat
	# curl -L $(KCL_SECRETS_MANIFEST_URL)
	# ls -al $(KCL_SECRETS_MANIFESTS_DIRPATH)
	$(_KCL_DIFF_SECRETS_|)$(KUBECTL) diff $(__KCL_FILENAME__SECRETS) $(__KCL_NAMESPACE__SECRETS)

_kcl_download_secret:
	@$(INFO) '$(KCL_UI_LABEL)Downloading assets from secret "$(KCL_SECRET_NAME)" ...'; $(NORMAL)
	$(if $(KCL_SECRET_TYPE), \
		mkdir -p -v $(KCL_SECRET_DOWNLOAD_DIRPATH), \
		@echo 'KCL_SECRET_TYPE not set ...' \
	)
	$(if $(filter generic, $(KCL_SECRET_TYPE)), echo 'Getting FIELD')
	$(if $(filter serviceaccount, $(KCL_SECRET_TYPE)), echo 'Getting JWT and CERT')
	$(if $(filter tls, $(KCL_SECRET_TYPE)), \
		$(KUBECTL) get secret  $(__KCL_NAMESPACE__SECRET) $(KCL_SECRET_NAME) --output jsonpath="{.data['ca\.crt']}" | base64 --decode | tee $(KCL_SECRET_DOWNLOAD_DIRPATH)ca.crt\
	)
	$(if $(filter tls, $(KCL_SECRET_TYPE)), \
		$(KUBECTL) get secret  $(__KCL_NAMESPACE__SECRET) $(KCL_SECRET_NAME) --output jsonpath="{.data['tls\.crt']}" | base64 --decode | tee $(KCL_SECRET_DOWNLOAD_DIRPATH)tls.crt\
	)
	$(if $(filter tls, $(KCL_SECRET_TYPE)), \
		$(KUBECTL) get secret  $(__KCL_NAMESPACE__SECRET) $(KCL_SECRET_NAME) --output jsonpath="{.data['tls\.key']}" | base64 --decode | tee $(KCL_SECRET_DOWNLOAD_DIRPATH)tls.key\
	)

_kcl_edit_secret:
	@$(INFO) '$(KCL_UI_LABEL)Editing secret "$(KCL_SECRET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) edit secret $(__KCL_NAMESPACE__SECRET) $(KCL_SECRET_NAME)

_kcl_explain_secret:
	@$(INFO) '$(KCL_UI_LABEL)Explaining service object ...'; $(NORMAL)
	@$(WARN) 'This operation fails if you do not have access to a cluster'; $(NORMAL)
	$(KUBECTL) explain secret$(KCL_SECRET_FIELD_JSONPATH) $(__KCL_RECURSIVE__SECRET)

_kcl_kustomize_secret: _kcl_kustomize_secrets
_kcl_kustomize_secrets:
	@$(INFO) '$(KCL_UI_LABEL)Kustomizing one-or-more secrets ...'; $(NORMAL)
	$(KUBECTL) kustomize $(KCL_SECRET_KUSTOMIZATION_DIRPATH) $(|_KCL_KUSTOMIZE_SECRET)

_kcl_label_secret:
	@$(INFO) '$(KCL_UI_LABEL)Labeling secret "$(KCL_SECRET_NAME)" ...'; $(NORMAL)

_kcl_list_secrets:
	@$(INFO) '$(KCL_UI_LABEL)Listing ALL secrets ...'; $(NORMAL)
	$(KUBECTL) get secret --all-namespaces=true $(_X__KCL_NAMESPACE__SECRETS)

_kcl_list_secrets_set:
	@$(INFO) '$(KCL_UI_LABEL)Listing secrets-set "$(KCL_SECRETS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Secrets are grouped based on the provided namespace'; $(NORMAL)
	$(KUBECTL) get secret --all-namespaces=false $(__KCL_NAMESPACE__SECRETS)

_kcl_patch_secret:
	@$(INFO) '$(KCL_UI_LABEL)Updating secret "$(KCL_SECRET_NAME)" ...'; $(NORMAL)
	$(_KCL_PATCH_SECRET_|) $(KUBECTL) patch secret $(__KCL_NAMESPACE__SECRET) $(__KCL_PATCH__SECRET) $(__KCL_TYPE__SECRET) $(KCL_SECRET_NAME) $(|_KCL_PATCH_SECRET)

_KCL_SHOW_SECRET_TARGETS?= _kcl_show_secret_data _kcl_show_secret_state _kcl_show_secret_type _kcl_show_secret_description
_kcl_show_secret: $(_KCL_SHOW_SECRET_TARGETS)

_kcl_show_secret_data:
	@$(INFO) '$(KCL_UI_LABEL)Showing data secret "$(KCL_SECRET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation displays base64 encoded values. To decode: echo "<value>" | base64 --decode'; $(NORMAL)
	@$(WARN) 'If the secret-type is docker-registry, the returned .dockerconfigjson is a base64-encoded configuration file'; $(NORMAL)
	@$(WARN) 'If the secret-type is generic/Opaque, the values in the returned key-value pairs are base64-encoded'; $(NORMAL)
	@$(WARN) 'If the secret-type is service-account, the certificate of authority (ca-cert) and JWT (token) are base64-encoded'; $(NORMAL)
	@$(WARN) 'If the secret-type is tls, the certificate (tls.crt), pairing private-key (tls.key), and optional CA (ca.crt) are base64-encoded'; $(NORMAL)
	$(KUBECTL) get secret  $(__KCL_NAMESPACE__SECRET) $(KCL_SECRET_NAME) --output jsonpath='{.data}' $(|_KCL_SHOW_SECRET_DATA)

_kcl_show_secret_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of secret "$(KCL_SECRET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'To display the full content of the secret, get the yaml formatted output!'; $(NORMAL)
	@$(WARN) 'If the secret-type is docker-registry, returned is a docker configuration file with username and registry credentials'; $(NORMAL) 
	@$(WARN) 'If the secret-type is generic/Opaque, returned are the keys of the key-value pairs'; $(NORMAL) 
	@$(WARN) 'If the secret-type is service-account, returned is a base64-DECODED JSON Web Token (JWT)'; $(NORMAL)
	@$(WARN) 'If the secret-type is tls, returned is the length of the content of tls.crt, tls.key, and optional ca.crt'; $(NORMAL)
	@$(WARN) 'Regardless of the secret-type, the keys are the names of the files mounted in the secret volume, values are their respective content'; $(NORMAL)
	$(KUBECTL) describe secret $(__KCL_NAMESPACE__SECRET) $(KCL_SECRET_NAME)

_kcl_show_secret_state:
	@$(INFO) '$(KCL_UI_LABEL)Showing state of secret "$(KCL_SECRET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get secret $(__KCL_NAMESPACE__SECRET) $(KCL_SECRET_NAME)

_kcl_show_secret_type:
	@$(INFO) '$(KCL_UI_LABEL)Showing content of secret "$(KCL_SECRET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'KCL_SECRET_TYPE=$(KCL_SECRET_TYPE)'; $(NORMAL)
	$(if $(filter docker-registry, $(KCL_SECRET_TYPE)), \
		$(KUBECTL) get secret  $(__KCL_NAMESPACE__SECRET) $(KCL_SECRET_NAME) --output jsonpath='{.data.\.dockerconfigjson}' | base64 --decode $(|_KCL_SHOW_SECRET_TYPE) \
	)
	$(if $(filter generic, $(KCL_SECRET_TYPE)), \
		$(foreach K, $(KCL_SECRET_KEYS), \
			$(KUBECTL) get secret $(__KCL_NAMESPACE__SECRET) $(KCL_SECRET_NAME) --output jsonpath='{.data.$(K)}' | base64 --decode $(|_KCL_SHOW_SECRET_TYPE) \
		) \
	)
	$(if $(filter tls, $(KCL_SECRET_TYPE)), \
		$(KUBECTL) get secret  $(__KCL_NAMESPACE__SECRET) $(KCL_SECRET_NAME) --output jsonpath="{.data['ca\.crt']}" | base64 --decode | openssl x509 -text 2>/dev/null $(|_KCL_SHOW_SECRET_TYPE) \
	)
	$(if $(filter tls, $(KCL_SECRET_TYPE)), \
		$(KUBECTL) get secret  $(__KCL_NAMESPACE__SECRET) $(KCL_SECRET_NAME) --output jsonpath="{.data['tls\.crt']}" | base64 --decode | openssl x509 -text $(|_KCL_SHOW_SECRET_TYPE) \
	)
	$(if $(filter tls, $(KCL_SECRET_TYPE)), \
		$(KUBECTL) get secret  $(__KCL_NAMESPACE__SECRET) $(KCL_SECRET_NAME) --output jsonpath="{.data['tls\.key']}" | base64 --decode | head -3; echo '...' $(|_KCL_SHOW_SECRET_TYPE) \
	)

_kcl_unannotate_secret:
	@$(INFO) '$(KCL_UI_LABEL)Un-annotate secret "$(KCL_SECRET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) annotate secret $(__KCL_NAMESPACE__SECRET) $(KCL_SECRET_NAME) $(foreach K, $(KCL_SECRET_ANNOTATIONS_KEYS), $(K)-)

_kcl_unapply_secret: _kcl_unapply_secrets
_kcl_unapply_secrets:
	@$(INFO) '$(KCL_UI_LABEL)Un-applying manifest for one-or-more secrets ...'; $(NORMAL)
	# cat $(KCL_SECRETS_MANIFEST_FILEPATH)
	# $(_KCL_UNAPPLY_SECRETS_|)cat
	# curl -L $(KCL_SECRETS_MANIFEST_URL)
	# ls -al $(KCL_SECRETS_MANIFESTS_DIRPATH)
	$(_KCL_UNAPPLY_SECRETS_|)$(KUBECTL) delete $(__KCL_FILENAME__SECRETS) $(__KCL_NAMESPACE__SECRETS)

_kcl_unlabel_secret:
	@$(INFO) '$(KCL_UI_LABEL)Un-label secret "$(KCL_SECRET_NAME)" ...'; $(NORMAL)
	$(KUBECTL) label secret $(__KCL_NAMESPACE__SECRET) $(KCL_SECRET_NAME) $(foreach K, $(KCL_SECRET_LABELS_KEYS), $(K)-)

_kcl_watch_secrets:
	@$(INFO) '$(KCL_UI_LABEL)Watching ALL secrets ...'; $(NORMAL)
	$(KUBECTL) get secret --all-namespaces=true $(_X__KCL_NAMESPACE__SECRETS) --watch

_kcl_watch_secrets_set:
	@$(INFO) '$(KCL_UI_LABEL)Watching secrets-set "$(KCL_SECRETS_SET_NAME)" ...'; $(NORMAL)

_kcl_write_secrets:
	@$(INFO) '$(KCL_UI_LABEL)Writing manifest for one-or-more secrets ...'; $(NORMAL)
	$(WRITER) $(KCL_SECRETS_MANIFEST_FILEPATH)
