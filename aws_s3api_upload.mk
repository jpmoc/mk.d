_AWS_S3API_UPLOAD_MK_VERSION=$(_AWS_S3API_MK_VERSION)

# S3I_UPLOAD_KEY?= test.txt
# S3I_UPLOAD_NAME?= my-upload
# S3I_UPLOAD_BUCKET_NAME?= mybucket
# S3I_UPLOAD_GRANT_READ?=
# S3I_UPLOAD_GRANT_READACP?=
# S3I_UPLOAD_GRANT_WRITE?=
S3I_UPLOAD_STORAGECLASS_TYPE?= STANDARD
# S3I_UPLOADS_BUCKET_NAME?= mybucket
# S3I_UPLOADS_DELETE_FILEPATH?= mybucket

# Derived parameters
S3I_UPLOAD_NAME?= $(S3I_UPLOAD_KEY)
S3I_UPLOAD_BUCKET_NAME?= $(S3I_BUCKET_NAME)
S3I_UPLOADS_BUCKET_NAME?= $(S3I_UPLOAD_BUCKET_NAME)

# Options parameters
__S3I_ACL__UPLOAD=
__S3I_BUCKET__UPLOAD= $(if $(S3I_UPLOAD_BUCKET_NAME),--bucket $(S3I_UPLOAD_BUCKET_NAME))
__S3I_BUCKET__UPLOADS= $(if $(S3I_UPLOADS_BUCKET_NAME),--bucket $(S3I_UPLOADS_BUCKET_NAME))
__S3I_DELIMITER__UPLOADS=
__S3I_ENCODING_TYPE__UPLOADS=
__S3I_GRANT_READ__UPLOAD= $(if $(S3I_UPLOAD_GRANT_READ),--grant-read $(S3I_UPLOAD_GRANT_READ))
__S3I_GRANT_READACL__UPLOAD= $(if $(S3I_UPLOAD_GRANT_READACL),--grant-read-acl $(S3I_UPLOAD_GRANT_READACL))
__S3I_GRANT_WRITE__UPLOAD= $(if $(S3I_UPLOAD_GRANT_WRITE),--grant-write $(S3I_UPLOAD_GRANT_WRITE))
__S3I_KEY__UPLOAD= $(if $(S3I_UPLOAD_KEY),--key $(S3I_UPLOAD_KEY))
__S3I_PREFIX__UPLOADS=
__S3I_STORAGE_CLASS= $(if $(S3I_UPLOAD_STORAGECLASS_TYPE),--storage-class $(S3I_UPLOAD_STORAGECLASS_TYPE))


# UI parameters

#--- MACROS
_s3i_get_upload_id= $(call _s3i_get_upload_id_K, $(S3I_UPLOAD_KEY))
_s3i_get_upload_id_K= $(call _s3i_get_upload_id_KB, $(1), $(S3I_UPLOAD_BUCKET_NAME))
_s3i_get_upload_id_KB= $(shell $(AWS) s3api list-multipart-uploads --bucket $(2) --query "Uploads[?Key=='$(strip $(1))'].UploadId" --output text)

#----------------------------------------------------------------------
# USAGE
#

_s3i_view_framework_macros ::
	@echo 'AWS::S3API::Upload ($(_AWS_S3API_UPLOAD_MK_VERSION)) macros:'
	@echo '    _s3i_get_upload_id_{|K|KB}                   - Get the ID of an upload (Key,Bucket)'
	@echo

_s3i_view_framework_parameters ::
	@echo 'AWS::S3API::Upload ($(_AWS_S3API_UPLOAD_MK_VERSION)) parameters:'
	@echo '    S3I_UPLOAD_BUCKET_NAME=$(S3I_UPLOAD_BUCKET_NAME)'
	@echo '    S3I_UPLOAD_GRANT_READ=$(S3I_UPLOAD_GRANT_READ)'
	@echo '    S3I_UPLOAD_GRANT_READACP=$(S3I_UPLOAD_GRANT_READACP)'
	@echo '    S3I_UPLOAD_GRANT_WRITE=$(S3I_UPLOAD_GRANT_WRITE)'
	@echo '    S3I_UPLOAD_KEY=$(S3I_UPLOAD_KEY)'
	@echo '    S3I_UPLOAD_NAME=$(S3I_UPLOAD_NAME)'
	@echo '    S3I_UPLOAD_STORAGECLASS_TYPE=$(S3I_UPLOAD_STORAGECLASS_TYPE)'
	@echo '    S3I_UPLOADS_BUCKET_NAME=$(S3I_UPLOADS_BUCKET_NAME)'
	@echo

