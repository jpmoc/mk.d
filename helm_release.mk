_HELM_RELEASE_MK_VERSION= $(_HELM_MK_VERSION)

# HLM_RELEASE_CHART_CNAME?= stable/redis
# HLM_RELEASE_CHART_NAME?= redis
# HLM_RELEASE_CHART_VERSION?= 0.5.1
# HLM_RELEASE_CHARTREPOSITORY_NAME?= stable
# HLM_RELEASE_CURL?= curl
# HLM_RELEASE_DIG?= dig
# HLM_RELEASE_DNSNAME?= host.sub.example.com
# HLM_RELEASE_DNSNAME_DOMAIN?= example.com
# HLM_RELEASE_DNSNAME_HOSTNAME?= host
# HLM_RELEASE_DNSNAME_SUBDOMAIN?= sub.example.com
HLM_RELEASE_MAX_COUNT?= 256
# HLM_RELEASE_NAME?= happy-panda
# HLM_RELEASE_NAMESPACE_NAME?= default
# HLM_RELEASE_REVISION_ID?= 1
# HLM_RELEASE_UPGRADE_INSTALLENABLE?= true
# HLM_RELEASE_URL?= http://host.sub.example.com
# HLM_RELEASE_URL_PORT?= 80
# HLM_RELEASE_URL_PROTOCOL?= http://
# HLM_RELEASE_VALUES_DIRPATH?= ./in/
# HLM_RELEASE_VALUES_FILENAME?= values.yml
# HLM_RELEASE_VALUES_FILEPATH?= ./in/values.yml
# HLM_RELEASE_VALUES_KEYVALUES?= key1=val1 key2=val2
# HLM_RELEASE_VERIFY_FLAG?= true
# HLM_RELEASE_WAIT_FLAG?= true
# HLM_RELEASES_DEPLOYED_FLAG?= true
# HLM_RELEASES_FAILED_FLAG?= true
# HLM_RELEASES_FILTER_REGEX?= 'ara[a-z]+'
HLM_RELEASES_MAX_COUNT?= 256
# HLM_RELEASES_NAMESPACE_NAME?= default
# HLM_RELEASES_OFFSET?= 256
# HLM_RELEASES_PENDING_FLAG?= true
# HLM_RELEASES_SET_NAME?= my-releases-set
# HLM_RELEASES_SUPERSEDED_FLAG?= true
# HLM_RELEASES_TLS?= true
# HLM_RELEASES_TLS_CACERT?= $(HLM_HOME)/ca.pem
# HLM_RELEASES_TLS_CERT?= $(HLM_HOME)/cert.pem
# HLM_RELEASES_TLS_KEY?= $(HLM_HOME)/key.pem
# HLM_RELEASES_UNINSTALLED_FLAG?= true
# HLM_RELEASES_UNINSTALLING_FLAG?= true

# Derived parameters
HLM_RELEASE_CHART_CNAME?= $(HLM_CHART_CNAME)
HLM_RELEASE_CHART_NAME?= $(lastword $(subst /,$(SPACE),$(HLM_RELEASE_CHART_CNAME)))
HLM_RELEASE_CHART_VERSION?= $(HLM_CHART_VERSION)
HLM_RELEASE_CHARTREPOSITORY_NAME?= $(firstword $(subst /,$(SPACE),$(HLM_RELEASE_CHART_CNAME)))
HLM_RELEASE_CURL?= $(HLM_CURL)
HLM_RELEASE_DIG?= $(HLM_DIG)
HLM_RELEASE_DNSNAME?= $(HLM_RELEASE_DNSNAME_HOSTNAME).$(HLM_RELEASE_DNSNAME_SUBDOMAIN)
HLM_RELEASE_DNSNAME_HOSTNAME?= $(HLM_RELEASE_NAME)
HLM_RELEASE_DNSNAME_SUBDOMAIN?= $(HLM_RELEASE_NAMESPACE_NAME).$(HLM_RELEASE_DNSNAME_DOMAIN)
HLM_RELEASE_VALUES_DIRPATH?= $(HLM_INPUTS_DIRPATH)
HLM_RELEASE_VALUES_FILEPATH?= $(if $(HLM_RELEASE_VALUES_FILENAME),$(HLM_RELEASE_VALUES_DIRPATH)$(HLM_RELEASE_VALUES_FILENAME))
HLM_RELEASE_URL?= $(HLM_RELEASE_URL_PROTOCOL)$(HLM_RELEASE_DNSNAME)#:$(HLM_RELEASE_URL_PORT)
HLM_RELEASES_LISTBYDATE_FLAG?= false
HLM_RELEASES_LISTREVERSE_FLAG?= false
HLM_RELEASES_LISTSHORT_FLAG?= false
# HLM_RELEASES_LISTWIDTH_COUNT?= 60
HLM_RELEASES_NAMESPACE_NAME= $(HLM_RELEASE_NAMESPACE_NAME)
HLM_RELEASES_SET_NAME?= releases@$(HLM_RELEASES_NAMESPACE_NAME)

