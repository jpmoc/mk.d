_AWS_S3_FOLDER_MK_VERSION= $(_AWS_S3_MK_VERSION)

# S3_FOLDER_BUCKET_LOCATION?= us-east-1
# S3_FOLDER_BUCKET_NAME?= mybucket
# S3_FOLDER_CACHE_CONTROL?= max-age=604800
# S3_FOLDER_DIRPATH?= ./s3/myfolder/
# S3_FOLDER_GRANTS_FULL?= full=emailaddress=user@example.com
# S3_FOLDER_GRANTS_READ?= read=uri=http://acs.amazonaws.com/groups/global/AllUsers
# S3_FOLDER_GRANTS_READACP?= 
# S3_FOLDER_GRANTS_WRITE?= write=uri=http://acs.amazonaws.com/groups/global/AllUsers
# S3_FOLDER_GRANTS_WRITEACP?= 
# S3_FOLDER_KEY?= /myfolder
# S3_FOLDER_NAME?= myfolder
S3_FOLDER_STORAGE_CLASS?= STANDARD
# S3_FOLDERS_DIRPATH?= ./s3/
# S3_FOLDERS_SET_NAME?= my-folders-set

# Derived parameters 
S3_FOLDER_GRANTS?= $(strip $(S3_FOLDER_GRANTS_FULL) $(S3_FOLDER_GRANTS_READ) $(S3FOLDER__GRANTS_WRITE))
S3_FOLDER_KEY?= $(if $(S3_FOLDER_NAME),/$(S3_FOLDER_NAME))
S3_FOLDER_URI?= $(if $(S3_BUCKET_URI),$(S3_BUCKET_URI)$(S3_FOLDER_KEY))

# Options parameters
__S3_ACL=
__S3_CACHE_CONTROL= $(if $(S3_FOLDER_CACHE_CONTROL),--cache-control $(S3_FOLDER_CACHE_CONTROL))
__S3_CONTENT_DISPOSITION=
__S3_CONTENT_ENCODING=
__S3_CONTENT_LANGUAGE=
__S3_DELETE=
__S3_EXACT_TIMESTAMPS=
# __S3_EXCLUDE?= $(if $(S3_EXCLUDE),--exclude $(S3_EXCLUDE))
__S3_EXPIRES=
__S3_FOLLOW_SYMLINKS=
__S3_GRANTS__FOLDER= $(if $(S3_FOLDER_GRANTS),--grants $(S3_FOLDER_GRANTS))
__S3_METADATA=
__S3_METADATA_DIRECTIVE=
__S3_NO_GUESS_MIME=
__S3_ONLY_SHOW_ERRORS=
__S3_PAGE_SIZE= --page-size 1000
# __S3_REGION?= $(if $(S3_REGION), --region $(S3_REGION))
__S3_SIZE_ONLY=
__S3_SOURCE_REGION=
__S3_SSE=
__S3_SSE_C=
__S3_SSE_C_COPY_SOURCE=
__S3_SSE_C_COPY_SOURCE_KEY=
__S3_SSE_C_KEY=
__S3_SSE_KMS_KEY_ID=
__S3_STORAGE_CLASS= $(if $(S3_FOLDER_STORAGE_CLASS),--storage-class $(S3_FOLDER_STORAGE_CLASS))
__S3_WEBSITE_REDIRECT=

# UI parameters

# Commands

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_s3_list_macros ::
	@#echo 'AWS::S3::Folder ($(_AWS_S3_FOLDER_MK_VERSION)) macros:'
	@#echo

_s3_list_parameters ::
	@echo 'AWS::S3::Folder ($(_AWS_S3_FOLDER_MK_VERSION)) parameters:'
	@echo '    S3_FOLDER_BUCKET_NAME=$(S3_FOLDER_BUCKET_NAME)'
	@echo '    S3_FOLDER_CACHE_CONTROL=$(S3_FOLDER_CACHE_CONTROL)'
	@echo '    S3_FOLDER_DIRPATH=$(S3_FOLDER_DIRPATH)'
	@echo '    S3_FOLDER_GRANTS=$(S3_FOLDER_GRANTS)'
	@echo '    S3_FOLDER_GRANTS_FULL=$(S3_FOLDER_GRANTS_FULL)'
	@echo '    S3_FOLDER_GRANTS_READ=$(S3_FOLDER_GRANTS_READ)'
	@echo '    S3_FOLDER_GRANTS_WRITE=$(S3_FOLDER_GRANTS_WRITE)'
	@echo '    S3_FOLDER_KEY=$(S3_FOLDER_KEY)'
	@echo '    S3_FOLDER_NAME=$(S3_FOLDER_NAME)'
	@echo '    S3_FOLDER_STORAGE_CLASS=$(S3_FOLDER_STORAGE_CLASS)'
	@echo '    S3_FOLDER_URI=$(S3_FOLDER_URI)'
	@#echo '    S3_FOLDERS_DIRPATH=$(S3_FOLDERS_DIRPATH)'
	@echo '    S3_FOLDERS_SET_NAME=$(S3_FOLDERS_SET_NAME)'
	@echo

