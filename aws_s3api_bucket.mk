_AWS_S3API_BUCKET_MK_VERSION=$(_AWS_S3API_MK_VERSION)

# S3I_BUCKET_ACL_FILETYPE?= private
# S3I_BUCKET_ANALYTICS_CONFIGURATION_ID?=
# S3I_BUCKET_CANNEDACL_TYPE?= private
# S3I_BUCKET_DIRPATH?= ./in/my-bucket/
# S3I_BUCKET_GRANT_FULLCONTROL?=
# S3I_BUCKET_GRANT_READ?=
# S3I_BUCKET_GRANT_READACP?= URI=http://acs.amazonaws.com/groups/s3/LogDelivery
# S3I_BUCKET_GRANT_WRITE?= URI=http://acs.amazonaws.com/groups/s3/LogDelivery
# S3I_BUCKET_GRANT_WRITEACL?=
# S3I_BUCKET_INVENTORY_CONFIGURATION_ID?=
# S3I_BUCKET_LIFECYCLE?='{ "Rules": [{ "Status": "Enabled", "ID": "Delete all objects after 1 day", "Prefix": "", "Expiration": { "Days": 1 } }]}'
# S3I_BUCKET_LIFECYCLE_FILENAME?= bucket-lifecycle.json
# S3I_BUCKET_LIFECYCLE_FILEPATH?= ./in/bucket-lifecycle.json
# S3I_BUCKET_LOCATION_CONSTRAINT?= us-east-1 
# S3I_BUCKET_LOGGING?= file://./in/bucket-logging.json
# S3I_BUCKET_LOGGING_FILENAME?= bucket-logging.json
# S3I_BUCKET_LOGGING_FILEPATH?= ./in/bucket-logging.json
# S3I_BUCKET_METRICS_CONFIGURATION_ID?=
# S3I_BUCKET_NAME?= mybucket
# S3I_BUCKET_POLICY?=
# S3I_BUCKET_POLICY_FILENAME?= bucket-policy.json
# S3I_BUCKET_POLICY_FILEPATH?= ./in/bucket-policy.json
# S3I_BUCKET_WEBSITE?=
# S3I_BUCKET_WEBSITE_FILENAME?= website-configuration.json
# S3I_BUCKET_WEBSITE_FILEPATH?= ./in/website-configuration.json
# S3I_BUCKET_WEBSITE_URL?= http://123456789012-coursera-serverless.s3-website-us-east-1.amazonaws.com
# S3I_BUCKETS_SET_NAME?= my-buckets-set

