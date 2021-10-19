_AWS_IOT1CLICK_PLACEMENT_MK_VERSION= $(_AWS_IOT1CLICK_MK_VERSION)

# I1K_PLACEMENT_ATTRIBUTES_KEYVALUES?= KeyName1=string KeyName2=string
# I1K_PLACEMENT_NAME?= SendEmail
# I1K_PLACEMENT_PROJECT_NAME?=
# I1K_PLACEMENTS_SET_NAME?= my-placements-set

# Derived parameters
I1K_PLACEMENT_PROJECT_NAME?= $(I1K_PROJECT_NAME)

# Options parameters
__I1K_ATTRIBUTES= $(if $(I1K_PLACEMENT_ATTRIBUTES_KEYVALUES),--attributes $(subst $(SPACE),$(CAOMMA),$(I1K_PLACEMENT_ATTRIBUTE_KEYVALUES)))
__I1K_PLACEMENT_NAME= $(if $(I1K_PLACEMENT_NAME),--placement-name $(I1K_PLACEMENT_NAME))
__I1K_PROJECT_NAME__PLACEMENT= $(if $(I1K_PLACEMENT_PROJECT_NAME),--project-name $(I1K_PLACEMENT_PROJECT_NAME))

# Pipe parameters

# UI parameters
I1K_UI_VIEW_PLACEMENTS_FIELDS?=
I1K_UI_VIEW_PLACEMENTS_SET_FIELDS?= $(I1K_UI_VIEW_PLACEMENTS_FIELDS)

#--- Utilities

#--- MACRO
_i1k_get_project_arn= $(call _i1k_get_project_arn_I, $(I1K_PLACEMENT_NAME))
_i1k_get_project_arn_I= $(shell echo 'arn:aws:iot1click:$(I1K_PLACEMENT_REGION_NAME):$(I1K_PLACEMENT_ACCOUNT_ID):projects/$(strip $(1))')

#----------------------------------------------------------------------
# USAGE
#

_i1k_view_framework_macros ::
	@echo 'AWS::Iot1clicK::Project ($(_AWS_IOT1CLICK_PLACEMENT_MK_VERSION)) macros:'
	@echo '    _i1k_get_project_arn_{|I}           - Get the ARN of the project (Id)'
	@echo

_i1k_view_framework_parameters ::
	@echo 'AWS::Iot1clicK::Project ($(_AWS_IOT1CLICK_PLACEMENT_MK_VERSION)) parameters:'
	@echo '    I1K_PLACEMENT_ATTRIBUTES_KEYVALUES=$(I1K_PLACEMENT_ATTRIBUTES_KEYVALUES)'
	@echo '    I1K_PLACEMENT_NAME=$(I1K_PLACEMENT_NAME)'
	@echo '    I1K_PLACEMENT_PROJECT_NAME=$(I1K_PLACEMENT_PROJECT_NAME)'
	@echo '    I1K_PLACEMENTS_SET_NAME=$(I1K_PLACEMENTS_SET_NAME)'
	@echo

_i1k_view_framework_targets ::
	@echo 'AWS::Iot1clicK::Project ($(_AWS_IOT1CLICK_PLACEMENT_MK_VERSION)) targets:'
	@echo '    _i1k_create_placement                - Create a placement'
	@echo '    _i1k_delete_placement                - Delete an existing placement'
	@echo '    _i1k_show_placement                  - Show everything relatead to a placement'
	@echo '    _i1k_show_placement_description      - Show description of a placement'
	@echo '    _i1k_show_placement_devices          - Show devices using a placement'
	@echo '    _i1k_tag_placement                   - Tag a placements'
	@echo '    _i1k_untag_placement                 - Remove tags from a placements'
	@echo '    _i1k_view_placements                 - View placements'
	@echo '    _i1k_view_placements_set             - View a set of placements'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_i1k_create_placement:
	@$(INFO) '$(AWS_UI_LABEL)Creating placement "$(I1K_PLACEMENT_NAME)" in project "$(I1K_PLACEMENT_PROJECT_NAME)" ...'; $(NORMAL)
	$(AWS) iot1click-projects create-placement $(__I1K_ATTRIBUTES) $(__I1K_PLACEMENT_NAME) $(__I1K_PROJECT_NAME__PLACEMENT)

_i1k_delete_placement:
	@$(INFO) '$(AWS_UI_LABEL)Deleting placement "$(I1K_PLACEMENT_NAME)" in project "$(I1K_PLACEMENT_PROJECT_NAME)" ...'; $(NORMAL)
	$(AWS) iot1click-projects delete_placement $(__I1K_PLACEMENT_NAME) $(__I1K_PROJECT_NAME__PLACEMENT)

_i1k_show_placement:: _i1k_show_placement_devices _i1k_show_placement_description

_i1k_show_placement_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of placement "$(I1K_PLACEMENT_NAME)" ...'; $(NORMAL)
	$(AWS) iot1click-projects describe-placement $(__I1K_PLACEMENT_NAME) $(__I1K_PROJECT_NAME) --query "placement"

_i1k_show_placement_devices:
	@$(INFO) '$(AWS_UI_LABEL)Showing devices in placement "$(I1K_PLACEMENT_NAME)" ...'; $(NORMAL)
	$(AWS) iot1click-projects get-devices-in-placement $(__I1K_PLACEMENT_NAME) $(__I1K_PROJECT_NAME) --query "devices"

_i1k_view_placements:
	@$(INFO) '$(AWS_UI_LABEL)View placements ...'; $(NORMAL)
	$(AWS) iot1click-projects list-placements $(__I1K_PROJECT_NAME__PLACEMENT) --query "placements[]$(I1K_UI_VIEW_PLACEMENTS_FIELDS)"

_i1k_view_placements_set:
	@$(INFO) '$(AWS_UI_LABEL)View placements-set "$(I1K_PROJECPLACEMENTT_NAME)" ...'; $(NORMAL)
