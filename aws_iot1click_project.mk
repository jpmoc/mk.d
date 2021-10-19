_AWS_IOT1CLICK_PROJECT_MK_VERSION= $(_AWS_IOT1CLICK_MK_VERSION)

# I1K_PROJECT_ACCOUNT_ID?= 012345678901
# I1K_PROJECT_ARN?= arn:aws:iot1click:us-west-2:012345678901:projects/SendEmail
# I1K_PROJECT_DESCRIPTION?= "This is my project!"
# I1K_PROJECT_NAME?= SendEmail
# I1K_PROJECT_PLACEMENT_TEMPLATE?= defaultAttributes={KeyName1=string,KeyName2=string},deviceTemplates={KeyName1={deviceType=string,callbackOverrides={KeyName1=string,KeyName2=string}},KeyName2={deviceType=string,callbackOverrides={KeyName1=string,KeyName2=string}}}
# I1K_PROJECT_REGION_NAME?= us-west-2
# I1K_PROJECT_TAGS_KEYVALUES?= KeyName1=string KeyName2=string
# I1K_PROJECT_TAGS_KEYS?= KeyName1 KeyName2

# Derived parameters
I1K_PROJECT_ACCOUNT_ID?= $(I1K_ACCOUNT_ID)
I1K_PROJECT_REGION_NAME?= $(I1K_REGION_NAME)

# Options parameters
__I1K_DESCRIPTION__PROJECT= $(if $(I1K_PROJECT_DESCRIPTION),--description $(I1K_PROJECT_DESCRIPTION))
__I1K_PLACEMENT_TEMPLATE= $(if $(I1K_PROJECT_PLACEMENTE_TEMPLATE),--placement-template $(I1K_PROJECT_PLACEMENT_TEMPLATE))
__I1K_PROJECT_NAME= $(if $(I1K_PROJECT_NAME),--project-name $(I1K_PROJECT_NAME))
__I1K_RESOURCE_ARN__PROJECT= $(if $(I1K_PROJECT_ARN),--resource-arn $(I1K_PROJECT_ARN))
__I1K_TAGS__PROJECT= $(if $(I1K_PROJECT_TAGS_KEYVALUES),--tags $(subst $(SPACE),$(COMMA),$(I1K_PROJECT_TAGS_KEYVALUES)))
__I1K_TAG_KEYS__PROJECT= $(if $(I1K_PROJECT_TAGS_KEYS),--tag-keys $(I1K_PROJECT_TAGS_KEYS))

# Pipe parameters

# UI parameters
I1K_UI_VIEW_PROJECTS_FIELDS?=
I1K_UI_VIEW_PROJECTS_SET_FIELDS?= $(I1K_UI_VIEW_PROJECTS_FIELDS)

#--- Utilities

#--- MACRO
_i1k_get_project_arn= $(call _i1k_get_project_arn_I, $(I1K_PROJECT_NAME))
_i1k_get_project_arn_I= $(shell echo 'arn:aws:iot1click:$(I1K_PROJECT_REGION_NAME):$(I1K_PROJECT_ACCOUNT_ID):projects/$(strip $(1))')

#----------------------------------------------------------------------
# USAGE
#

_i1k_view_framework_macros ::
	@echo 'AWS::Iot1clicK::Project ($(_AWS_IOT1CLICK_PROJECT_MK_VERSION)) macros:'
	@echo '    _i1k_get_project_arn_{|I}           - Get the ARN of the project (Id)'
	@echo