# Options
__HLM_ALL=
__HLM_ALL_NAMESPACE=
__HLM_CA_FILE=
__HLM_CERT_FILE=
__HLM_COL_WIDTH= $(if $(HLM_RELEASES_LISTWIDTH_COUNT),--col-width $(HLM_RELEASES_LISTWIDTH_COUNT))
__HLM_DATE__RELEASES= $(if $(filter true, $(HLM_RELEASES_LISTBYDATE_FLAG)),--date)
__HLM_DEPLOYED= $(if $(filter true, $(HLM_RELEASES_DEPLOYED_FLAG)),--deployed)
__HLM_DEP_UP=
__HLM_DEVEL=
__HLM_DRY_RUN=
__HLM_FAILED= $(if $(filter true, $(HLM_RELEASES_FAILED_FLAG)),--failed)
__HLM_FILTER= $(if $(HLM_RELEASES_FILTER_REGEX),--filter $(HLM_RELEASES_FILTER_REGEX))
__HLM_FORCE=
__HLM_INSTALL= $(if $(filter true, $(HLM_RELEASE_UPGRADE_INSTALLENABLE)),--install)
__HLM_KEY_FILE=
__HLM_KEYRING=
__HLM_MAX__RELEASE= $(if $(HLM_RELEASE_MAX_COUNT),--max $(HLM_RELEASE_MAX_COUNT))
__HLM_MAX__RELEASES= $(if $(HLM_RELEASES_MAX_COUNT),--max $(HLM_RELEASES_MAX_COUNT))
# __HLM_NAME__RELEASE= $(if $(HLM_RELEASE_NAME),--name $(HLM_RELEASE_NAME))
__HLM_NAME_TEMPLATE=
__HLM_NAMESPACE__RELEASE= $(if $(HLM_RELEASE_NAMESPACE_NAME),--namespace $(HLM_RELEASE_NAMESPACE_NAME))
__HLM_NAMESPACE__RELEASES= $(if $(HLM_RELEASES_NAMESPACE_NAME),--namespace $(HLM_RELEASES_NAMESPACE_NAME))
__HLM_NO_HOOKS=
__HLM_OFFSET= $(if $(HLM_RELEASES_OFFSET),--offset $(HLM_RELEASES_OFFSET))
__HLM_OUTPUT__RELEASE=
__HLM_PASSWORD=
__HLM_PENDING= $(if $(filter true, $(HLM_RELEASES_PENDING_FLAG)),--pending)
__HLM_RECREATE_PODS=
__HLM_REPLACE=
__HLM_REPO=
__HLM_RESET_VALUES=
__HLM_REUSE_VALUE=
__HLM_REVERSE= $(if $(filter true, $(HLM_RELEASES_LISTREVERSE_FLAG)),--reverse)
__HLM_REVISION= $(if $(HLM_RELEASE_REVISION_ID),--revision $(HLM_RELEASE_REVISION_ID))
__HLM_SET__RELEASE= $(if $(HLM_RELEASE_VALUES_KEYVALUES),--set $(subst $(SPACE),$(COMMA),$(strip $(HLM_RELEASE_VALUES_KEYVALUES))))
__HLM_SET_STRING__RELEASE=
__HLM_SHORT= $(if $(filter true, $(HLM_RELEASES_LISTSHORT_FLAG)),--short)
__HLM_SUPERSEDED= $(if $(filter true, $(HLM_RELEASES_SUPERSEDED_FLAG)),--superseded)
__HLM_TIMEOUT=
__HLM_TLS=
__HLM_TLS_CA_CERT=
__HLM_TLS_CERT=
__HLM_TLS_KEY=
__HLM_TLS_VERIFY=
__HLM_UNINSTALLED= $(if $(filter true, $(HLM_RELEASES_UNINSTALLED_FLAG)),--uninstalled)
__HLM_UNINSTALLING= $(if $(filter true, $(HLM_RELEASES_UNINSTALLING_FLAG)),--uninstalling)
__HLM_USERNAME=
__HLM_VALUES__RELEASE= $(if $(HLM_RELEASE_VALUES_FILEPATH),--values $(HLM_RELEASE_VALUES_FILEPATH))
__HLM_VERIFY= $(if $(filter true, $(HLM_RELEASE_VERIFY_FLAG)),--verify)
__HLM_VERSION= $(if $(filter-out latest, $(HLM_RELEASE_CHART_VERSION)),--version $(HLM_RELEASE_CHART_VERSION))
__HLM_WAIT= $(if $(filter true, $(HLM_RELEASE_WAIT_FLAG)),--wait)