_s3_list_targets ::
	@echo 'AWS::S3::Folder ($(_AWS_S3_FOLDER_MK_VERSION)) targets:'
	@echo '     _s3_create_folder                   - Create a folder'
	@echo '     _s3_delete_folder                   - Delete a folder'
	@echo '     _s3_list_folders                    - List all folders'
	@echo '     _s3_list_folders_set                - List a set of folders'
	@echo '     _s3_pull_folder                     - Pull content of a folder'
	@echo '     _s3_push_folder                     - Push content to a folder'
	@echo '     _s3_show_folder                     - Show everything related to a folder'
	@echo '     _s3_show_folder_description         - Show description of a folder'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_s3_create_folder: 
	@$(INFO) '$(S3_UI_LABEL)Creating folder "$(S3_FOLDER_NAME)" ...'; $(NORMAL)

_s3_deleting_folder: 
	@$(INFO) '$(S3_UI_LABEL)Deleting folder "$(S3_FOLDER_NAME)" ...'; $(NORMAL)
	$(AWS) s3 rm $(__S3_DRYRUN) $(_X__S3_EXCLUDE) $(_X__S3_INCLUDE) $(__S3_ONLY_SHOW_ERRORS) $(__S3_QUIET) $(_X__S3_RECURSIVE) $(__S3_REQUEST_PAYER) $(S3_FOLDER_URI)

_s3_list_folders:
	@$(INFO) '$(S3_UI_LABEL)Listing ALL folders ...'; $(NORMAL)

_s3_list_folders_set:
	@$(INFO) '$(S3_UI_LABEL)Listing folders-sets "$(S3_FOLDERS_SET_NAME)" ...'; $(NORMAL)

_s3_pull_folder:
	@$(INFO) '$(S3_UI_LABEL)Pulling content of folder "$(S3_FOLDER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation pull the objects into direction "$(S3_FOLDER_DIRPATH)"'; $(NORMAL)
	$(AWS) s3 sync $(S3_FOLDER_URI) $(S3_FOLDER_DIRPATH)

_s3_push_folder:
	@$(INFO) '$(S3_UI_LABEL)Pushing content to folder "$(S3_FOLDER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation pushes the content found in directory "$(S3_FOLDER_DIRPATH)"'; $(NORMAL)
	$(AWS) s3 sync $(strip $(__S3_ACL__FOLDER) $(__S3_CACHE_CONTROL) $(__S3_CONTENT_DISPOSITION) $(__S3_CONTENT_ENCODING) $(__S3_CONTENT_LANGUAGE) $(__S3_CONTENT_TYPE) $(__S3_DELETE) $(__S3_EXACT_TIMESTAMPS) $(__S3_EXCLUDE) $(__S3_EXPIRES) $(__S3_FOLLOW_SYMLINKS) $(__S3_FORCE_GLACIER_TRANSFER) $(__S3_INCLUDE) $(__S3_IGNORE_GLACIER_WARNINGS) $(__S3_GRANTS__FOLDER) $(__S3_METADATA) $(__S3_METADATA_DIRECTIVE) $(__S3_NO_GUESS_MIME_TYPE) $(__S3_NO_PROGRESS) $(__S3_ONLY_SHOW_ERRORS) $(__S3_PAGE_SIZE) $(__S3_REQUEST_PAYER) $(__S3_SIZE_ONLY) $(__S3_SOURCE_REGION) $(__S3_SSE) $(__S3_SSE_C) $(__S3_SSE_C_KEY) $(__S3_SSE_C_COPY_SOURCE) $(__S3_SSE_C_COPY_SOURCE_KEY) $(__S3_SSE_KMS_KEY_ID) $(__S3_STORAGE_CLASS) $(__S3_WEBSITE_REDIRECT)) $(S3_FOLDER_DIRPATH) $(S3_FOLDER_URI)

_s3_show_folder:: _s3_show_folder_description

_s3_show_folder_description:
	@$(INFO) '$(S3_UI_LABEL)Showing descriptoin of folder "$(S3_FOLDER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if folder does NOT exist!'; $(NORMAL)
	-$(AWS) s3 ls $(S3_FOLDER_URI)
	-$(AWS) s3 ls $(S3_FOLDER_URI)/
