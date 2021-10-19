_AWS_SERVICEDISCOVERY_INSTANCE_MK_VERSION= $(_AWS_SERVICEDISCOVERY_MK_VERSION)

# SDY_INSTANCE_ATTRIBUTES?= KeyName1=string,KeyName2=string
# SDY_INSTANCE_ID?= my-id
# SDY_INSTANCE_NAME?= my-instance
# SDY_INSTANCE_SERVICE_ID?=
# SDY_INSTANCE_REQUEST_ID?= 20191112_170011
# SDY_INSTANCES_SET_NAME?=

# Derived parameters
SDY_INSTANCE_ID?= $(SDY_INSTANCE_NAME)
SDY_INSTANCE_SERVICE_ID?= $(SDY_SERVICE_ID)
SDY_INSTANCES_SERVICE_ID?= $(SDY_INSTANCE_SERVICE_ID)
SDY_INSTANCES_SET_NAME?= $(SDY_SERVICE_NAME)

# Option parameters
__SDY_ATTRIBUTES= $(if $(SDY_INSTANCE_ATTRIBUTES),--attributes $(SDY_INSTANCE_ATTRIBUTES))
__SDY_CREATOR_REQUEST_ID__INSTANCE= $(if $(SDY_INSTANCE_REQUEST_ID),--creator-request-id $(SDY_INSTANCE_REQUEST_ID))
__SDY_INSTANCE_ID= $(if $(SDY_INSTANCE_ID),--instance-id $(SDY_INSTANCE_ID))
__SDY_INSTANCES__INSTANCE= $(if $(SDY_INSTANCE_ID),--instances $(SDY_INSTANCE_ID))
__SDY_SERVICE_ID__INSTANCE= $(if $(SDY_INSTANCE_SERVICE_ID),--service-id $(SDY_INSTANCE_SERVICE_ID))
__SDY_SERVICE_ID__INSTANCES= $(if $(SDY_INSTANCES_SERVICE_ID),--service-id $(SDY_INSTANCES_SERVICE_ID))

# UI parameters
SDY_UI_SHOW_INSTANCE_FIELDS?=
SDY_UI_VIEW_INSTANCES_FIELDS?= .{Id:Id,Values:join(' ',values(Attributes)),Keys:join(' ',keys(Attributes))}
SDY_UI_VIEW_INSTANCES_SET_FIELDS?= $(SDY_UI_VIEW_INSTANCES_FIELDS)
SDY_UI_VIEW_INSTANCES_SET_QUERYFILTER?=

#--- MACROS

_sdy_get_instance_arn= $(call _sdy_get_instance_arn_I, $(SDY_INSTANCE_ID))
_sdy_get_instance_arn_I= $(shell echo "arn:aws:instancediscovery:$(AWSS_REGION):$(AWS_ACCOUNT_ID):instance/$(strip $(1))")

_sdy_get_instance_id= $(call  _sdy_get_instance_id_N, $(SDY_INSTANCE_NAME))
_sdy_get_instance_id_N= $(shell $(AWS) instancediscovery list-instances --query "Services[?Name=='$(strip $(1))'].Id" --output text )

#--- Utilities

#----------------------------------------------------------------------
# USAGE
#

_sdy_view_framework_macros ::
	@echo 'AWS::ServiceDiscoverY::Instance ($(_AWS_SERVICEDISCOVERY_INSTANCE_MK_VERSION)) macros:'
	@echo '    _sdy_get_instance_arn_{|I}            - Get the ARN of a instance (Id)'
	@echo '    _sdy_get_instance_id_{|N}             - Get the ID of a instance (Name)'
	@echo

_sdy_view_framework_parameters ::
	@echo 'AWS::ServiceDiscoverY::Instance ($(_AWS_SERVICEDISCOVERY_INSTANCE_MK_VERSION)) parameters:'
	@echo '    SDY_INSTANCE_ATTRIBUTES=$(SDY_INSTANCE_ATTRIBUTES)'
	@echo '    SDY_INSTANCE_ID=$(SDY_INSTANCE_ID)'
	@echo '    SDY_INSTANCE_NAME=$(SDY_INSTANCE_NAME)'
	@echo '    SDY_INSTANCE_SERVICE_ID=$(SDY_INSTANCE_SERVICE_ID)'
	@echo '    SDY_INSTANCE_REQUEST_ID=$(SDY_INSTANCE_REQUEST_ID)'
	@echo '    SDY_INSTANCES_SET_NAME=$(SDY_INSTANCES_SET_NAME)'
	@echo

