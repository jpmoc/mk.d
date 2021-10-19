_AWS_CODECOMMIT_REPOSITORY_MK_VERSION= $(_AWS_CODECOMMIT_MK_VERSION)

# CCT_REPOSITORY_DESCRIPTION?= "This is my repository description"
# CCT_REPOSITORY_NAME?=
# CCT_REPOSITORY_NAMES?= MyDemoRepo MyOtherDemoRep
# CCT_REPOSITORY_REGION?= us-west-2

# Derived parameters
CCT_REPOSITORY_NAMES?= $(CCT_REPOSITORY_NAME)
CCT_REPOSITORY_REGION?= $(AWS_REGION)
CCT_REPOSITORY_HTTPS?= $(if $(CCT_REPOSITORY_NAME),https://git-codecommit.$(CCT_REPOSITORY_REGION).amazonaws.com/v1/repos/$(CCT_REPOSITORY_NAME))
CCT_REPOSITORY_SSH?= $(if $(CCT_REPOSITORY_NAME),ssh://git-codecommit.$(CCT_REPOSITORY_REGION).amazonaws.com/v1/repos/$(CCT_REPOSITORY_NAME))

# Option parameters
__CCT_BRANCH_NAME= $(if $(CCT_BRANCH_NAME), --branch-name $(CCT_BRANCH_NAME))
__CCT_COMMIT_ID= $(if $(CCT_COMMIT_ID), --commit-id $(CCT_COMMIT_ID))
__CCT_REPOSITORY_DESCRIPTION= $(if $(CCT_REPOSITORY_DESCRIPTION), --repository-description $(CCT_REPOSITORY_DESCRIPTION))
__CCT_REPOSITORY_NAME= $(if $(CCT_REPOSITORY_NAME), --repository-name $(CCT_REPOSITORY_NAME))
__CCT_REPOSITORY_NAMES= $(if $(CCT_REPOSITORY_NAMES), --repository-names $(CCT_REPOSITORY_NAMES))

# UI parameters
CCT_UI_VIEW_REPOSITORIES_FIELDS?=
CCT_UI_VIEW_REPOSITORIES_SET_FIELDS?= .{RepositoryName:repositoryName,RepositoryId:repositoryId,defaultBranch:defaultBranch,repositoryDescription:repositoryDescription}

#--- MACROS
_cct_get_repository_http_endpoint=$(call _cct_get_repository_http_endpoint_N, $(CCT_REPOSITORY_NAME))
_cct_get_repository_http_endpoint_N=$(call _cct_get_repository_parameter_NP, $(1), cloneUrlHttp)
_cct_get_repository_ssh_endpoint=$(call _cct_get_repository_ssh_endpoint_N, $(CCT_REPOSITORY_NAME))
_cct_get_repository_ssh_endpoint_N=$(call _cct_get_repository_parameter_NP, $(1), cloneUrlSsh)
_cct_get_repository_parameter_NP=$(shell $(AWS) codecommit get-repository  --repository-name $(1) --query "repositoryMetadata.[$(2)]" --output text)

#----------------------------------------------------------------------
# USAGE
#

_cct_view_framework_macros ::
	@echo 'AWS::CodeCommiT::Repository ($(_AWS_CODECOMMIT_REPOSITORY_MK_VERSION)) macros:'
	@echo '    _cct_get_repository_http_endpoint{|N}  - Get the http URL of this repository (Name)'
	@echo '    _cct_get_repository_ssh_endpoint{|N}   - Get the ssh URL of this repository (Name)'
	@echo '    _cct_get_repository_parameter_{N|NP}   - Get a repository parameter (Name, Param)'
	@echo

_cct_view_framework_parameters ::
	@echo 'AWS::CodeCommiT::Repository ($(_AWS_CODECOMMIT_REPOSITORY_MK_VERSION)) parameters:'
	@echo '    CCT_REPOSITORY_DESCRIPTION=$(CCT_REPOSITORY_DESCRIPTION)'
	@echo '    CCT_REPOSITORY_HTTPS=$(CCT_REPOSITORY_HTTPS)'
	@echo '    CCT_REPOSITORY_NAME=$(CCT_REPOSITORY_NAME)'
	@echo '    CCT_REPOSITORY_NAMES=$(CCT_REPOSITORY_NAMES)'
	@echo '    CCT_REPOSITORY_REGION=$(CCT_REPOSITORY_REGION)'
	@echo '    CCT_REPOSITORY_SSH=$(CCT_REPOSITORY_SSH)'
	@echo

_cct_view_framework_targets ::
	@echo 'AWS::CodeCommiT::Repository ($(_AWS_CODECOMMIT_REPOSITORY_MK_VERSION)) targets:'
	@echo '    _cct_create_repository             - Create a repository'
	@echo '    _cct_delete_repository             - Delete a repository'
	@echo '    _cct_show_repository               - Show details for a repository'
	@echo '    _cct_view_repositories             - View existing repositories'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cct_create_repository:
	@$(INFO) '$(AWS_UI_LABEL)Creating repository "$(CCT_REPOSITORY_NAME)" ...'; $(NORMAL)
	$(AWS) codecommit create-repository $(__CCT_REPOSITORY_DESCRIPTION) $(__CCT_REPOSITORY_NAME)

_cct_delete_repository:
	@$(INFO) '$(AWS_UI_LABEL)Deleting repository "$(CCT_REPOSITORY_NAME)" ...'; $(NORMAL)
	$(AWS) codecommit delete-repository $(__CCT_REPOSITORY_NAME)

_cct_show_repository:
	@$(INFO) '$(AWS_UI_LABEL)Showing repository "$(CCT_REPOSITORY_NAME)" ...'; $(NORMAL)
	$(AWS) codecommit get-repository $(__CCT_REPOSITORY_NAME) --query "repositoryMetadata"

_cct_view_repositories:
	@$(INFO) '$(AWS_UI_LABEL)View repositories ...'; $(NORMAL)
	$(AWS) codecommit list-repositories --query "repositories[]$(CCT_UI_VIEW_REPOSITORIES_FIELDS)"

_cct_view_repositories_set:
	@$(INFO) '$(AWS_UI_LABEL)View set of repositories ...'; $(NORMAL)
	$(AWS) codecommit batch-get-repositories $(__CCT_REPOSITORY_NAMES) --query "repositories[]$(CCT_UI_VIEW_REPOSITORIES_SET_FIELDS)"