_s3i_view_framework_targets ::
	@echo 'AWS::S3API::Upload ($(_AWS_S3API_UPLOAD_MK_VERSION)) targets:'
	@echo '    _s3i_create_upload                          - Create a upload'
	@echo '    _s3i_delete_upload                          - Delete an upload'
	@echo '    _s3i_show_upload                            - Show everything related to an upload'
	@echo '    _s3i_show_upload_description                - Show description of an upload'
	@echo '    _s3i_view_uploads                           - View uploads in uploads'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_s3i_create_upload:
	@$(INFO) '$(AWS_UI_LABEL)Creating upload "$(S3I_UPLOAD_NAME)" ...'; $(NORMAL)
	$(AWS) s3api create-multipart-upload $(strip $(__S3I_ACL__UPLOAD) $(__S3I_BUCKET__UPLOAD)  $(__S3I_CACHE_CONTROL) $(__S3I_CONTENT_DISPOSITION) $(__S3I_CONTENT_ENCODING) $(__S3I_CONTENT_LANGUAGE) $(__S3I_CONTENT_TYPE) $(__S3I_EXPIRES) $(__S3I_GRANT_FULL_CONTROL__UPLOAD) $(__S3I_GRANT_READ__UPLOAD) $(__S3I_GRANT_READ_ACP__UPLOAD) $(__S3I_GRANT_WRITE_ACP__UPLOAD) $(__S3I_KEY__UPLOAD) $(__S3I_METADATA) $(__S3I_OBJECT_LOCK_MODE) $(__S3I_OBJECT_LOCK_RETAINT_UNTIL_DATE) $(__S3I_OBJECT_LOCAK_LEGAL_HOLDE_STATUS) $(__S3I_SERVER_SIDE_ENCRYPTION) $(__S3I_STORAGE_CLASS) $(__S3I_WEBSITE_REDIRECT_LOCATION) $(__S3I_SSE_CUSTOMER_ALGORITHM) $(__S3I_SSE_CUSTOMER_KEY) $(__S3I_SSE_CUSTOMER_KEY_MD5) $(__S3I_SSEKMS_ENCRYPTION_CONTEXT) $(__S3I_REQUEST_PAYER__UPLOAD) $(__S3I_TAGGING__UPLOAD) )

_s3i_continue_upload:
	@$(INFO) '$(AWS_UI_LABEL)Continuing upload "$(S3I_UPLOAD_NAME)" ...'; $(NORMAL)

_s3i_delete_upload:
	@$(INFO) '$(AWS_UI_LABEL)Deleting upload "$(S3I_UPLOAD_NAME)" ...'; $(NORMAL)
	# $(AWS) s3api delete-upload $(__S3I_BUCKET__UPLOAD) $(__S3I_BYPASS_GOVERNANCE_RETENTION__UPLOAD) $(__S3I_KEY) $(__S3I_MFA__UPLOAD) $(__S3I_REQUEST_PAYER__UPLOAD)

_s3i_show_upload: _s3i_show_upload_description

_s3i_show_upload_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of upload "$(S3I_UPLOAD_NAME)" ...'; $(NORMAL)

_s3i_view_uploads:
	@$(INFO) '$(AWS_UI_LABEL)Viewing uploads ...'; $(NORMAL)
	$(AWS) s3api list-multipart-uploads $(__S3I_BUCKET__UPLOADS) $(__S3I_DELIMITER__UPLOADS) $(__S3I_ENCODING_TYPE__UPLOADS) $(__S3I_PREFIX__UPLOADS)
