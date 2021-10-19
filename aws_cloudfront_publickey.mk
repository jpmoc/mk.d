_AWS_CLOUDFRONT_PUBLICKEY_MK_VERSION= $(_AWS_CLOUDFRONT_MK_VERSION)

# CFT_PUBLICKEY_ID?=
# CFT_PUBLICKEY_NAME?=
# CFT_PUBLICKEYS_SET_NAME?=

# Derived parameters

# Option parameters
__CFT_ID__PUBLICKEY= $(if $(CFT_PUBLICKEY_ID),--id $(CFT_PUBLICKEY_ID))


# UI parameters
CFT_UI_VIEW_PUBLICKEYS_FIELDS?=
CFT_UI_VIEW_PUBLICKEYS_SET_FIELDS?= $(CFT_UI_VIEW_PUBLICKEYS_FIELDS)
CFT_UI_VIEW_PUBLICKEYS_SET_QUERYFILTER?=

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_cft_view_framework_macros ::
	@echo 'AWS::CloudFronT::PublicKey ($(_AWS_CLOUDFRONT_PUBLICKEY_MK_VERSION)) macros:'
	@echo

_cft_view_framework_parameters ::
	@echo 'AWS::CloudFronT::PublicKey ($(_AWS_CLOUDFRONT_PUBLICKEY_MK_VERSION)) parameters:'
	@echo '    CFT_PUBLICKEY_ID=$(CFT_PUBLICKEY_ID)'
	@echo '    CFT_PUBLICKEY_NAME=$(CFT_PUBLICKEY_NAME)'
	@echo '    CFT_PUBLICKEYS_SET_NAME=$(CFT_PUBLICKEYS_SET_NAME)'
	@echo

_cft_view_framework_targets ::
	@echo 'AWS::CloudFronT::PublicKey ($(_AWS_CLOUDFRONT_PUBLICKEY_MK_VERSION)) targets:'A
	@echo '    _cft_create_publickey               - Create a new public-key'
	@echo '    _cft_delete_publickey               - Delete an existing public-key'
	@echo '    _cft_show_publickey                 - Show everything related to a public-key'
	@echo '    _cft_show_publickey_description     - Show description of a public-key'
	@echo '    _cft_view_publickeys               - View public-keys'
	@echo '    _cft_view_publickeys_set           - View a set of public-keys'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cft_create_publickey:
	@$(INFO) '$(CFT_UI_LABEL)Creating public-key "$(CFT_PUBLICKEY_NAME)" ...'; $(NORMAL)
	# $(AWS) cloudfront create-cloud-front-public-key $(__CFT_CLOUD_FRONT_PUBLICKEY_CONFIG)

_cft_delete_publickey:
	@$(INFO) '$(CFT_UI_LABEL)Deleting public-key "$(CFT_PUBLICKEY_NAME)" ...'; $(NORMAL)
	# $(AWS) cloudfront delete-cloud-front-public-key $(__CFT_ID__PUBLICKEY) $(__CFT_IF_MATCH__PUBLICKEY)

_cft_show_publickey: _cft_show_publickey_description

_cft_show_publickey_description:
	@$(INFO) '$(CFT_UI_LABEL)Showing description of public-key "$(CFT_PUBLICKEY_NAME)" ...'; $(NORMAL)
	# $(AWS) cloudfront get-public-key $(__CFT_ID__PUBLICKEY)

_cft_view_publickeys:
	@$(INFO) '$(CFT_UI_LABEL)Viewing public-keys ...'; $(NORMAL)
	$(AWS) cloudfront list-public-keys --query "PublicKeyList.Items[]$(CFT_UI_VIEW_PUBLICKEYS_FIELDS)"

_cft_view_publickeys_set:
	@$(INFO) '$(CFT_UI_LABEL)Viewing public-keys-set "$(CFT_PUBLICKEYS_SET_NAME)" ...'; $(NORMAL)
	$(AWS) cloudfront list-public-keys --query "PublicKeyList.Items[$(CFT_UI_VIEW_PUBLICKEYS_SET_QUERYFILTER)]$(CFT_UI_VIEW_PUBLICKEYS_SET_FIELDS)"