_sdy_view_framework_targets ::
	@echo 'AWS::ServiceDiscoverY::Instance ($(_AWS_SERVICEDISCOVERY_INSTANCE_MK_VERSION)) targets:'
	@echo '    _sdy_create_instance                  - Create a new instance'
	@echo '    _sdy_delete_instance                  - Delete an existing instance'
	@echo '    _sdy_show_instance                    - Show everything related to a instance'
	@echo '    _sdy_show_instance_description        - Show description of an instance'
	@echo '    _sdy_show_instance_healthstatus       - Show health-status of an instance'
	@echo '    _sdy_update_instance                  - Update an existing instance'
	@echo '    _sdy_view_instances                   - View instances'
	@echo '    _sdy_view_instances_set               - View a set of instances'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_sdy_create_instance:
	@$(INFO) '$(AWS_UI_LABEL)Creating instance "$(SDY_INSTANCE_NAME)" ...'; $(NORMAL)
	$(AWS) servicediscovery register-instance $(__SDY_ATTRIBUTES) $(__SDY_CREATOR_REQUEST_ID__INSTANCE) $(__SDY_INSTANCE_ID) $(__SDY_SERVICE_ID__INSTANCE)

_sdy_delete_instance:
	@$(INFO) '$(AWS_UI_LABEL)Deleting instance "$(SDY_INSTANCE_NAME)" ...'; $(NORMAL)
	$(AWS) servicediscovery deregister-instance $(__SDY_INSTANCE_ID) $(__SDY_SERVICE_ID__INSTANCE)

_sdy_show_instance: _sdy_show_instance_healthstatus _sdy_show_instance_description

_sdy_show_instance_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of instance "$(SDY_INSTANCE_NAME)"...'; $(NORMAL)
	@$(WARN) 'This operation fails if instance ID is NOT set'; $(NORMAL)
	-$(AWS) servicediscovery get-instance $(__SDY_INSTANCE_ID) $(__SDY_SERVICE_ID__INSTANCE) # --query "@.Service$(SDY_UI_SHOW_INSTANCE_FIELDS)"

_sdy_show_instance_healthstatus:
	@$(INFO) '$(AWS_UI_LABEL)Showing health-status of instance "$(SDY_INSTANCE_NAME)"...'; $(NORMAL)
	@$(WARN) 'This operation fails if instance ID is NOT set'; $(NORMAL)
	-$(AWS) servicediscovery get-instances-health-status $(__SDY_INSTANCES__INSTANCE) $(__SDY_SERVICE_ID__INSTANCE) # --query "@.Service$(SDY_UI_SHOW_INSTANCE_FIELDS)"

_sdy_update_instance:
	@$(INFO) '$(AWS_UI_LABEL)Updating instance "$(SDY_INSTANCE_NAME)" ...'; $(NORMAL)
	$(AWS) servicediscovery register-instance $(__SDY_ATTRIBUTES) $(__SDY_CREATOR_REQUEST_ID__INSTANCE) $(__SDY_INSTANCE_ID) $(__SDY_SERVICE_ID__INSTANCE)

_sdy_view_instances:
	@$(INFO) '$(AWS_UI_LABEL)Viewing instances ...'; $(NORMAL)
	$(AWS) servicediscovery list-instances $(__SDY_SERVICE_ID__INSTANCES) --query "Instances[]$(SDY_UI_VIEW_INSTANCES_FIELDS)"

_sdy_view_instances_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing instances-set "$(SDY_INSTANCES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Instance are grouped based on the provided service-id, and/or query-filter'; $(NORMAL)
	$(AWS) servicediscovery list-instances $(__SDY_SERVICE_ID__INSTANCES) $(_X__MAX_ITEMS__INSTANCES) --query "Instances[$(SDY_UI_VIEW_INSTANCES_SET_QUERYFILTER)]$(SDY_UI_VIEW_INSTANCES_SET_FIELDS)"
