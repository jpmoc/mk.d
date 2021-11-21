_SKAFFOLD_CONFIG_MK_VERSION= $(_SKAFFOLD_MK_VERSION)

# SFD_CONFIG_APPLICATION_DIRPATH?= ./apps/my-app/
# SFD_CONFIG_APPLICATION_NAME?= my-app
SFD_CONFIG_DIRPATH?= ./
SFD_CONFIG_FILENAME?= skaffold.yaml
# SFD_CONFIG_FILEPATH?= ./skaffold.yml
# SFD_CONFIG_NAME?= my-name
SFD_CONFIG_SKIPBUILD_FLAG?= false
# SFD_CONFIGS_APPLICATIONS_DIRPATH?= ./apps/
# SFD_CONFIGS_SET_NAME?= my-set

# Derived parameters
SFD_CONFIG_APPLICATION_DIRPATH?= $(SFD_APPLICATION_DIRPATH)
SFD_CONFIG_APPLICATION_NAME?= $(SFD_APPLICATION_NAME)
SFD_CONFIG_FILEPATH?= $(SFD_CONFIG_DIRPATH)$(SFD_CONFIG_FILENAME)
SFD_CONFIG_NAME?= $(if $(SFD_CONFIG_APPLICATION_NAME),$(SFD_CONFIG_APPLICATION_NAME)-config)
SFD_CONFIGS_APPLICATIONS_DIRPATH?= $(SFD_APPLICATIONS_DIRPATH)
SFD_CONFIGS_SET_NAME?= configs@$(SFD_APPLICATIONS_DIRPATH)

# Options
__SFD_FILENAME__CONFIG= $(if $(SFD_CONFIG_FILEPATH),--filename $(SFD_CONFIG_FILEPATH))
__SFD_SKIP_BUILD__CONFIG= $(if $(filter true,$(SFD_CONFIG_SKIPBUILD_FLAG)),--skip-build)

# Customizations
_SFD_CREATE_CONFIG_|?= $(if $(SFD_CONFIG_DIRPATH),mkdir -p $(SFD_CONFIG_DIRPATH) && )
_SFD_DELETE_CONFIG_|?= $(_SFD_CREATE_CONFIG_|)
_SFD_LIST_CONFIGS_|?= $(if $(SFD_CONFIGS_APPLICATIONS_DIRPATH),cd $(SFD_CONFIGS_APPLICATIONS_DIRPATH) && )#
_SFD_LIST_CONFIGS_SET_|?= $(_SFD_LIST_CONFIGS_|)
|_SFD_LIST_CONFIGS?=
|_SFD_LIST_CONFIGS_SET?=
_SFD_READ_CONFIG_|?= $(_SFD_CREATE_CONFIG_|)
_SFD_SHOW_CONFIG_|?= $(if $(SFD_CONFIG_APPLICATION_DIRPATH),cd $(SFD_CONFIG_APPLICATION_DIRPATH) && )#
_SFD_SHOW_CONFIG_CONTENT_|?= $(_SFD_SHOW_CONFIG_|)
_SFD_SHOW_CONFIG_DESCRIPTION_|?= $(_SFD_SHOW_CONFIG_|)
_SFD_WRITE_CONFIG_|?= $(_SFD_READ_CONFIG_|)

# Macros

#----------------------------------------------------------------------
# USAGE
#

_sfd_list_macros ::
	@#echo 'SkaFfolD::Config ($(_SKAFFOLD_CONFIG_MK_VERSION)) macros:'
	@#echo

_sfd_list_parameters ::
	@echo 'SkaFfolD::Config ($(_SKAFFOLD_CONFIG_MK_VERSION)) parameters:'
	@echo '    SFD_CONFIG_APPLICATION_DIRPATH=$(SFD_CONFIG_APPLICATION_DIRPATH)'
	@echo '    SFD_CONFIG_APPLICATION_NAME=$(SFD_CONFIG_APPLICATION_NAME)'
	@echo '    SFD_CONFIG_APPLICATIONS_DIRPATH=$(SFD_CONFIG_APPLICATIONS_DIRPATH)'
	@echo '    SFD_CONFIG_DIRPATH=$(SFD_CONFIG_DIRPATH)'
	@echo '    SFD_CONFIG_FILENAME=$(SFD_CONFIG_FILENAME)'
	@echo '    SFD_CONFIG_FILEPATH=$(SFD_CONFIG_FILEPATH)'
	@echo '    SFD_CONFIG_NAME=$(SFD_CONFIG_NAME)'
	@echo '    SFD_CONFIG_SKIPBUILD_FLAG=$(SFD_CONFIG_SKIPBUILD_FLAG)'
	@echo '    SFD_CONFIGS_APPLICATIONS_DIRPATH=$(SFD_CONFIGS_APPLICATIONS_DIRPATH)'
	@echo '    SFD_CONFIGS_SET_NAME=$(SFD_CONFIGS_SET_NAME)'
	@echo