# Customizations
_HLM_DELETE_RELEASE_|?= -#
|_HLM_LIST_RELEASES_SET?= #
|_HLM_SHOW_RELEASE_HISTORY?= # | head -15; echo '...'
|_HLM_SHOW_RELEASE_HOOKS?= ; echo#
|_HLM_SHOW_RELEASE_MANIFEST?= | head -15; echo '...'
|_HLM_SHOW_RELEASE_STATUS?= # | head -15; echo '...'
|_HLM_SHOW_RELEASE_VALUES?= | head -15; echo '...'

#--- MACROS

_hlm_get_release_name= $(call _hlm_get_release_name_C, $(HLM_RELEASE_CHART_NAME))
_hlm_get_release_name_C= $(call _hlm_get_release_name_CN, $(1), $(HLM_RELEASE_NAMESPACE_NAME))
# strip required! Somehow a space is appended!
_hlm_get_release_name_CN= $(strip $(shell $(HELM) list --namespace $(2) --all | grep $(1) | head -1 | cut --fields=1))

_hlm_get_namespaced_release_names= $(_hlm_get_namespaced_release_names_N, $(HLM_RELEASE_NAMESPACE_NAME))
_hlm_get_namespaced_release_names_N= $(shell $(HELM) list --namespace $(1) --short )

_hlm_get_all_release_names= $(shell $(HELM) list --all --short )

#----------------------------------------------------------------------
# USAGE
#

_hlm_list_macros ::
	@echo 'HeLM::Release ($(_HELM_RELEASE_MK_VERSION)) macros:'
	@echo '    _hlm_get_all_release_names             - Get the names of ALL the releases'
	@echo '    _hlm_get_namespaced_release_name_{|N}  - Get the names of ALL release in a namespace (Namespace)'
	@echo '    _hlm_get_release_names_{|N}            - Get the name of a release (Chart,Namespace)'
	@echo

_hlm_list_parameters ::
	@echo 'HeLM::Release ($(_HELM_RELEASE_MK_VERSION)) parameters:'
	@echo '    HLM_RELEASE_CHART_CNAME=$(HLM_RELEASE_CHART_CNAME)'
	@echo '    HLM_RELEASE_CHART_NAME=$(HLM_RELEASE_CHART_NAME)'
	@echo '    HLM_RELEASE_CHART_VERSION=$(HLM_RELEASE_CHART_VERSION)'
	@echo '    HLM_RELEASE_CHARTREPOSITORY_NAME=$(HLM_RELEASE_CHARTREPOSITORY_NAME)'
	@echo '    HLM_RELEASE_DNSNAME=$(HLM_RELEASE_DNSNAME)'
	@echo '    HLM_RELEASE_DNSNAME_DOMAIN=$(HLM_RELEASE_DNSNAME_DOMAIN)'
	@echo '    HLM_RELEASE_DNSNAME_HOSTNAME=$(HLM_RELEASE_DNSNAME_HOSTNAME)'
	@echo '    HLM_RELEASE_DNSNAME_SUBDOMAIN=$(HLM_RELEASE_DNSNAME_SUBDOMAIN)'
	@echo '    HLM_RELEASE_DRY_RUN=$(HLM_RELEASE_DRY_RUN)'
	@echo '    HLM_RELEASE_NAME=$(HLM_RELEASE_NAME)'
	@echo '    HLM_RELEASE_NAMESPACE_NAME=$(HLM_RELEASE_NAMESPACE_NAME)'
	@echo '    HLM_RELEASE_REVISION_ID=$(HLM_RELEASE_REVISION_ID)'
	@echo '    HLM_RELEASE_UPGRADE_INSTALLENABLE=$(HLM_RELEASE_UPGRADE_INSTALLENABLE)'
	@echo '    HLM_RELEASE_VALUES_DIRPATH=$(HLM_RELEASE_VALUES_DIRPATH)'
	@echo '    HLM_RELEASE_VALUES_FILENAME=$(HLM_RELEASE_VALUES_FILENAME)'
	@echo '    HLM_RELEASE_VALUES_FILEPATH=$(HLM_RELEASE_VALUES_FILEPATH)'
	@echo '    HLM_RELEASE_VALUES_KEYVALUES=$(HLM_RELEASE_VALUES_KEYVALUES)'
	@echo '    HLM_RELEASE_VERIFY_FLAG=$(HLM_RELEASE_VERIFY_FLAG)'
	@echo '    HLM_RELEASE_WAIT_FLAG=$(HLM_RELEASE_WAIT_FLAG)'
	@echo '    HLM_RELEASES_DEPLOYED_FLAG=$(HLM_RELEASES_DEPLOYED_FLAG)'
	@echo '    HLM_RELEASES_FILTER_REGEX=$(HLM_RELEASES_FILTER_REGEX)'
	@echo '    HLM_RELEASES_LISTBYDATE_FLAG=$(HLM_RELEASES_LISTBYDATE_FLAG)'
	@echo '    HLM_RELEASES_LISTREVERSE_FLAG=$(HLM_RELEASES_LISTREVERSE_FLAG)'
	@echo '    HLM_RELEASES_LISTSHORT_FLAG=$(HLM_RELEASES_LISTSHORT_FLAG)'
	@echo '    HLM_RELEASES_LISTWIDTH_COUNT=$(HLM_RELEASES_LISTWIDTH_COUNT)'
	@echo '    HLM_RELEASES_MAX_COUNT=$(HLM_RELEASES_MAX_COUNT)'
	@echo '    HLM_RELEASES_NAMESPACE_NAME=$(HLM_RELEASES_NAMESPACE_NAME)'
	@echo '    HLM_RELEASES_OFFSET=$(HLM_RELEASES_OFFSET)'
	@echo '    HLM_RELEASES_PENDING_FLAG=$(HLM_RELEASES_PENDING_FLAG)'
	@echo '    HLM_RELEASES_SET_NAME=$(HLM_RELEASES_SET_NAME)'
	@echo '    HLM_RELEASES_SUPERSEDED_FLAG=$(HLM_RELEASES_SUPERSEDED_FLAG)'
	@echo '    HLM_RELEASES_TLS=$(HLM_RELEASES_TLS)'
	@echo '    HLM_RELEASES_TLS_CACERT=$(HLM_RELEASES_TLS_CACERT)'
	@echo '    HLM_RELEASES_TLS_CERT=$(HLM_RELEASES_TLS_CERT)'
	@echo '    HLM_RELEASES_TLS_KEY=$(HLM_RELEASES_TLS_KEY)'
	@echo '    HLM_RELEASES_UNINSTALLED_FLAG=$(HLM_RELEASES_UNINSTALLED_FLAG)'
	@echo '    HLM_RELEASES_UNINSTALLING_FLAG=$(HLM_RELEASES_UNINSTALLING_FLAG)'
	@echo

