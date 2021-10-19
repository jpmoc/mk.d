_AWS_S3_OBJECT_MK_VERSION= $(_AWS_S3_MK_VERSION)

# S3_OBJECT_BUCKET_MEDIAURL?= https://s3.<aws-region>.amazonaws.com/<bucket-name>
# S3_OBJECT_BUCKET_URI?= s3://awsexamplebucket
# S3_OBJECT_BUCKET_URL?= https://awsexamplebucket.s3.amazonaws.com
# S3_OBJECT_DIRPATH?= ./s3/folder/
# S3_OBJECT_FILENAME?= myfile.txt
# S3_OBJECT_FILEPATH?= ./s3/folder/myfile.txt
# S3_OBJECT_FOLDER_KEY?= 
# S3_OBJECT_GRANTS?= 
# S3_OBJECT_KEY?= /folder/object.txt
# S3_OBJECT_MEDIA_URL?= https://s3.<aws-region>.amazonaws.com/<bucket-name>/<keyprefix>/<objectkey>i
# S3_OBJECT_NAME?=
# S3_OBJECT_PRESIGNEDURL?= https://awsexamplebucket.s3.amazonaws.com/test2.txt?AWSAccessKeyId=AKIAEXAMPLEACCESSKEY&Signature=EXHCcBe%EXAMPLEKnz3r8O0AgEXAMPLE&Expires=1555531131
# S3_OBJECT_PRESIGNEDURL_EXPIRATION?= 604800
# S3_OBJECT_URI?= s3://awsexamplebucket/test2.txt
# THe URL object is used with transcribe
# https://docs.aws.amazon.com/transcribe/latest/dg/API_Media.html
# S3_OBJECT_WEBSITE_URL?= https://awsexamplebucket.s3.amazonaws.com/test2.txt --- ????
# S3_OBJECTS_DIRPATH?= ./s3/folder/
# S3_OBJECTS_SET_NAME?= mny-objects-set

# Derived parameters 
S3_OBJECT_BUCKET_MEDIAURL?= $(S3_BUCKET_MEDIA_URL)
S3_OBJECT_BUCKET_URI?= $(S3_BUCKET_URI)
S3_OBJECT_BUCKET_WEBSITEURL?= $(S3_BUCKET_WEBSITE_URL)
S3_OBJECT_DIRPATH?= $(S3_FOLDER_DIRPATH)
S3_OBJECT_FILEPATH?= $(S3_OBJECT_DIRPATH)$(S3_OBJECT_FILENAME)
S3_OBJECT_FOLDER_KEY?= $(S3_FOLDER_KEY)
S3_OBJECT_KEY?= $(if $(S3_OBJECT_FOLDER_KEY),$(S3_OBJECT_FOLDER_KEY)/$(S3_OBJECT_FILENAME))
S3_OBJECT_NAME?= $(S3_OBJECT_FILENAME)
S3_OBJECT_URI?= $(S3_OBJECT_BUCKET_URI)$(S3_OBJECT_KEY)
S3_OBJECT_MEDIA_URL?= $(S3_OBJECT_BUCKET_MEDIAURL)$(S3_OBJECT_KEY)
S3_OBJECT_WEBSITE_URL?= $(S3_OBJECT_BUCKETWEBSITE_URL)$(S3_OBJECT_KEY)
S3_OBJECTS_DIRPATH?= $(S3_OBJECT_DIRPATH)
S3_OBJECTS_FOLDER_KEY?= $(S3_OBJECT_FOLDER_KEY)

# Options
__S3_EXPIRES_IN= $(if $(S3_OBJECT_PRESIGNEDURL_EXPIRATION),--expiratinos-in $(S3_OBJECT_PRESIGNEDURL_EXPIRATION))
__S3_GRANTS__OBJECT= $(if $(S3_OBJECT_GRANTS),--grants $(S3_OBJECT_GRANTS))

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_s3_view_framework_macros ::
	@echo 'AWS::S3::Object ($(_AWS_S3_OBJECT_MK_VERSION)) macros:'
	@echo

_s3_view_framework_parameters ::
	@echo 'AWS::S3::Object ($(_AWS_S3_OBJECT_MK_VERSION)) parameters:'
	@echo '    S3_OBJECT_BUCKET_MEDIAURL=$(S3_OBJECT_BUCKET_MEDIAURL)'
	@echo '    S3_OBJECT_BUCKET_URI=$(S3_OBJECT_BUCKET_URI)'
	@echo '    S3_OBJECT_BUCKET_WEBSITEURL=$(S3_OBJECT_BUCKET_WEBSITEURL)'
	@echo '    S3_OBJECT_DIRPATH=$(S3_OBJECT_DIRPATH)'
	@echo '    S3_OBJECT_FILENAME=$(S3_OBJECT_FILENAME)'
	@echo '    S3_OBJECT_FILEPATH=$(S3_OBJECT_FILEPATH)'
	@echo '    S3_OBJECT_FOLDER_KEY=$(S3_OBJECT_FOLDER_KEY)'
	@echo '    S3_OBJECT_GRANTS=$(S3_OBJECT_GRANTS)'
	@echo '    S3_OBJECT_KEY=$(S3_OBJECT_KEY)'
	@echo '    S3_OBJECT_MEDIA_URL=$(S3_OBJECT_MEDIA_URL)'
	@echo '    S3_OBJECT_NAME=$(S3_OBJECT_NAME)'
	@echo '    S3_OBJECT_PRESIGNEDURL=$(S3_OBJECT_PRESIGNEDURL)'
	@echo '    S3_OBJECT_PRESIGNEDURL_EXPIRATION=$(S3_OBJECT_PRESIGNEDURL_EXPIRATION)'
	@echo '    S3_OBJECT_URI=$(S3_OBJECT_URI)'
	@echo '    S3_OBJECT_WEBSITE_URL=$(S3_OBJECT_WEBSITE_URL)'
	@echo '    S3_OBJECTS_FOLDER_KEY=$(S3_OBJECTS_FOLDER_KEY)'
	@echo '    S3_OBJECTS_SET_NAME=$(S3_OBJECTS_SET_NAME)'
	@echo