_sfd_list_targets ::
	@echo 'SkaFfolD::Config ($(_SKAFFOLD_CONFIG_MK_VERSION)) targets:'
	@echo '    _sfd_create_config             - Create a config'
	@echo '    _sfd_delete_config             - Delete an existing config'
	@echo '    _sfd_list_configs              - List all configs'
	@echo '    _sfd_list_configs_set          - List set of configs'
	@echo '    _sfd_read_config               - Read a config'
	@echo '    _sfd_show_config               - Show everything related to a config'
	@echo '    _sfd_show_config_content       - Show the content of a config'
	@echo '    _sfd_show_config_description   - Show the description of a config'
	@echo '    _sfd_write_config              - Write a config'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

define SFD_CONFIG_CONTENT
apiVersion: skaffold/v1
apiVersion: skaffold/v2beta5
kind: Config
metadata:
  name: getting-started-knative
build:
  artifacts:
  - image: dev.local/quarkus-quickstarts/getting-started-knative
  local:
    push: false
deploy:
  kubectl:
    manifests:
    - k8s/service.yaml
endef
export SFD_CONFIG_CONTENT

_sfd_create_config:
	@$(INFO) '$(SFD_UI_LABEL)Creating config "$(SFD_CONFIG_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if not Dockerfile are found in the file subtree'; $(NORMAL)
	@$(WARN) 'Beware: Ascertain that the config API-version is compatible with your version of the CLI'; $(NORMAL)
	@# $(_SFD_CREATE_CONFIG_|)echo "$${SFD_CONFIG_CONTENT}" >> $(SFD_CONFIG_FILENAME)
	$(_SFD_CREATE_CONFIG_|)skaffold init $(_SFD_SKIP_BUILD)

_sfd_delete_config:
	@$(INFO) '$(SFD_UI_LABEL)Deleting config "$(SFD_CONFIG_NAME)" ...'; $(NORMAL)
	$(_SFD_DELETE_CONFIG_|)rm -rf $(SFD_CONFIG_FILEPATH)

_sfd_list_configs:
	@$(INFO) '$(SFD_UI_LABEL)Listing ALL configs ...'; $(NORMAL)
	# $(_SFD_LIST_CONFIGS_|)

_sfd_list_configs_set:
	@$(INFO) '$(SFD_UI_LABEL)Listing configs-set "$(SFD_CONFIGS_SET_NAME)" ...'; $(NORMAL)
	# $(_SFD_LIST_CONFIGS_SET_|)

_sfd_read_config:
	@$(INFO) '$(SFD_UI_LABEL)Reading config "$(SFD_CONFIG_NAME)" ...'; $(NORMAL)
	$(_SFD_READ_CONFIG_|)$(READER) $(SFD_CONFIG_FILEPATH)

_SFD_SHOW_CONFIG_TARGETS?= _sfd_show_config_content _sfd_show_config_description
_sfd_show_config: $(_SFD_SHOW_CONFIG_TARGETS)

_sfd_show_config_content:
	@$(INFO) '$(SFD_UI_LABEL)Showing content of config "$(SFD_CONFIG_NAME)" ...'; $(NORMAL)
	$(_SFD_SHOW_CONFIG_CONTENT_|)cat $(SFD_CONFIG_FILEPATH)

_sfd_show_config_description:
	@$(INFO) '$(SFD_UI_LABEL)Showing description of config "$(SFD_CONFIG_NAME)" ...'; $(NORMAL)
	$(_SFD_SHOW_CONFIG_DESCRIPTION_|)ls -al $(SFD_CONFIG_FILEPATH)

_sfd_write_config:
	@$(INFO) '$(SFD_UI_LABEL)Writing config "$(SFD_CONFIG_NAME)" ...'; $(NORMAL)
	$(_SFD_WRITE_CONFIG_|)$(WRITER) $(SFD_CONFIG_FILEPATH)
