_AWS_ECR_REPOSITORY_MK_VERSION= $(_AWS_ECR_MK_VERSION)

# ECR_REPOSITORY_ACCESSPOLICY?=
# ECR_REPOSITORY_ACCESSPOLICY_FILEPATH?= ./repository-policy.json
# ECR_REPOSITORY_NAME?= my-ecr-repository
# ECR_REPOSITORY_REGISTRY_ID?= 123456789012
# ECR_REPOSITORIES_NAME?= my-repo1 my-repo2
# ECR_REPOSITORIES_SET_NAME?= 123456789012

# Derived parameters
ECR_REPOSITORY_ACCESSPOLICY?= $(if $(ECR_REPOSITORY_ACCESSPOLICY_FILEPATH), file://$(ECR_REPOSITORY_ACCESSPOLICY_FILEPATH))
ECR_REPOSITORY_LIFECYCLEPOLICY?= $(if $(ECR_REPOSITORY_LIFECYCLEPOLICY_FILEPATH), file://$(ECR_REPOSITORY_LIFECYCLEPOLICY_FILEPATH))
ECR_REPOSITORY_REGISTRY_ID?= $(ECR_REGISTRY_ID)
ECR_REPOSITORIES_NAMES?= $(ECR_REPOSITORY_NAME)

# Options parameters
__ECR_FORCE=
__ECR_LIFECYCLE_POLICY_TEXT= $(if $(ECR_REPOSITORY_LIFECYCLEPOLICY),--lifecycle-policy-text $(ECR_REPOSITORY_LIFECYCLEPOLICY))
__ECR_POLICY_TEXT= $(if $(ECR_REPOSITORY_ACCESSPOLICY),--policy-text $(ECR_REPOSITORY_ACCESSPOLICY))
__ECR_REGISTRY_ID__REPOSITORY= $(if $(ECR_REPOSITORY_REGISTRY_ID),--registry-id $(ECR_REPOSITORY_REGISTRY_ID))
__ECR_REPOSITORY_NAME= $(if $(ECR_REPOSITORY_NAME),--repository-name $(ECR_REPOSITORY_NAME))
__ECR_REPOSITORY_NAMES= $(if $(ECR_REPOSITORIES_NAMES),--repository-names $(ECR_REPOSITORIES_NAMES))

# UI parameters
ECR_UI_VIEW_REPOSITORIES_FIELDS?= .{RepositoryName:repositoryName,repositoryUri:repositoryUri,createdAt:createdAt}
ECR_UI_VIEW_REPOSITORIES_SET_FIELDS?= $(ECR_UI_VIEW_REPOSITORIES_FIELDS)
ECR_UI_VIEW_REPOSITORIES_SET_SLICE?=

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_ecr_view_framework_macros ::
	@echo 'AWS::ECR::Repository ($(_AWS_ECR_REPOSITORY_MK_VERSION)) macros:'
	@echo

_ecr_view_framework_parameters ::
	@echo 'AWS::ECR::Repository ($(_AWS_ECR_REPOSITORY_MK_VERSION)) parameters:'
	@echo '    ECR_REPOSITORY_ACCESSPOLICY=$(ECR_REPOSITORY_ACCESSPOLICY)'
	@echo '    ECR_REPOSITORY_ACCESSPOLICY_FILEPATH=$(ECR_REPOSITORY_ACCESSPOLICY_FILEPATH)'
	@echo '    ECR_REPOSITORY_LIFECYCLEPOLICY=$(ECR_REPOSITORY_LIFECYCLEPOLICY)'
	@echo '    ECR_REPOSITORY_LIFECYCLEPOLICY_FILEPATH=$(ECR_REPOSITORY_LIFECYCLEPOLICY_FILEPATH)'
	@echo '    ECR_REPOSITORY_NAME=$(ECR_REPOSITORY_NAME)'
	@echo '    ECR_REPOSITORY_REGISTRY_ID=$(ECR_REPOSITORY_REGISTRY_ID)'
	@echo '    ECR_REPOSITORIES_NAMES=$(ECR_REPOSITORIES_NAMES)'
	@echo '    ECR_REPOSITORIES_SET_NAME=$(ECR_REPOSITORIES_SET_NAME)'
	@echo

_ecr_view_framework_targets ::
	@echo 'AWS::ECR::Repository ($(_AWS_ECR_REPOSITORY_MK_VERSION)) targets:'
	@echo '    _ecr_create_repository                    - Create a repository'
	@echo '    _ecr_delete_repository                    - Delete a repository'
	@echo '    _ecr_delete_repository_accesspolicy       - Delete the access-policy of a repository'
	@echo '    _ecr_show_repository                      - Show details of a repository'
	@echo '    _ecr_show_repository_accesspolicy         - Show the access-policy of a repository'
	@echo '    _ecr_show_repository_description          - Show description of a repository'
	@echo '    _ecr_show_repository_lifecyclepolicy      - Show the lifecycle-policy of a repository'
	@echo '    _ecr_view_repositories                    - View existing repositories'
	@echo '    _ecr_view_repositories_set                - View a set of repositories'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ecr_create_repository:
	@$(INFO) '$(ECR_UI_LABEL)Creating repository "$(ECR_REPOSITORY_NAME)" ...'; $(NORMAL)
	$(AWS) ecr create-repository $(__ECR_REPOSITORY_NAME) --query "repository"

_ecr_delete_repository:
	@$(INFO) '$(ECR_UI_LABEL)Deleting repository "$(ECR_REPOSITORY_NAME)" ...'; $(NORMAL)
	$(AWS) ecr delete-repository $(__ECR_FORCE) $(__ECR_REGISTRY_ID__REPOSITORY) $(__ECR_REPOSITORY_NAME) --query "repository"

_ecr_delete_repository_accesspolicy:
	@$(INFO) '$(ECR_UI_LABEL)Deleting access-policy of repository "$(ECR_REPOSITORY_NAME)" ...'; $(NORMAL)
	$(AWS) ecr delete-repository-policy $(__ECR_REGISTRY_ID__REPOSITORY) $(__ECR_REPOSITORY_NAME) --query "policyText" --output text

_ecr_delete_repository_lifecyclepolicy:
	@$(INFO) '$(ECR_UI_LABEL)Deleting lifecycle-policy of repository "$(ECR_REPOSITORY_NAME)" ...'; $(NORMAL)
	$(AWS) ecr delete-lifecycle-policy $(__ECR_REGISTRY_ID__REPOSITORY) $(__ECR_REPOSITORY_NAME) --query "lifecyclePolicyText" --output text

_ecr_show_repository :: _ecr_show_repository_accesspolicy _ecr_show_repository_lifecyclepolicy _ecr_show_repository_description

_ecr_show_repository_accesspolicy:
	@$(INFO) '$(ECR_UI_LABEL)Showing access-policy of repository "$(ECR_REPOSITORY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This policy dictates who can access the repository and which action the princiapl can call'; $(NORMAL)
	@$(WARN) 'This operation fails if the policy has not yet been set!'; $(NORMAL)
	$(AWS) ecr get-repository-policy $(__ECR_REGISTRY_ID__REPOSITORY) $(__ECR_REPOSITORY_NAME) --query "policyText" --output text | jq '.'

_ecr_show_repository_description:
	@$(INFO) '$(ECR_UI_LABEL)Showing description of repository "$(ECR_REPOSITORY_NAME)" ...'; $(NORMAL)
	$(AWS) ecr describe-repositories $(__ECR_REGISTRY_ID__REPOSITORY) $(_X__ECR_REPOSITORY_NAMES) --repository-names $(ECR_REPOSITORY_NAME) --query "repositories"

_ecr_show_repository_lifecyclepolicy:
	@$(INFO) '$(ECR_UI_LABEL)Showing lifecycle-policy of repository "$(ECR_REPOSITORY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This policy dictates how the docker images are managed'; $(NORMAL)
	@$(WARN) 'This operation fails if the policy has not yet been set!'; $(NORMAL)
	$(AWS) ecr get-lifecycle-policy $(__ECR_REGISTRY_ID__REPOSITORY) $(__ECR_REPOSITORY_NAME) --query "lifecyclePolicyText" --output text | jq '.'

_ecr_update_repository_accesspolicy:
	@$(INFO) '$(ECR_UI_LABEL)Updating access-policy of repository "$(ECR_REPOSITORY_NAME)" ...'; $(NORMAL)
	$(if $(ECR_REPOSITORY_ACCESSPOLICY_FILEPATH), cat $(ECR_REPOSITORY_ACCESSPOLICY_FILEPATH))
	$(AWS) ecr set-repository-policy $(__ECR_FORCE) $(__ECR_POLICY_TEXT) $(__ECR_REGISTRY_ID) $(__ECR_REPOSITORY_NAME) --query "policyText" --output text

_ecr_update_repository_lifecyclepolicy:
	@$(INFO) '$(ECR_UI_LABEL)Updating lifecycle-policy of repository "$(ECR_REPOSITORY_NAME)" ...'; $(NORMAL)
	$(if $(ECR_REPOSITORY_LIFECYCLEPOLICY_FILEPATH), cat $(ECR_REPOSITORY_LIFECYCLEPOLICY_FILEPATH))
	$(AWS) ecr put-lifecycle-policy $(__ECR_LIFECYCLE_POLICY_TEXT) $(__ECR_REGISTRY_ID) $(__ECR_REPOSITORY_NAME) --query "lifecyclePolicyText" --output text

_ecr_view_repositories:
	@$(INFO) '$(ECR_UI_LABEL)Viewing repositories ...'; $(NORMAL)
	$(AWS) ecr describe-repositories $(_X__ECR_REGISTRY_ID) $(_X__ECR_REPOSITORY_NAMES)  --query "repositories[]$(ECR_UI_VIEW_REPOSITORIES_FIELDS)"

_ecr_view_repositories_set:
	@$(INFO) '$(ECR_UI_LABEL)Viewing repositories-set "$(ECR_REPOSITORIES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Repositories are grouped based on registry and provided repository-names'; $(NORMAL)
	$(AWS) ecr describe-repositories $(__ECR_REGISTRY_ID__REPOSITORY) $(__ECR_REPOSITORY_NAMES)  --query "repositories[$(ECR_UI_VIEW_REPOSITORIES_SET_SLICE)]$(ECR_UI_VIEW_REPOSITORIES_SET_FIELDS)"
