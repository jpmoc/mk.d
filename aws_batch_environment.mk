_AWS_BATCH_ENVIRONMENT_MK_VERSION=$(_AWS_BATCH_MK_VERSION)

# BCH_ENVIRONMENT_NAME?= my-compute-environment
# BCH_ENVIRONMENT_RESOURCES_FILEPATH?= ./my-environment-resources.json
# BCH_ENVIRONMENT_RESOURCES?= type=string,minvCpus=integer,maxvCpus=integer,desiredvCpus=integer,instanceTypes=string,string,imageId=string,subnets=string,string,securityGroupIds=string,string,ec2KeyPair=string,instanceRole=string,tags={KeyName1=string,KeyName2=string},bidPercentage=integer,spotIamFleetRole=string
# BCH_ENVIRONMENT_SERVICE_ROLE?= arn:aws:iam::012345678910:role/AWSBatchServiceRole
# BCH_ENVIRONMENT_ENABLED?= true
# BCH_ENVIRONMENT_TYPE?= MANAGED
# BCH_ENVIRONMENTSET_NAME?= my-compute-environmentset

# Derived variables
BCH_ENVIRONMENT_NAMES?= $(BCH_ENVIRONMENT_NAME)
BCH_ENVIRONMENT_RESOURCES?= $(if $(BCH_ENVIRONMENT_RESOURCES_FILEPATH), file://$(BCH_ENVIRONMENT_RESOURCES_FILEPATH))
BCH_ENVIRONMENT_SERVICE_ROLE?= arn:aws:iam::$(AWS_ACCOUNT_ID):role/AWSBatchServiceRole

# Options variables
__BCH_COMPUTE_ENVIRONMENT= $(if $(BCH_ENVIRONMENT_NAME), --compute-environment $(BCH_ENVIRONMENT_NAME))
__BCH_COMPUTE_ENVIRONMENT_NAME= $(if $(BCH_ENVIRONMENT_NAME), --compute-environment $(BCH_ENVIRONMENT_NAME))
__BCH_COMPUTE_ENVIRONMENT_ORDER= $(if $(BCH_QUEUE_COMPUTE_ENVIRONMENT_ORDER), --compute-environment-order $(BCH_QUEUE_COMPUTE_ENVIRONMENT_ORDER))
__BCH_COMPUTE_ENVIRONMENTS= $(if $(BCH_ENVIRONMENT_NAMES), --compute-environments $(BCH_ENVIRONMENT_NAMES))
__BCH_COMPUTE_RESOURCES= $(if $(BCH_ENVIRONMENT_RESOURCES), --compute-resources $(BCH_ENVIRONMENT_RESOURCES))
__BCH_SERVICE_ROLE= $(if $(BCH_ENVIRONMENT_SERVICE_ROLE), --service-role $(BCH_ENVIRONMENT_SERVICE_ROLE))
__BCH_STATE_ENVIRONMENT= $(if $(filter false, $(BCH_ENVIRONMENT_ENABLED)), --state DISABLED, --state ENABLED)
__BCH_TYPE= $(if $(BCH_ENVIRONMENT_TYPE), --type $(BCH_ENVIRONMENT_TYPE))

# UI variables
BCH_UI_SHOW_ENVIRONMENTSET_FIELDS?= $(BCH_UI_VIEW_ENVIRONMENTS_FIELDS)
BCH_UI_VIEW_ENVIRONMENTS_FIELDS?= .{status:status,state:state,ComputeEnvironmentName:computeEnvironmentName,type:type,ecsClusterArn:ecsClusterArn}

#--- Utilities

#--- MACRO
_bch_get_environment_status= $(call _bch_get_environment_status_N, $(BCH_ENVIRONMENT_NAME))
_bch_get_environment_status_N= $(shell $(AWS) batch describe-compute-environments --query "computeEnvironments[?computeEnvironmentName=='$(strip $(1))'].status" --output text)

#----------------------------------------------------------------------
# USAGE
#

_bch_view_makefile_macros ::  
	@echo "AWS::BatCH::Environment ($(_AWS_BATCH_ENVIRONMENT_MK_VERSION)) macros:"
	@echo "    _bch_get_environment_status_{|N}    - Get the status of an environment (Name)"
	@echo

_bch_view_makefile_targets ::
	@echo "AWS::BatCH::Environment ($(_AWS_BATCH_ENVIRONMENT_MK_VERSION)) targets:"
	@echo "    _bch_create_environment             - Create a compute environment"
	@echo "    _bch_delete_environment             - Delete an existing compute environment"
	@echo "    _bch_disable_environment            - Disable an existing compute environment"
	@echo "    _bch_enable_environment             - Enable an existing compute environment"
	@echo "    _bch_show_environment               - Show details of a compute environment"
	@echo "    _bch_show_environmentset            - Show summary of a compute environment set"
	@echo "    _bch_view_environment               - View available environments"
	@echo

_bch_view_makefile_variables ::
	@echo "AWS::BatCH::Environment ($(_AWS_BATCH_ENVIRONMENT_MK_VERSION)) variables:"
	@echo "    BCH_ENVIRONMENT_ENABLED=$(BCH_ENVIRONMENT_ENABLED)"
	@echo "    BCH_ENVIRONMENT_NAME=$(BCH_ENVIRONMENT_NAME)"
	@echo "    BCH_ENVIRONMENT_RESOURCES=$(BCH_ENVIRONMENT_RESOURCES)"
	@echo "    BCH_ENVIRONMENT_RESOURCES_FILEPATH=$(BCH_ENVIRONMENT_RESOURCES_FILEPATH)"
	@echo "    BCH_ENVIRONMENT_TYPE=$(BCH_ENVIRONMENT_TYPE)"
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_bch_create_environment:
	@$(INFO) "$(AWS_LABEL)Creating a new compute environment '$(BCH_ENVIRONMENT_NAME)' ..."; $(NORMAL)
	$(if $(BCH_ENVIRONMENT_RESOURCES_FILEPATH), cat $(BCH_ENVIRONMENT_RESOURCES_FILEPATH))
	$(AWS) batch create-compute-environment $(__BCH_COMPUTE_ENVIRONMENT_NAME) $(__BCH_COMPUTE_RESOURCES) $(__BCH_SERVICE_ROLE) $(__BCH_STATE_ENVIRONMENT) $(__BCH_TYPE)

_bch_delete_environment:
	@$(INFO) "$(AWS_LABEL)Creating compute environment '$(BCH_ENVIRONMENT_NAME)' ..."; $(NORMAL)
	@$(WARN) "The compute environment must first be disabled!"; $(NORMAL)
	$(AWS) batch delete-compute-environment $(__BCH_COMPUTE_ENVIRONMENT) 

_bch_disable_environment:
	@$(INFO) "$(AWS_LABEL)Disabling compute environment '$(BCH_ENVIRONMENT_NAME)' ..."; $(NORMAL)
	$(AWS) batch update-compute-environment $(__BCH_COMPUTE_ENVIRONMENT) --state DISABLED

_bch_enable_environment:
	@$(INFO) "$(AWS_LABEL)Enabling compute environment '$(BCH_ENVIRONMENT_NAME)' ..."; $(NORMAL)
	$(AWS) batch update-compute-environment $(__BCH_COMPUTE_ENVIRONMENT) --state ENABLED

_bch_show_environment:
	@$(INFO) "$(AWS_LABEL)Showing compute environment '$(BCH_ENVIRONMENT_NAME)' ..."; $(NORMAL)
	$(AWS) batch describe-compute-environments --query "computeEnvironments[?computeEnvironmentName=='$(BCH_ENVIRONMENT_NAME)']"

_bch_show_environmentset:
	@$(INFO) "$(AWS_LABEL)Showing compute environment set '$(BCH_ENVIRONMENTSET_NAME)' ..."; $(NORMAL)
	$(AWS) batch describe-compute-environments $(__BCH_COMPUTE_ENVIRONMENTS) --query "computeEnvironments[]$(BCH_UI_SHOW_ENVIRONMENTSET_FIELDS)"

_bch_view_environments:
	@$(INFO) "$(AWS_LABEL)Viewing ALL available compute environments ..."; $(NORMAL)
	$(AWS) batch describe-compute-environments $(_X__BCH_COMPUTE_ENVIRONMENTS) --query "computeEnvironments[]$(BCH_UI_VIEW_ENVIRONMENTS_FIELDS)"