_hlm_list_targets ::
	@echo 'HeLM::Release ($(_HELM_RELEASE_MK_VERSION)) targets:'
	@echo '    _hlm_create_release                      - Create a release'
	@echo '    _hlm_curl_release                        - Curl a release'
	@echo '    _hlm_delete_release                      - Delete a release'
	@echo '    _hlm_dig_release                         - Dig a release'
	@echo '    _hlm_dryrun_release                      - Show everything before release'
	@echo '    _hlm_dryrun_release_hooks                - Show hooks before release' 
	@echo '    _hlm_dryrun_release_manifest             - Show manifest before release' 
	@echo '    _hlm_dryrun_release_values               - Show values before release' 
	@echo '    _hlm_dryrun_release_values_chartsource   - Show values from chart-source' 
	@echo '    _hlm_dryrun_release_values_computed      - Show computed values before release' 
	@echo '    _hlm_dryrun_release_values_usersupplied  - Show user-supplied values before release' 
	@echo '    _hlm_list_releases                       - List all releases'
	@echo '    _hlm_list_releases_set                   - List a set of releases'
	@echo '    _hlm_rollback_release                    - Rollback a release'
	@echo '    _hlm_show_release                        - Show everything related to a release'
	@echo '    _hlm_show_release_description            - Show description of a release'
	@echo '    _hlm_show_release_history                - Show history of a release'
	@echo '    _hlm_show_release_hooks                  - Show hooks of a release'
	@echo '    _hlm_show_release_manifest               - Show manifest of a release'
	@echo '    _hlm_show_release_status                 - Show status of a release'
	@echo '    _hlm_show_release_values                 - Show values of a release'
	@echo '    _hlm_show_release_values_chartsource     - Show values of the chart-source'
	@echo '    _hlm_show_release_values_computed        - Show computed values of the chart-source'
	@echo '    _hlm_show_release_values_usersupplied    - Show user-supplied values of the chart-source'
	@echo '    _hlm_test_release                        - Test a release with release-tests'
	@echo '    _hlm_upgrade_release                     - Upgrade release'
	@echo '    _hlm_watch_releases                      - Watch all releases'
	@echo '    _hlm_watch_releases_set                  - Watch a set of releases'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_hlm_create_release:
	@$(INFO) '$(HLM_UI_LABEL)Creating release "$(HLM_RELEASE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if a release with the same name already exists'; $(NORMAL)
	@$(WARN) 'This release is using chart "$(HLM_RELEASE_CHART_NAME)" ...'; $(NORMAL)
	$(if $(HLM_RELEASE_VALUES_FILEPATH), cat $(HLM_RELEASE_VALUES_FILEPATH); echo)
	$(HELM) install $(strip $(__HLM_CA_FILE) $(__HLM_CERT_FILE) $(__HLM_DEP_UP) $(__HLM_DEVEL) $(__HLM_DRY_RUN__RELEASE) $(__HLM_KEY_FILE) $(__HLM_KEYRING) $(__HLM_NAME_TEMPLATE) $(__HLM_NAMESPACE__RELEASE) $(__HLM_NO_HOOKS) $(__HLM_PASSWORD) $(__HLM_REPLACE) $(__HLM_REPO) $(__HLM_SET__RELEASE) $(__HLM_SET_STRING) $(__HLM_TIMEOUT) $(__HLM_TLS) $(__HLM_TLS_CA_CERT) $(__HLM_TLS_CERT) $(__HLM_TLS_KEY) $(__HLM_TLS_VERIFY) $(__HLM_USERNAME) $(__HLM_VALUES__RELEASE) $(__HLM_VERIFY) $(__HLM_VERSION) $(__HLM_WAIT) $(HLM_RELEASE_NAME) $(HLM_RELEASE_CHART_CNAME))

