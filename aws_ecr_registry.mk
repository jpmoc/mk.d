_AWS_ECR_REGISTRY_MK_VERSION= $(_AWS_ECR_MK_VERSION)

# ECR_REGISTRY_ACCOUNT_ID?= 123456789012
# ECR_REGISTRY_ID?= 123456789012
# ECR_REGISTRY_NAME?= my-aws-registry
# ECR_REGISTRY_REGION_ID?= us-west-2
# ECR_REGISTRY_URI?= 123456789012.dkr.ecr.us-west-2.amazonaws.com
# ECR_REGISTRY_URL?= http://123456789012.dkr.ecr.us-west-2.amazonaws.com

# Derived parameters
ECR_REGISTRY_ACCOUNT_ID?= $(ECR_ACCOUNT_ID)
ECR_REGISTRY_ID?= $(ECR_REGISTRY_ACCOUNT_ID)
ECR_REGISTRY_NAME?= $(ECR_REGISTRY_ID)
ECR_REGISTRY_REGION_ID?= $(ECR_REGION_ID)
ECR_REGISTRY_URI?= $(ECR_REGISTRY_ID).dkr.ecr.$(ECR_REGISTRY_REGION_ID).amazonaws.com
ECR_REGISTRY_URL?= http://$(ECR_REGISTRY_URI)

# Options parameters
__ECR_REGISTRY_ID= $(if $(ECR_REGISTRY_ID), --registry-id $(ECR_REGISTRY_ID))

# UI parameters
ECR_UI_SHOW_REGISTRY_REPOSITORIES_FIELDS?= .{createdAt:createdAt,RepositoryName:repositoryName,repositoryUri:repositoryUri}

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_ecr_view_framework_macros ::
	@echo 'AWS::ECR::Registry ($(_AWS_ECR_REGISTRY_MK_VERSION)) macros:'
	@echo

_ecr_view_framework_parameters ::
	@echo 'AWS::ECR::Registry ($(_AWS_ECR_REGISTRY_MK_VERSION)) parameters:'
	@echo '    ECR_REGISTRY_ACCOUNT_ID=$(ECR_REGISTRY_ACCOUNT_ID)'
	@echo '    ECR_REGISTRY_ID=$(ECR_REGISTRY_ID)'
	@echo '    ECR_REGISTRY_NAME=$(ECR_REGISTRY_NAME)'
	@echo '    ECR_REGISTRY_REGION_ID=$(ECR_REGISTRY_REGION_ID)'
	@echo '    ECR_REGISTRY_URI=$(ECR_REGISTRY_URI)'
	@echo '    ECR_REGISTRY_URL=$(ECR_REGISTRY_URL)'
	@echo

_ecr_view_framework_targets ::
	@echo 'AWS::ECR::Registry ($(_AWS_ECR_REGISTRY_MK_VERSION)) targets:'
	@echo '    _ecr_create_registry                    - Create a registry'
	@echo '    _ecr_delete_registry                    - Delete a registry'
	@echo '    _ecr_login_registry                     - Login in a registry'
	@echo '    _ecr_show_registry                      - Show everything related to a registry'
	@echo '    _ecr_show_registry_login                - Show login command to access a registry'
	@echo '    _ecr_show_registry_repositories         - Show repositories of a registry'
	@echo '    _ecr_view_registries                    - View registries'
	@echo '    _ecr_view_registries_set                - View set of registries'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ecr_create_registry:
	@#$(INFO) '$(ECR_UI_LABEL)Creating registry "$(ECR_REGISTRY_NAME)" ...'; $(NORMAL)

_ecr_delete_registry:
	@#$(INFO) '$(ECR_UI_LABEL)Deleting registry "$(ECR_REGISTRY_NAME)" ...'; $(NORMAL)

_ecr_login_registry: _ecr_show_registry_login

_ecr_show_registry :: _ecr_show_registry_login _ecr_show_registry_repositories

_ecr_show_registry_login:
	@$(INFO) '$(ECR_UI_LABEL)Showing login command for registry "$(ECR_REGISTRY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'To interact with the registry, you need to run the login command below'; $(NORMAL)
	$(AWS) ecr get-login $(__ECR_INCLUDE_EMAIL) $(__ECR_REGISTRY_IDS)

_ecr_show_registry_repositories: 
	@$(INFO) '$(ECR_UI_LABEL)Showing repositories of registry "$(ECR_REGISTRY_NAME)" ...'; $(NORMAL)
	$(AWS) ecr describe-repositories $(__ECR_REGISTRY_ID) $(_X__ECR_REPOSITORY_NAMES) --query "repositories[]$(ECR_UI_SHOW_REGISTRY_REPOSITORIES_FIELDS)"

_ecr_view_registries:
	@$(INFO) '$(ECR_UI_LABEL)Viewing registries ...'; $(NORMAL)
	@$(WARN) 'This operation returns the unique registry in the current region'; $(NORMAL)
	@echo 'ECR_REGISTRY_URI=$(ECR_REGISTRY_URI)'

_ecr_view_registries_set: _ecr_view_registries
