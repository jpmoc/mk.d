_AWS_S3API_OBJECT_MK_VERSION=$(_AWS_S3API_MK_VERSION)

# S3I_OBJECT_KEY?= test.txt
# S3I_OBJECT_NAME?= myobject
# S3I_OBJECT_BUCKET_NAME?= mybucket
# S3I_OBJECTS_BUCKET_NAME?= mybucket
# S3I_OBJECTS_DELETE_FILEPATH?= mybucket

# Derived parameters
S3I_OBJECT_NAME?= $(S3I_OBJECT_KEY)
S3I_OBJECT_BUCKET_NAME?= $(S3I_BUCKET_NAME)
S3I_OBJECTS_BUCKET_NAME?= $(S3I_OBJECT_BUCKET_NAME)

# Options
__S3I_BUCKET__OBJECT= $(if $(S3I_OBJECT_BUCKET_NAME),--bucket $(S3I_OBJECT_BUCKET_NAME))
__S3I_BUCKET__OBJECTS= $(if $(S3I_OBJECTS_BUCKET_NAME),--bucket $(S3I_OBJECTS_BUCKET_NAME))
__S3I_BYPASS_GOVERNANCE_RETENTION__OBJECT=
__S3I_BYPASS_GOVERNANCE_RETENTION__OBJECTS=
__S3I_DELETE__OBJECTS?= $(if $(S3I_OBJECTS_DELETE_FILEPATH),--delete file://$(S3I_OBJECTS_DELETE_FILEPATH))
__S3I_DELIMITER?=
__S3I_KEY= $(if $(S3I_OBJECT_KEY),--key $(S3I_OBJECT_KEY))
__S3I_MFA__OBJECT=
__S3I_MFA__OBJECTS=
__S3I_REQUEST_PAYER__OBJECT=
__S3I_REQUEST_PAYER__OBJECTS=
__S3I_START_AFTER=

# Customizations

# Macros

#----------------------------------------------------------------------
# USAGE
#

_s3i_view_framework_macros ::
	@#echo 'AWS::S3API::Object ($(_AWS_S3API_OBJECT_MK_VERSION)) macros:'
	@#echo

_s3i_view_framework_parameters ::
	@echo 'AWS::S3API::Object ($(_AWS_S3API_OBJECT_MK_VERSION)) parameters:'
	@echo '    S3I_OBJECT_KEY=$(S3I_OBJECT_KEY)'
	@echo '    S3I_OBJECT_NAME=$(S3I_OBJECT_NAME)'
	@echo '    S3I_OBJECT_BUCKET_NAME=$(S3I_OBJECT_BUCKET_NAME)'
	@echo '    S3I_OBJECTS_BUCKET_NAME=$(S3I_OBJECTS_BUCKET_NAME)'
	@echo '    S3I_OBJECTS_DELETE_FILEPATH=$(S3I_OBJECTS_DELETE_FILEPATH)'
	@echo

_s3i_view_framework_targets ::
	@echo 'AWS::S3API::Object ($(_AWS_S3API_OBJECT_MK_VERSION)) targets:'
	@echo '    _s3i_create_object                          - Create a object'
	@echo '    _s3i_delete_object                          - Delete an object'
	@echo '    _s3i_delete_objects                         - Delete several objects'
	@echo '    _s3i_list_objects                           - View all objects in a bucket'
	@echo '    _s3i_show_object                            - Show everything related to an object'
	@echo '    _s3i_show_object_description                - Show description of an object'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_s3i_create_object:
	@$(INFO) '$(S3I_UI_LABEL)Creating object "$(S3I_OBJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The object location constraint must be set to the same region the API call goes to'; $(NORMAL)
	@$(WARN) 'If the API calls go to 'us-east-1' then NO location constraint should be specified!'; $(NORMAL)
	$(AWS) s3api create-object $(__S3I_ACL) $(__S3I_OBJECT)  $(__S3I_CREATE_OBJECT_CONFIGURATION) $(__S3I_GRANT_FULL_CONTROL) $(__S3I_GRANT_READ) $(__S3I_GRANT_READ_ACP) $(__S3I_GRANT_WRITE) $(__S3I_GRANT_WRITE_ACP) 

_s3i_delete_object:
	@$(INFO) '$(S3I_UI_LABEL)Deleting object "$(S3I_OBJECT_NAME)" ...'; $(NORMAL)
	$(AWS) s3api delete-object $(__S3I_BUCKET__OBJECT) $(__S3I_BYPASS_GOVERNANCE_RETENTION__OBJECT) $(__S3I_KEY) $(__S3I_MFA__OBJECT) $(__S3I_REQUEST_PAYER__OBJECT)

_s3i_delete_objects:
	@$(INFO) '$(S3I_UI_LABEL)Deleting objects ...'; $(NORMAL)
	$(AWS) s3api delete-objects $(__S3I_BUCKET__OBJECTS) $(__S3I_BYPASS_GOVERNANCE_RETENTION__OBJECTS) $(__S3I_DELETE__OBJECTS) $(__S3I_MFA__OBJECTS) $(__S3I_REQUEST_PAYER__OBJECTS)

_s3i_list_objects:
	@$(INFO) '$(S3I_UI_LABEL)Listing ALL objects ...'; $(NORMAL)
	$(AWS) s3api list-objects $(__S3I_BUCKET__OBJECTS) $(__S3I_DELIMITER) $(__S3I_ENCODING_TYPE) $(__S3I_FETCH_OWNER) $(__S3I_PREFIX)$(__S3I_REQUEST_PAYER) $(__S3I_START_AFTER)  # --query "Buckets[]$(_S3I_LIST_OBJECTS_FIELDS)"

_s3i_show_object: _s3i_show_object_description

_s3i_show_object_description:
	@$(INFO) '$(S3I_UI_LABEL)Showing description of object "$(S3I_OBJECT_NAME)" ...'; $(NORMAL)