# Derived parameters
# If the API calls go to 'us-east-1' then NO location constraint should be specified!
S3I_BUCKET_CONFIGURATION?= $(if $(filter-out us-east-1, $(S3I_BUCKET_LOCATION_CONSTRAINT)),LocationConstraint=$(S3I_BUCKET_LOCATION_CONSTRAINT))
S3I_BUCKET_LIFECYCLE?= $(if $(S3I_BUCKET_LIFECYCLE_FILEPATH),file://$(S3I_BUCKET_LIFECYCLE_FILEPATH))
S3I_BUCKET_LIFECYCLE_FILEPATH?= $(if $(S3I_BUCKET_LIFECYCLE_FILENAME),$(S3I_BUCKET_DIRPATH)$(S3I_BUCKET_LIFECYCLE_FILENAME))
S3I_BUCKET_LOGGING?= $(if $(S3I_BUCKET_LOGGING_FILEPATH),file://$(S3I_BUCKET_LOGGING_FILEPATH))
S3I_BUCKET_LOGGING_FILEPATH?= $(if $(S3I_BUCKET_LOGGING_FILENAME),$(S3I_BUCKET_DIRPATH)$(S3I_BUCKET_LOGGING_FILENAME))
S3I_BUCKET_LOCATION_CONSTRAINT?= $(AWS_REGION_ID)
S3I_BUCKET_POLICY?= $(if $(S3I_BUCKET_POLICY_FILEPATH),file://$(S3I_BUCKET_POLICY_FILEPATH))
S3I_BUCKET_POLICY_FILEPATH?= $(if $(S3I_BUCKET_POLICY_FILENAME),$(S3I_BUCKET_DIRPATH)$(S3I_BUCKET_POLICY_FILENAME))
S3I_BUCKET_WEBSITE?= $(if $(S3I_BUCKET_WEBSITE_FILEPATH),file://$(S3I_BUCKET_WEBSITE_FILEPATH))
S3I_BUCKET_WEBSITE_FILEPATH?= $(if $(S3I_BUCKET_WEBSITE_FILENAME),$(S3I_BUCKET_DIRPATH)$(S3I_BUCKET_WEBSITE_FILENAME))
S3I_BUCKET_WEBSITE_URL?= $(if $(S3I_BUCKET_NAME),http://$(S3I_BUCKET_NAME).s3-website-$(S3I_BUCKET_LOCATION_CONSTRAINT).amazonaws.com)

# Options parameters
__S3I_ACL= $(if $(S3I_BUCKET_CANNEDACL_TYPE),--acl $(S3I_BUCKET_CANNEDACL_TYPE))
__S3I_ACCESS_CONTROL_LIST= $(if $(S3I_BUCKET_ACL_FILETYPE),--access-control-list file://$(S3I_BUCKET_ACL_FILETYPE))
__S3I_BUCKET?= $(if $(S3I_BUCKET_NAME),--bucket $(S3I_BUCKET_NAME))
__S3I_BUCKET_LOGGING_STATUS?= $(if $(S3I_BUCKET_LOGGING),--bucket-logging-status $(S3I_BUCKET_LOGGING))
__S3I_CONTENT_MD5=
__S3I_CREATE_BUCKET_CONFIGURATION?= $(if $(S3I_BUCKET_CONFIGURATION),--create-bucket-configuration $(S3I_BUCKET_CONFIGURATION))
__S3I_GRANT_FULL_CONTROL= $(if $(S3I_BUCKET_GRANT_FULLCONTROL),--grant-full-control $(S3I_BUCKET_GRANT_FULLCONTROL))
__S3I_GRANT_READ= $(if $(S3I_BUCKET_GRANT_READ),--grant-read $(S3I_BUCKET_GRANT_READ))
__S3I_GRANT_READ_ACP= $(if $(S3I_BUCKET_GRANT_READACP),--grant-read-acp $(S3I_BUCKET_GRANT_READACP))
__S3I_GRANT_WRITE= $(if $(S3I_BUCKET_GRANT_WRITE),--grant-write $(S3I_BUCKET_GRANT_WRITE))
__S3I_GRANT_WRITE_ACP= $(if $(S3I_BUCKET_GRANT_WRITEACP),--grant-write-acp $(S3I_BUCKET_GRANT_WRITEACP))
__S3I_ID_ANALYTICS= $(if $(S3I_BUCKET_ANALYTICS_CONFIGURATION_ID),--id $(S3I_BUCKET_ANALYTICS_CONFIGURATION_ID))
__S3I_ID_INVENTORY= $(if $(S3I_BUCKET_INVENTORY_CONFIGURATION_ID),--id $(S3I_BUCKET_INVENTORY_CONFIGURATION_ID))
__S3I_ID_METRICS= $(if $(S3I_BUCKET_METRICS_CONFIGURATION_ID),--id $(S3I_BUCKET_METRICS_CONFIGURATION_ID))
__S3I_LIFECYCLE_CONFIGURATION?= $(if $(S3I_BUCKET_LIFECYCLE),--lifecycle-configuration $(S3I_BUCKET_LIFECYCLE))
__S3I_MFA=
__S3I_POLICY= $(if $(S3I_BUCKET_POLICY),--policy $(S3I_BUCKET_POLICY))
__S3I_VERSIONING_CONFIGURATION=
__S3I_WEBSITE_CONFIGURATION?= $(if $(S3I_BUCKET_WEBSITE),--website-configuration $(S3I_BUCKET_WEBSITE))

# Pipe parameters
_S3I_UPDATE_BUCKET_LIFECYCLE_|?= [ -z $(S3I_BUCKET_LIFECYCLE_FILEPATH) ] ||
_S3I_UPDATE_BUCKET_LOGGING_|?= [ -z $(S3I_BUCKET_LOGGING_FILEPATH) ] ||
_S3I_UPDATE_BUCKET_POLICY_|?= [ -z $(S3I_BUCKET_POLICY_FILEPATH) ] ||
_S3I_UPDATE_BUCKET_WEBSITE_|?= [ -z $(S3I_BUCKET_WEBSITE_FILEPATH) ] ||

# UI parameters
ifndef S3I_UI_SHOW_BUCKET_TARGETS
S3I_UI_SHOW_BUCKET_TARGETS+= _s3i_show_bucket_accelerate_configuration
S3I_UI_SHOW_BUCKET_TARGETS+= _s3i_show_bucket_acl
S3I_UI_SHOW_BUCKET_TARGETS+= _s3i_show_bucket_analytics_configurations
S3I_UI_SHOW_BUCKET_TARGETS+= _s3i_show_bucket_cors
S3I_UI_SHOW_BUCKET_TARGETS+= _s3i_show_bucket_dirpath
S3I_UI_SHOW_BUCKET_TARGETS+= _s3i_show_bucket_encryption
S3I_UI_SHOW_BUCKET_TARGETS+= _s3i_show_bucket_inventory_configurations
S3I_UI_SHOW_BUCKET_TARGETS+= _s3i_show_bucket_lifecycle
S3I_UI_SHOW_BUCKET_TARGETS+= _s3i_show_bucket_location
S3I_UI_SHOW_BUCKET_TARGETS+= _s3i_show_bucket_logging
S3I_UI_SHOW_BUCKET_TARGETS+= _s3i_show_bucket_metrics_configurations
S3I_UI_SHOW_BUCKET_TARGETS+= _s3i_show_bucket_notification_configuration
S3I_UI_SHOW_BUCKET_TARGETS+= _s3i_show_bucket_objects
S3I_UI_SHOW_BUCKET_TARGETS+= _s3i_show_bucket_policy
S3I_UI_SHOW_BUCKET_TARGETS+= _s3i_show_bucket_replication_configuration
S3I_UI_SHOW_BUCKET_TARGETS+= _s3i_show_bucket_request_payment
S3I_UI_SHOW_BUCKET_TARGETS+= _s3i_show_bucket_tagging
S3I_UI_SHOW_BUCKET_TARGETS+= _s3i_show_bucket_versioning
S3I_UI_SHOW_BUCKET_TARGETS+= _s3i_show_bucket_website_configuration
endif
S3I_UI_SHOW_BUCKET_OBJECTS_FIELDS?= .Key
S3I_UI_VIEW_BUCKETS_FIELDS?=

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_s3i_view_framework_macros ::
	@#echo 'AWS::S3API::Bucket ($(_AWS_S3API_BUCKET_MK_VERSION)) macros:'
	@#echo

_s3i_view_framework_parameters ::
	@echo 'AWS::S3API::Bucket ($(_AWS_S3API_BUCKET_MK_VERSION)) parameters:'
	@echo '    S3I_BUCKET_ACL_FILETYPE=$(S3I_BUCKET_CANNED_ACL_FILETYPE)'
	@echo '    S3I_BUCKET_ANALYTICS_CONFIGURATION_ID=$(S3I_BUCKET_ANALYTICS_CONFIGURATION_ID)'
	@echo '    S3I_BUCKET_CANNEDACL_TYPE=$(S3I_BUCKET_CANNED_CANNEDACL_TYPE)'
	@echo '    S3I_BUCKET_CONFIGURATION=$(S3I_BUCKET_CONFIGURATION)'
	@echo '    S3I_BUCKET_DIRPATH=$(S3I_BUCKET_DIRPATH)'
	@echo '    S3I_BUCKET_GRANT_FULLCONTROL=$(S3I_BUCKET_GRANT_FULLCONTROL)'
	@echo '    S3I_BUCKET_GRANT_READ=$(S3I_BUCKET_GRANT_READ)'
	@echo '    S3I_BUCKET_GRANT_READACP=$(S3I_BUCKET_GRANT_READACP)'
	@echo '    S3I_BUCKET_GRANT_WRITE=$(S3I_BUCKET_GRANT_WRITE)'
	@echo '    S3I_BUCKET_GRANT_WRITEACP=$(S3I_BUCKET_GRANT_WRITEACP)'
	@echo '    S3I_BUCKET_INVENTORY_CONFIGURATION_ID=$(S3I_BUCKET_INVENTORY_CONFIGURATION_ID)'
	@echo '    S3I_BUCKET_LIFECYCLE=$(S3I_BUCKET_LIFECYCLE)'
	@echo '    S3I_BUCKET_LIFECYCLE_FILENAME=$(S3I_BUCKET_LIFECYCLE_FILENAME)'
	@echo '    S3I_BUCKET_LIFECYCLE_FILEPATH=$(S3I_BUCKET_LIFECYCLE_FILEPATH)'
	@echo '    S3I_BUCKET_LOCATION_CONSTRAINT=$(S3I_BUCKET_LOCATION_CONSTRAINT)'
	@echo '    S3I_BUCKET_LOGGING=$(S3I_BUCKET_LOGGING)'
	@echo '    S3I_BUCKET_LOGGING_FILENAME=$(S3I_BUCKET_LOGGING_FILENAME)'
	@echo '    S3I_BUCKET_LOGGING_FILEPATH=$(S3I_BUCKET_LOGGING_FILEPATH)'
	@echo '    S3I_BUCKET_METRICS_CONFIGURATION_ID=$(S3I_BUCKET_METRICS_CONFIGURATION_ID)'
	@echo '    S3I_BUCKET_NAME=$(S3I_BUCKET_NAME)'
	@echo '    S3I_BUCKET_WEBSITE=$(S3I_BUCKET_WEBSITE)'
	@echo '    S3I_BUCKET_WEBSITE_FILENAME=$(S3I_BUCKET_WEBSITE_FILENAME)'
	@echo '    S3I_BUCKET_WEBSITE_FILEPATH=$(S3I_BUCKET_WEBSITE_FILEPATH)'
	@echo '    S3I_BUCKET_WEBSITE_URL=$(S3I_BUCKET_WEBSITE_URL)'
	@echo '    S3I_BUCKETS_SET_NAME=$(S3I_BUCKETS_SET_NAME)'
	@echo

_s3i_view_framework_targets ::
	@echo 'AWS::S3API::Bucket ($(_AWS_S3API_BUCKET_MK_VERSION)) targets:'
	@echo '    _s3i_create_bucket                          - Create a bucket'
	@echo '    _s3i_delete_bucket                          - Delete a bucket'
	@echo '    _s3i_disable_bucket_versioning              - Disable versioning of a bucket'
	@echo '    _s3i_enable_bucket_versioning               - Enable versioning of a bucket'
	@echo '    _s3i_show_bucket_location                   - Shows the location/region of an S3 bucket'
	@echo '    _s3i_show_bucket                            - Show everything about the buket'
	@echo '    _s3i_show_bucket_accelerate_configuration   - Show acclerate configuration of bucket'
	@echo '    _s3i_show_bucket_acl                        - Show ACLs of a bucket'
	@echo '    _s3i_show_bucket_analytics_configurations   - Show ALL analytics-configurations of a bucket'
	@echo '    _s3i_show_bucket_cors                       - Show CORS of a bucket'
	@echo '    _s3i_show_bucket_encryption                 - Show encryption of a bucket'
	@echo '    _s3i_show_bucket_inventory_configurations   - Show ALL inventory-configurations for a bucket'
	@echo '    _s3i_show_bucket_lifecycle                  - Show lifecycle-configuration of a bucket'
	@echo '    _s3i_show_bucket_location                   - Show the location of a bucket'
	@echo '    _s3i_show_bucket_logging                    - Show logging of a bucket'
	@echo '    _s3i_show_bucket_metrics_configurations     - Show ALL metrics-configurations for a bucket'
	@echo '    _s3i_show_bucket_notification_configuration - Show notification configuration of a bucket'
	@echo '    _s3i_show_bucket_objects                    - Show objects in a bucket'
	@echo '    _s3i_show_bucket_policy                     - Show the policy of a bucket'
	@echo '    _s3i_show_bucket_replication_configuration  - Show details of a replication-configuration of a bucket'
	@echo '    _s3i_show_bucket_request_payment            - Show request payment of a bucket'
	@echo '    _s3i_show_bucket_tagging                    - Show bucket tagging of a bucket'
	@echo '    _s3i_show_bucket_versioning                 - Show versioning of a bucket'
	@echo '    _s3i_show_bucket_website_configuration      - Show the website-configuration of a bucket'
	@echo '    _s3i_update_bucket                          - Update a bucket'
	@echo '    _s3i_update_bucket_lifescycle               - Update the lifecycle-configuration of a bucket'
	@echo '    _s3i_update_bucket_logging                  - Update the logging-configuration of a bucket'
	@echo '    _s3i_update_bucket_policy                   - Update the policy of a bucket'
	@echo '    _s3i_update_bucket_website                  - Update the website-configuration of a bucket'
	@echo '    _s3i_view_buckets                           - View buckets'
	@echo '    _s3i_view_buckets_set                       - View a set of buckets'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_s3i_create_bucket:
	@$(INFO) '$(AWS_UI_LABEL)Creating buckets "$(S3I_BUCKET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The bucket location constraint must be set to the same region the API call goes to'; $(NORMAL)
	@$(WARN) 'If the API calls go to 'us-east-1' then NO location constraint should be specified!'; $(NORMAL)
	$(AWS) s3api create-bucket $(strip $(__S3I_ACL) $(__S3I_BUCKET)  $(__S3I_CREATE_BUCKET_CONFIGURATION) $(__S3I_GRANT_FULL_CONTROL) $(__S3I_GRANT_READ) $(__S3I_GRANT_READ_ACP) $(__S3I_GRANT_WRITE) $(__S3I_GRANT_WRITE_ACP) )

_s3i_delete_bucket:
	@$(INFO) '$(AWS_UI_LABEL)Deleting buckets "$(S3I_BUCKET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the bucket is not empty'; $(NORMAL)
	$(AWS) s3api delete-bucket $(__S3I_BUCKET)

_s3i_disable_bucket_versioning:
	@$(INFO) '$(AWS_UI_LABEL)Disabling versioning of buckets "$(S3I_BUCKET_NAME)" ...'; $(NORMAL)
	$(AWS) s3api put-bucket-versioning $(__S3I_BUCKET) $(__S3I_CONTENT_MD5) $(__S3I_MFA) $(_X__S3I_VERSIONING_CONFIGURATION) --versioning-configuration MFADelete=Disabled,Status=Suspended

_s3i_enable_bucket_versioning:
	@$(INFO) '$(AWS_UI_LABEL)Enbling versioning of buckets "$(S3I_BUCKET_NAME)" ...'; $(NORMAL)
	$(AWS) s3api put-bucket-versioning $(__S3I_BUCKET) $(__S3I_CONTENT_MD5) $(__S3I_MFA) $(_X__S3I_VERSIONING_CONFIGURATION) --versioning-configuration MFADelete=Disabled,Status=Enabled

_s3i_show_bucket: $(S3I_UI_SHOW_BUCKET_TARGETS)

_s3i_show_bucket_accelerate_configuration:
	@$(INFO) '$(AWS_UI_LABEL)Showing details of an accelerate-configuration of bucket "$(S3I_BUCKET_NAME)" ...'; $(NORMAL)
	$(AWS) s3api get-bucket-accelerate-configuration $(__S3I_BUCKET)

_s3i_show_bucket_acl:
	@$(INFO) '$(AWS_UI_LABEL)Showing the ACLs of bucket "$(S3I_BUCKET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation shows who created the bucket and what access-level is granted to users or user-groups'; $(NORMAL)
	$(AWS) s3api get-bucket-acl $(__S3I_BUCKET)

_s3i_show_bucket_analytics_configuration:
	@$(INFO) '$(AWS_UI_LABEL)Showing the analytics-configuration of bucket "$(S3I_BUCKET_NAME)" ...'; $(NORMAL)
	$(AWS) s3api get-bucket-analytics-configuration $(__S3I_BUCKET) $(__S3I_ID_ANALYTICS)

_s3i_show_bucket_analytics_configurations:
	@$(INFO) '$(AWS_UI_LABEL)Showing ALL analytics-configurations of bucket "$(S3I_BUCKET_NAME)" ...'; $(NORMAL)
	$(AWS) s3api list-bucket-analytics-configurations $(__S3I_BUCKET)

_s3i_show_bucket_cors:
	@$(INFO) '$(AWS_UI_LABEL)Showing the CORS of bucket "$(S3I_BUCKET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if not cors have been defined for this bucket'; $(NORMAL)
	-$(AWS) s3api get-bucket-cors $(__S3I_BUCKET)

_s3i_show_bucket_dirpath:
	@$(INFO) '$(AWS_UI_LABEL)Showing dirpath of bucket "$(S3I_BUCKET_NAME)" ...'; $(NORMAL)
	ls -l $(S3I_BUCKET_DIRPATH)

_s3i_show_bucket_encryption:
	@$(INFO) '$(AWS_UI_LABEL)Showing the server-side encryption settings for bucket "$(S3I_BUCKET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if encryption is not set!'; $(NORMAL)
	-$(AWS) s3api get-bucket-encryption $(__S3I_BUCKET)

_s3i_show_bucket_inventory_configuration:
	@$(INFO) '$(AWS_UI_LABEL)Showing details of an inventory-configuration for bucket "$(S3I_BUCKET_NAME)" ...'; $(NORMAL)
	$(AWS) s3api get-bucket-inventory-configuration $(__S3I_BUCKET) $(__S3I_ID_INVENTORY)

_s3i_show_bucket_inventory_configurations:
	@$(INFO) '$(AWS_UI_LABEL)Showing ALL inventory-configurations of bucket "$(S3I_BUCKET_NAME)" ...'; $(NORMAL)
	$(AWS) s3api list-bucket-inventory-configurations $(__S3I_BUCKET)

_s3i_show_bucket_lifecycle:
	@$(INFO) '$(AWS_UI_LABEL)Showing the lifecyle-configuration of bucket "$(S3I_BUCKET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if no bucket lifecycle is configured!'; $(NORMAL)
	-$(AWS) s3api get-bucket-lifecycle-configuration $(__S3I_BUCKET)

_s3i_show_bucket_location:
	@$(INFO) '$(AWS_UI_LABEL)Showing location-constraint of bucket "$(S3I_BUCKET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns none if location-constraint is us-east-1'; $(NORMAL)
	$(AWS) s3api get-bucket-location $(__S3I_BUCKET)

_s3i_show_bucket_logging:
	@$(INFO) '$(AWS_UI_LABEL)Showing logging of bucket "$(S3I_BUCKET_NAME)" ...'; $(NORMAL)
	$(AWS) s3api get-bucket-logging $(__S3I_BUCKET)

_s3i_show_bucket_metrics_configuration:
	@$(INFO) '$(AWS_UI_LABEL)Showing the metrics-configuration of bucket "$(S3I_BUCKET_NAME)" ...'; $(NORMAL)
	$(AWS) s3api get-bucket-metrics-configuration $(__S3I_BUCKET) $(__S3I_ID_METRICS)

_s3i_show_bucket_metrics_configurations:
	@$(INFO) '$(AWS_UI_LABEL)Showing ALL metrics-configurations for bucket "$(S3I_BUCKET_NAME)" ...'; $(NORMAL)
	$(AWS) s3api list-bucket-metrics-configurations $(__S3I_BUCKET)

_s3i_show_bucket_notification_configuration:
	@$(INFO) '$(AWS_UI_LABEL)Showing the notification-configuration of bucket "$(S3I_BUCKET_NAME)" ...'; $(NORMAL)
	$(AWS) s3api get-bucket-notification-configuration $(__S3I_BUCKET)

_s3i_show_bucket_objects:
	@$(INFO) '$(AWS_UI_LABEL)Showing objects in bucket "$(S3I_BUCKET_NAME)" ...'; $(NORMAL)
	$(AWS) s3api list-objects $(__S3I_BUCKET) --query 'Contents[]$(S3I_UI_SHOW_BUCKET_OBJECTS_FIELDS)'

_s3i_show_bucket_policy:
	@$(INFO) '$(AWS_UI_LABEL)Showing the policy of bucket "$(S3I_BUCKET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if this bucket has no policy!'; $(NORMAL)
	$(AWS) s3api get-bucket-policy $(__S3I_BUCKET) --output text | jq '.'

_s3i_show_bucket_replication_configuration:
	@$(INFO) '$(AWS_UI_LABEL)Showing the replication-configuration of bucket "$(S3I_BUCKET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if this bucket does NOT already have a replication-configuration!'; $(NORMAL)
	-$(AWS) s3api get-bucket-replication $(__S3I_BUCKET)

_s3i_show_bucket_request_payment:
	@$(INFO) '$(AWS_UI_LABEL)Showing the request-payment of bucket "$(S3I_BUCKET_NAME)" ...'; $(NORMAL)
	$(AWS) s3api get-bucket-request-payment $(__S3I_BUCKET)

_s3i_show_bucket_tagging:
	@$(INFO) '$(AWS_UI_LABEL)Showing the tag-set of bucket "$(S3I_BUCKET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if this bucket has no tag-set!'; $(NORMAL)
	-$(AWS) s3api get-bucket-tagging $(__S3I_BUCKET)

_s3i_show_bucket_versioning:
	@$(INFO) '$(AWS_UI_LABEL)Showing versioning of bucket "$(S3I_BUCKET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns enabled, disabled, or none if the feature is not configured'; $(NORMAL)
	$(AWS) s3api get-bucket-versioning $(__S3I_BUCKET) --query '{Versioning:Status,MFADelete:MFADelete}'

_s3i_show_bucket_website:
	@$(INFO) '$(AWS_UI_LABEL)Showing the website-configuration of bucket "$(S3I_BUCKET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the bucket has no website-configuration!'; $(NORMAL)
	@$(WARN) 'Website can be accessed at URL: $(S3I_BUCKET_WEBSITE_URL)'; $(NORMAL)
	-$(AWS) s3api get-bucket-website $(__S3I_BUCKET)

_s3i_update_bucket:: _s3i_update_bucket_acl _s3i_update_bucket_lifecycle _s3i_update_bucket_logging _s3i_update_bucket_policy _s3i_update_bucket_website

_s3i_update_bucket_acl:
	@$(INFO) '$(AWS_UI_LABEL)Updating ACLs of bucket "$(S3I_BUCKET_NAME)" ...'; $(NORMAL)
	$(if $(S3I_BUCKET_ACL_FILEPATH), cat $(S3I_BUCKET_ACL_FILEPATH))
	$(AWS) s3api put-bucket-acl $(strip $(__S3I_ACL) $(__S3I_ACCESS_CONTROL_POLICY) $(__S3I_BUCKET) $(__S3I_CONTENT_MD5) $(__S3I_GRANT_FULL_CONTROL) $(__S3I_GRANT_READ_CONTROL) $(__S3I_GRANT_READ_ACP) $(__S3I_GRANT_WRITE) $(__S3I_GRANT_WRITE_ACP) )

_s3i_update_bucket_lifecycle:
	@$(INFO) '$(AWS_UI_LABEL)Updating lifecycle-configuration of bucket "$(S3I_BUCKET_NAME)" ...'; $(NORMAL)
	$(if $(S3I_BUCKET_LIFECYCLE_FILEPATH), cat $(S3I_BUCKET_LIFECYCLE_FILEPATH))
	$(_S3I_UPDATE_BUCKET_LIFECYCLE_|) $(AWS) s3api put-bucket-lifecycle-configuration $(__S3I_BUCKET) $(__S3I_LIFECYCLE_CONFIGURATION)

_s3i_update_bucket_logging:
	@$(INFO) '$(AWS_UI_LABEL)Updating logging-configuration of bucket "$(S3I_BUCKET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation starts logging bucket read/write in the bucket-folder referenced as target-prefix'; $(NORMAL)
	$(if $(S3I_BUCKET_LOGGING_FILEPATH), cat $(S3I_BUCKET_LOGGING_FILEPATH))
	$(_S3I_UPDATE_BUCKET_LOGGING_|) $(AWS) s3api put-bucket-logging $(__S3I_BUCKET) $(__S3I_BUCKET_LOGGING_STATUS) $(__S3I_CONTENT_MD5)

_s3i_update_bucket_policy:
	@$(INFO) '$(AWS_UI_LABEL)Updating policy of bucket "$(S3I_BUCKET_NAME)" ...'; $(NORMAL)
	$(if $(S3I_BUCKET_POLICY_FILEPATH), cat $(S3I_BUCKET_POLICY_FILEPATH))
	$(_S3I_UPDATE_BUCKET_POLICY_|) $(AWS) s3api put-bucket-policy $(__S3I_BUCKET) $(__S3I_POLICY)

_s3i_update_bucket_website:
	@$(INFO) '$(AWS_UI_LABEL)Updating website-configuration of bucket "$(S3I_BUCKET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The bucket is accessible at URL: $(S3I_BUCKET_WEBSITE_URL)'; $(NORMAL)
	$(if $(S3I_BUCKET_WEBSITE_FILEPATH), cat $(S3I_BUCKET_WEBSITE_FILEPATH))
	$(_S3I_UPDATE_BUCKET_WEBSITE_|) $(AWS) s3api put-bucket-website $(__S3I_BUCKET) $(__S3I_CONTENT_MD5) $(__S3I_WEBSITE_CONFIGURATION)

_s3i_view_buckets:
	@$(INFO) '$(AWS_UI_LABEL)Viewing buckets ...'; $(NORMAL)
	@$(WARN) 'S3 is a global service, the returned buckets can have any bucket location contraint'; $(NORMAL)
	$(AWS) s3api list-buckets --query "Buckets[]$(S3I_UI_VIEW_BUCKETS_FIELDS)"

_s3i_view_buckets_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing buckets-set "$(S3I_BUCKETS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Buckets are grouped based on ....'; $(NORMAL)
