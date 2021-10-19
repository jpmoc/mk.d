_AWS_CLOUDFRONT_ORIGINACCESSIDENTITY_MK_VERSION= $(_AWS_CLOUDFRONT_MK_VERSION)

# CFT_ORIGINACCESSIDENTITY_ARN?= "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity E2FRE96AP22R83"
# CFT_ORIGINACCESSIDENTITY_CALLER_REFERENCE?= 1572312202934
# CFT_ORIGINACCESSIDENTITY_COMMENT?= access-identity-123456789012-coursera-serverless.s3.amazonaws.com
# CFT_ORIGINACCESSIDENTITY_CONFIG_FILENAME?= originaccessidentity-config.json
# CFT_ORIGINACCESSIDENTITY_CONFIG_FILEPATH?= ./in/originaccessidentity-config.json
# CFT_ORIGINACCESSIDENTITY_DIRPATH?= ./in
# CFT_ORIGINACCESSIDENTITY_ETAG?= EJ5ZB4GFDWRMC
# CFT_ORIGINACCESSIDENTITY_ID?= E2FRE96AP22R83
# CFT_ORIGINACCESSIDENTITY_LOCATION?= https://cloudfront.amazonaws.com/2019-03-26/origin-access-identity/cloudfront/E2FRE96AP22R83
# CFT_ORIGINACCESSIDENTITY_NAME?=
# CFT_ORIGINACCESSIDENTITIES_SET_NAME?=