_hlm_curl_release:
	@$(INFO) '$(HLM_UI_LABEL)Curl-ing release "$(HLM_RELEASE_NAME)" ...'; $(NORMAL)
	$(HLM_RELEASE_CURL) $(HLM_RELEASE_URL)

_hlm_delete_release:
	@$(INFO) '$(HLM_UI_LABEL)Deleting release "$(HLM_RELEASE_NAME)" '; $(NORMAL)
	@$(WARN) 'The associated chart is "$(HLM_RELEASE_CHART_NAME)" ...'; $(NORMAL)
	$(_HLM_DELETE_RELEASE_|)$(HELM) delete $(strip $(__HLM_DRY_RUN) $(__HLM_NAMESPACE__RELEASE) $(__HLM_NO_HOOKS) $(__HLM_TIMEOUT) $(__HLM_TLS) $(__HLM_TLS_CA_CERT) $(__HLM_TLS_CERT) $(__HLM_TLS_KEY) $(__HLM_TLS_VERIFY) $(HLM_RELEASE_NAME))

_hlm_dig_release:
	@$(INFO) '$(HLM_UI_LABEL)Dig-ing release "$(HLM_RELEASE_NAME)" ...'; $(NORMAL)
	$(HLM_RELEASE_DIG) $(HLM_RELEASE_DNSNAME)

_hlm_dryrun_release: _hlm_dryrun_release_hooks _hlm_dryrun_release_manifest _hlm_dryrun_release_values

_hlm_dryrun_release_hooks:
	@$(INFO) '$(HLM_UI_LABEL)Showing expected hooks for release "$(HLM_RELEASE_NAME)" ...'; $(NORMAL)
	$(HELM) --debug install $(strip $(__HLM_CA_FILE) $(__HLM_CERT_FILE) $(__HLM_DEP_UP) $(__HLM_DEVEL) $(_X__HLM_DRY_RUN__RELEASE) --dry-run $(__HLM_KEY_FILE) $(__HLM_KEYRING) $(__HLM_NAME__RELEASE)--dry-run $(__HLM_NAME_TEMPLATE) $(__HLM_NAMESPACE__RELEASE) $(__HLM_NO_HOOKS) $(__HLM_PASSWORD) $(__HLM_REPLACE) $(__HLM_REPO) $(__HLM_SET__RELEASE) $(__HLM_SET_STRING) $(__HLM_TIMEOUT) $(__HLM_TLS) $(__HLM_TLS_CA_CERT) $(__HLM_TLS_CERT) $(__HLM_TLS_KEY) $(__HLM_TLS_VERIFY) $(__HLM_USERNAME) $(__HLM_VALUES__RELEASE) $(__HLM_VERIFY) $(__HLM_VERSION) $(__HLM_WAIT) $(HLM_RELEASE_CHART_CNAME)) | sed  '1,/HOOKS:/ d' | sed '/MANIFEST:/,$$ d'

