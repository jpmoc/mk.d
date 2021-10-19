_AWS_SERVICECATALOG_TAGOPTION_MK_VERSION?= $(_AWS_SERVICECATALOG_MK_VERSION)

# SCG_TAGOPTION_ID?= tag-wfjlg42kzvoh2
# SCG_TAGOPTION_FILTERS?=
# SCG_TAGOPTION_KEY?= OwnedBy
# SCG_TAGOPTION_NAME?= OwnedBy::BobbyRobot
# SCG_TAGOPTION_VALUE?= BobbyRobot

# Derived parameters
SCG_TAGOPTION_NAME?= $(SCG_TAGOPTION_KEY)=$(SCG_TAGOPTION_VALUE)
SCG_TAGOPTION_RESOURCE_ID?= $(SCG_PORTFOLIO_ID)
SCG_TAGOPTION_RESOURCE_NAME?= $(SCG_PORTFOLIO_NAME)

# Options parameters
__SCG_FILTERS_TAGOPTION= $(if $(SCG_TAGOPTION_FILTERS),--filters $(SCG_TAGOPTION_FILTERS))
__SCG_KEY= $(if $(SCG_TAGOPTION_KEY),--key '$(SCG_TAGOPTION_KEY)')
__SCG_ID__TAGOPTION= $(if $(SCG_TAGOPTION_ID),--id $(SCG_TAGOPTION_ID))
__SCG_RESOURCE_ID= $(if $(SCG_TAGOPTION_RESOURCE_ID),--resource-id $(SCG_TAGOPTION_RESOURCE_ID))
__SCG_RESOURCE_TYPE= $(if $(SCG_TAGOPTION_RESOURCE_TYPE),--resource-type $(SCG_TAGOPTION_RESOURCE_TYPE))
__SCG_TAG_OPTION_ID= $(if $(SCG_TAGOPTION_ID),--tag-option-id $(SCG_TAGOPTION_ID))
__SCG_VALUE= $(if $(SCG_TAGOPTION_VALUE),--value '$(SCG_TAGOPTION_VALUE)')

# UI parameters
SCG_UI_SHOW_TAGOPTION_ASSOCIATIONS_FIELDS?= .{Id:Id,Name:Name,description:Description}
SCG_UI_VIEW_TAGOPTIONS_FIELDS?=
SCG_UI_VIEW_TAGOPTIONS_SET_FIELDS?= $(SCG_UI_VIEW_TAGOPTIONS_FIELD)
SCG_UI_VIEW_TAGOPTIONS_SET_SLICE?=

#--- Utilities

#--- MACROS
_scg_get_tagoption_id=$(call _scg_get_tagoption_id_K, $(SCG_TAGOPTION_KEY))
_scg_get_tagoption_id_K=$(call _scg_get_tagoption_id_KV, $(1), $(SCG_TAGOPTION_VALUE))
_scg_get_tagoption_id_KV=$(shell $(AWS) servicecatalog list-tag-options  --query "TagOptionDetails[?Key=='$(strip $(1))'&&Value=='$(strip $(2))'].Id" --output text)

#----------------------------------------------------------------------
# USAGE
#

_scg_view_framework_macros ::
	@echo 'AWS::ServiceCataloG::TagOption ($(_AWS_SERVICECATALOG_TAGOPTION_MK_VERSION)) macros:'
	@echo '    _scg_get_tagoption_id_{|K|KV}       - Get a tag option id (Key,Value)'
	@echo

_scg_view_framework_parameters ::
	@echo 'AWS::ServiceCataloG::TagOption ($(_AWS_SERVICECATALOG_TAGOPTION_MK_VERSION)) parameters:'
	@echo '    SCG_TAGOPTION_FILTERS=$(SCG_TAGOPTION_FILTERS)'
	@echo '    SCG_TAGOPTION_ID=$(SCG_TAGOPTION_ID)'
	@echo '    SCG_TAGOPTION_KEY=$(SCG_TAGOPTION_KEY)'
	@echo '    SCG_TAGOPTION_NAME=$(SCG_TAGOPTION_NAME)'
	@echo '    SCG_TAGOPTION_RESOURCE_ID=$(SCG_TAGOPTION_RESOURCE_ID)'
	@echo '    SCG_TAGOPTION_RESOURCE_NAME=$(SCG_TAGOPTION_RESOURCE_NAME)'
	@echo '    SCG_TAGOPTION_RESOURCE_TYPE=$(SCG_TAGOPTION_RESOURCE_TYPE)'
	@echo '    SCG_TAGOPTION_VALUE=$(SCG_TAGOPTION_VALUE)'
	@echo