# Derived parameters
CFT_ORIGINACCESSIDENTITY_ARN?= $(if $(CFT_ORIGINACCESSIDENTITY_ID),"arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity $(CFT_ORIGINACCESSIDENTITY_ID)")
CFT_ORIGINACCESSIDENTITY_COMMENT?= $(CFT_ORIGINACCESSIDENTITY_NAME)
CFT_ORIGINACCESSIDENTITY_CONFIG?= $(if $(CFT_ORIGINACCESSIDENTITY_CONFIG_FILEPATH),file://$(CFT_ORIGINACCESSIDENTITY_CONFIG_FILEPATH))
CFT_ORIGINACCESSIDENTITY_CONFIG_FILEPATH?= $(CFT_ORIGINACCESSIDENTITY_DIRPATH)$(CFT_ORIGINACCESSIDENTITY_CONFIG_FILENAME)
CFT_ORIGINACCESSIDENTITY_DIRPATH?= $(CFT_DIRPATH)
CFT_ORIGINACCESSIDENTITY_LOCATION?= $(if $(CFT_ORIGINACCESSIDENTITY_ID),https://cloudfront.amazonaws.com/2019-03-26/origin-access-identity/cloudfront/$(CFT_ORIGINACCESSIDENTITY_ID))

# Option parameters
__CFT_ID__ORIGINACCESSIDENTITY= $(if $(CFT_ORIGINACCESSIDENTITY_ID),--id $(CFT_ORIGINACCESSIDENTITY_ID))
__CFT_IF_MATCH__ORIGINACCESSIDENTITY= $(if $(CFT_ORIGINACCESSIDENTITY_ETAG),--if-match $(CFT_ORIGINACCESSIDENTITY_ETAG))
__CFT_CLOUD_FRONT_ORIGIN_ACCESS_IDENTITY_CONFIG= $(if $(CFT_ORIGINACCESSIDENTITY_CONFIG),--cloud-front-origin-access-identity-config $(CFT_ORIGINACCESSIDENTITY_CONFIG))


# UI parameters
CFT_UI_VIEW_ORIGINACCESSIDENTITIES_FIELDS?=
CFT_UI_VIEW_ORIGINACCESSIDENTITIES_SET_FIELDS?= $(CFT_UI_VIEW_ORIGINACCESSIDENTITIES_FIELDS)
CFT_UI_VIEW_ORIGINACCESSIDENTITIES_SET_QUERYFILTER?=

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

# An origin access identity is a special CloudFront user that you can use to give CloudFront access to your Amazon S3 bucket.
# This is useful when you are using signed URLs or signed cookies to restrict access to private content in Amazon S3

_cft_view_framework_macros ::
	@echo 'AWS::CloudFronT::OriginAccessIdentity ($(_AWS_CLOUDFRONT_ORIGINACCESSIDENTITY_MK_VERSION)) macros:'
	@echo

_cft_view_framework_parameters ::
	@echo 'AWS::CloudFronT::OriginAccessIdentity ($(_AWS_CLOUDFRONT_ORIGINACCESSIDENTITY_MK_VERSION)) parameters:'
	@echo '    CFT_ORIGINACCESSIDENTITY_ARN=$(CFT_ORIGINACCESSIDENTITY_ARN)'
	@echo '    CFT_ORIGINACCESSIDENTITY_CALLER_REFERENCE=$(CFT_ORIGINACCESSIDENTITY_CALLER_REFERENCE)'
	@echo '    CFT_ORIGINACCESSIDENTITY_COMMENT=$(CFT_ORIGINACCESSIDENTITY_COMMENT)'
	@echo '    CFT_ORIGINACCESSIDENTITY_CONFIG=$(CFT_ORIGINACCESSIDENTITY_CONFIG)'
	@echo '    CFT_ORIGINACCESSIDENTITY_CONFIG_FILENAME=$(CFT_ORIGINACCESSIDENTITY_CONFIG_FILENAME)'
	@echo '    CFT_ORIGINACCESSIDENTITY_CONFIG_FILEPATH=$(CFT_ORIGINACCESSIDENTITY_CONFIG_FILEPATH)'
	@echo '    CFT_ORIGINACCESSIDENTITY_DIRPATH=$(CFT_ORIGINACCESSIDENTITY_DIRPATH)'
	@echo '    CFT_ORIGINACCESSIDENTITY_ETAG=$(CFT_ORIGINACCESSIDENTITY_ETAG)'
	@echo '    CFT_ORIGINACCESSIDENTITY_ID=$(CFT_ORIGINACCESSIDENTITY_ID)'
	@echo '    CFT_ORIGINACCESSIDENTITY_LOCATION=$(CFT_ORIGINACCESSIDENTITY_LOCATION)'
	@echo '    CFT_ORIGINACCESSIDENTITY_NAME=$(CFT_ORIGINACCESSIDENTITY_NAME)'
	@echo '    CFT_ORIGINACCESSIDENTITIES_SET_NAME=$(CFT_ORIGINACCESSIDENTITIES_SET_NAME)'
	@echo

_cft_view_framework_targets ::
	@echo 'AWS::CloudFronT::OriginAccessIdentity ($(_AWS_CLOUDFRONT_ORIGINACCESSIDENTITY_MK_VERSION)) targets:'A
	@echo '    _cft_create_originaccessidentity               - Create a new origin-access-identity'
	@echo '    _cft_delete_originaccessidentity               - Delete an existing origin-access-identity'
	@echo '    _cft_show_originaccessidentity                 - Show everything related to a origin-access-identity'
	@echo '    _cft_show_originaccessidentity_description     - Show description of a origin-access-identity'
	@echo '    _cft_view_originaccessidentities               - View origin-access-identities'
	@echo '    _cft_view_originaccessidentities_set           - View a set of origin-access-identities'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cft_create_originaccessidentity:
	@$(INFO) '$(CFT_UI_LABEL)Creating origin-access-identity "$(CFT_ORIGINACCESSIDENTITY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation creates a new origin-access-identity only for each new caller-reference'; $(NORMAL)
	$(if $(CFT_ORIGINACCESSIDENTITY_CONFIG_FILEPATH), cat $(CFT_ORIGINACCESSIDENTITY_CONFIG_FILEPATH))
	$(AWS) cloudfront create-cloud-front-origin-access-identity $(__CFT_CLOUD_FRONT_ORIGIN_ACCESS_IDENTITY_CONFIG)

_cft_delete_originaccessidentity:
	@$(INFO) '$(CFT_UI_LABEL)Deleting origin-access-identity "$(CFT_ORIGINACCESSIDENTITY_NAME)" ...'; $(NORMAL)
	$(AWS) cloudfront delete-cloud-front-origin-access-identity $(__CFT_ID__ORIGINACCESSIDENTITY) $(__CFT_IF_MATCH__ORIGINACCESSIDENTITY)

_cft_show_originaccessidentity: _cft_show_originaccessidentity_description

_cft_show_originaccessidentity_description:
	@$(INFO) '$(CFT_UI_LABEL)Showing description of origin-access-identity "$(CFT_ORIGINACCESSIDENTITY_NAME)" ...'; $(NORMAL)
	$(AWS) cloudfront get-cloud-front-origin-access-identity $(__CFT_ID__ORIGINACCESSIDENTITY)

_cft_view_originaccessidentities:
	@$(INFO) '$(CFT_UI_LABEL)Viewing origin-access-identities ...'; $(NORMAL)
	$(AWS) cloudfront list-cloud-front-origin-access-identities --query "CloudFrontOriginAccessIdentityList.Items[]$(CFT_UI_VIEW_ORIGINACCESSIDENTITIES_FIELDS)"

_cft_view_originaccessidentities_set:
	@$(INFO) '$(CFT_UI_LABEL)Viewing origin-access-identities-set "$(CFT_ORIGINACCESSIDENTITIES_SET_NAME)" ...'; $(NORMAL)
	$(AWS) cloudfront list-cloud-front-origin-access-identities --query "CloudFrontOriginAccessIdentityList.Items[$(CFT_UI_VIEW_iORIGINACCESSIDENTITIES_SET_QUERYFILTER)]$(CFT_UI_VIEW_ORIGINACCESSIDENTITIES_SET_FIELDS)"