_hlm_dryrun_release_manifest:
	@$(INFO) '$(HLM_UI_LABEL)Showing expected manifest for release "$(HLM_RELEASE_NAME)" ...'; $(NORMAL)
	$(HELM) --debug install $(strip $(__HLM_CA_FILE) $(__HLM_CERT_FILE) $(__HLM_DEP_UP) $(__HLM_DEVEL) $(_X__HLM_DRY_RUN__RELEASE) --dry-run $(__HLM_KEY_FILE) $(__HLM_KEYRING) $(__HLM_NAME__RELEASE)--dry-run $(__HLM_NAME_TEMPLATE) $(__HLM_NAMESPACE__RELEASE) $(__HLM_NO_HOOKS) $(__HLM_PASSWORD) $(__HLM_REPLACE) $(__HLM_REPO) $(__HLM_SET__RELEASE) $(__HLM_SET_STRING) $(__HLM_TIMEOUT) $(__HLM_TLS) $(__HLM_TLS_CA_CERT) $(__HLM_TLS_CERT) $(__HLM_TLS_KEY) $(__HLM_TLS_VERIFY) $(__HLM_USERNAME) $(__HLM_VALUES__RELEASE) $(__HLM_VERIFY) $(__HLM_VERSION) $(__HLM_WAIT) $(HLM_RELEASE_CHART_CNAME)) | sed -s '1,/MANIFEST:/ d'; echo

_hlm_dryrun_release_values :: _hlm_dryrun_release_values_usersupplied _hlm_dryrun_release_values_computed

_hlm_dryrun_release_values_usersupplied:
	@$(INFO) '$(HLM_UI_LABEL)Showing user-supplied values for release "$(HLM_RELEASE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'User-supplied values override default values in final computed-values'; $(NORMAL)
	@$(WARN) 'Values supplied in the command line override values supplied in files'; $(NORMAL)
	$(if $(HLM_RELEASE_VALUES_FILEPATH), cat $(HLM_RELEASE_VALUES_FILEPATH); echo)
	$(if $(HLM_RELEASE_VALUES_KEYVALUES), echo $(HLM_RELEASE_VALUES_KEYVALUES); echo)
	echo; $(HELM) --debug install $(strip $(__HLM_CA_FILE) $(__HLM_CERT_FILE) $(__HLM_DEP_UP) $(__HLM_DEVEL) $(_X__HLM_DRY_RUN__RELEASE) --dry-run $(__HLM_KEY_FILE) $(__HLM_KEYRING) $(__HLM_NAME__RELEASE)--dry-run $(__HLM_NAME_TEMPLATE) $(__HLM_NAMESPACE__RELEASE) $(__HLM_NO_HOOKS) $(__HLM_PASSWORD) $(__HLM_REPLACE) $(__HLM_REPO) $(__HLM_SET__RELEASE) $(__HLM_SET_STRING) $(__HLM_TIMEOUT) $(__HLM_TLS) $(__HLM_TLS_CA_CERT) $(__HLM_TLS_CERT) $(__HLM_TLS_KEY) $(__HLM_TLS_VERIFY) $(__HLM_USERNAME) $(__HLM_VALUES__RELEASE) $(__HLM_VERIFY) $(__HLM_VERSION) $(__HLM_WAIT) $(HLM_RELEASE_CHART_CNAME)) | sed  '1,/USER-SUPPLIED VALUES:/ d' | sed '/COMPUTED VALUES:/,$$ d'

_hlm_dryrun_release_values_computed:
	@$(INFO) '$(HLM_UI_LABEL)Showing expected computed-values for release "$(HLM_RELEASE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Computed-values = User-supplied values + non-overriden default values'; $(NORMAL)
	echo; $(HELM) --debug install $(strip $(__HLM_CA_FILE) $(__HLM_CERT_FILE) $(__HLM_DEP_UP) $(__HLM_DEVEL) $(_X__HLM_DRY_RUN__RELEASE) --dry-run $(__HLM_KEY_FILE) $(__HLM_KEYRING) $(__HLM_NAME__RELEASE)--dry-run $(__HLM_NAME_TEMPLATE) $(__HLM_NAMESPACE__RELEASE) $(__HLM_NO_HOOKS) $(__HLM_PASSWORD) $(__HLM_REPLACE) $(__HLM_REPO) $(__HLM_SET__RELEASE) $(__HLM_SET_STRING) $(__HLM_TIMEOUT) $(__HLM_TLS) $(__HLM_TLS_CA_CERT) $(__HLM_TLS_CERT) $(__HLM_TLS_KEY) $(__HLM_TLS_VERIFY) $(__HLM_USERNAME) $(__HLM_VALUES__RELEASE) $(__HLM_VERIFY) $(__HLM_VERSION) $(__HLM_WAIT) $(HLM_RELEASE_CHART_CNAME)) | sed  '1,/COMPUTED VALUES:/ d' | sed '/HOOKS:/,$$ d'