_i1k_view_framework_parameters ::
	@echo 'AWS::Iot1clicK::Project ($(_AWS_IOT1CLICK_PROJECT_MK_VERSION)) parameters:'
	@echo '    I1K_PROJECT_ACCOUNT_ID=$(I1K_PROJECT_ACCOUNT_ID)'
	@echo '    I1K_PROJECT_ARN=$(I1K_PROJECT_ARN)'
	@echo '    I1K_PROJECT_DESCRIPTION=$(I1K_PROJECT_DESCRIPTION)'
	@echo '    I1K_PROJECT_NAME=$(I1K_PROJECT_NAME)'
	@echo '    I1K_PROJECT_PLACEMENT_TEMPLATE=$(I1K_PROJECT_PLACEMENT_TEMPLATE)'
	@echo '    I1K_PROJECT_REGION_NAME=$(I1K_PROJECT_REGION_NAME)'
	@echo '    I1K_PROJECT_TAGS_KEYVALUES=$(I1K_PROJECT_TAGS_KEYVALUES)'
	@echo '    I1K_PROJECT_TAGS_KEYS=$(I1K_PROJECT_TAGS_KEYS)'
	@echo '    I1K_PROJECTS_SET_NAME=$(I1K_PROJECTS_SET_NAME)'
	@echo

_i1k_view_framework_targets ::
	@echo 'AWS::Iot1clicK::Project ($(_AWS_IOT1CLICK_PROJECT_MK_VERSION)) targets:'
	@echo '    _i1k_create_project                - Create a project'
	@echo '    _i1k_delete_project                - Delete an existing project'
	@echo '    _i1k_show_project                  - Show everything relatead to a project'
	@echo '    _i1k_show_project_description      - Show description of a project'
	@echo '    _i1k_show_project_placements       - Show placements in a project'
	@echo '    _i1k_tag_project                   - Tag a projects'
	@echo '    _i1k_untag_project                 - Remove tags from a projects'
	@echo '    _i1k_view_projects                 - View projects'
	@echo '    _i1k_view_projects_set             - View a set of projects'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_i1k_create_project:
	@$(INFO) '$(AWS_UI_LABEL)Creating project "$(I1K_PROJECT_NAME)" ...'; $(NORMAL)

_i1k_delete_project:
	@$(INFO) '$(AWS_UI_LABEL)Deleting project "$(I1K_PROJECT_NAME)" ...'; $(NORMAL)
	$(AWS) iot1click-projects unclaim-project $(__I1K_PROJECT_ID)

_i1k_show_project:: _i1k_show_project_placements _i1k_show_project_tags _i1k_show_project_description

_i1k_show_project_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of project "$(I1K_PROJECT_NAME)" ...'; $(NORMAL)
	$(AWS) iot1click-projects describe-project $(__I1K_PROJECT_NAME) --query "project"

_i1k_show_project_placements:
	@$(INFO) '$(AWS_UI_LABEL)Showing placements in project "$(I1K_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Devices are mapped to device-templates defined in placements'; $(NORMAL)
	$(AWS) iot1click-projects list-placements $(__I1K_PROJECT_NAME) --query "placements[]"

_i1k_show_project_tags:
	@$(INFO) '$(AWS_UI_LABEL)Showing tags for project "$(I1K_PROJECT_NAME)" ...'; $(NORMAL)
	$(AWS) iot1click-projects list-tags-for-resource $(__I1K_RESOURCE_ARN__PROJECT) --query 'tags'

_i1k_tag_project:
	@$(INFO) '$(AWS_UI_LABEL)Tagging project "$(I1K_PROJECT_NAME)" ...'; $(NORMAL)
	$(AWS) iot1click-projects tag-resource $(__I1K_RESOURCE_ARN__PROJECT) $(__I1K_TAGS__PROJECT)

_i1k_untag_project:
	@$(INFO) '$(AWS_UI_LABEL)Untagging project "$(I1K_PROJECT_NAME)" ...'; $(NORMAL)
	$(AWS) iot1click-projects untag-resource $(__I1K_RESOURCE_ARN__PROJECT) $(__I1K_TAG_KEYS__PROJECT)

_i1k_view_projects:
	@$(INFO) '$(AWS_UI_LABEL)View projects ...'; $(NORMAL)
	$(AWS) iot1click-projects list-projects --query "projects[]$(I1K_UI_VIEW_PROJECTS_FIELDS)"

_i1k_view_projects_set:
	@$(INFO) '$(AWS_UI_LABEL)View projects-set "$(I1K_PROJECPROJECTT_NAME)" ...'; $(NORMAL)