_s3_view_framework_targets ::
	@echo 'AWS::S3::Object ($(_AWS_S3_OBJECT_MK_VERSION)) targets:'
	@echo '     _s3_create_object                   - Create an object'
	@echo '     _s3_delete_object                   - Delete an object'
	@echo '     _s3_download_object                 - Download an object'
	@echo '     _s3_show_object                     - Show everything related to an object'
	@echo '     _s3_show_object_description         - Show description of an object'
	@echo '     _s3_update_object                   - Update an object'
	@echo '     _s3_upload_object                   - Upload an object'
	@echo '     _s3_view_objects                    - View objects'
	@echo '     _s3_view_objects_set                - View a set of objects'
	@echo '     _s3_watch_objects                   - Watch all objects'
	@echo '     _s3_watch_objects_set               - Watch a set of objects'
	@echo '     _s3_webify_object                   - Webify an object'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_s3_create_object:
	@$(INFO) '$(S3_UI_LABEL)Creating object "$(S3_OBJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Transfer: $(S3_OBJECT_FILEPATH) --> $(S3_OBJECT_URI)'; $(NORMAL)
	$(AWS) s3 cp $(S3_OBJECT_FILEPATH) $(S3_OBJECT_URI) $(__S3_GRANTS__OBJECT) 

_s3_delete_object:
	@$(INFO) '$(S3_UI_LABEL)Deleting object "$(S3_OBJECT_NAME)" ...'; $(NORMAL)
	$(AWS) s3 rm $(__S3_DRYRUN) $(_X__S3_EXCLUDE) $(_X__S3_INCLUDE) $(__S3_ONLY_SHOW_ERRORS) $(__S3_QUIET) $(_X__S3_RECURSIVE) $(__S3_REQUEST_PAYER) $(S3_OBJECT_URI)

_s3_download_object:
	@$(INFO) '$(S3_UI_LABEL)Downloading object "$(S3_OBJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Transfer: $(S3_OBJECT_URI) --> $(S3_OBJECT_FILEPATH)'; $(NORMAL)
	$(AWS) s3 cp $(S3_OBJECT_URI) $(S3_OBJECT_FILEPATH)

_s3_show_object: _s3_show_object_description

_s3_show_object_description:
	@$(INFO) '$(S3_UI_LABEL)Showing description of object "$(S3_OBJECT_NAME)" ...'; $(NORMAL)
	$(AWS) s3 ls $(S3_OBECT_URI)

_s3_update_object:
	@$(INFO) '$(S3_UI_LABEL)Updating object "$(S3_OBJECT_NAME)" ...'; $(NORMAL)

_s3_upload_object:
	@$(INFO) '$(S3_UI_LABEL)Uploading object "$(S3_OBJECT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Transfer: $(S3_OBJECT_FILEPATH) --> $(S3_OBJECT_URI)'; $(NORMAL)
	$(AWS) s3 cp $(S3_OBJECT_FILEPATH) $(S3_OBJECT_URI)

_s3_view_objects:
	@$(INFO) '$(S3_UI_LABEL)Viewing ALL objects ...'; $(NORMAL)
	# pstree

_s3_view_objects_set:
	@$(INFO) '$(S3_UI_LABEL)Viewing objects-set "$(S3_OBJECTS_SET_NAME)" ...'; $(NORMAL)A
	@$(WARN) 'Objects are grouped based on the provided folder'; $(NORMAL)
	# pstree
	
_s3_watch_objects:
	@$(INFO) '$(S3_UI_LABEL)Watching ALL objects ...'; $(NORMAL)

_s3_watch_objects_set:
	@$(INFO) '$(S3_UI_LABEL)Watching objects-set "$(S3_OBJECTS_SET_NAME)" ...'; $(NORMAL)A
	@$(WARN) 'Objects are grouped based on the provided folder'; $(NORMAL)

_s3_webify_object:
	@$(INFO) '$(S3_UI_LABEL)Webifying object "$(S3_OBJECT_NAME)" ...'; $(NORMAL)
	$(AWS) s3 presign $(__S3_EXPIRES_IN) $(S3_OBJECT_URI)
