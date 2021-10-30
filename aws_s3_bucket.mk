_AWS_S3_BUCKET_MK_VERSION= $(_AWS_S3_MK_VERSION)

# S3_BUCKET_COUNT?= 1000
S3_BUCKET_DELETE_FORCE?= false
S3_BUCKET_LOCATION_ID?= us-east-1
# S3_BUCKET_MEDIA_URL?= https://s3.<aws-region>.amazonaws.com/<bucket-name>
# S3_BUCKET_NAME?= mybucket
# S3_BUCKET_URI?= s3://my-bucket
# S3_BUCKET_WEBSITE_ERROR?= error.html
# S3_BUCKET_WEBSITE_INDEX?= index.html
# S3_BUCKET_WEBSITE_URL?= http://my-bucket.s3-website-us-west-2.amazonaws.com.
# S3_BUCKETS_SET_NAME?= my-buckets-set

# Derived parameters 
S3_BUCKET_MEDIA_URL?= http://s3.$(S3_BUCKET_LOCATION_ID).amazonaws.com/$(S3_BUCKET_NAME)
S3_BUCKET_URI?= $(if $(S3_BUCKET_NAME),s3://$(S3_BUCKET_NAME))
S3_BUCKET_WEBSITE_URL?= http://$(S3_BUCKET_NAME).s3-website-$(S3_BUCKET_LOCATION_ID).amazonaws.com

# Options
__S3_ERROR_DOCUMENT?= $(if $(S3_BUCKET_WEBSITE_ERROR),--error-document $(S3_BUCKET_WEBSITE_ERROR))
__S3_FORCE_BUCKET?= $(if $(filter true, $(S3_BUCKET_DELETE_FORCE)),--force)
__S3_INDEX_DOCUMENT?= $(if $(S3_BUCKET_WEBSITE_INDEX),--index-document $(S3_BUCKET_WEBSITE_INDEX))
__S3_REGION?= $(if $(S3_BUCKET_LOCATION_ID),--region $(S3_BUCKET_LOCATION_ID))

# UI parameters

# Commands

#--- MACROS

_s3_get_bucket_count= $(shell $(AWS) s3 ls --recursive | wc -l )

_s3_get_bucket_url=$(call _s3_get_bucket_url_N, $(S3_BUCKET_NAME))
_s3_get_bucket_url_N=$(call _s3_get_bucket_url_NL, $(1), $(S3_BUCKET_LOCATION_ID))
_s3_get_bucket_url_NL=$(shell echo 'http://$(strip $(1)).s3-website-$(strip $(2)).amazonaws.com')

#----------------------------------------------------------------------
# USAGE
#

_s3_list_macros ::
	@echo 'AWS::S3::Bucket ($(_AWS_S3_BUCKET_MK_VERSION)) macros:'
	@echo '    _s3_get_bucket_count                  - Get the number of bucket for this account'
	@echo '    _s3_get_bucket_url_{|N|NL}            - Get the website URL of the S3 bucket (Name, Location)'
	@echo

_s3_list_parameters ::
	@echo 'AWS::S3::Bucket ($(_AWS_S3_BUCKET_MK_VERSION)) parameters:'
	@echo '    S3_BUCKET_COUNT=$(S3_BUCKET_COUNT)'
	@echo '    S3_BUCKET_DELETE_FORCE=$(S3_BUCKET_DELETE_FORCE)'
	@echo '    S3_BUCKET_LOCATION_ID=$(S3_BUCKET_LOCATION_ID)'
	@echo '    S3_BUCKET_MEDIA_URL=$(S3_BUCKET_MEDIA_URL)'
	@echo '    S3_BUCKET_NAME=$(S3_BUCKET_NAME)'
	@echo '    S3_BUCKET_URI=$(S3_BUCKET_URI)'
	@echo '    S3_BUCKET_WEBSITE_ERROR=$(S3_BUCKET_WEBSITE_ERROR)'
	@echo '    S3_BUCKET_WEBSITE_INDEX=$(S3_BUCKET_WEBSITE_INDEX)'
	@echo '    S3_BUCKET_WEBSITE_URL=$(S3_BUCKET_WEBSITE_URL)'
	@echo '    S3_BUCKETS_SET_NAME=$(S3_BUCKETS_SET_NAME)'
	@echo

_s3_list_targets ::
	@echo 'AWS::S3::Bucket ($(_AWS_S3_BUCKET_MK_VERSION)) targets:'
	@echo '     _s3_create_bucket                   - Create a S3 bucket'
	@echo '     _s3_delete_bucket                   - Delete a S3 bucket'
	@echo '     _s3_show_bucket                     - Show everything related to a S3 bucket'
	@echo '     _s3_show_bucket_description         - Show description of a S3 bucket'
	@echo '     _s3_show_bucket_objects             - Show objects of a S3 bucket'
	@echo '     _s3_list_buckets                    - List all S3 buckets'
	@echo '     _s3_list_buckets_set                - List a set of S3 buckets'
	@echo '     _s3_webify_bucket                   - Webify a buckets'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_s3_create_bucket:
	@$(INFO) '$(S3_UI_LABEL)Creating bucket "$(S3_BUCKET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The region affinity of this bucket (aka LocationContraint) is $(S3_BUCKET_LOCATION_ID)'; $(NORMAL)
	@$(WARN) 'This operation fails if the LocationContraint is us-east-1. To fix, remove from CLI and run manually'; $(NORMAL)
	$(AWS) s3 mb $(__S3_REGION) $(S3_BUCKET_URI)

_s3_delete_bucket:
	@$(INFO) '$(S3_UI_LABEL)Deleting bucket "$(S3_BUCKET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The region affinity of this bucket (aka LocationContraint) is $(S3_BUCKET_LOCATION_ID)'; $(NORMAL)
	$(AWS) s3 rb $(__S3_FORCE__BUCKET) $(S3_BUCKET_URI)

_s3_list_buckets:
	@$(INFO) '$(S3_UI_LABEL)Listing ALL buckets ...'; $(NORMAL)
	$(AWS) s3 ls

_s3_list_buckets_set:
	@$(INFO) '$(S3_UI_LABEL)Listing buckets-set "$(S3_BUCKETS_SET_NAME)" ...'; $(NORMAL)

_s3_show_bucket:: _s3_show_bucket_objects _s3_show_bucket_description

_s3_show_bucket_description:
	@$(INFO) '$(S3_UI_LABEL)Showing description of bucket "$(S3_BUCKET_NAME)" ...'; $(NORMAL)
	$(AWS) s3 ls $(S3_BUCKET_URI)
	$(AWS) s3 ls $(S3_BUCKET_URI)/

_s3_show_bucket_objects:
	@$(INFO) '$(S3_UI_LABEL)Showing objects of bucket "$(S3_BUCKET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the object keys'; $(NORMAL)
	@$(WARN) 'Object keys must be prefixed with /'; $(NORMAL)
	$(AWS) s3 ls --recursive $(S3_BUCKET_URI)

_s3_webify_bucket:
	@$(INFO) '$(S3_UI_LABEL)Webifying bucket "$(S3_BUCKET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation turns a bucket into a website'; $(NORMAL)
	$(AWS) s3 website $(__S3_ERROR_DOCUMENT) $(__S3_INDEX_DOCUMENT) $(S3_BUCKET_URI)