_hlm_list_releases:
	@$(INFO) '$(HLM_UI_LABEL)Listing ALL releases ...'; $(NORMAL)
	$(HELM) list --all --all-namespaces $(strip $(__HLM_COL_WIDTH) $(__HLM_DATE__RELEASES) $(_X__HLM_DEPLOYED) $(_X__HLM_FAILED) $(_X_HLM_FILTER) $(__HLM_MAX__RELEASES) $(_X__HLM_NAMESPACE__RELEASES) $(__HLM_OFFSET) $(_X__HLM_PENDING) $(__HLM_REVERSE) $(__HLM_SHORT) $(__HLM_SUPERSEDED) $(__HLM_TLS) $(__HLM_TLS_CA_CERT) $(__HLM_TLS_CERT) $(__HLM_TLS_KEY) $(__HLM_TLS_VERIFY) $(_X__HLM_UNINSTALLED) $(_X__HLM_UNINSTALLING) )

_hlm_list_releases_set:
	@$(INFO) '$(HLM_UI_LABEL)Listing releases-set "$(HLM_RELEASES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Releases are grouped based on provided namespace, status, filter-regex'; $(NORMAL)
	$(HELM) list $(strip $(__HLM_ALL) $(__HLM_ALL_NAMESPACES) $(__HLM_COL_WIDTH) $(__HLM_DATE__RELEASES) $(__HLM_DEPLOYED) $(__HLM_FAILED) $(__HLM_FILTER)  $(__HLM_MAX__RELEASES) $(__HLM_NAMESPACE__RELEASES) $(__HLM_OFFSET) $(__HLM_PENDING) $(__HLM_REVERSE) $(__HLM_SHORT) $(__HLM_SUPERSEDED) $(__HLM_TLS) $(__HLM_TLS_CA_CERT) $(__HLM_TLS_CERT) $(__HLM_TLS_KEY) $(__HLM_TLS_VERIFY) $(__HLM_UNINSTALLED) $(__HLM_UNINSTALLING) $(|_HLM_LIST_RELEASES_SET) )

_hlm_rollback_release:
	@$(INFO) '$(HLM_UI_LABEL)Rolling back release "$(HLM_RELEASE_NAME)" to revision "$(HLM_RELEASE_REVISION_ID)" ... '; $(NORMAL)
	@$(WARN) 'This operation is supported only on releases that have been created and then upgraded'; $(NORMAL)
	$(HELM) rollback $(strip $(__HLM_DRY_RUN) $(__HLM_FORCE) $(__HLM_NO_HOOKS) $(__HLM_RECREATE_PODS) $(__HLM_TIMEOUT) $(__HLM_TLS) $(__HLM_TLS_CA_CERT) $(__HLM_TLS_CERT) $(__HLM_TLS_KEY) $(__HLM_TLS_VERIFY) $(__HLM_WAIT) $(HLM_RELEASE_NAME) $(HLM_RELEASE_REVISION_ID))

_HLM_SHOW_RELEASE_TARGETS?= _hlm_show_release_hooks _hlm_show_release_manifest _hlm_show_release_values _hlm_show_release_description
_hlm_show_release: $(_HLM_SHOW_RELEASE_TARGETS)

_hlm_show_release_description: _hlm_show_release_status _hlm_show_release_history

_hlm_show_release_history:
	@$(INFO) '$(HLM_UI_LABEL)Showing history of release "$(HLM_RELEASE_NAME)" ...'; $(NORMAL)
	$(HELM) history $(strip $(__HLM_COL_WIDTH) $(__HLM_MAX__RELEASE) $(__HLM_OUTPUT) $(__HLM_TLS) $(__HLM_TLS_CA_CERT) $(__HLM_TLS_CA_CERT) $(__HLM_TLS_CERT) $(__HLM_TLS_KEY) $(__HLM_TLS_VERIFY) ) $(HLM_RELEASE_NAME) $(|_HLM_SHOW_RELEASE_HISTORY)

_hlm_show_release_hooks:
	@$(INFO) '$(HLM_UI_LABEL)Showing hooks of release "$(HLM_RELEASE_NAME)" ...'; $(NORMAL)
	$(HELM) get hooks $(strip $(__HLM_OUTPUT) $(__HLM_REVISION) $(__HLM_TLS) $(__HLM_TLS_CA_CERT) $(__HLM_TLS_CERT) $(__HLM_TLS_KEY) $(__HLM_TLS_VERIFY) ) $(HLM_RELEASE_NAME) $(|_HLM_SHOW_RELEASE_HOOKS)

