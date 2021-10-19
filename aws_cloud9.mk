_AWS_CLOUD9_MK_VERSION=0.99.6

# CL9_CLIENT_REQUEST_TOKEN?=
# CL9_ENVIRONMENT_ARN?= arn:aws:cloud9:us-west-2:123456789012:environment:3e70a8cd206e4e018739c00a7fbf3cf5
# CL9_ENVIRONMENT_DESCRIPTION?= "My demonstration development environment."
# CL9_ENVIRONMENT_ID?= 685f892f431b45c2b28cb69eadcdb0EX
# CL9_ENVIRONMENT_NAME?= myDemoEnvvironment
# CL9_ENVIRONMENT_OWNER?= emayssat
CL9_INSTANCE_SUBNET_ID?= $(EC2_SUBNET_ID)
CL9_INSTANCE_TIMEOUT?= 60
CL9_INSTANCE_TYPE?= t2.micro
# CL9_MEMBERSHIP_PERMISSIONS?= owner
# CL9_MEMBERSHIP_USER?= aduston

CL9_ENVIRONMENT_IDS?= $(strip $(if $(CL9_ENVIRONMENT_ID), $(CL9_ENVIRONMENT_ID)))
CL9_ENVIRONMENT_OWNER_ARN?= $(if $(CL9_ENVIRONMENT_OWNER), arn:aws:iam::$(AWS_ACCOUNT_ID):user/$(CL9_ENVIRONMENT_OWNER))
CL9_ENVIRONMENT_URL?= $(strip $(if $(CL9_ENVIRONMENT_ID), https://$(AWS_REGION).console.aws.amazon.com/cloud9/ide/$(CL9_ENVIRONMENT_ID)))
CL9_MEMBERSHIP_USER_ARN?= $(if $(CL9_MEMBERSHIP_USER), arn:aws:iam::$(AWS_ACCOUNT_ID):user/$(CL9_MEMBERSHIP_USER))

__CL9_AUTOMATIC_STOP_TIME_MINUTES= $(if $(CL9_INSTANCE_TIMEOUT), --automatic-stop-time-minutes $(CL9_INSTANCE_TIMEOUT))
__CL9_CLIENT_REQUEST_TOKEN= $(if $(CL9_CLIENT_REQUEST_TOKEN), --client-request-token $(CL9_CLIENT_REQUEST_TOKEN))
__CL9_DESCRIPTION= $(if $(CL9_ENVIRONMENT_DESCRIPTION), --description $(CL9_ENVIRONMENT_DESCRIPTION))
__CL9_ENVIRONMENT_ID= $(if $(CL9_ENVIRONMENT_ID), --environment-id $(CL9_ENVIRONMENT_ID))
__CL9_ENVIRONMENT_IDS= $(if $(CL9_ENVIRONMENT_IDS), --environment-ids $(CL9_ENVIRONMENT_IDS))
__CL9_INSTANCE_TYPE= $(if $(CL9_INSTANCE_TYPE), --instance-type $(CL9_INSTANCE_TYPE))
__CL9_SUBNET_ID= $(if $(CL9_INSTANCE_SUBNET_ID), --subnet-id $(CL9_INSTANCE_SUBNET_ID))
__CL9_NAME= $(if $(CL9_ENVIRONMENT_NAME), --name $(CL9_ENVIRONMENT_NAME))
__CL9_OWNER_ARN= $(if $(CL9_ENVIRONMENT_OWNER_ARN), --owner-arn $(CL9_ENVIRONMENT_OWNER_ARN))
__CL9_PERMISSIONS= $(if $(CL9_MEMBERSHIP_PERMISSIONS), --permissions $(CL9_MEMBERSHIP_PERMISSIONS))
__CL9_USER_ARN= $(if $(CL9_MEMBERSHIP_USER_ARN), --user-arn $(CL9_MEMBERSHIP_USER_ARN))

#--- MACROS
_cl9_get_environment_ids=$(shell $(AWS) cloud9 list-environments --query "environmentIds" --output text)
_cl9_get_environment_id_I=$(word $(1), $(call _cl9_get_environment_ids))

#----------------------------------------------------------------------
# USAGE
#

_aws_view_makefile_macros :: _cl9_view_makefile_macros
_cl9_view_makefile_macros:
	@echo "AWS::Cloud9 ($(_AWS_CLOUD9_MK_VERSION)) macros:"
	@echo "    _cl9_get_environment_ids            - Retuns all the environment IDs in that region"
	@echo "    _cl9_get_environment_id_I           - Get a specific environment ID"
	@echo

_aws_view_makefile_targets :: _cl9_view_makefile_targets
_cl9_view_makefile_targets:
	@echo "AWS::Cloud9 ($(_AWS_CLOUD9_MK_VERSION)) targets:"
	@echo "    _cl9_create_environment             - Create a Cloud9 environment"
	@echo "    _cl9_create_membership              - Create a Cloud9 membership"
	@echo "    _cl9_delete_environment             - Delete a Cloud9 environment"
	@echo "    _cl9_delete_membership              - Delete a Cloud9 membership"
	@echo "    _cl9_show_status                    - Display status of given environment"
	@echo "    _cl9_list_environments              - List existing environments"
	@echo "    _cl9_update_environment             - Update existing environments"
	@echo "    _cl9_view_environments              - View existing environments"
	@echo "    _cl9_view_memberships               - View existing memberships"
	@echo 

_aws_view_makefile_variables :: _cl9_view_makefile_variables
_cl9_view_makefile_variables:
	@echo "AWS::Cloud9 ($(_AWS_CLOUD9_MK_VERSION)) variables:"
	@echo "    CL9_ENVIRONMENT_DESCRIPTION=$(CL9_ENVIRONMENT_DESCRIPTION)"
	@echo "    CL9_ENVIRONMENT_ID=$(CL9_ENVIRONMENT_ID)"
	@echo "    CL9_ENVIRONMENT_IDS=$(CL9_ENVIRONMENT_IDS)"
	@echo "    CL9_ENVIRONMENT_NAME=$(CL9_ENVIRONMENT_NAME)"
	@echo "    CL9_ENVIRONMENT_OWNER=$(CL9_ENVIRONMENT_OWNER)"
	@echo "    CL9_ENVIRONMENT_OWNER_ARN=$(CL9_ENVIRONMENT_OWNER_ARN)"
	@echo "    CL9_ENVIRONMENT_URL=$(CL9_ENVIRONMENT_URL)"
	@echo "    CL9_INSTANCE_SUBNET_ID=$(CL9_INSTANCE_SUBNET_ID)"
	@echo "    CL9_INSTANCE_TIMEOUT=$(CL9_INSTANCE_TIMEOUT)"
	@echo "    CL9_INSTANCE_TYPE=$(CL9_INSTANCE_TYPE)"
	@echo "    CL9_MEMBERSHIP_PERMISSIONS=$(CL9_MEMBERSHIP_PERMISSIONS)"
	@echo "    CL9_MEMBERSHIP_USER=$(CL9_MEMBERSHIP_USER)"
	@echo "    CL9_MEMBERSHIP_USER_ARN=$(CL9_MEMBERSHIP_USER_ARN)"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cl9_create_environment:
	@$(INFO) "$(AWS_LABEL)Creating environment '$(CL9_ENVIRONMENT_NAME)' ..."; $(NORMAL)
	$(AWS) cloud9 create-environment-ec2 $(__CL9_AUTOMATIC_STOP_TIME_MINUTES) $(__CL9_CLIENT_REQUEST_TOKEN) $(__CL9_DESCRIPTION) $(__CL9_INSTANCE_TYPE) $(__CL9_NAME) $(__CL9_OWNER_ARN) $(__CL9_SUBNET_ID) 

_cl9_create_membership:
	@$(INFO) "$(AWS_LABEL)Creating membership for user '$(CL9_MEMBERSHIP_USER)' ..."; $(NORMAL)
	$(AWS) cloud9 create-environment-membership $(__CL9_ENVIRONMENT_ID) $(__CL9_PERMISSIONS) $(__CL9_USER_ARN) 

_cl9_delete_environment:
	@$(INFO) "$(AWS_LABEL)Deleting environment '$(CL9_ENVIRONMENT_ID)' ..."; $(NORMAL)
	@$(WARN) "Environment Name: '$(CL9_ENVIRONMENT_NAME)' "; $(NORMAL)
	$(AWS) cloud9 delete-environment $(__CL9_ENVIRONMENT_ID) 

_cl9_delete_membership:
	@$(INFO) "$(AWS_LABEL)Deleting membership for user '$(CL9_MEMBERSHIP_USER)' ..."; $(NORMAL)
	@$(WARN) "Environment Name: '$(CL9_ENVIRONMENT_NAME)' "; $(NORMAL)
	$(AWS) cloud9 delete-environment-membership $(__CL9_ENVIRONMENT_ID) $(__CL9_USER_ARN)

_cl9_list_environments:
	@$(INFO) "$(AWS_LABEL)Listing environments ..."; $(NORMAL)
	$(AWS) cloud9 list-environments

_cl9_open_ide:
	@$(INFO) "$(AWS_LABEL)Opening IDE for environment '$(CL9_ENVIRONMENT_ID)' ..."; $(NORMAL)
	$(BROWSER) $(CL9_ENVIRONMENT_URL)

_cl9_show_membership:
	@$(INFO) "$(AWS_LABEL)Showing membership ..."; $(NORMAL)
	@$(WARN) "Environment ID: $(CL9_ENVIRONMENT_ID)"; $(NORMAL)
	@$(WARN) "Permissions: $(CL9_MEMBERSHIP_PERMISSIONS)"; $(NORMAL)
	@$(WARN) "User: $(CL9_MEMBERSHIP_USER)"; $(NORMAL)
	$(AWS) cloud9 describe-environment-memberships $(__CL9_ENVIRONMENT_ID) $(__CL9_PERMISSIONS) $(__CL9_USER_ARN)

_cl9_show_status:
	@$(INFO) "$(AWS_LABEL)Showing status of environment '$(CL9_ENVIRONMENT_ID)' ..."; $(NORMAL)
	@$(WARN) "Environment URL: $(CL9_ENVIRONMENT_URL)"; $(NORMAL)
	$(if $(CL9_ENVIRONMENT_ID), \
		$(AWS) cloud9 describe-environment-status $(__CL9_ENVIRONMENT_ID), \
		@$(WARN) "No environment ID provided!"; $(NORMAL) \
	)

_cl9_update_environment:
	@$(INFO) "$(AWS_LABEL)Updating environment '$(CL9_ENVIRONMENT_ID)' ..."; $(NORMAL)
	@$(WARN) "Environment URL: $(CL9_ENVIRONMENT_URL)"; $(NORMAL)
	$(AWS) cloud9 update-environment $(__CL9_ENVIRONMENT_DESCRIPTION) $(__CL9_ENVIRONMENT_ID)  $(__CL9_NAME)

_cl9_update_membership:
	@$(INFO) "$(AWS_LABEL)Updating membership for user '$(CL9_MEMBERSHIP_USER)' ..."; $(NORMAL)
	@$(WARN) "Environment URL: $(CL9_ENVIRONMENT_URL)"; $(NORMAL)
	$(AWS) cloud9 update-environment-membership $(__CL9_ENVIRONMENT_ID) $(__CL9_PERMISSIONS) $(__CL9_USER_ARN)

_cl9_view_environments:
	@$(INFO) "$(AWS_LABEL)View environments ..."; $(NORMAL)
	$(if $(CL9_ENVIRONMENT_IDS), \
		$(AWS) cloud9 describe-environments $(__CL9_ENVIRONMENT_IDS), \
		@$(WARN) "No environment IDs found or provided!"; $(NORMAL) \
	)

_cl9_view_memberships:
	@$(INFO) "$(AWS_LABEL)View memberships ..."; $(NORMAL)
	@$(WARN) "The credentials in use are those of the owner"; $(NORMAL)
	$(AWS) cloud9 describe-environment-memberships $(__CL9_ENVIRONMENT_ID) $(__CL9_PERMISSIONS) $(__CL9_USER_ARN)
