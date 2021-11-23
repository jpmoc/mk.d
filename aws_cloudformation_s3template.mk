_AWS_CLOUDFORMATION_S3TEMPLATE_MK_VERSION= $(_AWS_CLOUDFORMATION_MK_VERSION)

# CFN_S3PROJECT_BUCKET_GRANTS?=
# CFN_S3PROJECT_BUCKET_NAME?= my-bucket
# CFN_S3PROJECT_BUCKET_URI?=
# CFN_S3PROJECT_BUCKET_URL?=
# CFN_S3PROJECT_FOLDER_NAME=
# CFN_S3PROJECT_FOLDER_URI=
# CFN_S3PROJECT_GRANTS_FULL= full=emailaddress=aws.$(AWS_ACCOUNT_ID)@menlosecurity.com
# CFN_S3PROJECT_GRANTS_READ= read=uri=http://acs.amazonaws.com/groups/global/AllUsers
# CFN_S3PROJECT_GRANTS_WRITE=
CFN_S3ROOT_FOLDER?= cfn.d
# CFN_S3TEMPLATE_FOLDER_NAME=
# CFN_S3TEMPLATE_FOLDER_URI=
# CFN_S3TEMPLATE_KEY=
# CFN_S3TEMPLATE_KEYS=
# CFN_S3TEMPLATE_URI=
# CFN_S3TEMPLATE_URL=