_hlm_show_release_manifest:
	@$(INFO) '$(HLM_UI_LABEL)Showing manifest of release "$(HLM_RELEASE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the manifest to recreate the release'; $(NORMAL)
	$(HELM) get manifest $(strip $(__HLM_OUTPUT) $(__HLM_REVISION) $(__HLM_TLS) $(__HLM_TLS_CA_CERT) $(__HLM_TLS_CERT) $(__HLM_TLS_KEY) $(__HLM_TLS_VERIFY) ) $(HLM_RELEASE_NAME) $(|_HLM_SHOW_RELEASE_MANIFEST)

_hlm_show_release_status:
	@$(INFO) '$(HLM_UI_LABEL)Showing status of release "$(HLM_RELEASE_NAME)" ...'; $(NORMAL)
	$(HELM) status $(strip $(__HLM_OUTPUT) $(__HLM_REVISION) $(__HLM_TLS) $(__HLM_TLS_CA_CERT) $(__HLM_TLS_CERT) $(__HLM_TLS_KEY) $(__HLM_TLS_VERIFY) ) $(HLM_RELEASE_NAME) $(|_HLM_SHOW_RELEASE_STATUS)

_hlm_show_release_values :: _hlm_show_release_values_usersupplied _hlm_show_release_values_computed

_hlm_show_release_values_usersupplied:
	@$(INFO) '$(HLM_UI_LABEL)Showing user-suppplied values for release "$(HLM_RELEASE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'User-supplied values override default values in final computed-values'; $(NORMAL)
	@$(WARN) 'Values supplied in the command line override values supplied in files'; $(NORMAL)
	$(if $(HLM_RELEASE_VALUES_FILEPATH), cat $(HLM_RELEASE_VALUES_FILEPATH); echo)
	$(if $(HLM_RELEASE_VALUES_KEYVALUES), echo $(HLM_RELEASE_VALUES_KEYVALUES); echo)
	$(HELM) get values $(HLM_RELEASE_NAME) $(|_HLM_SHOW_RELEASE_VALUES)

_hlm_show_release_values_computed:
	@$(INFO) '$(HLM_UI_LABEL)Showing computed-values for release "$(HLM_RELEASE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Computed-values = User-supplied values + non-overriden default values'; $(NORMAL)
	$(HELM) get values --all $(HLM_RELEASE_NAME) $(|_HLM_SHOW_RELEASE_VALUES)

_hlm_test_release:
	@$(INFO) '$(HLM_UI_LABEL)Testing release "$(HLM_RELEASE_NAME)" with release-tests ...'; $(NORMAL)
	$(HELM) test $(strip $(HLM_CLEANUP) $(__HLM_TIMEOUT) $(__HLM_TLS) $(__HLM_TLS_CA_CERT) $(__HLM_TLS_CERT) $(__HLM_TLS_KEY) $(__HLM_TLS_VERIFY) $(HLM_RELEASE_NAME))

_hlm_upgrade_release:
	@$(INFO) '$(HLM_UI_LABEL)Upgrading release "$(HLM_RELEASE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation upgrades a release with new parameter-values or a new chart-version'; $(NORMAL)
	@$(WARN) 'Note: If required an upgraded release can be rolled-back'; $(NORMAL)
	$(if $(HLM_RELEASE_VALUES_FILEPATH), cat $(HLM_RELEASE_VALUES_FILEPATH); echo)
	$(HELM) upgrade $(strip $(__HLM_CA_FILE) $(__HLM_CERT_FILE) $(__HLM_DEVEL) $(__HLM_DRY_RUN) $(__HLM_FORCE) $(__HLM_INSTALL) $(__HLM__KEY_FILE) $(__HLM_KEYRING) $(__HLM_NAMESPACE__RELEASE) $(__HLM_NO_HOOOKS )$(__HLM_PASSWORD) $(__HLM_RECREATE_PODS) $(__HLM_REPO) $(__HLM_RESET_VALUES) $(__HLM_REUSE_VALUES) $(__HLM_SET__RELEASE) $(__HLM__SET_STRING) $(__HLM_TIMEOUT) $(__HLM_TLS) $(__HLM_TLS_CA_CERT) $(__HLM_TLS_CERT) $(__HLM_KEY) $(__HLM_VERIFY) $(__HLM_USERNAME) $(__HLM_VALUES__RELEASE) $(__HLM_VERIFY) $(__HLM_VERSION) $(__HLM_WAIT) $(HLM_RELEASE_NAME) $(HLM_RELEASE_CHART_CNAME))

_hlm_watch_releases:
	@$(INFO) '$(HLM_UI_LABEL)Watching ALL releases ...'; $(NORMAL)

_hlm_watch_releases_set:
	@$(INFO) '$(HLM_UI_LABEL)Watching releases-set "$(HLM_RELEASES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Releases are grouped based on namespace, status, ...'; $(NORMAL)