_scg_view_framework_targets ::
	@echo 'AWS::ServiceCataloG::TagOption ($(_AWS_SERVICECATALOG_TAGOPTION_MK_VERSION)) targets:'
	@echo '    _scg_create_tagoption              - Create a tag-option'
	@echo '    _scg_delete_tagoption              - Delete a tag-option'
	@echo '    _scg_show_tagoption                - Show everything related to a tag-option'
	@echo '    _scg_show_tagoption_associations   - Show associations of a tag-option'
	@echo '    _scg_show_tagoption_description    - Show description of a tag-option'
	@echo '    _scg_tag_resource                  - Add a tag-option to a resource'
	@echo '    _scg_untag_resource                - Remove a tag-option to a resource'
	@echo '    _scg_view_tagoptions               - View tag-options'
	@echo '    _scg_view_tagoptions_set           - View set of tag-options'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_scg_create_tagoption:
	@$(INFO) '$(SCG_UI_LABEL)Creating a tag-option "$(SCG_TAGOPTION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'You cannot create tag-options with the same key-value pair'; $(NORMAL)
	$(AWS) servicecatalog create-tag-option $(__SCG_KEY) $(__SCG_VALUE)

_scg_delete_tagoption:
	@$(INFO) '$(SCG_UI_LABEL)Deleting a tag-option "$(SCG_TAGOPTION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'To be deleted, a tag-option must first be disassociated from all of its resources'; $(NORMAL)
	$(AWS) servicecatalog delete-tag-option $(__SCG_ID__TAGOPTION)

_scg_show_tagoption: _scg_show_tagoption_associations _scg_show_tagoption_description

_scg_show_tagoption_description:
	@$(INFO) '$(SCG_UI_LABEL)Showing tag-option "$(SCG_TAGOPTION_NAME)" ...'; $(NORMAL)
	$(AWS) servicecatalog describe-tag-option $(__SCG_ID__TAGOPTION)

_scg_show_tagoption_associations:
	@$(INFO) '$(SCG_UI_LABEL)Showing associations with tag-option "$(SCG_TAGOPTION_NAME)" ...'; $(NORMAL)
	$(AWS) servicecatalog list-resources-for-tag-option $(__SCG_RESOURCE_TYPE) $(__SCG_TAG_OPTION_ID) --query "ResourceDetails[]$(SCG_UI_SHOW_TAGOPTION_ASSOCIATIONS_FIELDS)"

_scg_tag_resource:
	@$(INFO) '$(SCG_UI_LABEL)Adding tag-option to resource "$(SCG_TAGOPTION_RESOURCE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'You cannot add the same tag-option twice to a resource'; $(NORMAL)
	$(AWS) servicecatalog associate-tag-option-with-resource $(__SCG_RESOURCE_ID) $(__SCG_TAG_OPTION_ID)

_scg_untag_resource:
	@$(INFO) '$(SCG_UI_LABEL)Untagging resource "$(SCG_TAGOPTION_RESOURCE_NAME)" ...'; $(NORMAL)
	$(AWS) servicecatalog disassociate-tag-option-from-resource $(__SCG_RESOURCE_ID) $(__SCG_TAG_OPTION_ID)

_scg_view_tagoptions:
	@$(INFO) '$(SCG_UI_LABEL)Viewing ALL tag-options ...'; $(NORMAL)
	$(AWS) servicecatalog list-tag-options $(_X__SCG_FILTERS__TAGOPTIONS) --query "TagOptionDetails[]$(SCG_UI_VIEW_TAGOPTIONS_FIELDS)"

_scg_view_tagoptions_set:
	@$(INFO) '$(SCG_UI_LABEL)Viewing tag-options-set "$(SCG_TAGOPTIONS_SET_NAME)" ...'; $(NORMAL)
	$(AWS) servicecatalog list-tag-options $(__SCG_FILTERS__TAGOPTIONS) --query "TagOptionDetails[$(SCG_UI_VIEW_TAGOPTIONS_SET_SLICE)]$(SCG_UI_VIEW_TAGOPTIONS_SET_FIELDS)"