# Derived parameters
CFN_S3PROJECT_BUCKET_GRANTS?= $(strip $(CFN_S3PROJECT_BUCKET_GRANTS_READ) $(CFN_S3PROJECT_BUCKET_GRANTS_WRITE) $(CFN_S3PROJECT_BUCKET_GRANTS_FULL))
CFN_S3PROJECT_BUCKET_URI?= $(if $(CFN_S3PROJECT_BUCKET_NAME),s3://$(CFN_S3PROJECT_BUCKET_NAME))
CFN_S3PROJECT_BUCKET_URL?= $(if $(CFN_S3PROJECT_BUCKET_NAME),https://s3.amazonaws.com/$(CFN_S3PROJECT_BUCKET_NAME))
CFN_S3PROJECT_FOLDER_NAME?= $(subst $(SPACE),/,$(strip $(CFN_S3ROOT_FOLDER) $(CFN_STACK_NAME)))
CFN_S3PROJECT_FOLDER_URI?= $(CFN_S3PROJECT_BUCKET_URI)/$(CFN_S3PROJECT_FOLDER_NAME)
CFN_S3TEMPLATE_FOLDER_NAME?= $(CFN_S3PROJECT_FOLDER_NAME)
CFN_S3TEMPLATE_FOLDER_URI?= $(CFN_S3PROJECT_BUCKET_URI)/$(CFN_S3TEMPLATE_FOLDER_NAME)
CFN_S3TEMPLATE_KEY?= $(addprefix $(CFN_S3TEMPLATE_FOLDER_NAME)/, $(notdir $(CFN_TEMPLATE_FILEPATH)))
CFN_S3TEMPLATE_KEYS= $(addprefix $(CFN_S3TEMPLATE_FOLDER_NAME)/, $(notdir $(CFN_TEMPLATE_FILEPATHS)))
CFN_S3TEMPLATE_URI?= $(CFN_S3PROJECT_BUCKET_URI)/$(CFN_S3TEMPLATE_KEY)
CFN_S3TEMPLATE_URL?= $(if $(CFN_S3TEMPLATE_KEY),$(CFN_S3PROJECT_BUCKET_URL)/$(CFN_S3TEMPLATE_KEY))

# Options
__CFN_GRANTS= $(if $(CFN_S3PROJECT_BUCKET_GRANTS), --grants $(CFN_S3PROJECT_BUCKET_GRANTS))
__CFN_TEMPLATE_URL= $(if $(CFN_S3TEMPLATE_URL), --template-url $(CFN_S3TEMPLATE_URL))

# Customizations

# Macros

#----------------------------------------------------------------------
# USAGE
#

_cfn_list_macros ::
	@#echo 'AWS::CloudFormatioN::S3Template ($(_AWS_CLOUDFORMATION_S3TEMPLATE_MK_VERSION)) macros:'
	@#echo

_cfn_list_parameters ::
	@echo 'AWS::CloudFormatioN::S3Template ($(_AWS_CLOUDFORMATION_S3TEMPLATE_MK_VERSION)) parameters:'
	@echo '    CFN_S3PROJECT_BUCKET_GRANTS=$(CFN_S3PROJECT_BUCKET_GRANTS)'
	@echo '    CFN_S3PROJECT_BUCKET_NAME=$(CFN_S3PROJECT_BUCKET_NAME)'
	@echo '    CFN_S3PROJECT_BUCKET_URI=$(CFN_S3PROJECT_BUCKET_URI)'
	@echo '    CFN_S3PROJECT_BUCKET_URL=$(CFN_S3PROJECT_BUCKET_URL)'
	@echo '    CFN_S3PROJECT_FOLDER_NAME=$(CFN_S3PROJECT_FOLDER_NAME)'
	@echo '    CFN_S3PROJECT_FOLDER_URI=$(CFN_S3PROJECT_FOLDER_URI)'
	@echo '    CFN_S3PROJECT_GRANTS_FULL=$(CFN_S3PROJECT_GRANTS_FULL)'
	@echo '    CFN_S3PROJECT_GRANTS_READ=$(CFN_S3PROJECT_GRANTS_READ)'
	@echo '    CFN_S3PROJECT_GRANTS_WRITE=$(CFN_S3PROJECT_GRANTS_WRITE)'
	@echo '    CFN_S3ROOT_FOLDER=$(CFN_S3ROOT_FOLDER)'
	@echo '    CFN_S3TEMPLATE_FOLDER_NAME=$(CFN_S3TEMPLATE_FOLDER_NAME)'
	@echo '    CFN_S3TEMPLATE_FOLDER_URI=$(CFN_S3TEMPLATE_FOLDER_URI)'
	@echo '    CFN_S3TEMPLATE_KEY=$(CFN_S3TEMPLATE_KEY)'
	@echo '    CFN_S3TEMPLATE_KEYS=$(CFN_S3TEMPLATE_KEYS)'
	@echo '    CFN_S3TEMPLATE_URI=$(CFN_S3TEMPLATE_URI)'
	@echo '    CFN_S3TEMPLATE_URL=$(CFN_S3TEMPLATE_URL)'
	@echo

_cfn_list_targets ::
	@echo 'AWS::CloudFormatioN::S3Template ($(_AWS_CLOUDFORMATION_S3TEMPLATE_MK_VERSION)) targets:'
	@echo '    _cfn_estimate_s3cost                - Estimate cost of project'
	@echo '    _cfn_ls_s3project                   - List objects in the project folder on S3'
	@echo '    _cfn_remove_s3project               - Remove content of the project folder on S3'
	@echo '    _cfn_sync_s3project                 - Sync the project folder on S3'
	@echo '    _cfn_validate_s3template            - Validate a template in the project folder on S3'
	@echo '    _cfn_validate_s3templates_set       - Validate a template-set in the project folder on S3'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

__cfn_estimate_s3cost_info:
	@$(INFO) '$(CFN_UI_LABEL)Estimating cost of deployment ...'; $(NORMAL)
	@$(WARN) 'Size of auto-scaling groups is set at their desired value'; $(NORMAL)
	@$(WARN) 'Nested templates are not included in the estimate'; $(NORMAL)

__cfn_estimate_s3cost:
	@$(WARN) 'Template: "$(notdir $(CFN_TEMPLATE_FILEPATH))"  '; $(NORMAL)
	$(AWS) cloudformation estimate-template-cost $(__CFN_PARAMETERS) $(_X__CFN_TEMPLATE_BODY) $(__CFN_TEMPLATE_URL)

__cfn_validate_s3template:
	@$(WARN) 'S3 Template @ $(CFN_S3TEMPLATE_URI)'; $(NORMAL)
	$(AWS) cloudformation validate-template $(_X__CFN_TEMPLATE_BODY) $(__CFN_TEMPLATE_URL) --output json

__cfn_validate_s3template_info:
	@$(INFO) '$(CFN_UI_LABEL)Validating template on S3...'; $(NORMAL)

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cfn_estimate_s3cost: __cfn_estimate_s3cost_info __cfn_estimate_s3cost

_cfn_ls_s3project:
	@$(INFO) '$(CFN_UI_LABEL)Listing project folder on S3 ...'; $(NORMAL)
	@$(WARN) 'S3PROJECT @ $(CFN_S3PROJECT_FOLDER_URI)'; $(NORMAL)
	@# $(AWS_S3) ls $(CFN_S3PROJECT_FOLDER_URI)/      # S3_REGION
	$(AWS) s3 ls $(CFN_S3PROJECT_FOLDER_URI)/

_cfn_sync_s3project:
	@$(INFO) '$(CFN_UI_LABEL)Sync-ing project directory with project folder in S3 bucket "$(CFN_S3PROJECT_BUCKET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Project DIR: $(CFN_PROJECT_DIRPATH)'; $(NORMAL)
	@$(WARN) 'Project FOLDER: $(CFN_S3PROJECT_FOLDER_URI)'; $(NORMAL)
	$(AWS) s3 cp --recursive $(CFN_PROJECT_DIRPATH)/ $(CFN_S3PROJECT_FOLDER_URI)/  $(__CFN_GRANTS)

_cfn_remove_s3project:
	@$(INFO) '$(CFN_UI_LABEL)Removing project folder in S3 bucket "$(CFN_S3PROJECT_BUCKET_NAME)" ...'; $(NORMAL)
	@#$(AWS_S3) ls $(CFN_S3PROJECT_BUCKET_URI)/
	@#-$(AWS_S3) ls $(CFN_S3PROJECT_FOLDER_URI)
	@#-$(AWS_S3) ls $(CFN_S3PROJECT_FOLDER_URI)/
	@#-$(AWS_S3) rm --recursive $(CFN_S3PROJECT_FOLDER_URI)
	@#-$(AWS_S3) ls $(CFN_S3PROJECT_FOLDER_URI)/
	@#$(AWS_S3) ls $(CFN_S3PROJECT_BUCKET_URI)/       # BUCKET_LOCATION?
	-$(AWS) s3 ls $(CFN_S3PROJECT_FOLDER_URI)
	-$(AWS) s3 ls $(CFN_S3PROJECT_FOLDER_URI)/
	-$(AWS) s3 rm --recursive $(CFN_S3PROJECT_FOLDER_URI)
	-$(AWS) s3 ls $(CFN_S3PROJECT_FOLDER_URI)/
	@$(WARN) 'The above error confirms that the folder was removed correctly!'; $(NORMAL)

_cfn_remove_s3templates:
	@$(INFO) '$(CFN_UI_LABEL)Removing template folder in S3 bucket "$(CFN_S3PROJECT_BUCKET_NAME)" ...'; $(NORMAL)
	@#$(AWS_S3) ls $(CFN_S3TEMPLATE_BUCKET_URI)/
	@#-$(AWS_S3) ls $(CFN_S3TEMPLATE_FOLDER_URI)
	@#-$(AWS_S3) ls $(CFN_S3TEMPLATE_FOLDER_URI)/
	@#-$(AWS_S3) rm --recursive $(CFN_S3TEMPLATE_FOLDER_URI)
	@#-$(AWS_S3) ls $(CFN_S3TEMPLATE_FOLDER_URI)/       # use --region=BUCKET_LOCATION ?
	$(AWS) s3 ls $(CFN_S3TEMPLATE_BUCKET_URI)/
	-$(AWS) s3 ls $(CFN_S3TEMPLATE_FOLDER_URI)
	-$(AWS) s3 ls $(CFN_S3TEMPLATE_FOLDER_URI)/
	-$(AWS) s3 rm --recursive $(CFN_S3TEMPLATE_FOLDER_URI)
	-$(AWS) s3 ls $(CFN_S3TEMPLATE_FOLDER_URI)/
	@$(WARN) 'The above error confirms that the folder was removed correctly!'; $(NORMAL)

_cfn_validate_s3template: _cfn_validate_s3template_info __cfn_validate_s3template

_cfn_validate_s3templates_set:
	@$(INFO) '$(CFN_UI_LABEL)Validating templates in S3 "$(CFN_S3PROJECT_BUCKET_NAME)" ...'; $(NORMAL)
	@$(foreach K, $(CFN_S3TEMPLATE_KEYS), \
		$(MAKE) --no-print-directory CFN_S3TEMPLATE_KEY=$(K) __cfn_validate_s3template; \
	)
