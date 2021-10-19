_AWS_CODESTAR_PROJECT_MK_VERSION=$(_AWS_CODESTAR_MK_VERSION)

# CSR_PORJECT_ARN?= arn:aws:codestar:us-west-2:123456789012:project/my-project-id
# CSR_PROJECT_DELETE_STACK?= true
# CSR_PROJECT_DESCRIPTION?= "This is my project description!"
# CSR_PROJECT_ID?=
# CSR_PROJECT_NAME?= my-codestar-project
# CSR_PROJECT_TAGS?= KeyName1=string,KeyName2=string
# CSR_PROJECT_TAG_KEYS?= KeyName1 KeyName2 ...

# Derived parameters
CSR_PROJECT_ID?= $(CSR_PROJECT_NAME)

# Options parameters
_X__CSR_CLIENT_REQUEST_TOKEN=
__CSR_DELETE_STACK= $(if $(filter true, $(CSR_PROJECT_DELETE_STACK)), --delete-stack, --no-delete-stack)
__CSR_DESCRIPTION_PROJECT= $(if $(CSR_PROJECT_DESCRIPTION), --description $(CSR_PROJECT_DESCRIPTION))
__CSR_ID_PROJECT= $(if $(CSR_PROJECT_ID), --id $(CSR_PROJECT_ID))
__CSR_NAME_PROJECT= $(if $(CSR_PROJECT_NAME), --name $(CSR_PROJECT_NAME))
__CSR_PROJECT_ID= $(if $(CSR_PROJECT_ID), --project-id $(CSR_PROJECT_ID))
__CSR_TAGS_PROJECT= $(if $(CSR_PROJECT_TAGS), --tags $(CSR_PROJECT_TAGS))
__CSR_TAG_KEYS_PROJECT= $(if $(CSR_PROJECT_TAG_KEYS), --tags $(CSR_PROJECT_TAG_KEYS))

# UI parameters

#--- Utilities

#--- MACROS
_csr_get_project_arn= $(call _csr_get_project_arn_I, $(CSR_PROJECT_ID))
# _csr_get_project_arn_I= $(shell $(AWS) codestar list-projects --query "project[?projectId=='$(strip $(1))'].projectArn" --output text)
_csr_get_project_arn_I= $(shell echo arn:aws:codestar:$(AWS_REGION):$(AWS_ACCOUNT_ID):project/$(strip $(1)))

#----------------------------------------------------------------------
# USAGE
#

_csr_view_framework_macros ::
	@echo 'AWS::CodeStaR::Project ($(_AWS_CODESTAR_PROJECT_MK_VERSION)) macros:'
	@echo '    _csr_get_project_arn_{|I}              - Get a project ARN (Id)'
	@echo

_csr_view_framework_parameters ::
	@echo 'AWS::CodeStaR::Project ($(_AWS_CODESTAR_PROJECT_MK_VERSION)) parameters:'
	@echo '    CSR_PROJECT_ARN=$(CSR_PROJECT_ARN)'
	@echo '    CSR_PROJECT_DESCRIPTION=$(CSR_PROJECT_DESCRIPTION)'
	@echo '    CSR_PROJECT_ID=$(CSR_PROJECT_ID)'
	@echo '    CSR_PROJECT_NAME=$(CSR_PROJECT_NAME)'
	@echo '    CSR_PROJECT_TAGS=$(CSR_PROJECT_TAGS)'
	@echo '    CSR_PROJECT_TAG_KEYS=$(CSR_PROJECT_TAG_KEYS)'
	@echo

_csr_view_framework_targets ::
	@echo 'AWS::CodeStaR::Project ($(_AWS_CODESTAR_PROJECT_MK_VERSION)) targets:'
	@echo '    _csr_create_project                    - Create a new project'
	@echo '    _csr_delete_project                    - Delete an existing project'
	@echo '    _csr_show_project                      - Show details of a project'
	@echo '    _csr_show_project_description          - Show description of a project'
	@echo '    _csr_show_project_resources            - Show resources of a project'
	@echo '    _csr_show_project_tags                 - Show tags of a project'
	@echo '    _csr_show_project_teammembers          - Show team-members of a project'
	@echo '    _csr_show_project                      - Show details of a project'
	@echo '    _csr_tag_project                       - Tag an existing project'
	@echo '    _csr_update_project                    - Modify an existing project'
	@echo '    _csr_view_projects                     - View existing projects'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_csr_create_project:
	@$(INFO) '$(AWS_UI_LABEL)Creating project "$(CSR_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'If the length of the project name is more than 15, the project ID must be set explicitly!'; $(NORMAL)
	$(AWS) codestar create-project $(__CSR_CLIENT_REQUEST_TOKEN) $(__CSR_DESCRIPTION_PROJECT) $(__CSR_ID_PROJECT) $(__CSR_NAME_PROJECT) 

_csr_delete_project:
	@$(INFO) '$(AWS_UI_LABEL)Creating project "$(CSR_PROJECT_NAME)" ...'; $(NORMAL)
	$(AWS) codestar delete-project $(__CSR_CLIENT_REQUEST_TOKEN) $(__CSR_DELETE_STACK) $(__CSR_ID_PROJECT)

_csr_show_project: _csr_show_project_resources _csr_show_project_tags _csr_show_project_teammembers _csr_show_project_description

_csr_show_project_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of project "$(CSR_PROJECT_NAME)" ...'; $(NORMAL)
	$(AWS) codestar describe-project $(__CSR_ID_PROJECT)

_csr_show_project_resources:
	@$(INFO) '$(AWS_UI_LABEL)Showing resources of project "$(CSR_PROJECT_NAME)" ...'; $(NORMAL)
	$(AWS) codestar list-resources $(__CSR_PROJECT_ID)

_csr_show_project_tags:
	@$(INFO) '$(AWS_UI_LABEL)Showing tags of project "$(CSR_PROJECT_NAME)" ...'; $(NORMAL)
	$(AWS) codestar list-tags-for-project $(__CSR_ID_PROJECT) --query "tags"

_csr_show_project_teammembers:
	@$(INFO) '$(AWS_UI_LABEL)Showing team-members of project "$(CSR_PROJECT_NAME)" ...'; $(NORMAL)
	$(AWS) codestar list-team-members $(__CSR_PROJECT_ID) --query "teamMembers[]"

_csr_tag_project:
	@$(INFO) '$(AWS_UI_LABEL)Tagging project "$(CSR_PROJECT_NAME)" ...'; $(NORMAL)
	$(AWS) codestar tag-project $(__CSR_ID_PROJECT) $(__CSR_TAGS_PROJECT)

_csr_untag_project:
	@$(INFO) '$(AWS_UI_LABEL)Untagging project "$(CSR_PROJECT_NAME)" ...'; $(NORMAL)
	$(AWS) codestar untag-project $(__CSR_ID_PROJECT) $(__CSR_TAG_KEYS_PROJECT)

_csr_update_project:
	@$(INFO) '$(AWS_UI_LABEL)Updating  project "$(CSR_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The project name may change after the update'; $(NORMAL)
	$(AWS) codestar update-project $(__CSR_DESCRIPTION_PROJECT) $(__CSR_ID_PROJECT) $(__CSR_NAME_PROJECT) 

_csr_view_projects: 
	@$(INFO) '$(AWS_UI_LABEL)Viewing codestar projects ...'; $(NORMAL)
	$(AWS) codestar list-projects --query "projects[]"
