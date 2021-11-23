_AWS_CLOUDFORMATION_TEMPLATE_MK_VERSION= $(_AWS_CLOUDFORMATION_MK_VERSION)

# CFN_PROJECT_DIRPATH?= ./projects/my-project
# CFN_PROJECT_NAME?= my-project
CFN_ROOT_DIRPATH?= ./cfn.d/$(AWS_ACCOUNT_ID)
# CFN_TEMPLATE_FILEPATH?= $(call _cfn_get_root_template_filepath)
# CFN_TEMPLATE_FILEPATHS?= $(call _cfn_get_template_filepaths)
# CFN_TEMPLATES_SET_NAME?= my-templates-set

# Derived parameters
CFN_PROJECT_NAME?= $(CFN_STACK_NAME)
CFN_PROJECT_DIRPATH?= $(subst $(SPACE),/,$(strip $(CFN_ROOT_DIRPATH) $(CFN_PROJECT_NAME)))
CFN_TEMPLATE_FILEPATHS?= $(CFN_TEMPLATE_FILEPATH)
CFN_TEMPLATES_SET_NAME?= $(CFN_STACK_NAME)

# Options
__CFN_TEMPLATE_BODY= $(if $(CFN_TEMPLATE_FILEPATH), --template-body file://$(CFN_TEMPLATE_FILEPATH))

# Customizations

# Utilities
CLOUDFORMER_BIN?= cloudformer
CLOUDFORMER?= $(__CLOUDFORMER_ENVIRONMENT) $(CLOUDFORMER_ENVIRONMENT) $(CLOUDFORMER_BIN) $(__CLOUDFORMER_OPTIONS) $(CLOUDFORMER_OPTIONS)

# Macros
_cfn_get_template_filepaths=$(shell $(CLOUDFORMER) --get-template-filepaths)
_cfn_get_root_template_filepath=$(shell $(CLOUDFORMER) --get-root-template-filepath)

#----------------------------------------------------------------------
# USAGE
#

_cfn_list_macros ::
	@echo 'AWS::CloudFormatioN::Template ($(_AWS_CLOUDFORMATION_TEMPLATE_MK_VERSION)) macros:'
	@echo '    _cfn_get_template_filepaths       - Get a list of file-paths to all templates'
	@echo '    _cfn_get_root_template_filepath   - Get the file-path to the root template'
	@echo

_cfn_list_parameters ::
	@echo 'AWS::CloudFormatioN::Template ($(_AWS_CLOUDFORMATION_TEMPLATE_MK_VERSION)) parameters:'
	@echo '    CFN_ROOT_DIRPATH=$(CFN_ROOT_DIRPATH)'
	@echo '    CFN_PROJECT_DIRPATH=$(CFN_PROJECT_DIRPATH)'
	@echo '    CFN_TEMPLATE_FILEPATH=$(CFN_TEMPLATE_FILEPATH)'
	@echo '    CFN_TEMPLATE_FILEPATHS=$(CFN_TEMPLATE_FILEPATHS)'
	@echo '    CFN_TEMPLATES_SET_NAME=$(CFN_TEMPLATES_SET_NAME)'
	@echo '    CLOUDFORMER=$(CLOUDFORMER)'
	@echo

_cfn_list_targets ::
	@echo 'AWS::CloudFormatioN::Template ($(_AWS_CLOUDFORMATION_TEMPLATE_MK_VERSION)) targets:'
	@echo '    _cfn_build_template               - Build a template'
	@echo '    _cfn_build_templates_set          - Build a templates-set'
	@echo '    _cfn_estimate_cost                - Estimate monthly cost of a deployment based on a template+parameters'
	@echo '    _cfn_ls_project                   - List files/dirs in project directory'
	@echo '    _cfn_remove_project               - Remove project files and directory'
	@echo '    _cfn_show_template                - Show everything related to a template'
	@echo '    _cfn_show_template_content        - Show the content of a template'
	@echo '    _cfn_show_templates_set_content   - Show content of a templates-set'
	@echo '    _cfn_validate_template            - Validate the content of a template'
	@echo '    _cfn_validate_templates_set       - Validate the content of a template-set'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

__cfn_show_template_content:
	jq --color-output '.' $(CFN_TEMPLATE_FILEPATH) > /tmp/$(notdir $(CFN_TEMPLATE_FILEPATH)); less -r /tmp/$(notdir $(CFN_TEMPLATE_FILEPATH))

__cfn_show_template_content_info:
	@$(INFO) 'Showing content of local template ...'; $(NORMAL)

__cfn_estimate_cost_info:
	@$(INFO) '$(CFN_UI_LABEL)Estimating cost of deployment ...'; $(NORMAL)
	@$(WARN) 'Size of auto-scaling groups is set at their desired value'; $(NORMAL)
	@$(WARN) 'Nested templates are not included in the estimate'; $(NORMAL)

__cfn_estimate_cost:
	@$(WARN) 'Template: "$(notdir $(CFN_TEMPLATE_FILEPATH))"  '; $(NORMAL)
	$(AWS) cloudformation estimate-template-cost $(__CFN_PARAMETERS) $(__CFN_TEMPLATE_BODY) $(_X__CFN_TEMPLATE_URL)

__cfn_validate_template:
	@$(WARN) 'Template: "$(CFN_TEMPLATE_FILEPATH)"  '; $(NORMAL)
	$(AWS) cloudformation validate-template $(__CFN_TEMPLATE_BODY) --output json
	sleep 2

__cfn_validate_template_info:
	@$(INFO) '$(CFN_UI_LABEL)Validating template ...'; $(NORMAL)

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

#
# Single Template
#
_cfn_build_template:
	@$(INFO) '$(CMN_UI_LABEL)Building cloudformation template for prohject "$(CFN_PROJECT_NAME)" ...'; $(NORMAL)
	$(CLOUDFORMER) --build-templates

_cfn_estimate_cost: __cfn_estimate_cost_info __cfn_estimate_cost

_cfn_ls_project:
	@$(INFO) '$(CMN_UI_LABEL)List directories and files in project "$(CFN_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'PROJECT @ $(CFN_PROJECT_DIRPATH)'; $(NORMAL)
	-ls -laR $(CFN_PROJECT_DIRPATH)/

_cfn_remove_project:
	@$(INFO) '$(CMN_UI_LABEL)Removing files from directory of project "$(CFN_PROJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'PROJECT @ $(CFN_PROJECT_DIRPATH)'; $(NORMAL)
	rm -rf $(CFN_PROJECT_DIRPATH)/*
	ls -al $(CFN_PROJECT_DIRPATH)

_cfn_show_template: __cfn_show_template_content_info __cfn_show_template_content

_cfn_validate_template: __cfn_validate_template_info __cfn_validate_template

#
# Multi-Template = template-set 
#
_cfn_build_templates_set:
	@$(INFO) '$(CMN_UI_LABEL)Building templates-set "$(CFN_TEMPLATES_SET_NAME)" on local computer ...'; $(NORMAL)
	$(CLOUDFORMER) --build-templates

_cfn_show_templates_set_content:
	@$(INFO) '$(CMN_UI_LABEL)Showing content of templates-set "$(CFN_TEMPLATES_SET_NAME)" ...'; $(NORMAL)
	@$(foreach T, $(CFN_TEMPLATE_FILEPATHS), \
		$(MAKE) --no-print-directory CFN_TEMPLATE_FILEPATH=$(T) __cfn_show_template_content; \
	)

_cfn_validate_templates_set:
	@$(INFO) '$(CFN_UI_LABEL)Validating templates-set "$(CFN_TEMPLATES_SET_NAME)" ...'; $(NORMAL)
	@$(foreach T, $(CFN_TEMPLATE_FILEPATHS), \
		$(MAKE) --no-print-directory CFN_TEMPLATE_FILEPATH=$(T) __cfn_validate_template; \
	)
